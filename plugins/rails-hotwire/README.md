# rails-hotwire

Hotwire conventions and API reference for Rails frontend development. Ensures Claude follows Turbo and Stimulus best practices.

## What This Plugin Does

When working on Rails frontend code, Claude will:

- Use Turbo Frames and Streams instead of custom JavaScript for page updates
- Follow Stimulus controller naming and organization conventions
- Apply progressive enhancement patterns
- Reference the correct Turbo/Stimulus APIs

## Hotwire Components

- **Turbo Drive** - SPA-like navigation without JavaScript
- **Turbo Frames** - Independent page segments
- **Turbo Streams** - Real-time updates via WebSocket/SSE
- **Stimulus** - Modest JavaScript controllers

## More Information

- [Turbo Handbook](https://turbo.hotwired.dev/handbook/introduction)
- [Stimulus Handbook](https://stimulus.hotwired.dev/handbook/introduction)
