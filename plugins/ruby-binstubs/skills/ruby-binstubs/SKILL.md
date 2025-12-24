---
name: Ruby Binstubs
description: This skill should be used when the user is working in a Ruby project with a Gemfile and executes gem commands. Ensures proper use of binstubs (bin/*) instead of bundle exec.
version: 1.0.0
---

# Ruby Binstubs Convention

In Ruby projects using Bundler, always use binstubs from the `bin/` directory instead of `bundle exec` or bare commands.

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

## Creating Missing Binstubs

If a gem should have a binstub but doesn't:

```bash
bundle binstubs <gem-name>
```

## When bundle exec Is Acceptable

Use `bundle exec` only when:
- No binstub exists and creating one isn't worthwhile
- Running a one-off command

## Summary

1. **`bin/<command>`** - Always preferred when binstub exists
2. **`bundle exec <command>`** - When no binstub exists
3. **Never use bare commands** - May use wrong gem versions
