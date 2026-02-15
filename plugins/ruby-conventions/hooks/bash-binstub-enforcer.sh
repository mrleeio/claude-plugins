#!/bin/bash
# PATTERN: Dynamic Binstub Enforcement
# This hook blocks gem commands when a binstub exists in bin/,
# dynamically checking for any binstub rather than using a hard-coded list.
#
# Flow:
#   1. Intercept Bash tool calls
#   2. Check if command is `bundle exec <gem>` with a binstub → block, suggest binstub
#   3. Check if command is a bare `<gem>` with a binstub → block, suggest binstub
#   4. If no binstub exists → allow (bundle exec or bare command is fine)

# Fail-safe: ANY unhandled error exits 0 (allow)
trap 'exit 0' ERR

# Check if jq is available
if ! command -v jq &>/dev/null; then
  exit 0
fi

# Read JSON input from stdin
input=$(cat)

# Handle empty input gracefully
if [[ -z "$input" ]]; then
  exit 0
fi

# Parse JSON with error checking
tool_name=$(echo "$input" | jq -r '.tool_name' 2>/dev/null)
if [[ $? -ne 0 || -z "$tool_name" || "$tool_name" == "null" ]]; then
  exit 0
fi

command=$(echo "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Only process Bash tool
if [[ "$tool_name" != "Bash" ]]; then
  exit 0
fi

# Exit early if no command
if [[ -z "$command" ]]; then
  exit 0
fi

# Don't process if already using bin/ prefix
if [[ "$command" =~ ^bin/ ]]; then
  exit 0
fi

# Pattern 1: bundle exec <gem> [args]
if [[ "$command" =~ ^bundle[[:space:]]+exec[[:space:]]+([a-zA-Z0-9_-]+)(.*)?$ ]]; then
  gem_name="${BASH_REMATCH[1]}"
  remaining_args="${BASH_REMATCH[2]}"

  if [[ -x "bin/$gem_name" ]]; then
    cat >&2 << EOF
BLOCKED: Use binstub instead of bundle exec $gem_name

A binstub exists at bin/$gem_name. Use it instead:

  bin/$gem_name$remaining_args

Why: Binstubs ensure the correct gem version and are faster.
EOF
    exit 2
  fi
  # No binstub exists — bundle exec is fine, allow it
  exit 0
fi

# Pattern 2: Bare gem command without bin/ prefix
# Dynamically check if a binstub exists for the first word of the command
first_word="${command%% *}"
if [[ -x "bin/$first_word" ]]; then
  args="${command#$first_word}"
  cat >&2 << EOF
BLOCKED: Use binstub instead of bare command '$first_word'

A binstub exists at bin/$first_word. Use it instead:

  bin/$first_word$args

Why: Binstubs ensure the correct gem version from Gemfile.lock.
EOF
  exit 2
fi

# No binstub for this command — allow it through
exit 0
