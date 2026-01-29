#!/bin/bash
# PreToolUse hook: Enforce binstub usage for gem commands
# Intercepts Bash tool calls and suggests binstubs when available

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

# Common gems that should use binstubs
BINSTUB_GEMS="rspec rubocop rake rails erb_lint standardrb srb"

# Function to suggest binstub usage
suggest_binstub() {
  local gem_name="$1"
  local original_cmd="$2"
  local suggested_cmd="$3"

  cat >&2 << EOF
BLOCKED: Use binstub instead of $original_cmd

A binstub exists at bin/$gem_name. Use it instead:

  $suggested_cmd

Why: Binstubs ensure the correct gem version from Gemfile.lock is used.
EOF
  exit 2
}

# Pattern 1: bundle exec <gem> [args]
if [[ "$command" =~ ^bundle[[:space:]]+exec[[:space:]]+([a-zA-Z0-9_-]+)(.*)?$ ]]; then
  gem_name="${BASH_REMATCH[1]}"
  remaining_args="${BASH_REMATCH[2]}"

  if [[ -x "bin/$gem_name" ]]; then
    suggested="bin/$gem_name$remaining_args"
    suggest_binstub "$gem_name" "bundle exec $gem_name" "$suggested"
  fi
fi

# Pattern 2: Bare gem commands (rspec, rubocop, rake, etc.) without bin/ prefix
for gem in $BINSTUB_GEMS; do
  # Match: gem [args] but not bin/gem
  if [[ "$command" =~ ^${gem}([[:space:]]|$) ]] && [[ ! "$command" =~ ^bin/ ]]; then
    if [[ -x "bin/$gem" ]]; then
      # Extract args after the gem name
      args="${command#$gem}"
      suggested="bin/$gem$args"
      suggest_binstub "$gem" "$gem" "$suggested"
    fi
  fi
done

exit 0
