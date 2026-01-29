# Async Operation Patterns

Naming conventions for synchronous and asynchronous operations.

## The `_later` / `_now` Pattern

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
```

## Thin Job Classes

Jobs delegate to model methods:

```ruby
class Event::RelayJob < ApplicationJob
  def perform(event)
    event.relay_now
  end
end
```

## Naming Conventions

| Suffix | Meaning | Example |
|--------|---------|---------|
| `_later` | Enqueues a background job | `notify_later` |
| `_now` | Executes synchronously | `notify_now` |
| (no suffix) | Default behavior varies | `notify` |

## Common Patterns

### Notification

```ruby
class Notification
  after_create_commit :deliver_later

  def deliver_later
    Notification::DeliverJob.perform_later(self)
  end

  def deliver_now
    NotificationMailer.notification(self).deliver_now
  end
end
```

### Processing

```ruby
class Import
  def process_later
    Import::ProcessJob.perform_later(self)
  end

  def process_now
    rows.each { |row| process_row(row) }
    update!(processed_at: Time.current)
  end
end
```

### Webhooks

```ruby
class Webhook
  def deliver_later(payload)
    Webhook::DeliverJob.perform_later(self, payload)
  end

  def deliver_now(payload)
    HTTP.post(url, json: payload)
  end
end
```

## Callback Patterns

Use `after_create_commit` for async operations:

```ruby
class Comment < ApplicationRecord
  after_create_commit :notify_later
  after_create_commit :index_later

  private
    def notify_later
      Comment::NotifyJob.perform_later(self)
    end

    def index_later
      Comment::IndexJob.perform_later(self)
    end
end
```

## Testing

```ruby
# Test synchronous behavior
test "relay_now sends to webhooks" do
  event.relay_now
  assert_requested :post, webhook.url
end

# Test async enqueuing
test "relay_later enqueues job" do
  assert_enqueued_with(job: Event::RelayJob, args: [event]) do
    event.relay_later
  end
end

# Test full integration
test "creating event triggers relay" do
  perform_enqueued_jobs do
    Event.create!(...)
  end
  assert_requested :post, webhook.url
end
```

## When to Use Each

| Use | When |
|-----|------|
| `_later` | Default for side effects (notifications, webhooks) |
| `_now` | Testing, console debugging, immediate need |
| Callback + `_later` | Automatic async on model events |
