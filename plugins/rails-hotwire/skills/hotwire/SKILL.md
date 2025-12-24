---
name: Hotwire
description: This skill should be used when the user is working on Rails frontend code, asks about "Turbo Frames", "Turbo Streams", "Stimulus controllers", "Hotwire patterns", or implements interactive features in a Rails application. Provides conventions and API reference for Turbo and Stimulus.
version: 1.0.0
---

# Hotwire Conventions for Rails

Hotwire enables fast, modern web applications by sending HTML over the wire instead of JSON. It consists of Turbo (for navigation and updates) and Stimulus (for JavaScript behavior).

## Core Philosophy

**HTML over the wire**: Server renders HTML, client updates the DOM. No client-side rendering frameworks needed.

**Progressive enhancement**: Start with standard HTML, add interactivity through data attributes.

**Server-side logic**: Keep application logic on the server, minimize client-side JavaScript.

## When to Use Each Component

| Need | Solution |
|------|----------|
| Fast page navigation | Turbo Drive (automatic) |
| Update part of a page | Turbo Frames |
| Real-time updates | Turbo Streams |
| JavaScript behavior | Stimulus controllers |

## Turbo Drive

Turbo Drive intercepts link clicks and form submissions, fetching pages via AJAX and replacing the `<body>`. It's enabled by default.

**Disable for specific links:**
```html
<a href="/path" data-turbo="false">Regular navigation</a>
```

**Disable for forms:**
```html
<form data-turbo="false">...</form>
```

## Turbo Frames

Frames scope navigation to a specific region. Wrap content in `<turbo-frame>`:

```erb
<turbo-frame id="messages">
  <%= render @messages %>
</turbo-frame>
```

**Key rules:**
- Links/forms inside a frame update only that frame
- Server response must include a matching `<turbo-frame id="messages">`
- Use `data-turbo-frame` to target a different frame

**Target the whole page from inside a frame:**
```html
<a href="/path" data-turbo-frame="_top">Full page navigation</a>
```

**Lazy loading:**
```erb
<turbo-frame id="comments" src="<%= comments_path %>" loading="lazy">
  Loading...
</turbo-frame>
```

For complete Turbo Frames API, see `references/turbo.md`.

## Turbo Streams

Streams perform DOM operations: append, prepend, replace, update, remove, before, after, refresh.

**From controller response:**
```ruby
# app/controllers/messages_controller.rb
def create
  @message = Message.create!(message_params)
  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to messages_path }
  end
end
```

**Stream template:**
```erb
<%# app/views/messages/create.turbo_stream.erb %>
<%= turbo_stream.append "messages", @message %>
```

**Available actions:**
```erb
<%= turbo_stream.append "container", partial: "item", locals: { item: @item } %>
<%= turbo_stream.prepend "container", @item %>
<%= turbo_stream.replace @item %>
<%= turbo_stream.update "counter", "42" %>
<%= turbo_stream.remove @item %>
<%= turbo_stream.before @item, partial: "divider" %>
<%= turbo_stream.after @item, partial: "divider" %>
```

**Broadcast from model (Action Cable):**
```ruby
class Message < ApplicationRecord
  broadcasts_to :room
end
```

For complete Turbo Streams API, see `references/turbo.md`.

## Stimulus Controllers

Stimulus connects JavaScript to HTML via data attributes.

### File Naming

| Filename | Identifier |
|----------|------------|
| `hello_controller.js` | `hello` |
| `content_loader_controller.js` | `content-loader` |
| `users/list_controller.js` | `users--list` |

### Basic Structure

```javascript
// app/javascript/controllers/hello_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  static values = { name: String }

  connect() {
    // Called when controller connects to DOM
  }

  greet() {
    this.outputTarget.textContent = `Hello, ${this.nameValue}!`
  }
}
```

```html
<div data-controller="hello" data-hello-name-value="World">
  <button data-action="click->hello#greet">Greet</button>
  <span data-hello-target="output"></span>
</div>
```

### Targets

Targets reference important elements:

```javascript
static targets = ["input", "output", "submitButton"]
```

Generated properties:
- `this.inputTarget` - First matching element (error if missing)
- `this.inputTargets` - Array of all matches
- `this.hasInputTarget` - Boolean existence check

### Values

Values read/write data attributes with type coercion:

```javascript
static values = {
  url: String,
  count: Number,
  active: Boolean,
  items: Array,
  config: Object
}
```

```html
<div data-controller="example"
     data-example-url-value="/api"
     data-example-count-value="5"
     data-example-active-value="true">
```

**Change callbacks:**
```javascript
countValueChanged(value, previousValue) {
  console.log(`Count changed from ${previousValue} to ${value}`)
}
```

### Actions

Actions connect events to methods:

```html
<button data-action="click->controller#method">Click</button>
<input data-action="input->search#query">
<form data-action="submit->form#save">
```

**Event shorthand** (default events):
- `<button>`, `<a>` → click
- `<form>` → submit
- `<input>`, `<textarea>` → input
- `<select>` → change

**Multiple actions:**
```html
<input data-action="focus->field#highlight input->search#update">
```

**Keyboard filters:**
```html
<input data-action="keydown.enter->search#submit keydown.esc->search#clear">
```

**Global events:**
```html
<div data-action="resize@window->gallery#layout">
```

For complete Stimulus API, see `references/stimulus.md`.

## Common Patterns

### Flash Messages with Turbo Streams

```erb
<%# app/views/layouts/application.html.erb %>
<div id="flash"></div>

<%# app/views/shared/_flash.turbo_stream.erb %>
<%= turbo_stream.update "flash" do %>
  <% flash.each do |type, message| %>
    <div class="flash flash-<%= type %>"><%= message %></div>
  <% end %>
<% end %>
```

### Modal with Turbo Frame

```erb
<%# Link that opens modal %>
<%= link_to "Edit", edit_post_path(@post), data: { turbo_frame: "modal" } %>

<%# Modal frame in layout %>
<turbo-frame id="modal"></turbo-frame>

<%# edit.html.erb %>
<turbo-frame id="modal">
  <div class="modal">
    <%= form_with model: @post do |f| %>
      ...
    <% end %>
  </div>
</turbo-frame>
```

### Form Validation with Stimulus

```javascript
// app/javascript/controllers/form_validation_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit"]

  validate() {
    const valid = this.element.checkValidity()
    this.submitTarget.disabled = !valid
  }
}
```

```erb
<%= form_with model: @user, data: { controller: "form-validation" } do |f| %>
  <%= f.email_field :email, required: true, data: { action: "input->form-validation#validate" } %>
  <%= f.submit "Save", data: { form_validation_target: "submit" } %>
<% end %>
```

### Infinite Scroll with Turbo Frames

```erb
<%# index.html.erb %>
<div id="items">
  <%= render @items %>
</div>

<turbo-frame id="pagination" src="<%= items_path(page: @next_page) %>" loading="lazy">
  <p>Loading more...</p>
</turbo-frame>
```

## Best Practices

1. **Prefer Turbo over custom JavaScript** - Most interactions can be handled with Frames and Streams

2. **Keep Stimulus controllers small** - Each controller should do one thing well

3. **Use descriptive identifiers** - `content-loader` not `cl`, `form-validation` not `fv`

4. **Leverage server rendering** - Return HTML partials, not JSON

5. **Progressive enhancement** - Features should work without JavaScript when possible

6. **Scope Turbo Frames narrowly** - Smaller frames = faster updates

## Reference Files

For detailed API documentation:
- **`references/turbo.md`** - Turbo Drive, Frames, Streams API
- **`references/stimulus.md`** - Controllers, Actions, Targets, Values API
