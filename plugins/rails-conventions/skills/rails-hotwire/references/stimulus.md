# Stimulus API Reference

## Controller Basics

### File Naming Convention

| Filename | Controller Identifier |
|----------|----------------------|
| `hello_controller.js` | `hello` |
| `content_loader_controller.js` | `content-loader` |
| `users/list_controller.js` | `users--list` |
| `users/admin_panel_controller.js` | `users--admin-panel` |

### Basic Structure

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Lifecycle callbacks
  initialize() { }  // Once per controller class
  connect() { }      // Each time connected to DOM
  disconnect() { }   // Each time removed from DOM

  // Action methods
  greet() {
    console.log("Hello!")
  }
}
```

### Connection to HTML

```html
<div data-controller="hello">
  <button data-action="click->hello#greet">Greet</button>
</div>
```

## Targets

Targets provide references to important elements within the controller's scope.

### Declaration

```javascript
export default class extends Controller {
  static targets = ["input", "output", "submitButton"]
}
```

### Generated Properties

For a target named `input`:

| Property | Type | Description |
|----------|------|-------------|
| `this.inputTarget` | Element | First matching element (throws if missing) |
| `this.inputTargets` | Element[] | All matching elements |
| `this.hasInputTarget` | Boolean | Whether target exists |

### HTML Connection

```html
<div data-controller="search">
  <input data-search-target="input" type="text">
  <button data-search-target="submitButton">Search</button>
  <div data-search-target="output"></div>
</div>
```

### Usage

```javascript
export default class extends Controller {
  static targets = ["input", "output"]

  search() {
    const query = this.inputTarget.value
    this.outputTarget.textContent = `Searching for: ${query}`
  }

  clearAll() {
    this.inputTargets.forEach(input => input.value = "")
  }

  submit() {
    if (this.hasOutputTarget) {
      this.outputTarget.textContent = ""
    }
  }
}
```

### Target Callbacks

```javascript
export default class extends Controller {
  static targets = ["item"]

  itemTargetConnected(element) {
    console.log("Item added:", element)
  }

  itemTargetDisconnected(element) {
    console.log("Item removed:", element)
  }
}
```

## Values

Values read and write data attributes with automatic type coercion.

### Declaration

```javascript
export default class extends Controller {
  static values = {
    url: String,
    count: Number,
    active: Boolean,
    items: Array,
    config: Object
  }
}
```

### Default Values

```javascript
static values = {
  count: { type: Number, default: 0 },
  url: { type: String, default: "/api" },
  active: { type: Boolean, default: false }
}
```

### HTML Connection

```html
<div data-controller="example"
     data-example-url-value="/api/endpoint"
     data-example-count-value="42"
     data-example-active-value="true"
     data-example-items-value='["a","b","c"]'
     data-example-config-value='{"key":"value"}'>
</div>
```

### Generated Properties

For a value named `count`:

| Property | Description |
|----------|-------------|
| `this.countValue` | Get current value |
| `this.countValue = x` | Set value (updates DOM) |
| `this.hasCountValue` | Whether attribute exists |

### Change Callbacks

```javascript
export default class extends Controller {
  static values = { count: Number }

  countValueChanged(value, previousValue) {
    console.log(`Count: ${previousValue} -> ${value}`)
  }
}
```

### Type Coercion

| Type | Attribute Value | JavaScript Value |
|------|----------------|------------------|
| String | `"hello"` | `"hello"` |
| Number | `"42"` | `42` |
| Boolean | `"true"` / `"false"` | `true` / `false` |
| Array | `'["a","b"]'` | `["a", "b"]` |
| Object | `'{"k":"v"}'` | `{ k: "v" }` |

## Actions

Actions connect DOM events to controller methods.

### Basic Syntax

```
event->controller#method
```

```html
<button data-action="click->gallery#next">Next</button>
```

### Default Events

These elements have default events (event name optional):

| Element | Default Event |
|---------|---------------|
| `<a>` | `click` |
| `<button>` | `click` |
| `<form>` | `submit` |
| `<input>` | `input` |
| `<textarea>` | `input` |
| `<select>` | `change` |

```html
<!-- Equivalent -->
<button data-action="click->dialog#close">Close</button>
<button data-action="dialog#close">Close</button>
```

### Multiple Actions

```html
<input data-action="focus->field#highlight blur->field#unhighlight input->search#update">
```

### Event Options

```html
<!-- Prevent default -->
<a href="#" data-action="click->nav#open:prevent">Menu</a>

<!-- Stop propagation -->
<button data-action="click->modal#close:stop">Close</button>

<!-- Both -->
<form data-action="submit->form#save:prevent:stop">

<!-- Once (remove after first trigger) -->
<button data-action="click->setup#init:once">Initialize</button>

<!-- Self (only when event.target === element) -->
<div data-action="click->modal#close:self">
```

### Keyboard Filters

```html
<!-- Specific keys -->
<input data-action="keydown.enter->search#submit">
<input data-action="keydown.esc->search#clear">
<input data-action="keydown.space->player#toggle">

<!-- Key combinations -->
<input data-action="keydown.ctrl+s->editor#save:prevent">
<input data-action="keydown.meta+k->search#open:prevent">

<!-- Arrow keys -->
<div data-action="keydown.up->menu#previous keydown.down->menu#next">
```

Available key filters: `enter`, `tab`, `esc`, `space`, `up`, `down`, `left`, `right`, `home`, `end`, plus letter/number keys.

### Global Events

```html
<!-- Window events -->
<div data-action="resize@window->gallery#layout">
<div data-action="scroll@window->nav#updatePosition">

