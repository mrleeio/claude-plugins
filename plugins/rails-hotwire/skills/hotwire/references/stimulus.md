# Stimulus API Reference

## Controllers

### File Naming Convention

| Filename | Identifier | HTML |
|----------|------------|------|
| `hello_controller.js` | `hello` | `data-controller="hello"` |
| `content_loader_controller.js` | `content-loader` | `data-controller="content-loader"` |
| `users/list_controller.js` | `users--list` | `data-controller="users--list"` |

### Lifecycle Callbacks

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    // Once, when controller class is instantiated
  }

  connect() {
    // Each time controller connects to DOM
  }

  disconnect() {
    // Each time controller disconnects from DOM
  }
}
```

### Properties

| Property | Description |
|----------|-------------|
| `this.element` | The controller's element |
| `this.application` | The Stimulus Application instance |
| `this.identifier` | The controller's identifier string |
| `this.scope` | The controller's Scope |

### Registration

```javascript
// Automatic (import maps / Webpack)
// Controllers in app/javascript/controllers auto-register

// Manual registration
import { Application } from "@hotwired/stimulus"
import HelloController from "./controllers/hello_controller"

const application = Application.start()
application.register("hello", HelloController)
```

### Conditional Loading

```javascript
export default class extends Controller {
  static shouldLoad = document.documentElement.hasAttribute("data-turbo-preview") === false
}
```

## Targets

### Definition

```javascript
export default class extends Controller {
  static targets = ["input", "output", "submitButton"]
}
```

### HTML

```html
<div data-controller="search">
  <input data-search-target="input">
  <div data-search-target="output"></div>
  <button data-search-target="submitButton">Search</button>
</div>
```

### Generated Properties

| For target `input` | Returns |
|--------------------|---------|
| `this.inputTarget` | First element (throws if none) |
| `this.inputTargets` | Array of all elements |
| `this.hasInputTarget` | Boolean |

### Multiple Targets

```html
<li data-search-target="result item">Both result and item</li>
```

### Target Callbacks

```javascript
export default class extends Controller {
  static targets = ["item"]

  itemTargetConnected(element) {
    // Called when target is added to DOM
  }

  itemTargetDisconnected(element) {
    // Called when target is removed from DOM
  }
}
```

## Values

### Definition

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

### HTML

```html
<div data-controller="loader"
     data-loader-url-value="/api/items"
     data-loader-count-value="10"
     data-loader-active-value="true"
     data-loader-items-value='["a","b","c"]'
     data-loader-config-value='{"key":"value"}'>
```

### Type Coercion

| Type | Default | Decoding |
|------|---------|----------|
| String | `""` | Direct |
| Number | `0` | `Number()` |
| Boolean | `false` | `!(value == "0" \|\| value == "false")` |
| Array | `[]` | `JSON.parse()` |
| Object | `{}` | `JSON.parse()` |

### Default Values

```javascript
static values = {
  url: { type: String, default: "/api" },
  count: { type: Number, default: 10 },
  active: { type: Boolean, default: true }
}
```

### Generated Properties

| For value `count` | Purpose |
|-------------------|---------|
| `this.countValue` | Get/set value |
| `this.hasCountValue` | Boolean existence |

### Change Callbacks

```javascript
export default class extends Controller {
  static values = { count: Number }

  countValueChanged(value, previousValue) {
    console.log(`Changed from ${previousValue} to ${value}`)
  }
}
```

## Actions

### Syntax

```
event->controller#method
```

### HTML

```html
<button data-action="click->gallery#next">Next</button>
<input data-action="input->search#query">
<form data-action="submit->form#save">
```

### Default Events

| Element | Default Event |
|---------|---------------|
| `<a>` | `click` |
| `<button>` | `click` |
| `<form>` | `submit` |
| `<input>` | `input` |
| `<textarea>` | `input` |
| `<select>` | `change` |
| `<details>` | `toggle` |

Shorthand (omit event):
```html
<button data-action="gallery#next">Next</button>
```

### Multiple Actions

```html
<input data-action="focus->field#highlight input->search#update blur->field#reset">
```

### Global Events

```html
<div data-controller="gallery"
     data-action="resize@window->gallery#layout
                  keydown@document->gallery#handleKey">
