# Gemspec Reference

Guide to writing gemspec files for Ruby gems.

## Required Fields

Every gemspec must include:

| Field | Purpose |
|-------|---------|
| `name` | Gem name (lowercase, underscores) |
| `version` | Semantic version |
| `authors` | Array of author names |
| `summary` | One-line description |
| `files` | Array of files to include |
| `require_paths` | Directories to add to load path |

## Complete Gemspec Structure

```ruby
Gem::Specification.new do |spec|
  # Identity
  spec.name          = "my_gem"
  spec.version       = MyGem::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["your.email@example.com"]

  # Description
  spec.summary       = "Short summary (max 140 chars)"
  spec.description   = "Longer description of the gem's purpose and features"
  spec.homepage      = "https://github.com/username/my_gem"
  spec.license       = "MIT"

  # Requirements
  spec.required_ruby_version = ">= 3.0"
  spec.required_rubygems_version = ">= 3.0"

  # Files
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match?(%r{\A(?:test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "activesupport", ">= 6.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # Metadata
  spec.metadata = {
    "homepage_uri"      => spec.homepage,
    "source_code_uri"   => "https://github.com/username/my_gem",
    "changelog_uri"     => "https://github.com/username/my_gem/blob/main/CHANGELOG.md",
    "bug_tracker_uri"   => "https://github.com/username/my_gem/issues",
    "documentation_uri" => "https://rubydoc.info/gems/my_gem",
    "rubygems_mfa_required" => "true"
  }
end
```

## Dependencies

### Runtime Dependencies

Installed when users install your gem:

```ruby
# Required at runtime
spec.add_dependency "activesupport", ">= 6.0"
spec.add_dependency "zeitwerk", "~> 2.0"

# Use pessimistic constraints
spec.add_dependency "faraday", "~> 2.0"
```

### Development Dependencies

Only used during gem development:

```ruby
# Testing
spec.add_development_dependency "rspec", "~> 3.0"
spec.add_development_dependency "webmock", "~> 3.0"

# Code quality
spec.add_development_dependency "rubocop", "~> 1.0"
spec.add_development_dependency "rubocop-rspec", "~> 2.0"
```

### Runtime vs Development

| Type | When Installed | Use For |
|------|----------------|---------|
| Runtime (`add_dependency`) | Always | Gems needed to run your gem |
| Development (`add_development_dependency`) | Only with `bundle install` | Testing, linting, docs |

## File Selection Patterns

### Git-based (Recommended)

```ruby
spec.files = Dir.chdir(__dir__) do
  `git ls-files -z`.split("\x0").reject do |f|
    f.match?(%r{\A(?:test|spec|features)/}) ||
    f.match?(%r{\.gem\z}) ||
    f.start_with?(".")
  end
end
```

### Dir-based (Alternative)

```ruby
spec.files = Dir[
  "lib/**/*",
  "exe/*",
  "LICENSE.txt",
  "README.md",
  "CHANGELOG.md"
]
```

## Metadata Fields

Recommended metadata for discoverability:

| Key | Purpose |
|-----|---------|
| `homepage_uri` | Project homepage |
| `source_code_uri` | Source repository |
| `changelog_uri` | CHANGELOG location |
| `bug_tracker_uri` | Issue tracker |
| `documentation_uri` | Documentation site |
| `rubygems_mfa_required` | Require MFA for publish |

## Extensions (Native Gems)

For gems with C extensions:

```ruby
spec.extensions = ["ext/my_gem/extconf.rb"]
spec.files += Dir["ext/**/*"]
```

## Common Licenses

| License | SPDX Identifier |
|---------|-----------------|
| MIT | `"MIT"` |
| Apache 2.0 | `"Apache-2.0"` |
| BSD 3-Clause | `"BSD-3-Clause"` |
| GPL 3.0 | `"GPL-3.0"` |
| LGPL 3.0 | `"LGPL-3.0"` |

## Version Module Pattern

Store version in a dedicated file:

```ruby
# lib/my_gem/version.rb
module MyGem
  VERSION = "1.0.0"
end

# my_gem.gemspec
require_relative "lib/my_gem/version"

Gem::Specification.new do |spec|
  spec.version = MyGem::VERSION
end
```
