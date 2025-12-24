# ruby-binstubs

Ensures Claude Code uses binstubs (`bin/*`) instead of `bundle exec` in Ruby projects.

## Why Binstubs?

Binstubs are wrapper scripts in the `bin/` directory that load the exact gem versions from your `Gemfile.lock`. They're faster and more reliable than `bundle exec`.

## What This Plugin Does

When working in a Ruby project, Claude will check for binstubs before running gem commands and use `bin/<command>` instead of `bundle exec <command>`.

## More Information

- [Bundler: bundle binstubs](https://bundler.io/man/bundle-binstubs.1.html)
