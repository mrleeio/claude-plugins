# Conditional Return Patterns

When to use guard clauses vs expanded conditionals.

## Prefer Expanded Conditionals

```ruby
# Avoid
def todos_for_new_group
  ids = params.require(:todolist)[:todo_ids]
  return [] unless ids
  @bucket.recordings.todos.find(ids.split(","))
end

# Prefer
def todos_for_new_group
  if ids = params.require(:todolist)[:todo_ids]
    @bucket.recordings.todos.find(ids.split(","))
  else
    []
  end
end
```

## When Guard Clauses Are Acceptable

Guard clauses work well when:
1. The return is at the very beginning of the method
2. The main body is non-trivial (several lines of code)

```ruby
def after_recorded_as_commit(recording)
  return if recording.parent.was_created?

  if recording.was_created?
    broadcast_new_column(recording)
  else
    broadcast_column_change(recording)
  end
end
```

## Rationale

| Pattern | Best For |
|---------|----------|
| Expanded conditional | Short methods, clear alternatives |
| Guard clause | Early exit, long method bodies |

## Examples

### Expanded (Preferred)

```ruby
def display_name
  if name.present?
    name
  else
    email.split("@").first
  end
end

def status_badge
  if completed?
    "success"
  elsif in_progress?
    "warning"
  else
    "default"
  end
end
```

### Guard Clause (Acceptable)

```ruby
def process_payment
  return if already_processed?
  return if amount.zero?

  # Several lines of payment processing
  gateway.charge(amount)
  update!(processed_at: Time.current)
  send_receipt
  notify_subscribers
end
```

## Avoid Hidden Returns

```ruby
# Confusing - return buried in the middle
def calculate_total
  items.each do |item|
    return 0 if item.invalid?
    @total += item.price
  end
  @total
end

# Clearer
def calculate_total
  if items.any?(&:invalid?)
    0
  else
    items.sum(&:price)
  end
end
```
