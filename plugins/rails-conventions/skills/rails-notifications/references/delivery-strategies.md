# Notification Delivery Strategies

Two delivery strategies: immediate and bundled (digest).

## Immediate Delivery

Sends email as soon as notification is created:

```ruby
# app/jobs/notification/deliver_job.rb
class Notification::DeliverJob < ApplicationJob
  def perform(notification)
    return if notification.user.notifications_paused?

    NotificationMailer.notification(notification).deliver_now
  end
end
```

Triggered via callback:

```ruby
# In Notification model
after_create_commit :deliver_later

private
  def deliver_later
    Notification::DeliverJob.perform_later(self)
  end
```

## Bundled Delivery (Digest)

Collects notifications and sends periodic digest emails:

```ruby
# app/jobs/notifications/deliver_bundled_job.rb
class Notifications::DeliverBundledJob < ApplicationJob
  def perform
    User.wants_bundled_notifications.find_each do |user|
      notifications = user.notifications.unbundled.recent

      if notifications.any?
        NotificationMailer.bundled(user, notifications).deliver_now
        notifications.update_all(bundled_at: Time.current)
      end
    end
  end
end
```

Schedule in `config/recurring.yml`:

```yaml
production:
  deliver_bundled_notifications:
    class: Notifications::DeliverBundledJob
    schedule: every 30 minutes
```

## User Preference Scope

```ruby
# app/models/user.rb
class User < ApplicationRecord
  scope :wants_bundled_notifications, -> {
    where(notification_delivery: 'bundled')
  }

  def notifications_paused?
    notification_delivery == 'paused'
  end
end
```

## Delivery Options

| Option | Behavior | Use Case |
|--------|----------|----------|
| `immediate` | Email per notification | Time-sensitive alerts |
| `bundled` | Periodic digest email | Reduce email volume |
| `paused` | No emails | User preference |

## Mailer Examples

```ruby
# app/mailers/notification_mailer.rb
class NotificationMailer < ApplicationMailer
  def notification(notification)
    @notification = notification
    mail to: notification.user.email,
         subject: notification_subject(notification)
  end

  def bundled(user, notifications)
    @user = user
    @notifications = notifications
    mail to: user.email,
         subject: "#{notifications.count} new notifications"
  end
end
```
