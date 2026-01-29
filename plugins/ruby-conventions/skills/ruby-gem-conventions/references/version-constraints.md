# Version Constraints Reference

Quick reference for RubyGems version constraint syntax.

## Constraint Syntax

| Constraint | Meaning | Matches | Does NOT Match |
|------------|---------|---------|----------------|
| `"1.2.3"` | Exact version | 1.2.3 only | Any other version |
| `">= 1.2"` | At least | 1.2.0, 1.3.0, 2.0.0, 5.0.0 | 1.1.9 |
| `"< 2.0"` | Less than | 1.0.0, 1.9.9 | 2.0.0, 2.0.1 |
| `"~> 1.2"` | Pessimistic major | 1.2.0 to 1.999.999 | 2.0.0 |
| `"~> 1.2.3"` | Pessimistic minor | 1.2.3 to 1.2.999 | 1.3.0 |
| `">= 1.0, < 2.0"` | Range | 1.0.0 to 1.999.999 | 0.9.9, 2.0.0 |

## Pessimistic Operator (~>) Explained

The pessimistic operator allows updates within a version segment:

```
~> 1.0   → >= 1.0, < 2.0    (allows 1.x updates)
~> 1.2   → >= 1.2, < 2.0    (allows 1.x updates)
~> 1.2.3 → >= 1.2.3, < 1.3  (allows 1.2.x updates)
~> 0.9   → >= 0.9, < 1.0    (allows 0.9.x updates)
```

## Recommended Patterns by Gem Type

| Gem Type | Constraint | Rationale |
|----------|------------|-----------|
| Rails/Framework | `~> 7.1.0` | Lock minor, allow patches |
| Database adapters | `~> 1.5` | Lock major, allow minor |
| Stable utilities | `~> 7.0` | Lock major, allow minor |
| Rapidly changing/beta | `~> 0.9.1` | Lock tight during instability |
| Internal gems | No constraint | You control the source |

## Examples

```ruby
# Framework - lock to minor version for stability
gem "rails", "~> 7.1.0"

# Database - lock to major, allow minor updates
gem "pg", "~> 1.5"
gem "redis", "~> 5.0"

# Stable utilities - lock to major
gem "sidekiq", "~> 7.0"
gem "puma", "~> 6.0"

# Pre-1.0 gems - lock tight (API may change)
gem "some-beta-gem", "~> 0.9.1"

# Known problematic version - exact match
gem "problematic-gem", "1.2.3"

# Security fixes only - range
gem "critical-gem", ">= 1.2.1", "< 2.0"
```

## Version Precedence

Bundler resolves the newest version matching all constraints:

```ruby
gem "rails", "~> 7.0"      # Allows 7.0.0 to 7.999
gem "rails", ">= 7.1"      # Combined: 7.1.0 to 7.999
```
