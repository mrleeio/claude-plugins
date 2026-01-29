# Turbo-First Pattern

Prefer Turbo over fetch + manual DOM manipulation.

## The Problem

```javascript
// WRONG - manual fetch and DOM manipulation
async load() {
  const response = await fetch(this.urlValue)
  const html = await response.text()
  this.outputTarget.textContent = html  // Loses HTML formatting
}
```

This approach:
- Requires manual error handling
- Loses HTML structure with `textContent`
- Doesn't integrate with Turbo's caching
- Requires more JavaScript code

## The Solution

```javascript
// RIGHT - let Turbo handle it
handleClick() {
  Turbo.visit(this.urlValue)
}
```

Or use lazy Turbo frames:

```erb
<%= turbo_frame_tag "content", src: path, loading: :lazy %>
```

## When to Use Each Approach

| Approach | Use Case |
|----------|----------|
| `Turbo.visit(url)` | Full page navigation |
| `<turbo-frame>` | Partial page updates |
| `<turbo-stream>` | Multiple DOM updates |
| Fetch API | Only when Turbo can't work |

## Turbo Frame Examples

### Lazy Loading

```erb
<%# Loads content when frame enters viewport %>
<%= turbo_frame_tag "sidebar", src: sidebar_path, loading: :lazy %>
```

### Click to Load

```erb
<%# Frame with link that loads content %>
<%= turbo_frame_tag "details" do %>
  <%= link_to "Load details", details_path %>
<% end %>
```

### Replace on Submit

```erb
<%# Form that replaces its frame on submit %>
<%= turbo_frame_tag "search_results" do %>
  <%= form_with url: search_path, method: :get do |f| %>
    <%= f.text_field :q %>
    <%= f.submit "Search" %>
  <% end %>

  <%# Results appear here %>
<% end %>
```

## Stimulus + Turbo Integration

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  // Let Turbo handle navigation
  navigate() {
    Turbo.visit(this.urlValue)
  }

  // Or trigger a frame refresh
  refresh() {
    const frame = document.querySelector("turbo-frame#content")
    frame.src = this.urlValue
  }
}
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| `fetch` + `innerHTML` | Use Turbo frame |
| Manual loading states | Turbo handles automatically |
| Custom caching | Use Turbo's cache |
| XHR for partials | Use Turbo streams |

## When Fetch is Acceptable

- Non-HTML responses (JSON APIs)
- Uploads with progress tracking
- Third-party API calls
- WebSocket connections (use Action Cable instead)
