# Account Slug Middleware

Rack middleware that extracts the account ID from URL paths.

## How It Works

1. Intercepts incoming requests
2. Extracts account ID from URL path (e.g., `/12345678/boards/1`)
3. Moves the account prefix from `PATH_INFO` to `SCRIPT_NAME`
4. Rails sees the remaining path and generates URLs with the prefix automatically

## Implementation

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

## Registration

```ruby
# config/application.rb
module YourApp
  class Application < Rails::Application
    config.middleware.insert_before 0, AccountSlug::Extractor
  end
end
```

## URL Generation

Because `SCRIPT_NAME` is set, Rails automatically prefixes all generated URLs:

```ruby
# With account 12345678 in context:
boards_path          # => "/12345678/boards"
board_path(@board)   # => "/12345678/boards/1"
```

## Custom Environment Key

The middleware stores the account ID in a custom env key:

```ruby
# Access in controller
request.env["fizzy.account_id"]

# Or use a before_action
def set_current_account
  if account_id = request.env["fizzy.account_id"]
    Current.account = Account.find_by!(external_account_id: account_id)
  end
end
```

## Pattern Matching

Customize the regex for your account ID format:

```ruby
# 7+ digit numbers
path =~ %r{^/(\d{7,})}

# UUIDs
path =~ %r{^/([a-f0-9-]{36})}

# Slugs
path =~ %r{^/([a-z0-9-]+)}
```
