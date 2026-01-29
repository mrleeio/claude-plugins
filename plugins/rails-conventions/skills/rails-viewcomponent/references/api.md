# ViewComponent API Reference

## Class Methods

### `.config`

Returns the current configuration as `ActiveSupport::OrderedOptions`.

### `.identifier`

Provides the file path to the component's Ruby file.

### `.new(...)`

Initializes instances with pre-allocated variables optimized for Ruby object shapes.

### `.sidecar_files(extensions)`

Locates companion files matching specified extensions:

```ruby
# Find all ERB and Haml templates
MyComponent.sidecar_files(["erb", "haml"])
```

Extensions provided as strings without dots.

### `.strip_trailing_whitespace(value = true)`

Removes trailing whitespace from templates during compilation:

```ruby
class MyComponent < ViewComponent::Base
  strip_trailing_whitespace
end
```

### `.strip_trailing_whitespace?`

Returns boolean indicating whether whitespace stripping is enabled.

### `.with_collection(collection, spacer_component: nil, **args)`

Renders a component for each collection element:

```ruby
render(ProductComponent.with_collection(@products))
render(ProductComponent.with_collection(@products, spacer_component: DividerComponent))
```

### `.with_collection_parameter(parameter)`

Defines the parameter name for collection element rendering:

```ruby
class ProductComponent < ViewComponent::Base
  with_collection_parameter :item

  def initialize(item:)
    @item = item
  end
end
```

## Instance Methods

### `#before_render`

Executes before rendering; useful for view context-dependent operations:

```ruby
def before_render
  @current_user = helpers.current_user
end
```

### `#content`

Accesses block content passed to the component:

```ruby
def call
  content_tag :div, content, class: "wrapper"
end
```

### `#content?`

Returns true if content has been provided:

```erb
<% if content? %>
  <div class="body"><%= content %></div>
<% end %>
```

### `#controller`

References the current controller. Use cautiously to maintain encapsulation.

### `#helpers`

Provides a proxy for accessing Rails helpers:

```ruby
def formatted_date
  helpers.l(@date, format: :short)
end
```

Use sparingly to maintain component isolation.

### `#output_postamble`

Optional content appended after rendered output.

### `#output_preamble`

Optional content prepended before rendered output.

### `#render?`

Override to conditionally prevent rendering:

```ruby
def render?
  @items.any?
end
```

### `#render_in(view_context, &block)`

Primary rendering entry point; returns escaped HTML.

### `#render_parent`

Renders parent templates respecting the current variant:

```ruby
class EnhancedCard < BaseCard
  def call
    content_tag :div, render_parent, class: "enhanced"
  end
end
```

### `#render_parent_to_string`

Returns parent template as a string; use within custom `#call` methods.

### `#request`

Accesses the current request object. Exercise caution to maintain encapsulation.

### `#set_original_view_context(view_context)`

Establishes reference to the original Rails view context.

## Configuration Options

### Generator Settings

```ruby
# config/application.rb
config.view_component.generate.path = "app/components"
config.view_component.generate.sidecar = true
config.view_component.generate.stimulus_controller = true
config.view_component.generate.typescript = false
config.view_component.generate.locale = true
config.view_component.generate.distinct_locale_files = true
config.view_component.generate.preview = true
config.view_component.generate.preview_path = "test/components/previews"
config.view_component.generate.use_component_path_for_rspec_tests = false
```

| Option | Description | Default |
|--------|-------------|---------|
| `path` | Output directory for components | `app/components` |
| `sidecar` | Always generate sidecar directories | `false` |
| `stimulus_controller` | Generate Stimulus controllers | `false` |
| `typescript` | Generate TypeScript instead of JS | `false` |
| `locale` | Generate translation files | `false` |
| `distinct_locale_files` | Separate file per locale | `false` |
| `preview` | Generate preview files | `false` |
| `preview_path` | Preview generation location | varies |

### Preview Settings

```ruby
# config/application.rb
config.view_component.preview_controller = "PreviewController"
config.view_component.preview_route = "/components"
config.view_component.show_previews = true
config.view_component.default_preview_layout = "component_preview"
```

| Option | Description | Default |
|--------|-------------|---------|
| `preview_controller` | Controller class for previews | `ViewComponentsController` |
| `preview_route` | URL path for previews | `/rails/view_components` |
| `show_previews` | Enable/disable previews | `true` in dev/test |
| `default_preview_layout` | Layout for preview pages | `nil` |

### Other Options

```ruby
config.view_component.instrumentation_enabled = true
```

Enables ActiveSupport notifications for performance monitoring.

## Test Helpers

### `#render_inline(component, **args, &block)`

Renders components inline for testing:

```ruby
def test_renders_message
  render_inline(MessageComponent.new(text: "Hello"))
  assert_selector "p", text: "Hello"
end
```

### `#render_preview(name, from:, params:)`

Renders previews inline:

```ruby
def test_default_preview
  render_preview(:default, from: MessageComponentPreview)
  assert_text "Hello"
end
```

### `#rendered_content`

Returns render results as `ActionView::OutputBuffer`.

### `#rendered_json`

Parses and returns component output as JSON:

```ruby
render_inline(ApiComponent.new(data: @data))
assert_equal "success", rendered_json["status"]
```

### `#vc_test_controller`

Accesses the test controller used by `render_inline`.

### `#vc_test_request`

Accesses the test request object.

### `#with_controller_class(klass)`

Sets controller for block execution:

```ruby
with_controller_class(AdminController) do
  render_inline(AdminComponent.new)
end
```

### `#with_format(*formats)`

Sets request format:

```ruby
with_format(:json) do
  render_inline(ApiComponent.new)
end
```

### `#with_request_url(full_path, host:, method:)`

Configures request URL:

```ruby
with_request_url("/products/1", host: "example.com", method: "GET") do
  render_inline(BreadcrumbComponent.new)
end
```

### `#with_variant(*variants)`

Sets Action Pack variant:

```ruby
with_variant(:phone) do
  render_inline(NavComponent.new)
end
```

### `#render_in_view_context(...)`

Executes blocks within view context; enables Capybara assertions.

## Error Classes

| Error | Cause |
|-------|-------|
| `AlreadyDefinedPolymorphicSlotSetterError` | Slot setter method conflicts with existing method |
| `ContentSlotNameError` | "content" used as slot name (reserved) |
| `ControllerCalledBeforeRenderError` | Controller accessed before rendering |
| `DuplicateContentError` | Both `with_content` and block provided |
| `InvalidCollectionArgumentError` | Invalid argument to `with_collection` |
| `MissingCollectionArgumentError` | Required collection parameter missing |
| `MissingTemplateError` | No matching component template found |
| `ReservedParameterError` | Initializer parameter conflicts with ViewComponent methods |
