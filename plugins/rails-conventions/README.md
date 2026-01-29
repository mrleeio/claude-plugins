# Rails Conventions Plugin

A comprehensive Rails conventions plugin covering project structure, coding patterns, Hotwire (Turbo/Stimulus), ViewComponent, and architectural patterns inspired by 37signals/Basecamp. Includes 16 skills, 1 command, a code review agent, and a PreToolUse hook for enforcement.

## Skills

### Project Convention Skills

| Skill | Trigger Conditions | Purpose |
|-------|-------------------|---------|
| `rails-controller-conventions` | Working on `app/controllers/**/*.rb` | Thin controllers, authorization, message passing, RESTful patterns |
| `rails-model-conventions` | Working on `app/models/**/*.rb` | Business logic, clean interfaces, concerns organization |
| `rails-view-conventions` | Working on `app/views/**`, `app/components/**/*.rb`, `app/helpers/**` | Hotwire-first, ViewComponents over helpers, no custom helpers |
| `rails-policy-conventions` | Working on `app/policies/**/*.rb` | Permission-only Pundit policies, role hierarchy |
| `rails-job-conventions` | Working on `app/jobs/**/*.rb` | Idempotent background jobs, thin dispatchers |
| `rails-migration-conventions` | Working on `db/migrate/**/*.rb` | Safe, reversible migrations, proper indexing |
| `rails-stimulus-conventions` | Working on `*_controller.js` files | Thin controllers, Turbo-first, cleanup requirements |
| `rails-testing-conventions` | Working on `spec/**/*.rb` | No mocking behavior, explicit factories, spec organization |

### API Reference Skills

| Skill | Trigger Conditions | Purpose |
|-------|-------------------|---------|
| `hotwire` | Working on Turbo Frames, Turbo Streams, Stimulus controllers, or interactive Rails features | Turbo and Stimulus API reference, patterns, best practices |
| `viewcomponent` | Working on ViewComponents, component slots, previews, or reusable UI components | ViewComponent API reference, slots, testing, best practices |

### Architectural Pattern Skills

| Skill | Trigger Conditions | Purpose |
|-------|-------------------|---------|
| `rails-current-attributes` | Working on `app/models/current.rb`, request-scoped state | CurrentAttributes pattern for user/account context |
| `rails-multitenancy` | Working on tenant middleware, URL-based tenancy | Path-based multi-tenancy with SCRIPT_NAME |
| `rails-events` | Working on `app/models/event.rb`, activity logs, webhooks | Polymorphic event tracking for audit trails |
| `rails-state-resources` | Working on closures, pins, watches controllers | Model state as CRUD on sub-resources |
| `rails-notifications` | Working on `app/models/notification.rb`, notifiers | Polymorphic notification system with factory pattern |
| `rails-style-guide` | Code style questions, method ordering, visibility | Ruby/Rails coding conventions |

## Command

### `/new-component`

Interactive command to create a new ViewComponent with proper structure:
- Gathers component name, type, and options
- Supports slots, collections, and wrapper patterns
- Generates component class, template, preview, and test files
- Follows ViewComponent naming conventions

## Agent

### rails-reviewer

Reviews Rails code against all 10 convention skills. Use after spec compliance review passes, before code quality review.

**Usage:**
```
Review this PR against Rails conventions
```

The agent will:
1. Load all convention skills (including hotwire and viewcomponent)
2. Check each file against relevant conventions
3. Report violations with file:line references

## Hook

### PreToolUse Hook

The `rails-conventions.sh` hook blocks file edits until the appropriate convention skill is loaded.

**Behavior:**
- Triggers on `Edit`, `Write`, `MultiEdit` tools
- Detects Rails file types by path pattern
- Blocks with exit code 2 if skill not loaded
- Logs decisions to `/tmp/claude-skill-usage.log`

**File Type → Required Skill:**

| Path Pattern | Required Skill |
|--------------|----------------|
| `app/models/current.rb` | `rails-current-attributes` |
| `app/models/event.rb`, `concerns/eventable.rb` | `rails-events` |
| `app/models/notification.rb`, `notifier*.rb` | `rails-notifications` |
| `**/closures_controller.rb`, `pins_controller.rb` | `rails-state-resources` |
| `config/initializers/*tenant*.rb` | `rails-multitenancy` |
| `app/controllers/**/*.rb` | `rails-controller-conventions` |
| `app/models/**/*.rb` | `rails-model-conventions` |
| `app/views/**/*.erb` | `rails-view-conventions` |
| `app/helpers/**/*.rb` | `rails-view-conventions` |
| `app/components/**/*.rb` | `rails-view-conventions` |
| `*_controller.js` | `rails-stimulus-conventions` |
| `app/policies/**/*.rb` | `rails-policy-conventions` |
| `app/jobs/**/*.rb` | `rails-job-conventions` |
| `db/migrate/**/*.rb` | `rails-migration-conventions` |
| `spec/**/*.rb` | `rails-testing-conventions` |

## Reference Files

### ViewComponent References

The `viewcomponent` skill includes comprehensive reference documentation:

| File | Content |
|------|---------|
| `references/api.md` | Full API reference (methods, config, errors) |
| `references/slots.md` | Slots API (renders_one, renders_many, polymorphic) |
| `references/previews.md` | Preview system and configuration |
| `references/testing.md` | Testing helpers and patterns |
| `references/collections.md` | with_collection, counters, iteration |
| `references/generators.md` | Rails generators and options |
| `references/helpers.md` | Accessing Rails helpers |
| `references/lifecycle.md` | before_render, around_render hooks |
| `references/templates.md` | Template options, inline, variants |
| `references/translations.md` | i18n and locale files |
| `references/best-practices.md` | Organization, composition, anti-patterns |

### Convention Skill References

Several convention skills include additional reference documentation:

| Skill | Reference | Content |
|-------|-----------|---------|
| `rails-controller-conventions` | `references/scoped-concerns.md` | DRY resource loading with controller concerns |
| `rails-model-conventions` | `references/concerns.md` | Composable model behaviors with namespaced concerns |
| `rails-job-conventions` | `references/multitenancy.md` | Preserving Current.account in background jobs |
| `rails-testing-conventions` | `references/fixture-testing.md` | Rails fixtures for multi-tenant test setup |

## Installation

Add to your Claude Code configuration:

```json
{
  "plugins": [
    "path/to/rails-conventions"
  ]
}
```

## License

MIT
