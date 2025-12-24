# ViewComponent Collections API Reference

## Basic Usage

Render multiple component instances from a collection:

```ruby
<%= render(ProductComponent.with_collection(@products)) %>
```

Equivalent to:

```ruby
<% @products.each do |product| %>
  <%= render(ProductComponent.new(product: product)) %>
<% end %>
```

## Collection Parameter

By default, the parameter name is derived from the component class name:

- `ProductComponent` → `product:`
- `UserCardComponent` → `user_card:`

### Custom Parameter Name

```ruby
class ProductComponent < ViewComponent::Base
  with_collection_parameter :item

  def initialize(item:)
    @item = item
  end
end
```

## Additional Arguments

Pass extra arguments to all instances:

```ruby
<%= render(ProductComponent.with_collection(@products, show_price: true)) %>
```

```ruby
class ProductComponent < ViewComponent::Base
  def initialize(product:, show_price: false)
    @product = product
    @show_price = show_price
  end
end
```

## Counter Variable

Track position with `_counter` suffix:

```ruby
class ProductComponent < ViewComponent::Base
  def initialize(product:, product_counter:)
    @product = product
    @counter = product_counter  # 0-indexed
  end
end
```

```erb
<div class="product" data-index="<%= @counter %>">
  <%= @product.name %>
</div>
```

## Iteration Context

Access iteration details with `_iteration` suffix (v2.33.0+):

```ruby
def initialize(product:, product_iteration:)
  @product = product
  @iteration = product_iteration
end
```

### Iteration Methods

| Method | Description |
|--------|-------------|
| `@iteration.index` | Current position (0-indexed) |
| `@iteration.size` | Total collection size |
| `@iteration.first?` | Is first item? |
| `@iteration.last?` | Is last item? |

```erb
<div class="product <%= 'first' if @iteration.first? %>">
  <%= @iteration.index + 1 %> of <%= @iteration.size %>
</div>
```

## Spacer Components

Insert components between items (v3.20.0+):

```ruby
<%= render(ProductComponent.with_collection(@products,
  spacer_component: DividerComponent.new)) %>
```

Output:
```
Product 1
--- divider ---
Product 2
--- divider ---
Product 3
```

## Common Patterns

### Empty State

```erb
<% if @products.any? %>
  <%= render(ProductComponent.with_collection(@products)) %>
<% else %>
  <%= render(EmptyStateComponent.new(message: "No products")) %>
<% end %>
```

### With Wrapper

```erb
<ul class="product-list">
  <%= render(ProductComponent.with_collection(@products)) %>
</ul>
```

### Conditional Styling

```ruby
def initialize(product:, product_iteration:)
  @product = product
  @css_class = product_iteration.last? ? "product last" : "product"
end
```
