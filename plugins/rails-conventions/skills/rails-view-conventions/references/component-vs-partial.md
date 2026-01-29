# ViewComponents vs Partials

When to use each approach for reusable view elements.

## Quick Decision Guide

| Use Case | Choice |
|----------|--------|
| Simple markup, no logic | Partial |
| Conditional rendering | ViewComponent |
| Computed display values | ViewComponent |
| Formatted data (dates, currency) | ViewComponent |
| Loops with simple items | Partial |
| Interactive elements | ViewComponent |
| Anything you'd put in a helper | ViewComponent |

## Partials: Simple Markup

Good for straightforward HTML with minimal logic:

```erb
<%# app/views/cards/_card.html.erb %>
<div class="card" id="<%= dom_id(card) %>">
  <h3><%= card.title %></h3>
  <p><%= card.description %></p>
</div>

<%# Usage %>
<%= render partial: "cards/card", collection: @cards %>
```

## ViewComponents: Presentation Logic

Good for anything requiring logic, formatting, or conditional rendering:

```ruby
# app/components/status_badge_component.rb
class StatusBadgeComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
  end

  def color_class
    case @status
    when :success then "bg-green-100 text-green-800"
    when :warning then "bg-yellow-100 text-yellow-800"
    when :error then "bg-red-100 text-red-800"
    else "bg-gray-100 text-gray-800"
    end
  end

  def label
    @status.to_s.humanize
  end
end
```

```erb
<%# app/components/status_badge_component.html.erb %>
<span class="badge <%= color_class %>"><%= label %></span>

<%# Usage %>
<%= render StatusBadgeComponent.new(status: :success) %>
```

## Why Not Helpers?

```ruby
# AVOID - app/helpers/status_helper.rb
module StatusHelper
  def status_badge(status)
    color = case status
            when :success then "green"
            # ...
            end
    content_tag :span, status.humanize, class: "badge bg-#{color}"
  end
end
```

Problems:
- No template file (hard to customize)
- Untestable in isolation
- Global namespace pollution
- Mixes Ruby and HTML awkwardly

## Testing

### Partials: Test via Integration

```ruby
# Partials are tested through request/system specs
test "renders card partial" do
  get cards_path
  assert_select ".card", count: @cards.count
end
```

### ViewComponents: Unit Testable

```ruby
# test/components/status_badge_component_test.rb
class StatusBadgeComponentTest < ViewComponent::TestCase
  def test_renders_success_badge
    render_inline(StatusBadgeComponent.new(status: :success))

    assert_selector ".badge.bg-green-100"
    assert_text "Success"
  end

  def test_renders_warning_badge
    render_inline(StatusBadgeComponent.new(status: :warning))

    assert_selector ".badge.bg-yellow-100"
  end
end
```

## Migration Path

Converting a partial with logic to a component:

```erb
<%# Before: app/views/shared/_deadline_badge.html.erb %>
<% if deadline < Time.current %>
  <span class="badge badge-danger">Overdue</span>
<% elsif deadline < 1.day.from_now %>
  <span class="badge badge-warning">Due soon</span>
<% else %>
  <span class="badge"><%= deadline.strftime("%b %d") %></span>
<% end %>
```

```ruby
# After: app/components/deadline_badge_component.rb
class DeadlineBadgeComponent < ViewComponent::Base
  def initialize(deadline:)
    @deadline = deadline
  end

  def overdue?
    @deadline < Time.current
  end

  def due_soon?
    @deadline < 1.day.from_now
  end

  def formatted_date
    @deadline.strftime("%b %d")
  end

  def badge_class
    if overdue?
      "badge-danger"
    elsif due_soon?
      "badge-warning"
    else
      "badge"
    end
  end

  def label
    if overdue?
      "Overdue"
    elsif due_soon?
      "Due soon"
    else
      formatted_date
    end
  end
end
```

```erb
<%# app/components/deadline_badge_component.html.erb %>
<span class="badge <%= badge_class %>"><%= label %></span>
```
