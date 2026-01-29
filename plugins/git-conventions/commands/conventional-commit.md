---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*)
description: Create a git commit following Conventional Commits standard
---

# Context Gathering

Before creating the commit, gather context by running these commands:
1. `git status` - to see current changes
2. `git diff HEAD` - to see staged and unstaged changes
3. `git log --oneline -5` - for recent commit style reference

# Task

Create a git commit following Conventional Commits v1.0.0 specification.

## Quick Reference

Format: `type(optional-scope): description`

Common types:
- **feat**: New feature (MINOR in SemVer)
- **fix**: Bug fix (PATCH in SemVer)
- **docs**, **style**, **refactor**, **perf**, **test**, **build**, **ci**, **chore**, **revert**

For breaking changes (MAJOR in SemVer), add an exclamation mark before the colon.

For the complete specification, see `skills/conventional-commits/references/specification.md`.

## Rules

1. Use imperative mood in description (`Add` not `Added`)
2. Capitalize the description
3. No period at end of description

**CRITICAL - No AI Attribution:**
- NEVER add `Co-Authored-By` lines (not even for Claude/AI)
- NEVER add "Generated with Claude Code" or similar
- NEVER mention AI, Claude, or Anthropic anywhere in the commit
- The commit message should contain ONLY the conventional commit format - nothing else

## Steps

1. Run the context gathering commands above to understand current changes
2. Determine the appropriate commit type based on changes
3. Stage the appropriate files with git add
4. Create the commit with a properly formatted message
5. Confirm success with just the commit message

Keep the response concise - no verbose explanations unless asked.