<!-- Document events -->
<div data-action="turbo:load@document->analytics#trackPage">
```

### Action Parameters

```html
<button data-action="click->item#update"
        data-item-id-param="123"
        data-item-status-param="active">
  Update
</button>
```

```javascript
export default class extends Controller {
  update({ params }) {
    console.log(params.id)     // "123" (string)
    console.log(params.status) // "active"
  }
}
```

## Classes

Classes allow configuring CSS class names via data attributes.

### Declaration

```javascript
export default class extends Controller {
  static classes = ["active", "loading", "error"]
}
```

### HTML Connection

```html
<div data-controller="tabs"
     data-tabs-active-class="tab--active"
     data-tabs-loading-class="is-loading">
</div>
```

### Generated Properties

For a class named `active`:

| Property | Description |
|----------|-------------|
| `this.activeClass` | Single class string |
| `this.activeClasses` | Array of classes (for space-separated) |
| `this.hasActiveClass` | Whether attribute exists |

### Usage

```javascript
export default class extends Controller {
  static classes = ["active"]
  static targets = ["tab"]

  select(event) {
    this.tabTargets.forEach(tab => {
      tab.classList.remove(this.activeClass)
    })
    event.currentTarget.classList.add(this.activeClass)
  }
}
```

### Default Classes

```javascript
static classes = ["active"]

get activeClass() {
  return this.hasActiveClass ? super.activeClass : "is-active"
}
```

## Outlets

Outlets connect controllers to other controllers on the page.

### Declaration

```javascript
// tabs_controller.js
export default class extends Controller {
  static outlets = ["tab-panel"]

  show(index) {
    this.tabPanelOutlets.forEach((panel, i) => {
      panel.visible = (i === index)
    })
  }
}
```

### HTML Connection

```html
<div data-controller="tabs" data-tabs-tab-panel-outlet=".panel">
  <button data-action="click->tabs#show" data-index="0">Tab 1</button>
</div>

<div class="panel" data-controller="tab-panel">Content 1</div>
<div class="panel" data-controller="tab-panel">Content 2</div>
```

### Generated Properties

For an outlet named `tabPanel`:

| Property | Description |
|----------|-------------|
| `this.tabPanelOutlet` | First matching controller |
| `this.tabPanelOutlets` | All matching controllers |
| `this.hasTabPanelOutlet` | Whether any exist |
| `this.tabPanelOutletElement` | First matching element |
| `this.tabPanelOutletElements` | All matching elements |

### Outlet Callbacks

```javascript
export default class extends Controller {
  static outlets = ["item"]

  itemOutletConnected(outlet, element) {
    console.log("Item outlet connected:", outlet)
  }

  itemOutletDisconnected(outlet, element) {
    console.log("Item outlet disconnected:", outlet)
  }
}
```

## Lifecycle Callbacks

### Order of Execution

1. `initialize()` - Once when controller instantiated
2. `[name]TargetConnected()` - For each target in initial DOM
3. `connect()` - When controller connected to DOM
4. `[name]ValueChanged()` - For initial values
5. ... (controller active) ...
6. `disconnect()` - When controller removed from DOM
7. `[name]TargetDisconnected()` - For each target removed

### Common Patterns

```javascript
export default class extends Controller {
  connect() {
    // Start intervals, add listeners, fetch data
    this.interval = setInterval(() => this.poll(), 5000)
    document.addEventListener("click", this.handleClick)
  }

  disconnect() {
    // Clean up
    clearInterval(this.interval)
    document.removeEventListener("click", this.handleClick)
  }

  handleClick = (event) => {
    // Arrow function for correct `this` binding
  }
}
```

## Utility Properties

```javascript
export default class extends Controller {
  connect() {
    this.element      // The controller's element
    this.application  // The Stimulus application
    this.identifier   // The controller identifier ("hello")
    this.scope        // The controller's scope
    this.dispatch     // Dispatch custom events
  }
}
```

## Custom Events

### Dispatching

```javascript
export default class extends Controller {
  select() {
    this.dispatch("selected", {
      detail: { item: this.selectedItem },
      prefix: "gallery",  // Event name: gallery:selected
      target: this.element,
      bubbles: true,
      cancelable: true
    })
  }
}
```

### Listening

```html
<div data-controller="gallery"
     data-action="gallery:selected->sidebar#updateSelection">
</div>
```

## Common Patterns

### Debouncing

```javascript
export default class extends Controller {
  static values = { delay: { type: Number, default: 300 } }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.performSearch()
    }, this.delayValue)
  }
}
```

### Loading States

```javascript
export default class extends Controller {
  static targets = ["button", "spinner"]

  async submit() {
    this.buttonTarget.disabled = true
    this.spinnerTarget.hidden = false

    try {
      await this.performAction()
    } finally {
      this.buttonTarget.disabled = false
      this.spinnerTarget.hidden = true
    }
  }
}
```

### Toggle Visibility

```javascript
export default class extends Controller {
  static targets = ["content"]
  static classes = ["hidden"]

  toggle() {
    this.contentTarget.classList.toggle(this.hiddenClass)
  }
}
```

### Form Reset

```javascript
export default class extends Controller {
  reset() {
    this.element.reset()
  }

  clear() {
    this.element.querySelectorAll("input, textarea").forEach(el => {
      el.value = ""
    })
  }
}
```
