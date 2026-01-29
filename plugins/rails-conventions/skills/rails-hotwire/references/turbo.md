# Turbo API Reference

## Turbo Drive

Turbo Drive accelerates page navigation by intercepting link clicks and form submissions.

### Configuration

```javascript
// Disable Turbo Drive globally
Turbo.session.drive = false

// Re-enable
Turbo.session.drive = true
```

### Data Attributes

| Attribute | Purpose |
|-----------|---------|
| `data-turbo="false"` | Disable Turbo for element |
| `data-turbo="true"` | Enable Turbo (override parent disable) |
| `data-turbo-method="post"` | Use specific HTTP method for links |
| `data-turbo-confirm="Sure?"` | Show confirmation before navigation |
| `data-turbo-prefetch="false"` | Disable link prefetching |

### Progress Bar

```css
/* Customize progress bar */
.turbo-progress-bar {
  height: 5px;
  background-color: green;
}
```

```javascript
// Control programmatically
Turbo.setProgressBarDelay(500) // ms before showing
```

### Cache Control

```html
<!-- Don't cache this page -->
<meta name="turbo-cache-control" content="no-cache">

<!-- Don't preview from cache -->
<meta name="turbo-cache-control" content="no-preview">
```

## Turbo Frames

### Basic Frame

```erb
<turbo-frame id="messages">
  <%= render @messages %>
</turbo-frame>
```

### Frame Attributes

| Attribute | Purpose |
|-----------|---------|
| `id` | Unique identifier (required) |
| `src` | URL to load content from |
| `loading="lazy"` | Load when frame visible |
| `loading="eager"` | Load immediately (default) |
| `disabled` | Prevent frame from loading |
| `target` | Default target for links/forms |
| `autoscroll` | Scroll frame into view |

### Lazy Loading

```erb
<turbo-frame id="comments" src="<%= comments_path %>" loading="lazy">
  <p>Loading comments...</p>
</turbo-frame>
```

### Targeting Frames

```html
<!-- Target specific frame from link -->
<a href="/path" data-turbo-frame="sidebar">Load in sidebar</a>

<!-- Break out of frame -->
<a href="/path" data-turbo-frame="_top">Full page navigation</a>

<!-- Form targeting frame -->
<form action="/path" data-turbo-frame="results">
```

### Frame Events

```javascript
document.addEventListener("turbo:frame-load", (event) => {
  console.log("Frame loaded:", event.target.id)
})

document.addEventListener("turbo:frame-render", (event) => {
  console.log("Frame rendered:", event.target.id)
})

document.addEventListener("turbo:frame-missing", (event) => {
  // Response didn't contain matching frame
  event.preventDefault() // Prevent error
  event.detail.visit(event.detail.response) // Visit full page instead
})
```

### Programmatic Control

```javascript
const frame = document.querySelector("turbo-frame#messages")

// Reload frame content
frame.reload()

// Load new URL
frame.src = "/new-path"

// Check loading state
frame.loading // "eager" or "lazy"
frame.complete // boolean
frame.disabled // boolean
```

## Turbo Streams

### Stream Actions

| Action | Description |
|--------|-------------|
| `append` | Add to end of container |
| `prepend` | Add to beginning of container |
| `replace` | Replace entire element |
| `update` | Replace element's content |
| `remove` | Remove element |
| `before` | Insert before element |
| `after` | Insert after element |
| `refresh` | Reload page preserving scroll |

### Rails Helpers

```erb
<%# Append to container %>
<%= turbo_stream.append "messages", @message %>
<%= turbo_stream.append "messages", partial: "message", locals: { message: @message } %>

<%# Prepend to container %>
<%= turbo_stream.prepend "messages", @message %>

<%# Replace element %>
<%= turbo_stream.replace @message %>
<%= turbo_stream.replace dom_id(@message), partial: "message" %>

<%# Update element content %>
<%= turbo_stream.update "counter", "42" %>
<%= turbo_stream.update "counter" do %>
  <span><%= @count %></span>
<% end %>

<%# Remove element %>
<%= turbo_stream.remove @message %>
<%= turbo_stream.remove "message_123" %>

<%# Before/After %>
<%= turbo_stream.before @message, partial: "divider" %>
<%= turbo_stream.after @message, partial: "divider" %>

<%# Refresh %>
<%= turbo_stream.refresh %>
<%= turbo_stream.refresh request_id: "abc123" %>
```

