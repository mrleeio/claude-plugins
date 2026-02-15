---
name: ruby-binstubs
description: This skill should be used when working in a Ruby project with a Gemfile and executing gem commands. Ensures proper use of binstubs (bin/*) instead of bundle exec.
---

# Ruby Binstubs Convention

In Ruby projects using Bundler, always use binstubs from the `bin/` directory instead of `bundle exec` or bare commands.

**Note:** This convention is enforced by a Bash hook that intercepts shell commands.

## Core Rule

**Before running any gem command, check if a binstub exists:**

```bash
ls bin/
```

**If the binstub exists, use it:**

| Instead of | Use |
|------------|-----|
| `bundle exec <command>` | `bin/<command>` |
| `<command>` | `bin/<command>` |

## Why Binstubs Matter

1. **Version isolation**: Binstubs load the exact gem versions from `Gemfile.lock`
2. **Faster startup**: Skip the `bundle exec` overhead
3. **Project-specific**: Each project can customize its binstubs

## Common Binstubs

| Command | Binstub |
|---------|---------|
| `bundle exec rspec` | `bin/rspec` |
| `bundle exec rubocop` | `bin/rubocop` |
| `bundle exec rake` | `bin/rake` |
| `bundle exec rails` | `bin/rails` |
| `bundle exec erb_lint` | `bin/erb_lint` |
| `bundle exec standardrb` | `bin/standardrb` |

## Creating Missing Binstubs

If a gem should have a binstub but doesn't:

```bash
bundle binstubs <gem-name>
```

Or for all gems with executables:

```bash
bundle binstubs --all
```

## Priority Order

1. **`bin/<command>`** — Always preferred when the binstub exists
2. **`bundle exec <command>`** — Acceptable fallback when no binstub exists
3. **Bare `<command>`** — Only when no binstub exists AND not in a Bundler project

## When bundle exec Is Acceptable

`bundle exec` is the correct approach when:
- No binstub exists for the gem
- Creating a binstub isn't worthwhile for a rarely-used gem
- Running a one-off command from a gem not in the Gemfile

## Hook Enforcement

The `bash-binstub-enforcer.sh` hook dynamically detects binstubs and:
- Blocks `bundle exec <gem>` when `bin/<gem>` exists (suggests binstub)
- Blocks bare gem commands when a binstub exists (suggests binstub)
- Allows `bundle exec` when no binstub exists (correct fallback)
- Allows bare commands when no binstub exists
- Works with **any** gem — no hard-coded list, checks `bin/` directory at runtime
