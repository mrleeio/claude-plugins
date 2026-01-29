#!/bin/bash
# PreToolUse hook: Enforce binstub usage for gem commands
# Intercepts Bash tool calls and suggests binstubs when available

# Debug log (disable after debugging)
DEBUG_LOG="/tmp/claude-binstub-enforcer-debug.log"
debug() {
  echo "[$(date '+%H:%M:%S')] $1" >> "$DEBUG_LOG" 2>/dev/null
}

# Fail-safe: ANY unhandled error exits 0 (allow)
trap 'debug "TRAP: exiting 0 due to error"; exit 0' ERR

debug "=== HOOK START ==="

# Check if jq is available
if ! command -v jq &>/dev/null; then
  debug "ERROR: jq not found in PATH"
  exit 0
fi

# Read JSON input from stdin
input=$(cat)
debug "INPUT length: ${#input}"

# Handle empty input gracefully
if [[ -z "$input" ]]; then
  debug "INPUT: empty, exiting 0"
  exit 0
fi

# Parse JSON with error capture
tool_name=$(echo "$input" | jq -r '.tool_name' 2>&1)
jq_exit=$?
debug "jq tool_name exit=$jq_exit result='$tool_name'"

if [[ $jq_exit -ne 0 || -z "$tool_name" || "$tool_name" == "null" ]]; then
  debug "PARSE FAILED: tool_name, exiting 0"
  exit 0
fi

command=$(echo "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)
debug "command='${command:0:50}...'"

# Only process Bash tool
if [[ "$tool_name" != "Bash" ]]; then
  debug "NOT BASH: $tool_name, exiting 0"
  exit 0
fi

# Exit early if no command
if [[ -z "$command" ]]; then
  debug "NO COMMAND, exiting 0"
  exit 0
fi

# Common gems that should use binstubs
BINSTUB_GEMS="rspec rubocop rake rails erb_lint standardrb srb"

# Function to suggest binstub usage
suggest_binstub() {
  local gem_name="$1"
  local original_cmd="$2"
  local suggested_cmd="$3"

  debug "BLOCKED: $original_cmd -> $suggested_cmd"

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

  debug "PATTERN 1 MATCH: bundle exec $gem_name$remaining_args"

  if [[ -x "bin/$gem_name" ]]; then
    suggested="bin/$gem_name$remaining_args"
    suggest_binstub "$gem_name" "bundle exec $gem_name" "$suggested"
  fi
fi

# Pattern 2: Bare gem commands (rspec, rubocop, rake, etc.) without bin/ prefix
for gem in $BINSTUB_GEMS; do
  # Match: gem [args] but not bin/gem
  if [[ "$command" =~ ^${gem}([[:space:]]|$) ]] && [[ ! "$command" =~ ^bin/ ]]; then
    debug "PATTERN 2 MATCH: bare $gem command"

    if [[ -x "bin/$gem" ]]; then
      # Extract args after the gem name
      args="${command#$gem}"
      suggested="bin/$gem$args"
      suggest_binstub "$gem" "$gem" "$suggested"
    fi
  fi
done

debug "ALLOWED: No binstub enforcement needed"
exit 0
