---
name: conventional-commits
description: Create git commits following Conventional Commits standard without AI attribution. Trigger phrases include "commit", "create a commit", "git commit", "commit changes". (user)
---

# Conventional Commits

Conventional Commits is a specification for writing standardized commit messages that are both human and machine readable. It provides a lightweight convention for creating an explicit commit history.

## Quick Reference

**Format:** `type(scope): description`

**Common types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

**Breaking changes:** Add exclamation mark before colon (e.g., `feat!: Remove deprecated API`)

## Commit Types

| Type | Description | SemVer |
|------|-------------|--------|
| `feat` | New feature | MINOR |
| `fix` | Bug fix | PATCH |
| `docs` | Documentation changes | - |
| `style` | Formatting (no code change) | - |
| `refactor` | Code restructuring | - |
| `perf` | Performance improvement | PATCH |
| `test` | Adding/updating tests | - |
| `build` | Build system changes | - |
| `ci` | CI configuration | - |
| `chore` | Maintenance tasks | - |
| `revert` | Reverting commits | varies |

## Rules

1. Use imperative mood in description (`Add` not `Added`)
2. Capitalize the description
3. No period at end
4. NEVER include AI/Claude attribution or Co-Authored-By tags

## Examples

```
feat: Add user authentication flow
fix(api): Handle null response from service
docs: Update installation guide
refactor!: Drop support for Node 14
```

## Usage

Run `/conventional-commit` to create a commit following this standard.

## Reference

For the complete Conventional Commits v1.0.0 specification, see:
- [Full Specification](references/specification.md) - All 16 specification points, commit types, breaking change patterns, and examples
