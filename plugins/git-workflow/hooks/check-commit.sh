#!/usr/bin/env bash
# Checks the commit that Claude has just created against the rules of the commit-messages skill.
#
# The hook runs after the command instead of before it: the message of the created commit is exact, while parsing
# it out of a shell command (-m, -F, here-documents) would be guesswork. Exit code 2 shows the problems to Claude,
# which then amends the commit.

# Only commits younger than this are checked, so that a failed "git commit" does not report an older commit.
readonly MAX_COMMIT_AGE_SECONDS=60
readonly MAX_SUBJECT_LENGTH=72
readonly TYPES='feat|fix|docs|test|refactor|perf|style|build|ci|chore|revert'

is_commit_command() {
  grep -Eq 'git( -C [^ ]+)? commit' <<<"$1"
}

is_fresh_non_merge_commit() {
  git rev-parse --verify -q HEAD >/dev/null 2>&1 || return 1
  local age=$(( $(date +%s) - $(git log -1 --format=%ct) ))
  (( age <= MAX_COMMIT_AGE_SECONDS )) || return 1
  # Merge commits keep the message that git creates for them.
  ! git rev-parse --verify -q 'HEAD^2' >/dev/null 2>&1
}

find_problems() {
  local subject message sign_off
  subject=$(git log -1 --format=%s)
  message=$(git log -1 --format=%B)
  sign_off="Signed-off-by: $(git config user.name) <$(git config user.email)>"

  if ! grep -Eq "^(${TYPES})(\([^()]+\))?!?: [^ ]" <<<"$subject"; then
    echo "The first line has no Conventional Commits prefix (${TYPES//|/, }, optional scope): \"$subject\""
  fi
  if (( ${#subject} > MAX_SUBJECT_LENGTH )); then
    echo "The first line has ${#subject} characters; the maximum is $MAX_SUBJECT_LENGTH."
  fi
  if ! grep -Fxq "$sign_off" <<<"$message"; then
    echo "The commit is not signed off by the current git user (\"$sign_off\"); use git commit -s."
  fi
}

hook_input=$(cat)
is_commit_command "$hook_input" || exit 0
is_fresh_non_merge_commit || exit 0

problems=$(find_problems)
[[ -z $problems ]] && exit 0
{
  echo "Commit $(git log -1 --format=%h) breaks the commit rules of the git-workflow plugin:"
  sed 's/^/- /' <<<"$problems"
  echo "If it has not been pushed, fix it with git commit --amend -s and a corrected message."
} >&2
exit 2
