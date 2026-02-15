---
name: rails-style-guide
description: Use for Ruby/Rails code style conventions. Covers method ordering, guard clauses, visibility modifiers, and naming patterns.
---

# Ruby/Rails Style Guide

These conventions prioritize readability and consistency. Code should be a pleasure to read.

## Quick Reference

| Do | Don't |
|----|-------|
| Prefer expanded conditionals over guard clauses | Use guard clauses for mid-method returns |
| Order methods by invocation order | Random method ordering |
| Indent private methods under `private` keyword | Add blank line after `private` |
| Use `!` only when a non-bang counterpart exists | Use `!` to flag destructive actions |
| Model actions as CRUD on sub-resources | Add custom actions to controllers |
| Keep controllers thin, models rich | Put business logic in controllers |
| Use `_later`/`_now` suffix for async patterns | Inconsistent async naming |
| Match surrounding code style | Introduce new patterns unilaterally |

## Conditional Returns

```ruby
# WRONG - guard clause for mid-method return
def todos_for_new_group
  ids = params.require(:todolist)[:todo_ids]
  return [] unless ids
  @bucket.recordings.todos.find(ids.split(","))
end

# RIGHT - expanded conditional
def todos_for_new_group
  if ids = params.require(:todolist)[:todo_ids]
    @bucket.recordings.todos.find(ids.split(","))
  else
    []
  end
end
```

**Exception: Guard clauses are acceptable when:**
- The return is at the very beginning of the method
- The main body is non-trivial (several lines of code)

```ruby
# RIGHT - guard clause at the very beginning
def after_recorded_as_commit(recording)
  return if recording.parent.was_created?

  if recording.was_created?
    broadcast_new_column(recording)
  else
    broadcast_column_change(recording)
  end
end
```

## Method Ordering

Order methods in classes:

1. Class methods
2. Public methods (with `initialize` first)
3. Private methods

```ruby
class Card
  def self.recent
    order(created_at: :desc)
  end

  def initialize(attributes = {})
    super
  end

  def close
    # ...
  end

  def reopen
    # ...
  end

  private
    def track_closure
      # ...
    end
end
```

## Invocation Order

Order methods vertically based on their invocation order:

```ruby
class SomeClass
  def some_method
    method_1
    method_2
  end

  private
    def method_1
      method_1_1
      method_1_2
    end

    def method_1_1
      # ...
    end

    def method_1_2
      # ...
    end

    def method_2
      method_2_1
      method_2_2
    end

    def method_2_1
      # ...
    end

    def method_2_2
      # ...
    end
end
```

## Visibility Modifiers

**No newline after `private`, indent content under it:**

```ruby
# WRONG
class SomeClass
  private

  def some_private_method
    # ...
  end
end

# RIGHT
class SomeClass
  def some_method
    # ...
  end

  private
    def some_private_method_1
      # ...
    end

    def some_private_method_2
      # ...
    end
end
```

**Exception: Modules with only private methods:**

```ruby
module SomeModule
  private

  def some_private_method
    # ...
  end
end
```

## Bang Methods

**Only use `!` when there's a non-bang counterpart:**

```ruby
# WRONG - no non-bang counterpart exists
def destroy_everything!  # Just use destroy_everything
end

# RIGHT - bang has a non-bang pair
def process
  # returns false on failure
end

def process!
  # raises on failure
end
```

Don't use `!` to flag destructive actions. Many Ruby/Rails methods are destructive without bangs (`delete`, `destroy`, `update`).

## CRUD Controllers

Model actions as CRUD on resources, not custom actions:

```ruby
# WRONG - custom actions
resources :cards do
  post :close
  post :reopen
end

# RIGHT - sub-resources
resources :cards do
  resource :closure
end
```

## Controller-Model Interaction

**Thin controllers, rich models. No service objects by default:**

```ruby
# WRONG - business logic in controller
class CardsController < ApplicationController
  def close
    @card.update!(closed_at: Time.current)
    Event.create!(action: :closed, eventable: @card, creator: Current.user)
    NotificationJob.perform_later(@card)
  end
end

# RIGHT - simple operations: direct ActiveRecord
class Cards::CommentsController < ApplicationController
  def create
    @comment = @card.comments.create!(comment_params)
  end
end

# RIGHT - complex operations: intention-revealing model methods
class Cards::GoldnessesController < ApplicationController
  def create
    @card.gild
  end
end
```

## Async Operations in Jobs

**Use `_later`/`_now` suffix convention. Thin job classes that delegate to models:**

```ruby
# WRONG - inconsistent naming, logic in job
class Event::RelayJob < ApplicationJob
  def perform(event)
    event.account.webhooks.active.each { |w| w.deliver(event.payload) }
  end
end

# RIGHT - _later/_now convention, thin job
module Event::Relaying
  extend ActiveSupport::Concern

  included do
    after_create_commit :relay_later
  end

  # _later suffix: enqueues job
  def relay_later
    Event::RelayJob.perform_later(self)
  end

  # _now suffix: synchronous execution
  def relay_now
    account.webhooks.active.each { |w| w.deliver(payload) }
  end
end

class Event::RelayJob < ApplicationJob
  def perform(event)
    event.relay_now
  end
end
```

## Common Mistakes

1. **Guard clauses for complex returns**: Guard clauses are for simple early exits at the top of methods. For conditional returns in the middle, use expanded `if/else`
2. **Blank line after `private`**: Indent methods under `private` without a blank line. The indentation visually groups them
3. **Business logic in controllers**: Controllers should only route requests to model methods. Move multi-step operations into the model
4. **Custom controller actions**: Actions like `post :close` bypass REST conventions. Model them as CRUD on sub-resources (`resource :closure`)
5. **Using `!` without a counterpart**: The `!` suffix means "this is the dangerous version of the non-bang method." Without a non-bang counterpart, the `!` is meaningless
6. **Random method ordering**: Methods should follow their invocation order. Private helpers should appear directly below the public method that calls them
7. **Logic in job classes**: Jobs should be thin wrappers that call model methods. Keep the logic in the model so it can be tested without the job infrastructure
8. **Inconsistent async naming**: Always pair `_later` (enqueues) and `_now` (synchronous) methods for async operations

## General Principles

1. **Readability first**: Code should be pleasant to read
2. **Find similar code**: When unsure, look at existing code for patterns
3. **Discuss code**: Pull requests are great for discussing style questions
4. **Consistency**: Match the style of surrounding code
5. **Simplicity**: Don't over-engineer; keep solutions focused

## See Also

- [Conditionals](references/conditionals.md) - Guard clauses vs expanded conditionals
- [Method Ordering](references/method-ordering.md) - Class and invocation order
- [Visibility Modifiers](references/visibility-modifiers.md) - Private placement and indentation
- [Async Patterns](references/async-patterns.md) - _later/_now suffix conventions
