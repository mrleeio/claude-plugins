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

## When bundle exec Is Acceptable

Use `bundle exec` only when:
- No binstub exists and creating one isn't worthwhile
- Running a one-off command from a gem not in the Gemfile

## Hook Enforcement

The `bash-binstub-enforcer.sh` hook automatically:
- Blocks `bundle exec <gem>` when `bin/<gem>` exists
- Blocks bare gem commands when binstubs exist
- Suggests the correct binstub command

## Summary

1. **`bin/<command>`** - Always preferred when binstub exists
2. **`bundle exec <command>`** - When no binstub exists
3. **Never use bare commands** - May use wrong gem versions
