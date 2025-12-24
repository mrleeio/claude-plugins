---
name: new-component
description: Walk through creating a new ViewComponent with slots, previews, and tests
allowed-tools: AskUserQuestion, Read, Glob, Bash(bin/rails generate view_component:component *)
---

# Create New ViewComponent

Guide the user through creating a new ViewComponent by gathering requirements and generating the appropriate files.

## Step 1: Gather Component Information

Use AskUserQuestion to collect:

**Question 1: Component Name**
Ask: "What should the component be named?"
- Get the component name (e.g., "Button", "Card", "UserAvatar")
- Ensure it follows naming conventions (PascalCase, ends with Component suffix)

**Question 2: Component Type**
Ask: "What type of component is this?"
Options:
- **Simple** - Basic component with initializer params only
- **With Slots** - Component with content slots (renders_one/renders_many)
- **Collection** - Component designed to render collections
- **Wrapper** - Component that wraps content (uses `content`)

**Question 3: Additional Options**
Ask: "What additional files should be generated?" (multiSelect: true)
Options:
- **Preview** - Generate preview class for component gallery
- **Test** - Generate test file
- **Translations** - Generate locale file for i18n
- **Stimulus** - Generate accompanying Stimulus controller

## Step 2: Gather Slot Information (if "With Slots" selected)

Ask about slots:
- "What single slots does this component need?" (renders_one)
  - Examples: header, footer, icon, title
- "What multiple slots does this component need?" (renders_many)
  - Examples: items, actions, tabs

## Step 3: Gather Initializer Parameters

Ask: "What parameters should the initializer accept?"
- Get parameter names and whether they're required or have defaults
- Examples: `title:`, `variant: :default`, `size: :medium`

## Step 4: Generate Files

Based on the gathered information, create the component files:

### Component Class (app/components/[name]_component.rb)

```ruby
# frozen_string_literal: true

class [Name]Component < ViewComponent::Base
  # Slots (if applicable)
  renders_one :header
  renders_many :items

  def initialize(param:, optional: nil)
    @param = param
    @optional = optional
  end

  # For wrapper components
  # def call
  #   content_tag :div, content, class: "wrapper"
  # end
end
```

### Template (app/components/[name]_component.html.erb)

Generate appropriate template based on component type and slots.

### Preview (test/components/previews/[name]_component_preview.rb)

```ruby
# frozen_string_literal: true

class [Name]ComponentPreview < ViewComponent::Preview
  def default
    render([Name]Component.new(param: "value"))
  end

  # Add variant previews based on options
end
```

### Test (test/components/[name]_component_test.rb)

```ruby
# frozen_string_literal: true

require "test_helper"

class [Name]ComponentTest < ViewComponent::TestCase
  def test_renders
    render_inline([Name]Component.new(param: "value"))

    assert_selector "[appropriate selector]"
  end
end
```

### Translations (app/components/[name]_component.yml)

```yaml
en:
  # Add translation keys
```

## Step 5: Verify and Explain

After generating files:
1. List all created files
2. Explain how to use the component
3. Show example usage in a view
4. Mention the preview URL if preview was generated

## Guidelines

- Follow ViewComponent naming conventions (Component suffix)
- Use frozen_string_literal pragma
- Keep components focused on single responsibility
- Prefer explicit initializer params over accessing global state
- Generate comprehensive previews showing all variants
- Write tests that verify rendered output, not implementation
