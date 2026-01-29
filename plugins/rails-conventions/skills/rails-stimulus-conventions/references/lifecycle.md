# Stimulus Controller Lifecycle

Connect and disconnect patterns for proper cleanup.

## Basic Structure

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  static values = { url: String }

  connect() {
    // Setup: called when controller connects to DOM
  }

  disconnect() {
    // Cleanup: called when controller disconnects from DOM
  }
}
```

## The Cleanup Rule

**`disconnect()` must clean up what `connect()` creates.**

| Created in `connect()` | Clean up in `disconnect()` |
|------------------------|----------------------------|
| `setInterval` | `clearInterval` |
| `setTimeout` | `clearTimeout` |
| `addEventListener` | `removeEventListener` |
| `IntersectionObserver` | `observer.disconnect()` |
| `MutationObserver` | `observer.disconnect()` |
| `ResizeObserver` | `observer.disconnect()` |

## Timer Cleanup

```javascript
export default class extends Controller {
  connect() {
    this.timer = setInterval(() => this.refresh(), 5000)
  }

  disconnect() {
    if (this.timer) {
      clearInterval(this.timer)
    }
  }

  refresh() {
    // Periodic refresh logic
  }
}
```

## Event Listener Cleanup

```javascript
export default class extends Controller {
  connect() {
    this.handleResize = this.handleResize.bind(this)
    window.addEventListener("resize", this.handleResize)
  }

  disconnect() {
    window.removeEventListener("resize", this.handleResize)
  }

  handleResize(event) {
    // Handle window resize
  }
}
```

## Observer Cleanup

```javascript
export default class extends Controller {
  connect() {
    this.observer = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.load()
        }
      })
    })
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer.disconnect()
  }

  load() {
    // Load content when visible
  }
}
```

## AbortController for Fetch

```javascript
export default class extends Controller {
  connect() {
    this.abortController = new AbortController()
    this.load()
  }

  disconnect() {
    this.abortController.abort()
  }

  async load() {
    try {
      const response = await fetch(this.urlValue, {
        signal: this.abortController.signal
      })
      // Handle response
    } catch (error) {
      if (error.name !== "AbortError") {
        console.error(error)
      }
    }
  }
}
```

## Why Cleanup Matters

Without cleanup:
- Memory leaks accumulate
- Timers fire on removed elements
- Event handlers trigger errors
- Performance degrades over time

With Turbo, elements are frequently added/removed from the DOM, making cleanup essential.

## Testing Cleanup

```javascript
// Verify no lingering timers or listeners
test("cleans up on disconnect", () => {
  const controller = new MyController()
  controller.connect()

  const timerSpy = jest.spyOn(window, "clearInterval")
  controller.disconnect()

  expect(timerSpy).toHaveBeenCalled()
})
```
