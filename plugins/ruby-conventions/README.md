# Ruby Conventions Plugin

A comprehensive Ruby conventions plugin covering binstubs, style guide, testing (RSpec/Minitest), gem conventions, and class design patterns. Includes 5 skills, 1 agent, and 2 PreToolUse hooks for enforcement.

## Skills

| Skill | Trigger Conditions | Purpose |
|-------|-------------------|---------|
| `ruby-binstubs` | Running gem commands in Ruby projects | Use `bin/*` binstubs instead of `bundle exec` |
| `ruby-style-guide` | Writing or editing `*.rb` files | Naming, method design, class structure, idiomatic Ruby |
| `ruby-testing` | Working on `*_spec.rb` or `*_test.rb` files | RSpec and Minitest conventions, test organization |
| `ruby-gem-conventions` | Editing `Gemfile`, `Gemfile.lock`, `*.gemspec` | Gem grouping, version constraints, bundle commands |
| `ruby-class-design` | Designing Ruby classes and modules | SOLID principles, composition, module patterns |

## Agent

### ruby-reviewer

Reviews Ruby code against all 5 convention skills.

**Usage:**
```
Review this Ruby code against conventions
```

The agent will:
1. Load all convention skills
2. Check each file against relevant conventions
3. Report violations with file:line references

## Hooks

### PreToolUse Hooks

The plugin includes two hooks that enforce conventions automatically.

#### 1. Edit/Write Hook (`ruby-conventions.sh`)

Blocks file edits until the appropriate convention skill is loaded.

**File Type → Required Skill:**

| Path Pattern | Required Skill |
|--------------|----------------|
| `Gemfile`, `Gemfile.lock`, `*.gemspec` | `ruby-gem-conventions` |
| `spec/*_spec.rb`, `spec_helper.rb` | `ruby-testing` |
| `test/*_test.rb`, `test_helper.rb` | `ruby-testing` |
| `*.rb` (general) | `ruby-style-guide` |

**Note:** Rails files (`app/*`, `config/*`, `db/*`) are skipped as they're handled by the `rails-conventions` plugin.

#### 2. Bash Hook (`bash-binstub-enforcer.sh`)

Intercepts shell commands and enforces binstub usage.

**Blocked Commands:**

| Instead of | Suggests |
|------------|----------|
| `bundle exec rspec` | `bin/rspec` |
| `bundle exec rubocop` | `bin/rubocop` |
| `bundle exec rake` | `bin/rake` |
| `rspec spec/` | `bin/rspec spec/` |
| `rubocop` | `bin/rubocop` |

**Behavior:**
- Only blocks when a binstub exists (checks for `bin/<gem>`)
- Allows commands when no binstub is available
- Suggests the correct binstub command

## Reference Files

### Testing References

The `ruby-testing` skill includes comprehensive reference documentation:

| File | Content |
|------|---------|
| `references/rspec.md` | Full RSpec API (describe, let, expectations, mocks) |
| `references/minitest.md` | Full Minitest API (assertions, setup, fixtures) |

## Installation

Add to your Claude Code configuration:

```json
{
  "plugins": [
    "path/to/ruby-conventions"
  ]
}
```

## Relationship with Other Plugins

| Plugin | Relationship |
|--------|--------------|
| `rails-conventions` | Complements - use both for Rails projects. Ruby-conventions skips Rails-specific paths. |
| `ruby-lsp` | Separate - LSP is infrastructure, not conventions |
| `conventional-commits` | Separate - language-agnostic, applies to all projects |

## License

MIT
