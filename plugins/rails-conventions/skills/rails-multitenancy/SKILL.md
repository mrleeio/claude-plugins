---
name: rails-multitenancy
description: Use when implementing URL path-based multi-tenancy. Covers tenant middleware, scoping, and request isolation patterns.
---

# URL Path-Based Multi-Tenancy

Implement multi-tenancy using URL path prefixes (e.g., `/12345678/boards/1`) instead of subdomains or separate databases. This approach simplifies local development, testing, and deployment.

## Quick Reference

| Do | Don't |
|----|-------|
| Use URL path prefix (`/{account_id}/...`) | Use subdomains for tenant isolation |
| Extract account ID in Rack middleware | Parse account from URL in controllers |
| Move prefix from `PATH_INFO` to `SCRIPT_NAME` | Manually prepend prefix to generated URLs |
| Set `Current.account` in `before_action` | Pass account through every method |
| Scope all queries through `Current.account` | Allow unscoped queries on tenant data |
| Add `account_id` foreign keys with constraints | Rely solely on application-level scoping |
| Set `script_name` in test setup | Skip tenant context in tests |

## Architecture Overview

- URLs are prefixed with account identifier: `/{account_id}/resources/...`
- Rack middleware extracts the account ID from the path
- The account prefix is moved from `PATH_INFO` to `SCRIPT_NAME`
- Rails thinks it's "mounted" at that path, so all generated URLs include the prefix automatically

## Middleware Implementation

```ruby
# config/initializers/tenanting/account_slug.rb
module AccountSlug
  class Extractor
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      if account_id = extract_account_id(request.path_info)
        # Move account prefix from PATH_INFO to SCRIPT_NAME
        env["SCRIPT_NAME"] = "/#{account_id}"
        env["PATH_INFO"] = request.path_info.sub(%r{^/#{account_id}}, "")
        env["PATH_INFO"] = "/" if env["PATH_INFO"].empty?

        # Store account for later use
        env["fizzy.account_id"] = account_id
      end

      @app.call(env)
    end

    private
      def extract_account_id(path)
        # Match account ID pattern (e.g., 7+ digit number)
        if path =~ %r{^/(\d{7,})}
          $1
        end
      end
  end
end
```

## Register Middleware

```ruby
# config/application.rb
module YourApp
  class Application < Rails::Application
    config.middleware.insert_before 0, AccountSlug::Extractor
  end
end
```

## Setting Current Account

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_current_account

  private
    def set_current_account
      if account_id = request.env["fizzy.account_id"]
        Current.account = Account.find_by!(external_account_id: account_id)
      end
    end
end
```

## Route Configuration

Routes work normally - the middleware handles the prefix:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  resources :boards do
    resources :cards
  end
end
```

Generated URLs automatically include the account prefix because `SCRIPT_NAME` is set.

## Model Scoping

All tenant-scoped models should include `account_id`:

```ruby
class Card < ApplicationRecord
  belongs_to :account

  # Ensure all queries are scoped to current account
  default_scope { where(account: Current.account) if Current.account }
end
```

Or use explicit scoping:

```ruby
class CardsController < ApplicationController
  def index
    @cards = Current.account.cards
  end
end
```

## Test Setup

### Integration Tests

```ruby
# test/test_helper.rb
class ActionDispatch::IntegrationTest
  setup do
    # Set the script_name to simulate the account prefix
    integration_session.default_url_options[:script_name] = "/#{accounts(:default).external_account_id}"
  end
end
```

### System Tests

```ruby
class ActionDispatch::SystemTestCase
  setup do
    self.default_url_options[:script_name] = "/#{accounts(:default).external_account_id}"
  end
end
```

### Untenanted Requests

For routes that don't require tenant context (like login):

```ruby
module SessionTestHelper
  def untenanted(&block)
    original_script_name = integration_session.default_url_options[:script_name]
    integration_session.default_url_options[:script_name] = ""
    yield
  ensure
    integration_session.default_url_options[:script_name] = original_script_name
  end
end
```

Usage:

```ruby
def test_login
  untenanted do
    post session_path, params: { email: "user@example.com" }
  end
end
```

## Common Mistakes

1. **Parsing account in controllers**: Extract the account ID in Rack middleware, not in controllers. The middleware sets `SCRIPT_NAME` which makes URL generation automatic
2. **Manually prefixing URLs**: If you find yourself prepending account IDs to URLs, the middleware isn't set up correctly. The `SCRIPT_NAME` mechanism handles this
3. **Missing `account_id` foreign keys**: Application-level scoping can be bypassed. Always add database-level `account_id` foreign key constraints
4. **Unscoped queries**: Every query on tenant data must be scoped through `Current.account`. An unscoped query leaks data across tenants
5. **Forgetting `script_name` in tests**: Integration and system tests need `script_name` set in setup to generate correct URLs
6. **Not handling untenanted routes**: Login, signup, and public pages don't have an account prefix. The middleware must gracefully handle paths without an account ID
7. **Not preserving context in jobs**: Background jobs run outside the request lifecycle. Serialize `Current.account` and restore it in the job
8. **Using subdomains**: Subdomains require DNS configuration, complicate local development, and make testing harder. URL path prefixes are simpler

## Key Benefits

1. **Simple local development**: No subdomain configuration needed
2. **Easy testing**: Just set `script_name` in test setup
3. **Single database**: All tenants share one database with `account_id` column
4. **Automatic URL generation**: Rails handles prefixed URLs automatically via `SCRIPT_NAME`
5. **Flexible routing**: Standard Rails routes work unchanged

## Security Considerations

- Always validate account access in controllers
- Use `Current.account` scoping to prevent cross-tenant data access
- Consider adding `account_id` foreign keys with database constraints

## See Also

- [Middleware](references/middleware.md) - AccountSlug extractor implementation
- [Model Scoping](references/model-scoping.md) - Query scoping patterns
- [Test Setup](references/test-setup.md) - Integration and system test configuration
