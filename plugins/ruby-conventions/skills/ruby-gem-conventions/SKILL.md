---
name: ruby-gem-conventions
description: This skill should be used when editing Gemfile, Gemfile.lock, or gemspec files. Covers gem grouping, version constraints, and bundle commands.
---

# Ruby Gem Conventions

Always use pessimistic version constraints (`~>`). Always organize gems by environment group. Always alphabetize gems within groups.

## Quick Reference

| Do | Don't |
|----|-------|
| Use pessimistic constraints (`~> 1.2`) | Leave gems unconstrained |
| Organize gems by environment group | Mix production and test gems |
| Alphabetize gems within groups | Random gem ordering |
| Use `require: false` for CLI tools | Auto-require tools like rubocop |
| Update gems one at a time | `bundle update` with no arguments |
| Run tests after each gem update | Batch update multiple gems |
| Use `bundle binstubs` for executables | Use `bundle exec` when binstub exists |
| Run `bundle audit` regularly | Ignore security advisories |
| Lock framework gems to minor version | Use loose constraints on Rails |

## Core Rules

```ruby
# WRONG - no version constraints, unorganized, not alphabetized
gem "rails"
gem "sidekiq"
gem "rspec-rails"
gem "pg"
gem "rubocop"
gem "puma"

# RIGHT - constrained, grouped, alphabetized
gem "pg", "~> 1.5"
gem "puma", "~> 6.0"
gem "rails", "~> 7.1.0"
gem "sidekiq", "~> 7.0"

group :development, :test do
  gem "rspec-rails", "~> 6.0"
  gem "rubocop", "~> 1.0", require: false
end
```

## Gemfile Organization

### Group Structure

Organize gems by environment in this order:

```ruby
source "https://rubygems.org"

# Ruby version
ruby "3.2.2"

# Core gems (always loaded)
gem "rails", "~> 7.1.0"
gem "pg"
gem "puma"
gem "redis"

# Asset pipeline / Frontend
gem "importmap-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

# Background jobs
gem "sidekiq"
gem "sidekiq-scheduler"

# Authentication / Authorization
gem "devise"
gem "pundit"

# API / Serialization
gem "jbuilder"
gem "oj"

group :development, :test do
  # Debugging
  gem "debug"
  gem "pry-rails"

  # Testing
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"

  # Code quality
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "listen"
  gem "rack-mini-profiler"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "timecop"
end

group :production do
  # Production-only gems
end
```

## Version Constraints

### Semantic Versioning

| Constraint | Meaning | Example |
|------------|---------|---------|
| `"1.2.3"` | Exact version | Only 1.2.3 |
| `">= 1.2"` | At least 1.2 | 1.2.0, 1.3.0, 2.0.0 |
| `"~> 1.2"` | Pessimistic (>= 1.2, < 2.0) | 1.2.0, 1.9.9 |
| `"~> 1.2.3"` | Pessimistic (>= 1.2.3, < 1.3) | 1.2.3, 1.2.9 |
| `">= 1.0, < 2.0"` | Range | 1.0.0 to 1.9.9 |

### When to Use Each

```ruby
# Exact version - for gems with known incompatibilities
gem "problematic-gem", "1.2.3"

# Pessimistic minor - most gems (allows patch updates)
gem "rails", "~> 7.1.0"

# Pessimistic major - stable APIs (allows minor updates)
gem "sidekiq", "~> 7.0"

# No constraint - only for gems you control or trust completely
gem "internal-gem"
```

### Recommended Constraints

```ruby
# Framework - lock to minor version
gem "rails", "~> 7.1.0"

# Database adapters - lock to minor
gem "pg", "~> 1.5"

# Stable utilities - lock to major
gem "sidekiq", "~> 7.0"
gem "redis", "~> 5.0"

# Rapidly changing gems - lock tighter
gem "some-beta-gem", "~> 0.9.1"
```

## Gemfile Best Practices

### require: false

Use for gems invoked directly, not loaded automatically:

```ruby
# CLI tools
gem "rubocop", require: false
gem "brakeman", require: false
gem "bundler-audit", require: false

# Loaded by Rake tasks only
gem "rspec-rails", require: false
```

### Git Sources

```ruby
# GitHub shorthand
gem "private-gem", github: "company/private-gem"

# With branch
gem "gem", github: "user/repo", branch: "main"

# With tag
gem "gem", github: "user/repo", tag: "v1.0.0"
```

### Platforms

```ruby
gem "wdm", ">= 0.1.0", platforms: [:mingw, :mswin, :x64_mingw]
gem "jdbc-postgres", platforms: :jruby
gem "pg", platforms: :ruby
```

## Gemspec Conventions

### Required Fields

```ruby
Gem::Specification.new do |spec|
  spec.name          = "my_gem"
  spec.version       = MyGem::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["you@example.com"]

  spec.summary       = "Short summary (required)"
  spec.description   = "Longer description of the gem"
  spec.homepage      = "https://github.com/you/my_gem"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.0"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match?(%r{\A(?:test|spec|features)/})
    end
  end

  spec.require_paths = ["lib"]
end
```

### Dependencies

```ruby
Gem::Specification.new do |spec|
  # Runtime dependencies (installed with gem)
  spec.add_dependency "activesupport", ">= 6.0"
  spec.add_dependency "zeitwerk", "~> 2.0"

  # Development dependencies (not installed with gem)
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.0"
end
```

## Bundle Commands

### Essential Commands

```bash
bundle install          # Install dependencies
bundle update sidekiq   # Update specific gem
bundle outdated         # Show outdated gems
bundle info sidekiq     # Show gem info
bundle add sidekiq      # Add gem
bundle audit check --update  # Check for vulnerabilities
```

### Updating Safely

1. Check what will change: `bundle outdated`
2. Update one gem at a time: `bundle update sidekiq --conservative`
3. Run tests after each update
4. Commit Gemfile.lock separately for each gem

## Common Mistakes

1. **No version constraints**: Leaving gems unconstrained means `bundle update` can pull breaking changes. Always use `~>` at minimum
2. **Using `>=` without upper bound**: `gem "rails", ">= 7.0"` allows Rails 8.0 which may break your app. Use `~> 7.1.0` instead
3. **Auto-requiring CLI tools**: Gems like `rubocop` and `brakeman` should use `require: false` to avoid loading them in every process
4. **Bulk updating**: Running `bundle update` without arguments updates everything at once. Update one gem at a time and test between each
5. **Unalphabetized gems**: Random ordering makes it hard to find gems and leads to duplicates. Alphabetize within each group
6. **Missing groups**: Putting test gems in the default group loads them in production. Always use `:development`, `:test`, or `:production` groups
7. **Ignoring security audits**: Run `bundle audit` in CI to catch known vulnerabilities in dependencies
8. **Committing Gemfile without Gemfile.lock**: Both files must be committed together for reproducible builds

## See Also

- `references/version-constraints.md` - Complete version constraint syntax and patterns
- `references/bundle-commands.md` - Bundler CLI command reference
- `references/gemspec-guide.md` - Gemspec fields and best practices
- `assets/templates/Gemfile.template` - Complete Gemfile scaffold
- `assets/templates/gemspec.template` - Complete gemspec template
