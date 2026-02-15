# frozen_string_literal: true

# Rack middleware template for URL path-based multi-tenancy
# Extracts account ID from URL path prefix and moves it to SCRIPT_NAME
#
# Register in config/application.rb:
#   config.middleware.insert_before 0, AccountSlug::Extractor

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
        env["app.account_id"] = account_id
      end

      @app.call(env)
    end

    private

    def extract_account_id(path)
      # Match account ID pattern (customize regex as needed)
      if path =~ %r{^/(\d{7,})}
        $1
      end
    end
  end
end
