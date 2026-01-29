# ViewComponent Lifecycle Reference

## Lifecycle Hooks

### before_render

Called before rendering, when `helpers` is available (v2.8.0+):

```ruby
class UserComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def before_render
    @formatted_name = helpers.sanitize(@user.name)
    @avatar_url = helpers.gravatar_url(@user.email)
  end
end
```

**Use cases:**
- Access Rails helpers that aren't available in `initialize`
- Prepare computed values before rendering
- Set up data that depends on the view context

### around_render

Wraps the entire render process (v4.0.0+):

```ruby
class InstrumentedComponent < ViewComponent::Base
  def around_render
    Rails.logger.info "Rendering #{self.class.name}"
    start = Time.current

    yield  # Actual rendering happens here

    duration = Time.current - start
    Rails.logger.info "Rendered in #{duration}ms"
  end
end
```

**Use cases:**
- Performance monitoring
- Logging and instrumentation
- Wrapping output in additional markup
- Error handling

## Execution Order

1. `initialize` - Set up instance variables
2. `before_render` - Prepare data with helpers access
3. `render?` - Check if should render
4. `around_render` (before yield) - Pre-render logic
5. Template rendering / `call` method
6. `around_render` (after yield) - Post-render logic

## Common Patterns

### Lazy Loading

```ruby
class DashboardComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def before_render
    @stats = calculate_stats
    @notifications = fetch_notifications
  end

  private

  def calculate_stats
    # Expensive calculation deferred until render
  end
end
```

### Conditional Setup

```ruby
class AlertComponent < ViewComponent::Base
  def initialize(message:, type: :info)
    @message = message
    @type = type
  end

  def before_render
    @icon = case @type
            when :error then "exclamation-circle"
            when :warning then "exclamation-triangle"
            when :success then "check-circle"
            else "info-circle"
            end
  end
end
```

### Base Component Hook

```ruby
class ApplicationComponent < ViewComponent::Base
  def around_render
    ActiveSupport::Notifications.instrument(
      "render.view_component",
      component: self.class.name
    ) do
      yield
    end
  end
end
```

### Error Boundary

```ruby
class SafeComponent < ViewComponent::Base
  def around_render
    yield
  rescue => e
    Rails.logger.error "Component error: #{e.message}"
    render(ErrorFallbackComponent.new(error: e))
  end
end
```

## Testing Lifecycle

```ruby
class UserComponentTest < ViewComponent::TestCase
  def test_before_render_sets_avatar
    user = User.new(email: "test@example.com")
    component = UserComponent.new(user: user)

    render_inline(component)

    # before_render has been called, @avatar_url is set
    assert_selector "img[src*='gravatar']"
  end
end
```
