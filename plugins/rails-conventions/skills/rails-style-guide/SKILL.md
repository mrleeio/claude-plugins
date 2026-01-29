---
name: rails-style-guide
description: Use for Ruby/Rails code style conventions. Covers method ordering, guard clauses, visibility modifiers, and naming patterns.
---

# Ruby/Rails Style Guide

These conventions prioritize readability and consistency. Code should be a pleasure to read.

## Conditional Returns

**Prefer expanded conditionals over guard clauses:**

```ruby
# Avoid
def todos_for_new_group
  ids = params.require(:todolist)[:todo_ids]
  return [] unless ids
  @bucket.recordings.todos.find(ids.split(","))
end

# Prefer
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
# Good: save! exists because save exists
user.save!

# Good: Custom method with counterpart
def process
  # returns false on failure
end

def process!
  # raises on failure
end

# Avoid: No non-bang counterpart
def destroy_everything!  # Just use destroy_everything
end
```

Don't use `!` to flag destructive actions. Many Ruby/Rails methods are destructive without bangs (`delete`, `destroy`, `update`).

## CRUD Controllers

Model actions as CRUD on resources, not custom actions:

```ruby
# Avoid
resources :cards do
  post :close
  post :reopen
end

# Prefer
resources :cards do
  resource :closure
end
```

## Controller-Model Interaction

**Thin controllers, rich models. No service objects by default:**

```ruby
# Simple operations: direct ActiveRecord
class Cards::CommentsController < ApplicationController
  def create
    @comment = @card.comments.create!(comment_params)
  end
end

# Complex operations: intention-revealing model methods
class Cards::GoldnessesController < ApplicationController
  def create
    @card.gild
  end
end
```

## Async Operations in Jobs

**Thin job classes that delegate to models:**

```ruby
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
