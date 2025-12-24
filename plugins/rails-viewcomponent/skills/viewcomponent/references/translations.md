# ViewComponent Translations (i18n) Reference

## Translation File Location

### Single File

```yaml
# app/components/greeting_component.yml
en:
  hello: "Hello!"
  goodbye: "Goodbye!"
fr:
  hello: "Bonjour!"
  goodbye: "Au revoir!"
```

### Per-Locale Files

```yaml
# app/components/greeting_component.en.yml
en:
  hello: "Hello!"
  goodbye: "Goodbye!"
```

```yaml
# app/components/greeting_component.fr.yml
fr:
  hello: "Bonjour!"
  goodbye: "Au revoir!"
```

### Sidecar Directory

```
app/components/
└── greeting_component/
    ├── greeting_component.rb
    ├── greeting_component.html.erb
    ├── greeting_component.en.yml
    └── greeting_component.fr.yml
```

## Accessing Translations

### Component-Scoped (Dot Prefix)

```erb
<%# In template %>
<h1><%= t(".hello") %></h1>
<p><%= t(".goodbye") %></p>
```

```ruby
# In component class
def greeting_text
  t(".hello")
end
```

### Global Translations

```erb
<%= t("shared.welcome") %>
<%= helpers.t("activerecord.errors.messages.blank") %>
<%= I18n.t("date.formats.short") %>
```

## Namespaced Components

For `Admin::DashboardComponent`:

```yaml
# app/components/admin/dashboard_component.yml
en:
  title: "Admin Dashboard"
  stats: "Statistics"
```

```erb
<h1><%= t(".title") %></h1>
```

## Translation Inheritance

Child components inherit parent translations:

```yaml
# app/components/base_button_component.yml
en:
  click: "Click me"
  submit: "Submit"
```

```yaml
# app/components/danger_button_component.yml
en:
  click: "Delete"  # Overrides parent
  # submit inherited from parent
```

## Interpolation

```yaml
# app/components/welcome_component.yml
en:
  greeting: "Hello, %{name}!"
  items_count: "You have %{count} items"
```

```erb
<%= t(".greeting", name: @user.name) %>
<%= t(".items_count", count: @items.size) %>
```

## Pluralization

```yaml
# app/components/notification_component.yml
en:
  messages:
    zero: "No messages"
    one: "1 message"
    other: "%{count} messages"
```

```erb
<%= t(".messages", count: @message_count) %>
```

## HTML Translations

```yaml
# app/components/terms_component.yml
en:
  agreement_html: "By continuing, you agree to our <a href='/terms'>Terms</a>"
```

```erb
<%= t(".agreement_html") %>  <%# Automatically marked html_safe %>
```

## Generator Support

Generate component with locale file:

```bash
bin/rails generate view_component:component Welcome --locale
```

Creates:
- `app/components/welcome_component.rb`
- `app/components/welcome_component.html.erb`
- `app/components/welcome_component.yml`

## Testing Translations

```ruby
class GreetingComponentTest < ViewComponent::TestCase
  def test_renders_english
    I18n.with_locale(:en) do
      render_inline(GreetingComponent.new)
      assert_text "Hello!"
    end
  end

  def test_renders_french
    I18n.with_locale(:fr) do
      render_inline(GreetingComponent.new)
      assert_text "Bonjour!"
    end
  end
end
```

## Missing Translations

Handle missing translations gracefully:

```erb
<%= t(".optional_text", default: "Fallback text") %>
```

```ruby
def status_text
  t(".status.#{@status}", default: @status.humanize)
end
```
