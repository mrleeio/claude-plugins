# Sub-Resource Routing Patterns

Model state transitions as creating or destroying sub-resources instead of custom actions.

## Route Configuration

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

## Common State Patterns

| State Change | Sub-Resource | Create Action | Destroy Action |
|-------------|--------------|---------------|----------------|
| Open/Close | `closure` | close | reopen |
| Pin/Unpin | `pin` | pin | unpin |
| Watch/Unwatch | `watch` | watch | unwatch |
| Archive/Unarchive | `archival` | archive | unarchive |
| Publish/Unpublish | `publication` | publish | unpublish |
| Lock/Unlock | `lock` | lock | unlock |
| Suspend/Activate | `suspension` | suspend | activate |

## URL Examples

```
POST   /cards/:card_id/closure    # Close the card
DELETE /cards/:card_id/closure    # Reopen the card

POST   /cards/:card_id/pin        # Pin the card
DELETE /cards/:card_id/pin        # Unpin the card

POST   /boards/:board_id/publication  # Publish the board
DELETE /boards/:board_id/publication  # Unpublish the board
```

## Why Not Custom Actions?

```ruby
# Avoid this
resources :cards do
  post :close, on: :member
  post :reopen, on: :member
  post :pin, on: :member
  delete :unpin, on: :member
end

# Prefer this
resources :cards do
  resource :closure
  resource :pin
end
```

## Benefits

| Benefit | Explanation |
|---------|-------------|
| RESTful | Standard CRUD verbs map naturally to state changes |
| Auditable | Join record stores who/when the state changed |
| Queryable | Easy to query with `joins(:closure)` or `where.missing(:closure)` |
| Consistent | Same pattern applies to all boolean state transitions |
| Thin controllers | Controllers just delegate to model methods |
