# Turbo API Reference

## Turbo Drive

Turbo Drive accelerates navigation by intercepting link clicks and form submissions.

### Data Attributes

| Attribute | Purpose |
|-----------|---------|
| `data-turbo="false"` | Disable Turbo for link/form |
| `data-turbo-method="delete"` | HTTP method for links |
| `data-turbo-confirm="Sure?"` | Confirmation dialog |
| `data-turbo-action="replace"` | History mode: `advance` or `replace` |
| `data-turbo-preload` | Preload on hover |

### Meta Tags

```html
<meta name="turbo-cache-control" content="no-cache">
<meta name="turbo-visit-control" content="reload">
<meta name="turbo-root" content="/app">
```

### JavaScript API

```javascript
// Navigate programmatically
Turbo.visit("/path")
Turbo.visit("/path", { action: "replace" })

// Clear cache
Turbo.cache.clear()

// Disable/enable
Turbo.session.drive = false
```

## Turbo Frames

### HTML Attributes

| Attribute | Values | Purpose |
|-----------|--------|---------|
| `id` | string | Required unique identifier |
| `src` | URL | URL to load content from |
| `loading` | `eager`, `lazy` | Load timing |
| `disabled` | boolean | Prevent navigation |
| `target` | frame ID, `_top` | Navigation target |
| `autoscroll` | boolean | Scroll into view after load |
| `data-turbo-action` | `advance`, `replace` | History behavior |

### Targeting Frames

```html
<!-- From inside frame, target another frame -->
<a href="/path" data-turbo-frame="other-frame">Link</a>

<!-- From inside frame, break out to full page -->
<a href="/path" data-turbo-frame="_top">Full page</a>

<!-- From outside frame, target a frame -->
<a href="/path" data-turbo-frame="sidebar">Update sidebar</a>
```

### Lazy Loading

```erb
<turbo-frame id="comments" src="<%= comments_path %>" loading="lazy">
  <p>Loading comments...</p>
</turbo-frame>
```

### JavaScript API

```javascript
const frame = document.querySelector("turbo-frame#messages")

// Properties
frame.src              // Get/set source URL
frame.loading          // "eager" or "lazy"
frame.disabled         // Boolean
frame.complete         // Read-only completion status
frame.loaded           // Promise

// Methods
frame.reload()         // Reload from src
```

### Events

| Event | When |
|-------|------|
| `turbo:frame-load` | Frame content loaded |
| `turbo:frame-render` | Frame content rendered |
| `turbo:frame-missing` | Response missing frame |

## Turbo Streams

### Actions

| Action | Purpose |
|--------|---------|
| `append` | Add to end of container |
| `prepend` | Add to beginning of container |
| `replace` | Replace entire element |
| `update` | Replace element's content |
| `remove` | Remove element |
| `before` | Insert before element |
| `after` | Insert after element |
| `refresh` | Refresh the page with morphing |

### HTML Format

```html
<turbo-stream action="append" target="messages">
  <template>
    <div id="message_1">Hello!</div>
  </template>
</turbo-stream>
```

### Multiple Targets

```html
<turbo-stream action="remove" targets=".notification">
</turbo-stream>
```

### Rails Helpers

```erb
<%# Single element %>
<%= turbo_stream.append "messages", @message %>
<%= turbo_stream.prepend "messages", @message %>
<%= turbo_stream.replace @message %>
<%= turbo_stream.update @message %>
<%= turbo_stream.remove @message %>

<%# With partial %>
<%= turbo_stream.append "messages", partial: "message", locals: { message: @message } %>

<%# With block %>
<%= turbo_stream.update "counter" do %>
  <%= @count %>
<% end %>

<%# Multiple targets %>
<%= turbo_stream.remove_all ".flash" %>
```

### Broadcasting (Action Cable)

```ruby
# Model callbacks
class Message < ApplicationRecord
  broadcasts_to :room
  broadcasts_to ->(message) { [message.room, :messages] }
end

# Manual broadcast
Turbo::StreamsChannel.broadcast_append_to(
  "room_#{room.id}",
  target: "messages",
  partial: "messages/message",
  locals: { message: message }
)
```

### Stream Subscription

```erb
<%= turbo_stream_from @room %>
<%= turbo_stream_from @room, :messages %>
```

### Morphing

```erb
<%= turbo_stream.replace @message, method: :morph %>
<%= turbo_stream.update "container", method: :morph do %>
  ...
<% end %>
```

### JavaScript API

```javascript
// Render stream manually
Turbo.renderStreamMessage(`
  <turbo-stream action="append" target="messages">
    <template><div>New message</div></template>
  </turbo-stream>
`)

// Connect custom stream source
Turbo.session.connectStreamSource(eventSource)
Turbo.session.disconnectStreamSource(eventSource)
```

### Events

| Event | When |
|-------|------|
| `turbo:before-stream-render` | Before stream action |
| `turbo:stream-render` | After stream action |

## Common Patterns

### Form Response with Flash

```ruby
def create
  @post = Post.create!(post_params)
  flash.now[:notice] = "Created!"

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.prepend("posts", @post),
        turbo_stream.update("flash", partial: "shared/flash")
      ]
    end
    format.html { redirect_to posts_path }
  end
end
```

### Error Handling

```ruby
def create
  @post = Post.new(post_params)

  if @post.save
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @post }
    end
  else
    render :new, status: :unprocessable_entity
  end
end
```

### Inline Editing

```erb
<%# Show view %>
<turbo-frame id="<%= dom_id(post) %>">
  <p><%= post.title %></p>
  <%= link_to "Edit", edit_post_path(post) %>
</turbo-frame>

<%# Edit view %>
<turbo-frame id="<%= dom_id(@post) %>">
  <%= form_with model: @post do |f| %>
    <%= f.text_field :title %>
    <%= f.submit %>
  <% end %>
</turbo-frame>
```
