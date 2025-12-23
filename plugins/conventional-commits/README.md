# Conventional Commits Plugin

Create git commits following the [Conventional Commits](https://www.conventionalcommits.org/) standard (v1.0.0) without AI attribution.

## Installation

```bash
/plugin install conventional-commits@mrleeio/claude-plugins
```

## Usage

### Command

```bash
/conventional-commit
```

Stage your changes with `git add`, then run the command to create a properly formatted commit.

### Skill

The plugin also provides a `conventional-commits` skill that can be referenced in your `CLAUDE.md`:

```markdown
Always use the `conventional-commits` skill when creating git commits.
```

## Commit Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit Types

| Type | Description |
|------|-------------|
| `feat` | New feature (MINOR version bump) |
| `fix` | Bug fix (PATCH version bump) |
| `docs` | Documentation only |
| `style` | Code style changes |
| `refactor` | Code refactoring |
| `perf` | Performance improvements |
| `test` | Adding/updating tests |
| `build` | Build system changes |
| `ci` | CI configuration changes |
| `chore` | Routine tasks |
| `revert` | Revert previous commit |

## Breaking Changes

Use `!` after type or add `BREAKING CHANGE:` footer:

```
feat!: Remove deprecated API

BREAKING CHANGE: The old API endpoints are no longer available.
```

## Features

- Follows Conventional Commits v1.0.0 specification
- Uses author info from your git config
- No AI/Claude attribution in commits
- Clean, professional commit history

## License

MIT
