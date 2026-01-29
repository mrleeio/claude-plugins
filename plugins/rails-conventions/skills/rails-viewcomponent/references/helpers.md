# ViewComponent Helpers Reference

## Accessing Rails Helpers

Three approaches to use helpers in components:

### 1. Include Helper Module

```ruby
class UserComponent < ViewComponent::Base
  include IconHelper
  include ActionView::Helpers::NumberHelper

  def initialize(user:)
    @user = user
  end

  def formatted_balance
    number_to_currency(@user.balance)
  end
end
```

### 2. Helpers Proxy

Access any helper through the `helpers` object:

```ruby
class UserComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def avatar_url
    helpers.gravatar_url(@user.email)
  end

  def formatted_date
    helpers.l(@user.created_at, format: :short)
  end
end
```

### 3. Delegation

Delegate specific helpers for cleaner syntax:

```ruby
class UserComponent < ViewComponent::Base
  delegate :gravatar_url, :time_ago_in_words, to: :helpers

  def initialize(user:)
    @user = user
  end
end
```

## Common Helpers

### URL Helpers

```ruby
class NavComponent < ViewComponent::Base
  delegate :root_path, :users_path, to: :helpers

  def nav_links
    [
      { label: "Home", path: root_path },
      { label: "Users", path: users_path }
    ]
  end
end
```

### Tag Helpers

```ruby
class IconComponent < ViewComponent::Base
  include ActionView::Helpers::TagHelper

  def initialize(name:)
    @name = name
  end

  def call
    tag.i(class: "icon icon-#{@name}")
  end
end
```

### Asset Helpers

```ruby
class LogoComponent < ViewComponent::Base
  delegate :image_tag, :asset_path, to: :helpers

  def call
    image_tag("logo.png", alt: "Logo")
  end
end
```

## URL Helper Caveats

Avoid implicit request dependencies:

```ruby
# Bad - depends on current request
def profile_link
  helpers.edit_user_path  # Uses current user from request
end

# Good - explicit parameters
def profile_link(user)
  helpers.edit_user_path(user)
end
```

## Custom Helpers

### Application Helper

```ruby
# app/helpers/application_helper.rb
module ApplicationHelper
  def format_status(status)
    content_tag :span, status, class: "status status-#{status}"
  end
end
```

```ruby
# app/components/order_component.rb
class OrderComponent < ViewComponent::Base
  include ApplicationHelper

  # or
  delegate :format_status, to: :helpers
end
```

### Component-Specific Helpers

Define methods directly in the component:

```ruby
class PriceComponent < ViewComponent::Base
  def initialize(amount:, currency: "USD")
    @amount = amount
    @currency = currency
  end

  private

  def formatted_price
    helpers.number_to_currency(@amount, unit: currency_symbol)
  end

  def currency_symbol
    { "USD" => "$", "EUR" => "€", "GBP" => "£" }[@currency]
  end
end
```

## Template Helpers

In templates, helpers are available directly:

```erb
<%# app/components/user_component.html.erb %>
<div class="user">
  <%= image_tag @user.avatar_url %>
  <%= link_to @user.name, user_path(@user) %>
  <span><%= time_ago_in_words(@user.created_at) %> ago</span>
</div>
```
