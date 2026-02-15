---
name: rails-viewcomponent
description: Use when building ViewComponents with slots, previews, or collections. Covers component patterns, testing, and best practices.
---

# ViewComponent Conventions for Rails

Use ViewComponents instead of partials for reusable UI with explicit interfaces. Test components directly with `render_inline`.

## Core Rules

```ruby
# WRONG - partial with logic scattered in views and helpers
# app/views/shared/_message.html.erb
<div class="message message--<%= type || :info %>">
  <%= message_icon(type) %>
  <%= text %>
</div>

# app/helpers/messages_helper.rb
def message_icon(type)
  case type
  when :error then "X"
  when :success then "check"
  else "info"
  end
end

# RIGHT - ViewComponent with encapsulated logic
# app/components/message_component.rb
class MessageComponent < ViewComponent::Base
  def initialize(text:, type: :info)
    @text = text
    @type = type
  end

  def icon
    case @type
    when :error then "X"
    when :success then "check"
    else "info"
    end
  end
end
```

## Core Philosophy

**Components over partials**: ViewComponents are ~2.5x faster than partials and provide explicit interfaces.

**Ruby objects**: Components are proper Ruby classes with initializers, making dependencies explicit.

**Testable**: Unit test components directly with `render_inline` instead of integration tests.

## File Structure

```
app/components/
├── example_component.rb
├── example_component.html.erb
└── example_component_preview.rb  # or in test/components/previews/
```

**Naming**: Component class name must end with `Component`. Template must match class name.

## Basic Component

```ruby
# app/components/message_component.rb
class MessageComponent < ViewComponent::Base
  def initialize(name:, type: :info)
    @name = name
    @type = type
  end
end
```

```erb
<%# app/components/message_component.html.erb %>
<div class="message message--<%= @type %>">
  Hello, <%= @name %>!
</div>
```

**Render in views:**
```erb
<%= render(MessageComponent.new(name: "World")) %>
```

## Slots

Slots allow components to accept content in specific areas.

### renders_one

Single slot rendered at most once:

```ruby
class CardComponent < ViewComponent::Base
  renders_one :header
  renders_one :footer
end
```

```erb
<%# Template %>
<div class="card">
  <div class="card-header"><%= header %></div>
  <div class="card-body"><%= content %></div>
  <div class="card-footer"><%= footer %></div>
</div>
```

```erb
<%# Usage %>
<%= render(CardComponent.new) do |card| %>
  <% card.with_header { "Title" } %>
  Body content here
  <% card.with_footer { "Footer" } %>
<% end %>
```

### renders_many

Multiple slot instances:

```ruby
class ListComponent < ViewComponent::Base
  renders_many :items
end
```

```erb
<%# Template %>
<ul>
  <% items.each do |item| %>
    <li><%= item %></li>
  <% end %>
</ul>
```

```erb
<%# Usage %>
<%= render(ListComponent.new) do |list| %>
  <% list.with_item { "Apple" } %>
  <% list.with_item { "Orange" } %>
<% end %>
```

### Component Slots

Pass a component class to render in the slot:

```ruby
class PageComponent < ViewComponent::Base
  renders_one :header, HeaderComponent
  renders_many :sections, SectionComponent
end
```

### Polymorphic Slots

Render different component types:

```ruby
class MediaComponent < ViewComponent::Base
  renders_one :visual, types: {
    icon: IconComponent,
    avatar: AvatarComponent,
    image: ImageComponent
  }
end
```

```erb
<%= render(MediaComponent.new) do |media| %>
  <% media.with_icon(name: "star") %>
<% end %>
```

For complete Slots API, see `references/slots.md`.

## Previews

Previews provide a way to view and document components in isolation.

```ruby
# test/components/previews/message_component_preview.rb
class MessageComponentPreview < ViewComponent::Preview
  def default
    render(MessageComponent.new(name: "World"))
  end

  def with_error_type
    render(MessageComponent.new(name: "Error", type: :error))
  end
end
```

