# Eventable Concern

Include this concern in models that should track events.

## Concern Definition

```ruby
# app/models/concerns/eventable.rb
module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable, dependent: :destroy
  end

  def track_event(action, creator: Current.user, **particulars)
    events.create!(
      account: account,
      creator: creator,
      action: action,
      particulars: particulars
    )
  end
end
```

## Using in Models

```ruby
# app/models/card.rb
class Card < ApplicationRecord
  include Eventable

  belongs_to :account
  belongs_to :column

  def move_to(new_column, user: Current.user)
    old_column = column

    transaction do
      update!(column: new_column)
      track_event :moved, creator: user,
        old_column_id: old_column.id,
        new_column_id: new_column.id
    end
  end

  def close(user: Current.user)
    transaction do
      update!(closed_at: Time.current)
      track_event :closed, creator: user
    end
  end

  def assign_to(assignee, user: Current.user)
    transaction do
      update!(assignee: assignee)
      track_event :assigned, creator: user,
        assignee_id: assignee.id,
        assignee_name: assignee.name
    end
  end
end
```

## Displaying Events

```ruby
# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
    @events = @card.events.recent.includes(:creator)
  end
end
```

```erb
<%# app/views/cards/_events.html.erb %>
<% events.each do |event| %>
  <div class="event">
    <span class="creator"><%= event.creator.name %></span>
    <span class="action"><%= event.action %></span>
    <span class="time"><%= time_ago_in_words(event.created_at) %> ago</span>
  </div>
<% end %>
```

## Best Practices

| Do | Don't |
|----|-------|
| Track in explicit methods | Track in `after_save` callbacks |
| Use domain action names | Use generic "updated" |
| Include relevant particulars | Store everything |
| Wrap in transactions | Create events outside transactions |

## Event Actions by Domain

| Domain | Actions |
|--------|---------|
| Cards | created, moved, closed, reopened, assigned, unassigned |
| Comments | created, edited, deleted |
| Projects | created, archived, restored |
| Users | invited, removed, role_changed |
