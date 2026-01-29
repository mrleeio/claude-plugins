# Notifier Factory Pattern

Route notifications to type-specific notifiers using a factory class.

## Base Notifier Class

```ruby
# app/models/notifier.rb
class Notifier
  attr_reader :source

  class << self
    def for(source)
      case source
      when Event
        notifier_for_event(source)
      when Mention
        MentionNotifier.new(source)
      end
    end

    private
      def notifier_for_event(event)
        # Route to event-type-specific notifier
        "Notifier::#{event.eventable.class}EventNotifier".safe_constantize&.new(event)
      end
  end

  def notify
    if should_notify?
      recipients.sort_by(&:id).each do |recipient|
        Notification.create!(
          account: source.account,
          user: recipient,
          source: source,
          creator: creator
        )
      end
    end
  end

  private
    def initialize(source)
      @source = source
    end

    def should_notify?
      !creator.system?
    end

    def creator
      raise NotImplementedError
    end

    def recipients
      raise NotImplementedError
    end
end
```

## How It Works

1. **Factory method** (`Notifier.for`) receives a source object
2. **Routes** to the appropriate specific notifier based on source type
3. **Base `notify` method** handles common logic (exclusions, creation)
4. **Subclasses** implement `creator` and `recipients`

## Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| Sort recipients by ID | Prevents deadlocks in concurrent notification creation |
| Check `should_notify?` | Skip notifications for system/automated actions |
| Use `safe_constantize` | Gracefully handle missing notifier classes |
| Exclude creator | Never notify the person who triggered the action |

## Adding New Notifiers

1. Create a new subclass in `app/models/notifier/`
2. Implement `creator` and `recipients` methods
3. Optionally override `should_notify?` for action-specific filtering
4. Register in the factory's `for` method if needed
