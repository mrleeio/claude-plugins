# Bundle Commands Reference

Quick reference for Bundler CLI commands.

## Essential Commands

| Command | Description |
|---------|-------------|
| `bundle install` | Install dependencies from Gemfile |
| `bundle update` | Update all gems to latest allowed versions |
| `bundle update GEM` | Update specific gem only |
| `bundle outdated` | Show gems with newer versions available |
| `bundle info GEM` | Show details about installed gem |
| `bundle add GEM` | Add gem to Gemfile and install |
| `bundle remove GEM` | Remove gem from Gemfile |

## Installation Options

```bash
# Standard install
bundle install

# Install without specific groups
bundle install --without development test

# Install to specific path
bundle install --path vendor/bundle

# Install with parallelism
bundle install --jobs 4

# Retry failed network requests
bundle install --retry 3

# Don't update Gemfile.lock
bundle install --frozen
```

## Update Commands

```bash
# Update all gems
bundle update

# Update single gem (and its dependencies)
bundle update sidekiq

# Update gem conservatively (minimal dependency changes)
bundle update sidekiq --conservative

# Update gems in a group
bundle update --group development

# Patch-level updates only
bundle update --patch

# Minor-level updates only
bundle update --minor
```

## Lock File Operations

```bash
# Regenerate Gemfile.lock without installing
bundle lock

# Add platform to lock file
bundle lock --add-platform x86_64-linux
bundle lock --add-platform aarch64-linux

# Remove platform from lock file
bundle lock --remove-platform x86_64-linux

# Update lock file conservatively
bundle lock --conservative
```

## Inspection Commands

```bash
# Show installed gems
bundle list

# Show outdated gems
bundle outdated

# Show outdated gems (strict mode)
bundle outdated --strict

# Show gem info
bundle info sidekiq

# Show dependency tree
bundle show --paths

# Check for Gemfile/Gemfile.lock consistency
bundle check

# Visualize dependencies (requires graphviz)
bundle viz
```

## Binstubs

```bash
# Generate binstub for specific gem
bundle binstubs rspec-core
bundle binstubs rubocop

# Generate all binstubs
bundle binstubs --all

# Generate to custom directory
bundle binstubs rspec-core --path exe
```

## Configuration

```bash
# List all config
bundle config list

# Set local config
bundle config set --local path vendor/bundle
bundle config set --local without development:test

# Set global config
bundle config set --global jobs 4

# Unset config
bundle config unset path

# Common settings
bundle config set deployment true
bundle config set frozen true
bundle config set no-cache true
```

## Execution

```bash
# Run command in bundle context
bundle exec rspec
bundle exec rails server

# Open gem in editor
bundle open sidekiq

# Show gem path
bundle show sidekiq
```

## Security

```bash
# Check for vulnerable gems (requires bundler-audit)
bundle audit check

# Update vulnerability database and check
bundle audit check --update

# Ignore specific advisory
bundle audit check --ignore CVE-2022-12345
```

## CI/CD Patterns

```bash
# CI install (fast, frozen)
bundle config set --local frozen true
bundle config set --local deployment true
bundle install --jobs 4 --retry 3

# Docker multi-stage build
bundle config set --local without development:test
bundle install --jobs 4
```
