# Visibility Modifiers

Formatting conventions for `private`, `protected`, and `public`.

## Standard Pattern

No newline after `private`, indent content under it:

```ruby
class SomeClass
  def some_method
    # ...
  end

  private
    def some_private_method_1
      # ...
    end

    def some_private_method_2
      # ...
    end
end
```

## Exception: Modules with Only Private Methods

When a module contains only private methods, add a newline:

```ruby
module SomeModule
  private

  def some_private_method
    # ...
  end
end
```

## Multiple Visibility Sections

```ruby
class SomeClass
  def public_method
    # ...
  end

  protected
    def protected_method
      # ...
    end

  private
    def private_method
      # ...
    end
end
```

## Class Methods Visibility

```ruby
class SomeClass
  class << self
    def public_class_method
      # ...
    end

    private
      def private_class_method
        # ...
      end
  end
end
```

Or use `private_class_method`:

```ruby
class SomeClass
  def self.public_method
    private_helper
  end

  def self.private_helper
    # ...
  end
  private_class_method :private_helper
end
```

## Avoid Inline Visibility

```ruby
# Avoid
private def some_method
  # ...
end

# Prefer
private
  def some_method
    # ...
  end
```

## Why Indentation?

Indenting under `private` provides visual grouping:

```ruby
class Card
  def close
    track_closure
    update_state
  end

  def reopen
    clear_closure
    update_state
  end

  private
    def track_closure    # Visual indent shows these are private
      # ...
    end

    def clear_closure
      # ...
    end

    def update_state
      # ...
    end
end
```

## Common Patterns

| Scenario | Pattern |
|----------|---------|
| Class with public and private | Indent under `private` |
| Module with only private | Newline after `private` |
| Concern with callbacks | Group by visibility |
| Controller | Indent private methods |
