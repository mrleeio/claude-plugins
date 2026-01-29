# Webhook Dispatch

Relay events to external webhooks asynchronously.

## Relaying Concern

```ruby
# app/models/event/relaying.rb
module Event::Relaying
  extend ActiveSupport::Concern

  def relay_now
    account.webhooks.active.each do |webhook|
      webhook.deliver(payload)
    end
  end

  private
    def payload
      {
        event: action,
        eventable_type: eventable_type,
        eventable_id: eventable_id,
        creator_id: creator_id,
        particulars: particulars,
        created_at: created_at.iso8601
      }
    end
end
```

## Background Job

```ruby
# app/jobs/event/relay_job.rb
class Event::RelayJob < ApplicationJob
  def perform(event)
    event.relay_now
  end
end
```

## Webhook Model

```ruby
# app/models/webhook.rb
class Webhook < ApplicationRecord
  belongs_to :account

  scope :active, -> { where(active: true) }

  def deliver(payload)
    Webhook::DeliverJob.perform_later(self, payload)
  end
end

# app/jobs/webhook/deliver_job.rb
class Webhook::DeliverJob < ApplicationJob
  retry_on Net::OpenTimeout, wait: :polynomially_longer, attempts: 5

  def perform(webhook, payload)
    response = HTTP
      .timeout(10)
      .headers(webhook_headers(webhook))
      .post(webhook.url, json: payload)

    unless response.status.success?
      raise "Webhook delivery failed: #{response.status}"
    end
  end

  private
    def webhook_headers(webhook)
      {
        "Content-Type" => "application/json",
        "X-Webhook-Signature" => sign_payload(webhook, payload)
      }
    end

    def sign_payload(webhook, payload)
      OpenSSL::HMAC.hexdigest("SHA256", webhook.secret, payload.to_json)
    end
end
```

## Payload Structure

```json
{
  "event": "moved",
  "eventable_type": "Card",
  "eventable_id": "abc-123",
  "creator_id": "user-456",
  "particulars": {
    "old_column_id": "col-1",
    "new_column_id": "col-2"
  },
  "created_at": "2024-01-15T10:30:00Z"
}
```

## Webhook Table

```ruby
class CreateWebhooks < ActiveRecord::Migration[7.1]
  def change
    create_table :webhooks, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.string :url, null: false
      t.string :secret, null: false
      t.boolean :active, default: true
      t.string :events, array: true, default: []  # Filter by event types
      t.timestamps
    end
  end
end
```

## Filtering Events

```ruby
# Only relay specific event types
def relay_now
  account.webhooks.active.each do |webhook|
    if webhook.events.empty? || webhook.events.include?(action)
      webhook.deliver(payload)
    end
  end
end
```
