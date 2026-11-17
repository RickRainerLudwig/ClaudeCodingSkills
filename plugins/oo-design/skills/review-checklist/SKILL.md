---
name: review-checklist
description: Review source code with a fixed checklist - correctness, security, tests, design principles and readability - and report findings ranked as blocker, major or minor, each with location, failure scenario and fix. Use when asked to review a diff, a pull request, a file or a module, or to check code before it is committed.
---

# Review Checklist

## Procedure

1. Understand the purpose of the change first (task, issue, commit message). Review against that purpose.
2. Read the code in the context of its callers and the surrounding code, not only the diff.
3. Check the areas below in order; correctness first.
4. Report findings ranked by severity; for each: location (`file:line`), the problem, a concrete failure scenario
   or cost, and a suggested fix.
5. Report only findings you can justify. Mark uncertain ones as questions instead of claims.

## Areas

1. **Correctness:** logic errors, edge cases (empty, null, boundaries, overflow), error handling, concurrency,
   resource handling.
2. **Security:** input validation, injection, secrets in code, authorization checks.
3. **Tests:** are the changed behaviors tested, including edge and error cases? Do the tests check behavior rather
   than implementation details?
4. **Design and maintainability:** the principles of the `coding-principles` skill (Single Level of
   Abstraction, Single Responsibility, Don't Repeat Yourself, Keep It Simple, You Aren't Gonna Need It, ...),
   coupling, consistency with the existing code and its conventions.
5. **Readability:** names, function length, comments that explain why rather than what.

## Severity

- **Blocker:** wrong results, data loss, security problem, crash.
- **Major:** likely bug in edge cases, missing tests for changed behavior, design that makes the next change hard.
- **Minor:** readability, naming, small simplifications.

Style questions that a formatter or linter covers are not review findings.
