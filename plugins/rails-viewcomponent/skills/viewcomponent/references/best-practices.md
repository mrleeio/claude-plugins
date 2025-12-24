# ViewComponent Best Practices

## Philosophy

**ViewComponent is to UI what ActiveRecord is to SQL** - It brings conceptual compression to interface building, helping manage growing view complexity.

Converting existing views to ViewComponents often reveals hidden complexity and dependencies, supporting better refactoring.

## Component Types

### General-Purpose Components

Implement standard UI patterns reusable across the application:

- Buttons
- Forms and inputs
- Modals and dialogs
- Cards and panels
- Navigation elements

### Application-Specific Components

Translate domain objects into UI:

```ruby
# Translates User model into UI
class UserCardComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end
end
```

## Organization Guidelines

### Extract, Don't Invent

1. Implement a single use case first
2. Adapt across multiple locations
3. Then extract into shared component

**Don't** create abstract components before you have concrete use cases.

### DRY After Three

Abstract once three or more similar instances exist:

```ruby
# After seeing this pattern 3+ times, extract it
class StatusBadgeComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
  end
end
```

### Minimize One-Offs

Reduce single-use view code. If something is used once, consider whether it needs to be a component at all.

### Naming Convention

Always use the `Component` suffix:

```ruby
# Good
class ButtonComponent < ViewComponent::Base
class UserAvatarComponent < ViewComponent::Base

# Bad
class Button < ViewComponent::Base
class UserAvatar < ViewComponent::Base
```

## Implementation Guidelines

### Prefer Composition Over Inheritance

```ruby
# Bad - inheritance with separate templates is confusing
class PrimaryButtonComponent < ButtonComponent
end

# Good - composition wraps components
class PrimaryButtonComponent < ViewComponent::Base
  def call
    render(ButtonComponent.new(variant: :primary)) { content }
  end
end
```

### Decouple from Global State

```ruby
# Bad - accesses params directly
class SearchComponent < ViewComponent::Base
  def query
    params[:q]
  end
end

# Good - explicit dependencies
class SearchComponent < ViewComponent::Base
  def initialize(query:)
    @query = query
  end
end
```

### Mark Methods Private

Instance methods remain accessible in templates even when private:

```ruby
class UserComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  private

  def formatted_name
    "#{@user.first_name} #{@user.last_name}"
  end

  def avatar_url
    # Still accessible in template as <%= avatar_url %>
  end
end
```

### Use Instance Methods Over Inline Ruby

```erb
<%# Bad - logic in template %>
<span class="<%= @user.admin? ? 'text-red' : 'text-gray' %>">
  <%= @user.name.titleize %>
</span>

<%# Good - use methods %>
<span class="<%= name_class %>">
  <%= formatted_name %>
</span>
```

### Use Slots for Markup

```ruby
# Bad - bypasses HTML sanitization
class CardComponent < ViewComponent::Base
  def initialize(header_html:)
    @header_html = header_html
  end
end

# Good - slots maintain security
class CardComponent < ViewComponent::Base
  renders_one :header
end
```

## Testing Guidelines

### Test Rendered Output

```ruby
# Good - tests what user sees
def test_displays_user_name
  render_inline(UserComponent.new(user: @user))
  assert_text @user.name
end

# Bad - tests internal implementation
def test_formatted_name_method
  component = UserComponent.new(user: @user)
  assert_equal "John Doe", component.send(:formatted_name)
end
```

### Test All Variants

```ruby
def test_all_button_variants
  %i[primary secondary danger].each do |variant|
    render_inline(ButtonComponent.new(variant: variant))
    assert_selector ".btn-#{variant}"
  end
end
```

## When to Use ViewComponent

**Good candidates:**
- Reused across multiple views
- Complex conditional rendering
- Need unit testing
- Have multiple variants/states
- Encapsulate domain logic

**Maybe not needed:**
- Simple one-off markup
- Static content without logic
- Already simple partials working well

## Anti-Patterns to Avoid

1. **God components** - Components doing too much
2. **Deep inheritance** - More than one level
3. **Implicit dependencies** - Accessing request/session directly
4. **Logic in templates** - Complex Ruby in ERB
5. **Testing internals** - Testing private methods instead of output
6. **Premature abstraction** - Creating components before patterns emerge
