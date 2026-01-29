# ViewComponent Slots API Reference

## renders_one

Defines a slot rendered at most once:

```ruby
class CardComponent < ViewComponent::Base
  renders_one :header
  renders_one :footer
end
```

### With Component Class

```ruby
renders_one :header, HeaderComponent
renders_one :header, "HeaderComponent"  # String form
```

### With Lambda

```ruby
renders_one :header, ->(classes:) {
  content_tag :h1, class: classes do
    content
  end
}
```

### With Delegated Content

```ruby
renders_one :header, "HeaderComponent"

# Usage
card.with_header_content("Plain text header")
```

## renders_many

Defines a slot that renders multiple times:

```ruby
class ListComponent < ViewComponent::Base
  renders_many :items
  renders_many :items, ItemComponent
  renders_many :items, ->(highlighted: false) { ... }
end
```

### Iterating Slots

```erb
<% items.each do |item| %>
  <li><%= item %></li>
<% end %>
```

### Collection Rendering

```ruby
# Pass array directly
list.with_items([
  { title: "One" },
  { title: "Two" }
])
```

## Polymorphic Slots

Render different component types based on context:

```ruby
class MediaComponent < ViewComponent::Base
  renders_one :visual, types: {
    icon: IconComponent,
    avatar: AvatarComponent,
    image: ->(src:) { tag.img(src: src) }
  }
end
```

```erb
<%# Usage %>
<%= render(MediaComponent.new) do |media| %>
  <% media.with_icon(name: "star") %>
<% end %>

<%= render(MediaComponent.new) do |media| %>
  <% media.with_avatar(user: @user) %>
<% end %>
```

## Slot Methods

For a slot named `header`:

| Method | Purpose |
|--------|---------|
| `with_header { }` | Set slot content with block |
| `with_header(args)` | Set slot with arguments (component slots) |
| `with_header_content("text")` | Set content directly |
| `header` | Access rendered slot |
| `header?` | Check if slot has content |

## Default Slot Values

```ruby
class CardComponent < ViewComponent::Base
  renders_one :header

  def default_header
    "Default Header"
  end
end
```

## Slot Content Access

```erb
<%# In template %>
<%= header %>           <%# Render the slot %>
<% if header? %>        <%# Check if set %>
  <%= header %>
<% end %>
```

## Lambda Slot Examples

### Simple Tag

```ruby
renders_one :title, ->(tag: :h1) {
  content_tag(tag, content)
}
```

### With Classes

```ruby
renders_one :button, ->(variant: :primary) {
  content_tag :button, content, class: "btn btn-#{variant}"
}
```

### Wrapping Content

```ruby
renders_one :icon, ->(name:) {
  tag.span(class: "icon icon-#{name}")
}
```

## Nested Slots

Components rendered in slots can have their own slots:

```ruby
class PageComponent < ViewComponent::Base
  renders_one :sidebar, SidebarComponent
end

class SidebarComponent < ViewComponent::Base
  renders_many :links
end
```

```erb
<%= render(PageComponent.new) do |page| %>
  <% page.with_sidebar do |sidebar| %>
    <% sidebar.with_link { "Home" } %>
    <% sidebar.with_link { "About" } %>
  <% end %>
<% end %>
```

## Common Patterns

### Optional Wrapper

```ruby
class SectionComponent < ViewComponent::Base
  renders_one :heading

  def wrapper_class
    heading? ? "section--with-heading" : "section"
  end
end
```

### Conditional Slot Rendering

```erb
<% if header? %>
  <header class="card-header">
    <%= header %>
  </header>
<% end %>
```

### Slot with Fallback

```erb
<%= header || "Default Title" %>
```