```

### Keyboard Filters

```html
<input data-action="keydown.enter->search#submit">
<input data-action="keydown.esc->modal#close">
<input data-action="keydown.ctrl+s->editor#save">
```

Available keys: `enter`, `tab`, `esc`, `space`, `up`, `down`, `left`, `right`, `home`, `end`, `page_up`, `page_down`, plus letter/number keys.

Modifiers: `alt`, `ctrl`, `meta`, `shift`

### Action Options

```html
<button data-action="click->controller#method:prevent">No default</button>
<button data-action="click->controller#method:stop">No propagation</button>
<button data-action="click->controller#method:self">Only direct clicks</button>
<a data-action="click->controller#method:passive">Passive listener</a>
```

### Action Parameters

```html
<button data-action="click->item#delete"
        data-item-id-param="123"
        data-item-type-param="post">
  Delete
</button>
```

```javascript
delete(event) {
  const { id, type } = event.params
  // id = 123 (Number), type = "post" (String)
}
```

## Classes

### Definition

```javascript
export default class extends Controller {
  static classes = ["active", "loading"]
}
```

### HTML

```html
<div data-controller="toggle"
     data-toggle-active-class="bg-blue-500"
     data-toggle-loading-class="opacity-50 cursor-wait">
```

### Generated Properties

| For class `active` | Returns |
|--------------------|---------|
| `this.activeClass` | Single class string |
| `this.activeClasses` | Array of classes |
| `this.hasActiveClass` | Boolean |

### Usage

```javascript
this.element.classList.add(this.activeClass)
this.element.classList.add(...this.activeClasses)
```

## Outlets

Outlets reference other controllers:

### Definition

```javascript
export default class extends Controller {
  static outlets = ["result"]

  show() {
    this.resultOutlets.forEach(outlet => outlet.show())
  }
}
```

### HTML

```html
<div data-controller="search" data-search-result-outlet=".result">
  <input data-action="input->search#update">
</div>

<div data-controller="result" class="result">...</div>
<div data-controller="result" class="result">...</div>
```

### Generated Properties

| For outlet `result` | Returns |
|---------------------|---------|
| `this.resultOutlet` | First controller instance |
| `this.resultOutlets` | Array of controllers |
| `this.hasResultOutlet` | Boolean |
| `this.resultOutletElement` | First element |
| `this.resultOutletElements` | Array of elements |

## Events / Dispatching

### Dispatch Events

```javascript
this.dispatch("select", {
  detail: { item: this.selectedItem },
  target: this.element,
  prefix: "gallery",    // Event: "gallery:select"
  bubbles: true,
  cancelable: true
})
```

### Listen to Dispatched Events

```html
<div data-controller="parent"
     data-action="gallery:select->parent#handleSelect">
  <div data-controller="gallery">...</div>
</div>
```

```javascript
// parent_controller.js
handleSelect(event) {
  const { item } = event.detail
}
```

## Common Patterns

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

### Remote Content Loading

For loading remote HTML content, use Turbo Frames instead of manual fetch. If you must load content manually, use Turbo's API:

```javascript
export default class extends Controller {
  static values = { url: String }

  async load() {
    // Prefer Turbo Frames for remote content
    // If manual loading needed, use fetch + Turbo:
    const response = await fetch(this.urlValue)
    const html = await response.text()
    Turbo.renderStreamMessage(html) // If response is Turbo Stream
  }
}
```

### Debounced Input

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

### Form Auto-Submit

```javascript
export default class extends Controller {
  submit() {
    this.element.requestSubmit()
  }
}
```

```html
<form data-controller="auto-submit">
  <select data-action="change->auto-submit#submit">
    ...
  </select>
</form>
```
