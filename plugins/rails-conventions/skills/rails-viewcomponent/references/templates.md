# ViewComponent Templates Reference

## Template Locations

### Sibling File (Default)

```
app/components/
├── example_component.rb
└── example_component.html.erb
```

### Sidecar Directory

```
app/components/
└── example_component/
    ├── example_component.rb
    └── example_component.html.erb
```

Generate with `--sidecar` flag.

## Template Definition Methods

### ERB File

```erb
<%# app/components/message_component.html.erb %>
<div class="message">
  <%= @content %>
</div>
```

### Inline Template (v3.0.0+)

```ruby
class MessageComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="message">
      <%= @content %>
    </div>
  ERB

  def initialize(content:)
    @content = content
  end
end
```

### Slim Template

```ruby
class MessageComponent < ViewComponent::Base
  slim_template <<-SLIM
    .message
      = @content
  SLIM
end
```

### Haml Template

```ruby
class MessageComponent < ViewComponent::Base
  haml_template <<-HAML
    .message
      = @content
  HAML
end
```

### Call Method (v1.16.0+)

No template file needed:

```ruby
class BadgeComponent < ViewComponent::Base
  def initialize(label:, color: :gray)
    @label = label
    @color = color
  end

  def call
    content_tag :span, @label, class: "badge badge-#{@color}"
  end
end
```

## Template Variants

### With Separate Files

```
app/components/
├── nav_component.rb
├── nav_component.html.erb          # Default
├── nav_component.html+phone.erb    # Phone variant
└── nav_component.html+tablet.erb   # Tablet variant
```

### With Call Methods

```ruby
class NavComponent < ViewComponent::Base
  def call
    # Default template
  end

  def call_phone
    # Phone variant
  end

  def call_tablet
    # Tablet variant
  end
end
```

### Rendering Variants

```ruby
# In controller
request.variant = :phone

# Or in view
<%= render(NavComponent.new.with_variant(:phone)) %>
```

## Template Inheritance

### Parent Template

```ruby
class BaseCardComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="card">
      <%= content %>
    </div>
  ERB
end
```

### Child Inherits

```ruby
class SpecialCardComponent < BaseCardComponent
  # Inherits parent template automatically
  # Override by defining own template
end
```

### Render Parent (v2.55.0+)

```ruby
class EnhancedCardComponent < BaseCardComponent
  erb_template <<-ERB
    <div class="enhanced">
      <%= render_parent %>
    </div>
  ERB
end
```

## Whitespace Management

Strip trailing whitespace:

```ruby
class CompactComponent < ViewComponent::Base
  strip_trailing_whitespace

  erb_template <<-ERB
    <span>Content</span>
  ERB
end
```

## Content Block

Access block content with `content`:

```ruby
class WrapperComponent < ViewComponent::Base
  def call
    content_tag :div, content, class: "wrapper"
  end
end
```

```erb
<%= render(WrapperComponent.new) do %>
  Block content here
<% end %>
```

## Multiple Content Areas

Use slots for multiple content areas:

```ruby
class LayoutComponent < ViewComponent::Base
  renders_one :header
  renders_one :sidebar
  # `content` is the main area
end
```

```erb
<%= render(LayoutComponent.new) do |layout| %>
  <% layout.with_header { "Header" } %>
  <% layout.with_sidebar { "Sidebar" } %>
  Main content
<% end %>
```
