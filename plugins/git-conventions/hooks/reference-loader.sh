#!/bin/bash
# UserPromptSubmit hook: Load Conventional Commits specification when relevant keywords detected
# Injects the spec as context when user asks about commits

# Read JSON input from stdin
input=$(cat)

prompt=$(echo "$input" | jq -r '.user_prompt // empty')
plugin_root="${CLAUDE_PLUGIN_ROOT}"

# Exit if no prompt
if [[ -z "$prompt" ]]; then
  exit 0
fi

# Convert prompt to lowercase for case-insensitive matching
prompt_lower=$(echo "$prompt" | tr '[:upper:]' '[:lower:]')

load_spec=""

# Detect commit-related keywords
# - Direct mentions of conventional commits
# - Commit message questions
# - Git commit actions
# - Asking about commit format/types
if echo "$prompt_lower" | grep -qE 'conventional commit|commit message|commit format|commit type|feat:|fix:|docs:|style:|refactor:|perf:|test:|build:|ci:|chore:|revert:|breaking change|semver|semantic version'; then
  spec_file="$plugin_root/skills/conventional-commits/references/specification.md"
  if [[ -f "$spec_file" ]]; then
    load_spec=$(cat "$spec_file")
  fi
fi

# Also load for generic commit questions that might benefit from the spec
if [[ -z "$load_spec" ]] && echo "$prompt_lower" | grep -qE 'how.*(should|do).*(i|we).*commit|what.*commit.*type|write.*commit|format.*commit|good commit'; then
  spec_file="$plugin_root/skills/conventional-commits/references/specification.md"
  if [[ -f "$spec_file" ]]; then
    load_spec=$(cat "$spec_file")
  fi
fi

# Output loaded reference as context
if [[ -n "$load_spec" ]]; then
  echo "# Conventional Commits Reference (auto-loaded)"
  echo ""
  echo "$load_spec"
fi

exit 0
