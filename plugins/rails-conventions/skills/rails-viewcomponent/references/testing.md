# ViewComponent Testing API Reference

## Setup

### Minitest

```ruby
# test/components/example_component_test.rb
require "test_helper"

class ExampleComponentTest < ViewComponent::TestCase
  def test_renders
    render_inline(ExampleComponent.new(title: "Test"))
    assert_selector "h1", text: "Test"
  end
end
```

### RSpec

```ruby
# spec/components/example_component_spec.rb
require "rails_helper"

RSpec.describe ExampleComponent, type: :component do
  it "renders" do
    render_inline(described_class.new(title: "Test"))
    expect(page).to have_css "h1", text: "Test"
  end
end
```

```ruby
# spec/rails_helper.rb
require "view_component/test_helpers"
require "capybara/rspec"

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component
end
```

## Core Test Methods

### render_inline

Render a component and return Nokogiri fragment:

```ruby
render_inline(ExampleComponent.new(title: "Test"))
render_inline(ExampleComponent.new) { "Block content" }
```

### rendered_content

Debug helper returning rendered HTML as string:

```ruby
render_inline(ExampleComponent.new)
puts rendered_content  # Outputs HTML
```

### render_preview

Render a preview method:

```ruby
render_preview(:default)
render_preview(:with_title, params: { title: "Custom" })
```

## Capybara Matchers

With Capybara installed, use these assertions:

```ruby
# CSS selectors
assert_selector ".message"
assert_selector "h1", text: "Title"
assert_selector ".item", count: 3
assert_no_selector ".error"

# Text
assert_text "Hello"
assert_no_text "Error"

# Links
assert_link "Click here", href: "/path"

# Forms
assert_field "Email"
assert_button "Submit"
assert_checked_field "Remember me"
```

### Visibility

By default, matchers check visible elements:

```ruby
assert_selector ".hidden-element", visible: false
assert_selector ".visible-element", visible: true
```

## Testing Slots

### With Block

```ruby
def test_slots
  render_inline(CardComponent.new) do |card|
    card.with_header { "Header" }
    card.with_footer { "Footer" }
  end

  assert_selector ".card-header", text: "Header"
  assert_selector ".card-footer", text: "Footer"
end
```

### With tap

```ruby
def test_slots_with_tap
  component = CardComponent.new.tap do |card|
    card.with_header { "Header" }
  end
  render_inline(component)

  assert_selector ".card-header", text: "Header"
end
```

### renders_many Slots

```ruby
def test_multiple_items
  render_inline(ListComponent.new) do |list|
    list.with_item { "One" }
    list.with_item { "Two" }
    list.with_item { "Three" }
  end

  assert_selector "li", count: 3
  assert_selector "li", text: "One"
end
```

## Request Context

### with_request_url

Set request path and parameters:

```ruby
def test_with_request_context
  with_request_url "/products/42" do
    render_inline(BreadcrumbComponent.new)
    assert_text "Products"
  end
end

def test_with_host
  with_request_url "/", host: "admin.example.com" do
    render_inline(HeaderComponent.new)
  end
end
```

### with_controller_class

Use specific controller context:

```ruby
def test_with_admin_controller
  with_controller_class AdminController do
    render_inline(NavComponent.new)
  end
end
```

## Variants and Formats

### with_variant

Test template variants:

```ruby
def test_mobile_variant
  with_variant(:mobile) do
    render_inline(NavComponent.new)
    assert_selector ".mobile-nav"
  end
end
```

### with_format

Test different formats:

```ruby
def test_json_format
  with_format(:json) do
    render_inline(DataComponent.new)
  end
end
```

## Testing Without Capybara

Use Nokogiri directly:

```ruby
def test_without_capybara
  result = render_inline(ExampleComponent.new(title: "Test"))

  assert result.css("h1").present?
  assert_equal "Test", result.css("h1").text
  assert_includes result.to_html, "Test"
end
```

## Testing render?

```ruby
def test_does_not_render_when_empty
  render_inline(AlertComponent.new(message: nil))

  assert_no_selector ".alert"
  assert_equal "", rendered_content.strip
end

def test_renders_when_message_present
  render_inline(AlertComponent.new(message: "Error!"))

  assert_selector ".alert", text: "Error!"
end
```

## Testing Collections

```ruby
def test_collection_rendering
  products = [
    Product.new(name: "One"),
    Product.new(name: "Two")
  ]

  render_inline(ProductComponent.with_collection(products))

  assert_selector ".product", count: 2
end
```

## Common Patterns

### Testing All Variants

```ruby
def test_all_button_variants
  %i[primary secondary danger].each do |variant|
    render_inline(ButtonComponent.new(variant: variant))
    assert_selector ".btn.btn-#{variant}"
  end
end
```

### Testing Conditional Classes

```ruby
def test_active_state
  render_inline(TabComponent.new(active: true))
  assert_selector ".tab.active"

  render_inline(TabComponent.new(active: false))
  assert_no_selector ".tab.active"
end
```

### Testing Links

```ruby
def test_link_component
  render_inline(LinkComponent.new(href: "/about")) { "About" }

  assert_link "About", href: "/about"
end
```
