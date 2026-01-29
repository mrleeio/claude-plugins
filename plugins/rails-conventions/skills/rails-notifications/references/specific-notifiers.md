# Specific Notifier Implementations

Examples of type-specific notifiers that extend the base Notifier class.

## Card Event Notifier

Notifies watchers when card actions occur:

```ruby
# app/models/notifier/card_event_notifier.rb
class Notifier::CardEventNotifier < Notifier
  private
    def creator
      source.creator
    end

    def recipients
      source.eventable.watchers.where.not(id: creator)
    end

    def should_notify?
      super && source.action.in?(%w[closed reopened assigned moved])
    end
end
```

## Comment Event Notifier

Notifies card watchers when comments are added:

```ruby
# app/models/notifier/comment_event_notifier.rb
class Notifier::CommentEventNotifier < Notifier
  private
    def creator
      source.creator
    end

    def recipients
      card.watchers.where.not(id: creator)
    end

    def card
      source.eventable.card
    end
end
```

## Mention Notifier

Notifies users when they're mentioned:

```ruby
# app/models/notifier/mention_notifier.rb
class Notifier::MentionNotifier < Notifier
  private
    def creator
      source.mentioner
    end

    def recipients
      [source.mentioned_user].compact - [creator]
    end
end
```

## Implementation Patterns

| Pattern | Example |
|---------|---------|
| Filter by action | `source.action.in?(%w[closed reopened])` |
| Exclude creator | `watchers.where.not(id: creator)` |
| Handle nil values | `[user].compact - [creator]` |
| Navigate associations | `source.eventable.card.watchers` |

## Creating a New Notifier

```ruby
# app/models/notifier/my_event_notifier.rb
class Notifier::MyEventNotifier < Notifier
  private
    def creator
      source.user  # Who triggered the action
    end

    def recipients
      # Who should be notified (excluding creator)
      source.subscribers.where.not(id: creator)
    end

    def should_notify?
      # Optional: filter which actions trigger notifications
      super && relevant_action?
    end

    def relevant_action?
      # Your filtering logic
    end
end
```
