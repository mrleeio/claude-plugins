---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*)
description: Create a git commit following Conventional Commits standard
---

# Context

Current git status:
!`git status`

Staged and unstaged changes:
!`git diff HEAD`

Recent commits for style reference:
!`git log --oneline -5`

# Task

Create a git commit following Conventional Commits v1.0.0 specification.

## Conventional Commits v1.0.0 Specification

1. Commits MUST be prefixed with a type (noun like `feat`, `fix`), optional scope, optional `!`, and required colon+space before description
2. The type `feat` MUST be used when a commit adds a new feature
3. The type `fix` MUST be used when a commit represents a bug fix
4. Optional scope is a noun in parentheses describing a codebase section (e.g., `fix(parser):`)
5. Description MUST immediately follow the type/scope prefix
6. Longer body MAY follow after one blank line
7. Body is free-form, can contain multiple paragraphs
8. Footers appear after one blank line, using `token: value` or `token #value` format
9. Footer tokens use hyphens instead of spaces (e.g., `Acked-by`); exception: `BREAKING CHANGE`
10. Footer values may contain spaces/newlines
11. Breaking changes MUST be indicated in type/scope prefix OR as a footer
12. Breaking change footer format: `BREAKING CHANGE: description`
13. Breaking change in prefix: `!` before colon (footer may be omitted if `!` used)
14. Types beyond `feat` and `fix` are permitted (e.g., `docs`, `build`, `test`, `chore`, `ci`, `style`, `refactor`, `perf`, `revert`)
15. Units are case-insensitive except `BREAKING CHANGE` (must be uppercase)
16. `BREAKING-CHANGE` is synonymous with `BREAKING CHANGE` in footers

## Commit Format

`type(optional-scope): description`

Common types:
- **feat**: New feature (correlates with MINOR in SemVer)
- **fix**: Bug fix (correlates with PATCH in SemVer)
- **docs**, **build**, **chore**, **ci**, **style**, **refactor**, **perf**, **test**, **revert**

Add `!` before colon for breaking changes (correlates with MAJOR in SemVer)

## Rules

1. Use imperative mood in description (`Add` not `Added`)
2. Capitalize the description
3. No period at end of description
4. NEVER mention AI, Claude, or automated generation in commit messages
5. DO NOT include Co-Authored-By tags for AI/Claude
6. DO NOT include `Generated with Claude Code` or similar attributions

## Steps

1. Review the git status and diff above
2. Determine the appropriate commit type based on changes
3. Stage the appropriate files with git add
4. Create the commit with a properly formatted message
5. Confirm success with just the commit message

Keep the response concise - no verbose explanations unless asked.
