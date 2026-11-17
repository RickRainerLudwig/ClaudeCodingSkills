---
name: commit-messages
description: Write git commit messages in the Conventional Commits format with a type prefix (feat, fix, docs, test, refactor, chore, ...) and sign off every commit with the current git user. Use when creating a commit, amending one, writing or reviewing a commit message, or splitting changes into commits.
---

# Commit Messages

Commit messages follow Conventional Commits 1.0.0 (https://www.conventionalcommits.org). The type prefix makes the
history easy to scan and lets tools create changelogs and choose the next version number.

## Format

```
<type>[(<scope>)][!]: <summary>

[body]

[footers]
```

Example:

```
fix(parser): accept empty lines at the end of a file

Files saved by some editors end with an empty line, and the parser
rejected them as invalid. Empty trailing lines carry no data, so the
parser now ignores them.

Signed-off-by: Jane Doe <jane.doe@example.com>
```

## Types

| Type | Use for |
|---|---|
| `feat` | A new feature for the users of the software |
| `fix` | A bug fix |
| `docs` | Documentation only |
| `test` | Adding or correcting tests only |
| `refactor` | A code change that neither fixes a bug nor adds a feature |
| `perf` | A code change that improves performance |
| `style` | Formatting only, no change of meaning (white space, semicolons) |
| `build` | Build system or external dependencies |
| `ci` | Continuous integration (CI) configuration and scripts |
| `chore` | Other maintenance that changes no source or test code |
| `revert` | Reverts an earlier commit; the body names the reverted commit |

Choose the type by the effect for the users, not by the files changed: a bug fix together with its regression test
is `fix`, not `test`. If a change fits several types, it usually belongs in several commits; split it.

## Summary line

- Lower-case type, optional scope in parentheses (the module or area, e.g. `fix(parser):`), then `: ` and the
  summary.
- Imperative mood, as if completing "This commit will ...": "add", not "added" or "adds".
- At most 72 characters in total, no period at the end.
- A breaking change gets a `!` before the colon (`feat(api)!: remove the v1 endpoints`) and a `BREAKING CHANGE:`
  footer that says what users must change.

## Body

Separate the body from the summary with an empty line and wrap it at 72 characters. Explain why the change was made
and what it is meant to achieve; the diff already shows what changed. Omit the body when the summary says it all.

## Sign-off

Every commit is signed off by the current git user: create it with `git commit -s`, also when amending
(`git commit --amend -s`). This adds the footer `Signed-off-by: <user.name> <user.email>` from the git
configuration.

- Never write a `Signed-off-by` line for another person, and never change `user.name` or `user.email` to do so.
- Put other footers, such as `Co-Authored-By`, into the message yourself; `git commit -s` appends the sign-off after
  them.

## Checked by a hook

This plugin brings a hook that checks every commit Claude creates. If the newest commit has no valid type prefix, a
too long first line or no sign-off of the current user, the hook reports it. Fix the commit with
`git commit --amend -s` and a corrected message, as long as it has not been pushed.
