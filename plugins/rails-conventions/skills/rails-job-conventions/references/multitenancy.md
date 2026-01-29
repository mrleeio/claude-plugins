# Background Jobs with Multi-Tenant Context

Ensure background jobs automatically preserve and restore tenant context. Jobs should seamlessly work with `Current.account` without manual context passing.

## The Problem

When you enqueue a job, the request context (including `Current.account`) is lost:

```ruby
# This won't work - Current.account is nil when job runs
class NotifyWatchersJob < ApplicationJob
  def perform(card)
    card.watchers.each do |watcher|
      # Current.account is nil here!
      NotificationMailer.card_updated(watcher, card).deliver_later
    end
  end
end
```

## Solution: Auto-Serialize Account Context

Extend ActiveJob to automatically capture and restore `Current.account`:

```ruby
# config/initializers/active_job.rb
module FizzyActiveJobExtensions
  extend ActiveSupport::Concern

  included do
    # Capture account when job is enqueued
    attr_accessor :current_account_gid

    before_enqueue do |job|
      job.current_account_gid = Current.account&.to_global_id&.to_s
    end

    # Restore account when job runs
    around_perform do |job, block|
      if job.current_account_gid
        account = GlobalID::Locator.locate(job.current_account_gid)
        Current.with_account(account) { block.call }
      else
        block.call
      end
    end
  end
end

Rails.application.config.after_initialize do
  ActiveJob::Base.prepend(FizzyActiveJobExtensions)
end
```

Now jobs automatically have access to `Current.account`:

```ruby
class NotifyWatchersJob < ApplicationJob
  def perform(card)
    # Current.account is automatically restored!
    card.watchers.each do |watcher|
      NotificationMailer.card_updated(watcher, card).deliver_later
    end
  end
end
```

## Job Naming Conventions

Use `_later` suffix for methods that enqueue jobs, `_now` suffix for synchronous execution:

```ruby
# app/models/event/relaying.rb
module Event::Relaying
  extend ActiveSupport::Concern

  included do
    after_create_commit :relay_later
  end

  def relay_later
    Event::RelayJob.perform_later(self)
  end

  def relay_now
    account.webhooks.active.each do |webhook|
      webhook.deliver(payload)
    end
  end
end

# app/jobs/event/relay_job.rb
class Event::RelayJob < ApplicationJob
  def perform(event)
    event.relay_now
  end
end
```

## Thin Job Classes

Jobs should be thin wrappers that delegate to model methods:

```ruby
# Good: Thin job delegating to model
class Card::AutoPostponeJob < ApplicationJob
  def perform(card)
    card.auto_postpone_if_stale
  end
end

# Avoid: Business logic in job
class Card::AutoPostponeJob < ApplicationJob
  def perform(card)
    return if card.closed?
    return if card.updated_at > card.entropy_period.ago

    card.transaction do
      card.create_not_now!(user: card.account.system_user)
      card.track_event(:auto_postponed)
    end
  end
end
```

## Handling Deserialization Errors

When records are deleted between enqueue and perform, handle gracefully:

```ruby
class ApplicationJob < ActiveJob::Base
  # Discard job if the record was deleted
  discard_on ActiveJob::DeserializationError

  # Or retry with backoff
  retry_on ActiveJob::DeserializationError, wait: :polynomially_longer, attempts: 3
end
```

## Recurring Jobs

For scheduled tasks, use `solid_queue` recurring jobs:

```yaml
# config/recurring.yml
production:
  auto_postpone_stale_cards:
    class: Cards::AutoPostponeAllJob
    schedule: every hour

  deliver_bundled_notifications:
    class: Notifications::DeliverBundledJob
    schedule: every 30 minutes
```

The job iterates over accounts:

```ruby
# app/jobs/cards/auto_postpone_all_job.rb
class Cards::AutoPostponeAllJob < ApplicationJob
  def perform
    Account.find_each do |account|
      Current.with_account(account) do
        account.cards.stale.find_each(&:auto_postpone_if_stale)
      end
    end
  end
end
```

## Testing Jobs

```ruby
# test/jobs/notify_watchers_job_test.rb
class NotifyWatchersJobTest < ActiveJob::TestCase
  setup do
    Current.account = accounts(:default)
    @card = cards(:one)
  end

  teardown do
    Current.clear_all
  end

  test "notifies all watchers" do
    @card.watch(user: users(:alice))
    @card.watch(user: users(:bob))

    assert_emails 2 do
      NotifyWatchersJob.perform_now(@card)
    end
  end

  test "runs within account context" do
    perform_enqueued_jobs do
      NotifyWatchersJob.perform_later(@card)
    end

    # Verify the job ran with correct account context
    assert_equal accounts(:default), @card.notifications.last.account
  end
end
```

## Best Practices

1. **Auto-serialize context**: Use the extension pattern to automatically preserve `Current.account`
2. **Thin jobs**: Jobs should only call model methods, not contain business logic
3. **`_later`/`_now` naming**: Clear convention for async vs sync execution
4. **Handle missing records**: Use `discard_on` for records that may be deleted
5. **Test with context**: Set up `Current.account` in job tests
6. **Iterate over accounts**: Recurring jobs should explicitly loop over accounts