**Access at**: `/rails/view_components/message_component/default`

### Dynamic Parameters

```ruby
def with_custom_name(name: "Default")
  render(MessageComponent.new(name: name))
end
```

**Access with**: `/rails/view_components/message_component/with_custom_name?name=Custom`

For complete Previews API, see `references/previews.md`.

## Testing

Test components directly with `render_inline`:

```ruby
# test/components/message_component_test.rb
class MessageComponentTest < ViewComponent::TestCase
  def test_renders_message
    render_inline(MessageComponent.new(name: "World"))

    assert_selector ".message", text: "Hello, World!"
  end

  def test_renders_error_type
    render_inline(MessageComponent.new(name: "Error", type: :error))

    assert_selector ".message.message--error"
  end
end
```

### Testing Slots

```ruby
def test_renders_with_slots
  render_inline(CardComponent.new) do |card|
    card.with_header { "Header" }
    card.with_footer { "Footer" }
  end

  assert_selector ".card-header", text: "Header"
  assert_selector ".card-footer", text: "Footer"
end
```

### Testing Previews

```ruby
def test_preview_renders
  render_preview(:default)

  assert_text "Hello, World!"
end
```

For complete Testing API, see `references/testing.md`.

## Common Patterns

### Conditional Rendering

```ruby
class AlertComponent < ViewComponent::Base
  def initialize(message:)
    @message = message
  end

  def render?
    @message.present?
  end
end
```

### Content Wrapping

```ruby
class WrapperComponent < ViewComponent::Base
  def call
    content_tag :div, content, class: "wrapper"
  end
end
```

### Helper Access

```ruby
class LinkComponent < ViewComponent::Base
  def initialize(path:)
    @path = path
  end

  def call
    link_to content, @path, class: "custom-link"
  end
end
```

### Collections

```ruby
# Render multiple components efficiently
<%= render(ProductComponent.with_collection(@products)) %>
```

## Common Mistakes

1. **Using partials with view logic**: Partials with conditionals and helper methods should be ViewComponents instead. Components provide explicit interfaces and are testable in isolation
2. **Implicit dependencies**: Passing data via instance variables from the view instead of through the component initializer. Always make dependencies explicit via constructor arguments
3. **Missing `render?` method**: Rendering empty components when the data is absent. Override `render?` to return `false` when the component should not render
4. **Testing through integration tests**: Component logic should be tested with `render_inline` in unit tests, not through slow browser-based integration tests
5. **Forgetting to preview all variants**: Every visual state of a component should have a preview method for documentation and visual regression testing
6. **Not using slots for composition**: Deeply nesting components by passing them as initializer arguments. Use `renders_one` and `renders_many` slots instead
7. **Putting logic in templates**: Keep conditional logic, formatting, and data transformation in the Ruby class. Templates should only do presentation
8. **Not using `with_collection`**: Rendering components in a loop with `.each` is slower than using `with_collection` which batches rendering

## Best Practices

1. **Use components for reusable UI** - Buttons, cards, modals, form inputs
2. **Explicit dependencies** - All data via initializer, not instance variables from views
3. **Keep templates simple** - Logic in Ruby class, presentation in template
4. **Test at component level** - Faster than integration tests
5. **Use slots for composition** - Instead of deeply nested components
6. **Preview all variants** - Document component states

## Reference Files

For detailed API documentation:
- **`references/api.md`** - Full API reference (methods, config, errors)
- **`references/slots.md`** - Slots API (renders_one, renders_many, polymorphic)
- **`references/previews.md`** - Preview system and configuration
- **`references/testing.md`** - Testing helpers and patterns
- **`references/collections.md`** - with_collection, counters, iteration
- **`references/generators.md`** - Rails generators and options
- **`references/helpers.md`** - Accessing Rails helpers
- **`references/lifecycle.md`** - before_render, around_render hooks
- **`references/templates.md`** - Template options, inline, variants
- **`references/translations.md`** - i18n and locale files
- **`references/best-practices.md`** - Organization, composition, anti-patterns
