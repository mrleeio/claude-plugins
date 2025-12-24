# ViewComponent Previews API Reference

## Basic Preview

```ruby
# test/components/previews/example_component_preview.rb
class ExampleComponentPreview < ViewComponent::Preview
  def default
    render(ExampleComponent.new(title: "Default"))
  end

  def with_long_title
    render(ExampleComponent.new(title: "A very long title"))
  end
end
```

**Access at**: `/rails/view_components/example_component/default`

## Dynamic Parameters

Accept URL parameters as keyword arguments:

```ruby
def with_title(title: "Default Title")
  render(ExampleComponent.new(title: title))
end
```

**Access with**: `?title=Custom+Title`

### Multiple Parameters

```ruby
def configurable(title: "Title", size: "medium", theme: "light")
  render(ExampleComponent.new(
    title: title,
    size: size.to_sym,
    theme: theme.to_sym
  ))
end
```

## Layout Configuration

### Per Preview

```ruby
class AdminComponentPreview < ViewComponent::Preview
  layout "admin"

  def default
    render(AdminComponent.new)
  end
end
```

### No Layout

```ruby
class ModalComponentPreview < ViewComponent::Preview
  layout false

  def default
    render(ModalComponent.new)
  end
end
```

### Global Default

```ruby
# config/application.rb
config.view_component.default_preview_layout = "component_preview"
```

## Preview Templates

Use custom templates instead of `render()`:

```ruby
class CardComponentPreview < ViewComponent::Preview
  def in_grid_context
    render_with_template(locals: { cards: sample_cards })
  end

  private

  def sample_cards
    3.times.map { |i| { title: "Card #{i}" } }
  end
end
```

```erb
<%# test/components/previews/card_component_preview/in_grid_context.html.erb %>
<div class="grid">
  <% cards.each do |card| %>
    <%= render(CardComponent.new(**card)) %>
  <% end %>
</div>
```

## Preview Helpers

Available in preview classes:

```ruby
class ExampleComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::TagHelper

  def with_wrapper
    content_tag :div, class: "wrapper" do
      render(ExampleComponent.new)
    end
  end
end
```

## Configuration Options

```ruby
# config/application.rb

# Preview paths (default: test/components/previews)
config.view_component.preview_paths << Rails.root.join("spec/components/previews")

# Preview route (default: /rails/view_components)
config.view_component.preview_route = "/previews"

# Enable/disable (default: true in test/development)
config.view_component.show_previews = true

# Custom controller
config.view_component.preview_controller = "PreviewsController"
```

## Custom Preview Controller

Add authentication or other logic:

```ruby
# app/controllers/previews_controller.rb
class PreviewsController < ViewComponentsController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    redirect_to root_path unless current_user&.admin?
  end
end
```

## Grouping Previews

Organize with modules:

```ruby
module Admin
  class ButtonComponentPreview < ViewComponent::Preview
    def default
      render(Admin::ButtonComponent.new)
    end
  end
end
```

**Access at**: `/rails/view_components/admin/button_component/default`

## Preview with Slots

```ruby
class CardComponentPreview < ViewComponent::Preview
  def with_all_slots
    render(CardComponent.new) do |card|
      card.with_header { "Header Content" }
      card.with_footer { "Footer Content" }
    end
  end
end
```

## Testing Previews

```ruby
class ExampleComponentTest < ViewComponent::TestCase
  def test_default_preview
    render_preview(:default)
    assert_selector ".example"
  end

  def test_preview_with_params
    render_preview(:with_title, params: { title: "Custom" })
    assert_text "Custom"
  end
end
```

## Lookbook Integration

For enhanced preview UI, use [Lookbook](https://lookbook.build/):

```ruby
# Gemfile
gem "lookbook"
```

Provides:
- Component browser UI
- Parameter controls
- Source code viewing
- Notes and documentation
