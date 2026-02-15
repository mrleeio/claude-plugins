---
name: rails-state-resources
description: Use when modeling state changes as RESTful resources (open/close, pin/unpin). Covers CRUD-based state transitions.
---

# Model State Changes as CRUD on Sub-Resources

Instead of adding custom actions like `post :close` or `patch :archive`, model state transitions as creating or destroying a sub-resource. This keeps controllers RESTful and thin.

## Quick Reference

| Do | Don't |
|----|-------|
| Model state as a sub-resource (`resource :closure`) | Add custom actions (`post :close`) |
| Use `create` to enter state, `destroy` to exit | Use `update` to toggle boolean columns |
| Store who/when in the join record | Only store a boolean `closed` column |
| Use `joins(:closure)` / `where.missing(:closure)` for scoping | Use `where(closed: true)` |
| Put state logic in a model concern | Put state logic in the controller |
| Wrap state change + event in a transaction | Create event and state change separately |
| Use singular `resource` for 1:1 state relationships | Use `resources` (plural) for state toggles |

## The Pattern

| State Change | Sub-Resource | Create | Destroy |
|-------------|--------------|--------|---------|
| Open/Close | `closure` | close | reopen |
| Pin/Unpin | `pin` | pin | unpin |
| Watch/Unwatch | `watch` | watch | unwatch |
| Archive/Unarchive | `archival` | archive | unarchive |
| Publish/Unpublish | `publication` | publish | unpublish |
| Lock/Unlock | `lock` | lock | unlock |

## Routes

```ruby
# config/routes.rb
resources :cards do
  resource :closure, only: [:create, :destroy]
  resource :pin, only: [:create, :destroy]
  resource :watch, only: [:create, :destroy]
end

resources :boards do
  resource :publication, only: [:create, :destroy]
  resource :archival, only: [:create, :destroy]
end
```

## Controller Implementation

```ruby
# app/controllers/cards/closures_controller.rb
class Cards::ClosuresController < ApplicationController
  before_action :set_card

  def create
    @card.close
    redirect_to @card, notice: "Card closed"
  end

  def destroy
    @card.reopen
    redirect_to @card, notice: "Card reopened"
  end

  private
    def set_card
      @card = Current.account.cards.find(params[:card_id])
    end
end
```

For Turbo/Hotwire responses:

```ruby
# app/controllers/cards/closures_controller.rb
class Cards::ClosuresController < ApplicationController
  before_action :set_card

  def create
    @card.close
    respond_to do |format|
      format.html { redirect_to @card }
      format.turbo_stream { render_card_update }
    end
  end

  def destroy
    @card.reopen
    respond_to do |format|
      format.html { redirect_to @card }
      format.turbo_stream { render_card_update }
    end
  end

  private
    def set_card
      @card = Current.account.cards.find(params[:card_id])
    end

    def render_card_update
      render turbo_stream: turbo_stream.replace(@card, partial: "cards/card", locals: { card: @card })
    end
end
```

## Model Implementation

The model uses a concern for the state behavior:

```ruby
# app/models/card/closeable.rb
module Card::Closeable
  extend ActiveSupport::Concern

  included do
    has_one :closure, dependent: :destroy

    scope :closed, -> { joins(:closure) }
    scope :open, -> { where.missing(:closure) }
  end

  def closed?
    closure.present?
  end

  def open?
    !closed?
  end

  def close(user: Current.user)
    unless closed?
      transaction do
        create_closure!(user: user)
        track_event :closed, creator: user
      end
    end
  end

  def reopen(user: Current.user)
    if closed?
      transaction do
        closure.destroy
        track_event :reopened, creator: user
      end
    end
  end
end
```

## Join Model

```ruby
# app/models/closure.rb
class Closure < ApplicationRecord
  belongs_to :card
  belongs_to :user, default: -> { Current.user }
end
```

Migration:

```ruby
class CreateClosures < ActiveRecord::Migration[7.1]
  def change
    create_table :closures, id: :uuid do |t|
      t.references :card, null: false, foreign_key: true, type: :uuid, index: { unique: true }
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
```

## View Integration

Toggle buttons that switch between create/destroy:

```erb
<%# app/views/cards/_card.html.erb %>
<div id="<%= dom_id(card) %>">
  <h2><%= card.title %></h2>

  <% if card.closed? %>
    <%= button_to "Reopen", card_closure_path(card), method: :delete %>
  <% else %>
    <%= button_to "Close", card_closure_path(card), method: :post %>
  <% end %>
</div>
```

## Why This Pattern?

```ruby
# WRONG - custom actions
resources :cards do
  post :close, on: :member
  post :reopen, on: :member
  post :pin, on: :member
  delete :unpin, on: :member
end

# RIGHT - sub-resources
resources :cards do
  resource :closure
  resource :pin
end
```

**Benefits:**

1. **RESTful**: Standard CRUD verbs map naturally to state changes
2. **Auditable**: The join record stores who/when the state changed
3. **Queryable**: Easy to query "closed cards" with `joins(:closure)`
4. **Consistent**: Same pattern for all boolean state transitions
5. **Thin controllers**: Controllers just call model methods

## Advanced: Multiple States

For mutually exclusive states, use a polymorphic approach:

```ruby
# card can be in triage, active (in a column), closed, or postponed
class Card < ApplicationRecord
  has_one :closure
  has_one :not_now  # postponed state

  scope :in_triage, -> { where(column: nil).where.missing(:closure, :not_now) }
  scope :active, -> { where.not(column: nil).where.missing(:closure, :not_now) }
  scope :closed, -> { joins(:closure) }
  scope :postponed, -> { joins(:not_now) }
end
```

## Common Mistakes

1. **Using boolean columns**: A `closed` boolean loses who closed it and when. Use a join record instead
2. **Custom controller actions**: `post :close` and `post :reopen` bypass REST conventions. Use `resource :closure` with `create`/`destroy`
3. **Forgetting uniqueness constraint**: The join table should have a unique index on the parent ID to prevent duplicate state records
4. **Not wrapping in transactions**: State changes and their associated events must be in the same transaction for consistency
5. **Missing guard clauses**: Don't close an already-closed card. Check `closed?` before creating the closure
6. **Using `resources` instead of `resource`**: State toggles are 1:1 relationships. Use singular `resource` (no index action, no ID in URL)
7. **Putting logic in controllers**: The controller should just call `@card.close`. All state logic belongs in the model concern
8. **Not providing scopes**: Always add `scope :closed` and `scope :open` to make querying easy. Use `joins` and `where.missing`

## See Also

- [Sub-Resource Routing](references/sub-resource-routing.md) - RESTful routing patterns
- [State Concern](references/state-concern.md) - Concern implementation details
- [Multiple States](references/multiple-states.md) - Mutually exclusive state patterns