### Controller Response

```ruby
class MessagesController < ApplicationController
  def create
    @message = Message.create!(message_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to messages_path }
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@message) }
      format.html { redirect_to messages_path }
    end
  end
end
```

### Multiple Streams

```erb
<%# app/views/messages/create.turbo_stream.erb %>
<%= turbo_stream.append "messages", @message %>
<%= turbo_stream.update "message_count", Message.count %>
<%= turbo_stream.remove "empty_state" %>
```

### Inline Rendering

```ruby
def create
  @message = Message.create!(message_params)

  render turbo_stream: [
    turbo_stream.append("messages", @message),
    turbo_stream.update("counter", Message.count.to_s)
  ]
end
```

## Broadcasting (Action Cable)

### Model Broadcasts

```ruby
class Message < ApplicationRecord
  # Broadcast to channel matching association
  broadcasts_to :room

  # Broadcast to specific channel
  broadcasts_to ->(message) { :messages }

  # Customize which actions broadcast
  broadcasts_to :room, inserts_by: :prepend

  # Broadcast for specific actions only
  after_create_commit -> { broadcast_append_to room }
  after_update_commit -> { broadcast_replace_to room }
  after_destroy_commit -> { broadcast_remove_to room }
end
```

### Broadcast Methods

```ruby
# From model instance
message.broadcast_append_to "messages"
message.broadcast_prepend_to "messages"
message.broadcast_replace_to "messages"
message.broadcast_update_to "messages"
message.broadcast_remove_to "messages"

# With custom partial
message.broadcast_append_to "messages",
  partial: "messages/message",
  locals: { message: message }

# With custom target
message.broadcast_append_to "messages",
  target: "message_list"
```

### Stream From View

```erb
<%# Subscribe to broadcasts %>
<%= turbo_stream_from @room %>
<%= turbo_stream_from "messages" %>
<%= turbo_stream_from current_user, "notifications" %>
```

### Broadcast Later (Background Job)

```ruby
message.broadcast_append_later_to "messages"
message.broadcast_replace_later_to "messages"
```

## Stream Events

```javascript
// Stream element connected
document.addEventListener("turbo:before-stream-render", (event) => {
  const stream = event.target
  console.log("Action:", stream.action)
  console.log("Target:", stream.target)

  // Prevent render
  event.preventDefault()

  // Custom render
  event.detail.render(stream)
})
```

## Morphing (Turbo 8+)

### Page Refresh with Morph

```ruby
# Controller
def update
  @message.update!(message_params)
  redirect_to @message, status: :see_other
end
```

```html
<!-- Enable morphing on page -->
<meta name="turbo-refresh-method" content="morph">
```

### Stream Morph

```erb
<%= turbo_stream.replace @message, method: :morph %>
```

## Common Patterns

### Flash Messages

```erb
<%# Layout %>
<div id="flash"><%= render "shared/flash" %></div>

<%# create.turbo_stream.erb %>
<%= turbo_stream.update "flash", partial: "shared/flash" %>
<%= turbo_stream.append "messages", @message %>
```

### Form Errors

```erb
<%# create.turbo_stream.erb (on validation failure) %>
<%= turbo_stream.replace "new_message_form" do %>
  <%= render "form", message: @message %>
<% end %>
```

### Empty States

```erb
<%# Show empty state when list empty %>
<% if @messages.empty? %>
  <div id="empty_state">No messages yet</div>
<% end %>

<%# Remove empty state on create %>
<%= turbo_stream.remove "empty_state" if @message.persisted? %>
```

### Optimistic UI

```javascript
// Submit form and show optimistic result
form.addEventListener("turbo:submit-start", () => {
  // Show loading state
})

form.addEventListener("turbo:submit-end", () => {
  // Remove loading state
})
```
