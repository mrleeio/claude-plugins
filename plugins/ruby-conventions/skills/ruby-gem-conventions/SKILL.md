---
name: ruby-gem-conventions
description: This skill should be used when editing Gemfile, Gemfile.lock, or gemspec files. Covers gem grouping, version constraints, and bundle commands.
---

# Ruby Gem Conventions

Conventions for managing Ruby dependencies with Bundler.

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
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

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
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"

  # Code quality
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  # Development tools
  gem "web-console"
  gem "rack-mini-profiler"

  # Code reloading
  gem "listen"

  # Error pages
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  # System testing
  gem "capybara"
  gem "selenium-webdriver"

  # Coverage
  gem "simplecov", require: false

  # Time manipulation
  gem "timecop"
end

group :production do
  # Production-only gems
end
```

### Alphabetize Within Groups

```ruby
# Good
gem "devise"
gem "omniauth"
gem "pundit"

# Bad
gem "pundit"
gem "devise"
gem "omniauth"
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

Use for gems that are invoked directly, not loaded automatically:

```ruby
# CLI tools
gem "rubocop", require: false
gem "brakeman", require: false
gem "bundler-audit", require: false

# Loaded conditionally
gem "pry-rails", require: false  # if using debugger

# Loaded by Rake tasks only
gem "rspec-rails", require: false  # loaded by spec_helper
```

### Git Sources

```ruby
# GitHub shorthand
gem "private-gem", github: "company/private-gem"

# With branch
gem "gem", github: "user/repo", branch: "main"

# With tag
gem "gem", github: "user/repo", tag: "v1.0.0"

# Full git URL
gem "gem", git: "https://github.com/user/repo.git"
```

### Path Sources

```ruby
# Local development
gem "my-engine", path: "../my-engine"

# Conditional (development only)
if ENV["LOCAL_GEMS"]
  gem "my-gem", path: "../my-gem"
else
  gem "my-gem", "~> 1.0"
end
```

### Platforms

```ruby
# Platform-specific gems
gem "wdm", ">= 0.1.0", platforms: [:mingw, :mswin, :x64_mingw]

# JRuby
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

### Metadata

```ruby
spec.metadata = {
  "homepage_uri"      => spec.homepage,
  "source_code_uri"   => "https://github.com/you/my_gem",
  "changelog_uri"     => "https://github.com/you/my_gem/blob/main/CHANGELOG.md",
  "bug_tracker_uri"   => "https://github.com/you/my_gem/issues",
  "documentation_uri" => "https://rubydoc.info/gems/my_gem"
}
```

## Bundle Commands

### Essential Commands

```bash
# Install dependencies
bundle install

# Update all gems
bundle update

# Update specific gem
bundle update sidekiq

# Show outdated gems
bundle outdated

# Show gem info
bundle info sidekiq

# Add gem
bundle add sidekiq

# Remove gem (edit Gemfile, then)
bundle install
```

### Lock File

```bash
# Check for security vulnerabilities
bundle audit

# Update only Gemfile.lock
bundle lock

# Update lock for specific platform
bundle lock --add-platform x86_64-linux
```

### Binstubs

```bash
# Create binstubs
bundle binstubs rspec-core
bundle binstubs rubocop

# Create all binstubs
bundle binstubs --all

# Use binstubs
bin/rspec
bin/rubocop
```

### Bundler Config

```bash
# Set config
bundle config set path 'vendor/bundle'
bundle config set without 'development test'

# Show config
bundle config list

# Unset config
bundle config unset path
```

## Dependency Management

### Updating Safely

1. Check what will change:
   ```bash
   bundle outdated
   ```

2. Update one gem at a time:
   ```bash
   bundle update sidekiq --conservative
   ```

3. Run tests after each update

4. Commit Gemfile.lock separately for each gem

### Security Auditing

```bash
# Install bundler-audit
gem install bundler-audit

# Check for vulnerabilities
bundle audit check --update

# In CI
bundle audit check --update || exit 1
```

## Summary

1. Organize Gemfile by environment groups
2. Alphabetize gems within groups
3. Use pessimistic version constraints (`~>`)
4. Use `require: false` for CLI tools
5. Keep dependencies minimal
6. Update gems one at a time with tests
7. Run security audits regularly

## See Also

- `references/version-constraints.md` - Complete version constraint syntax and patterns
- `references/bundle-commands.md` - Bundler CLI command reference
- `references/gemspec-guide.md` - Gemspec fields and best practices
- `assets/templates/Gemfile.template` - Complete Gemfile scaffold
- `assets/templates/gemspec.template` - Complete gemspec template
