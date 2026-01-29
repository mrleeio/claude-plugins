# Message Passing Pattern

Ask models questions instead of reaching into associations.

## The Problem

```erb
<%# WRONG - reaching into associations %>
<% if current_user.bookmarks.exists?(academy: academy) %>
  <span>Bookmarked</span>
<% end %>

<%# WRONG - association access in component %>
<% if task.review_criteria.any? %>
  <span>Requires review</span>
<% end %>
```

This approach:
- Couples views to database structure
- Makes testing harder
- Duplicates query logic
- Creates N+1 query risks

## The Solution

```erb
<%# RIGHT - ask the model %>
<% if current_user.bookmarked?(academy) %>
  <span>Bookmarked</span>
<% end %>

<%# RIGHT - delegate to model %>
<% if task.requires_review? %>
  <span>Requires review</span>
<% end %>
```

## Implementing Model Methods

```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_many :bookmarks

  def bookmarked?(item)
    bookmarks.exists?(bookmarkable: item)
  end
end

# app/models/task.rb
class Task < ApplicationRecord
  has_many :review_criteria

  def requires_review?
    review_criteria.any?
  end
end
```

## Benefits

| Aspect | Association Access | Message Passing |
|--------|-------------------|-----------------|
| Testability | Hard (needs DB) | Easy (stub method) |
| Reusability | Copy-paste | Call method |
| Encapsulation | Exposes internals | Hides implementation |
| Performance | Can cause N+1 | Can optimize |

## More Examples

### Status Checks

```erb
<%# Avoid %>
<% if card.closure.present? %>

<%# Prefer %>
<% if card.closed? %>
```

### Permission Checks

```erb
<%# Avoid %>
<% if current_user.memberships.find_by(account: account)&.admin? %>

<%# Prefer %>
<% if current_user.admin_of?(account) %>
```

### Count Checks

```erb
<%# Avoid %>
<% if project.tasks.incomplete.count > 0 %>

<%# Prefer %>
<% if project.has_incomplete_tasks? %>
```

## Caching Benefits

Model methods can leverage caching:

```ruby
class User < ApplicationRecord
  def bookmarked?(item)
    # Cache bookmark IDs to avoid repeated queries
    @bookmarked_ids ||= bookmarks.pluck(:bookmarkable_id, :bookmarkable_type).to_set
    @bookmarked_ids.include?([item.id, item.class.name])
  end
end
```

## Testing

```ruby
# Easy to test in isolation
test "user can check if item is bookmarked" do
  user = users(:default)
  academy = academies(:one)

  refute user.bookmarked?(academy)

  user.bookmarks.create!(bookmarkable: academy)
  assert user.bookmarked?(academy)
end
```
