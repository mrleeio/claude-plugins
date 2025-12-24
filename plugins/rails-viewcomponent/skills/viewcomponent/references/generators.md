# ViewComponent Generators Reference

## Basic Generation

```bash
bin/rails generate view_component:component Example title content
```

Creates:
- `app/components/example_component.rb`
- `app/components/example_component.html.erb`
- `test/components/example_component_test.rb`

## Namespaced Components

```bash
bin/rails generate view_component:component Admin::Button label variant
```

Creates:
- `app/components/admin/button_component.rb`
- `app/components/admin/button_component.html.erb`

## Generator Options

| Flag | Purpose |
|------|---------|
| `--preview` | Generate preview file |
| `--sidecar` | Use sidecar directory structure |
| `--inline` | Use inline template |
| `--stimulus` | Generate Stimulus controller |
| `--typescript` | Generate TypeScript Stimulus controller |
| `--locale` | Generate translation files |

### Preview Generation

```bash
bin/rails generate view_component:component Example title --preview
```

Creates additional:
- `test/components/previews/example_component_preview.rb`

### Sidecar Directory

```bash
bin/rails generate view_component:component Example title --sidecar
```

Creates:
```
app/components/
└── example_component/
    ├── example_component.rb
    └── example_component.html.erb
```

### Inline Template

```bash
bin/rails generate view_component:component Example title --inline
```

Creates component with embedded template:

```ruby
class ExampleComponent < ViewComponent::Base
  erb_template <<-ERB
    <div><%= @title %></div>
  ERB

  def initialize(title:)
    @title = title
  end
end
```

### Stimulus Integration

```bash
bin/rails generate view_component:component Dropdown --stimulus
```

Creates:
- `app/components/dropdown_component.rb`
- `app/components/dropdown_component.html.erb`
- `app/components/dropdown_component_controller.js`

### Locale Files

```bash
bin/rails generate view_component:component Welcome --locale
```

Creates:
- `app/components/welcome_component.yml`

## Template Engine

Override default template engine:

```bash
bin/rails generate view_component:component Example --template-engine slim
bin/rails generate view_component:component Example --template-engine haml
```

## Test Framework

Override default test framework:

```bash
bin/rails generate view_component:component Example --test-framework rspec
```

## Parent Class

Specify custom base class:

```bash
bin/rails generate view_component:component Example --parent ApplicationComponent
```

## Configuration

Configure defaults in `config/application.rb`:

```ruby
config.generators do |g|
  g.view_component do |vc|
    vc.preview true
    vc.sidecar true
  end
end
```

### Custom Generation Path

```ruby
config.view_component.generate.path = "app/views/components"
```

## Destroying Components

```bash
bin/rails destroy view_component:component Example
```

Removes all generated files.
