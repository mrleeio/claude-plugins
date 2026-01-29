#!/bin/bash
# PreToolUse hook: Validate git commit messages follow Conventional Commits format
# Blocks commits with invalid message format and provides guidance

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

# Only check git commit commands
if ! echo "$command" | grep -qE '^git\s+commit'; then
  exit 0
fi

# Skip if it's just git commit without -m (interactive or amend without message change)
if ! echo "$command" | grep -qE '\s+-m\s|\s+--message'; then
  exit 0
fi

# Extract commit message from -m "message" or -m 'message' or --message="message"
# Handle HEREDOC style: -m "$(cat <<'EOF' ... EOF)"
message=""

# Pattern 1: HEREDOC style -m "$(cat <<'EOF' or <<EOF
if echo "$command" | grep -qE '\-m\s+"\$\(cat\s+<<'; then
  # Extract content between first line after << and EOF
  message=$(echo "$command" | sed -n "/<<'*EOF'*/,/EOF/p" | sed '1d;$d')
fi

# Pattern 2: Simple -m "message" or -m 'message'
if [[ -z "$message" ]]; then
  # Try double quotes first
  message=$(echo "$command" | sed -n 's/.*-m[[:space:]]*"\([^"]*\)".*/\1/p')

  # Try single quotes if no match
  if [[ -z "$message" ]]; then
    message=$(echo "$command" | sed -n "s/.*-m[[:space:]]*'\\([^']*\\)'.*/\\1/p")
  fi

  # Try --message= format
  if [[ -z "$message" ]]; then
    message=$(echo "$command" | sed -n 's/.*--message="\([^"]*\)".*/\1/p')
  fi
fi

# If we couldn't extract the message, allow the commit (don't block on parse failure)
if [[ -z "$message" ]]; then
  exit 0
fi

# Get just the first line (subject) for validation
subject=$(echo "$message" | head -n1)

# Valid conventional commit types
VALID_TYPES="feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert"

# Conventional Commits regex pattern:
# type(optional-scope)!?: description
# - type: required, one of the valid types
# - scope: optional, in parentheses
# - !: optional, indicates breaking change
# - :: required separator
# - description: required, after colon and space
PATTERN="^($VALID_TYPES)(\([a-zA-Z0-9_-]+\))?\!?:[[:space:]].+"

if ! echo "$subject" | grep -qE "$PATTERN"; then
  cat >&2 << EOF
BLOCKED: Commit message does not follow Conventional Commits format

Your message: "$subject"

Expected format: type(scope): description

Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

Examples:
  feat: Add user authentication
  fix(api): Handle null response
  docs: Update README
  refactor!: Drop Node 14 support

Rules:
  - Type is required (feat, fix, etc.)
  - Scope is optional, in parentheses
  - Add ! before : for breaking changes
  - Colon and space after type/scope
  - Description is required

See the full specification: skills/conventional-commits/references/specification.md
EOF
  exit 2
fi

# Check for AI attribution (which should be avoided)
if echo "$message" | grep -qiE 'co-authored-by:.*claude|generated.*claude|claude.*code|anthropic'; then
  cat >&2 << EOF
BLOCKED: Commit message contains AI attribution

Conventional commits in this project should NOT include:
  - Co-Authored-By tags for AI/Claude
  - "Generated with Claude Code" or similar
  - References to AI assistance

Please remove AI attribution from the commit message.
EOF
  exit 2
fi

exit 0
