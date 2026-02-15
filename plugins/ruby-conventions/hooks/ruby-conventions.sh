#!/bin/bash
# PATTERN: Deny-Until-Skill-Loaded
# This hook blocks file edits until the appropriate Ruby convention skill
# has been loaded in the current session. This ensures Claude reads
# the conventions before making changes.
#
# Flow:
#   1. Intercept Edit/Write/MultiEdit tool calls
#   2. Check if the file is a Ruby-related file (not Rails — those are handled separately)
#   3. Check if the required skill was loaded (grep transcript)
#   4. If not loaded: exit 2 (block) with instructions to load skill
#   5. If loaded: exit 0 (allow)

# Fail-safe: ANY unhandled error exits 0 (allow)
trap 'exit 0' ERR

# Check if jq is available
if ! command -v jq &>/dev/null; then
  exit 0
fi

LOG_FILE="/tmp/claude-ruby-conventions.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

log() {
  echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# Read JSON input from stdin
input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name')
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')
skill_name=$(echo "$input" | jq -r '.tool_input.skill // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

log "HOOK START: tool=$tool_name path=$file_path skill=$skill_name"

# Log skill usage - always allow Skill tool
if [[ "$tool_name" == "Skill" && -n "$skill_name" ]]; then
  log "BRANCH: Skill tool -> loaded: $skill_name"
  exit 0
fi

# Exit early if no file_path (not a file operation)
if [[ -z "$file_path" ]]; then
  log "BRANCH: No file_path -> exit early"
  exit 0
fi

# Only process Ruby-related files
if [[ "$file_path" != *.rb ]] && \
   [[ "$file_path" != */Gemfile ]] && \
   [[ "$file_path" != */Gemfile.lock ]] && \
   [[ "$file_path" != *.gemspec ]]; then
  log "BRANCH: Not a Ruby file -> exit early"
  exit 0
fi

# Skip Rails files - they're handled by rails-conventions plugin
if [[ "$file_path" == */app/* ]] || \
   [[ "$file_path" == */config/* ]] || \
   [[ "$file_path" == */db/* ]] || \
   [[ "$file_path" == */lib/tasks/* ]]; then
  log "BRANCH: Rails file -> skipping (handled by rails-conventions)"
  exit 0
fi

# Function to check if skill was loaded in transcript
# Uses flexible whitespace matching to handle JSON serialization variations
skill_loaded() {
  local skill="$1"
  if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    if grep -qE "\"skill\"[[:space:]]*:[[:space:]]*\"$skill\"" "$transcript_path" 2>/dev/null; then
      return 0
    fi
  fi
  return 1
}

# Function to deny with message - uses exit code 2 to block
deny_without_skill() {
  local skill="$1"
  local file_type="$2"

  log "BRANCH: $file_type matched -> DENIED (skill $skill not loaded)"

  cat >&2 << EOF
BLOCKED: You must load the $skill skill before editing $file_type files.

STOP. Do not immediately retry your edit.
1. Load the skill: Skill(skill: "$skill")
2. Read the conventions carefully
3. Reconsider whether your planned edit follows them
4. Adjust your approach if needed, then edit
EOF
  exit 2
}

# Function to allow after skill loaded
allow_with_skill() {
  local skill="$1"
  local file_type="$2"

  log "BRANCH: $file_type matched -> ALLOWED (skill $skill already loaded)"
  exit 0
}

# Check if this is a Gemfile or gemspec
if [[ "$file_path" == */Gemfile ]] || \
   [[ "$file_path" == */Gemfile.lock ]] || \
   [[ "$file_path" == *.gemspec ]]; then
  if skill_loaded "ruby-conventions:ruby-gem-conventions"; then
    allow_with_skill "ruby-conventions:ruby-gem-conventions" "gem configuration"
  else
    deny_without_skill "ruby-conventions:ruby-gem-conventions" "gem configuration"
  fi
  exit 0
fi

# Check if this is an RSpec spec file
if [[ "$file_path" == */spec/*_spec.rb ]] || \
   [[ "$file_path" == */spec/spec_helper.rb ]] || \
   [[ "$file_path" == */spec/rails_helper.rb ]]; then
  if skill_loaded "ruby-conventions:ruby-testing"; then
    allow_with_skill "ruby-conventions:ruby-testing" "RSpec spec"
  else
    deny_without_skill "ruby-conventions:ruby-testing" "RSpec spec"
  fi
  exit 0
fi

# Check if this is a Minitest test file
if [[ "$file_path" == */test/*_test.rb ]] || \
   [[ "$file_path" == */test/test_helper.rb ]]; then
  if skill_loaded "ruby-conventions:ruby-testing"; then
    allow_with_skill "ruby-conventions:ruby-testing" "Minitest test"
  else
    deny_without_skill "ruby-conventions:ruby-testing" "Minitest test"
  fi
  exit 0
fi

# Check if this is a general Ruby file
if [[ "$file_path" == *.rb ]]; then
  if skill_loaded "ruby-conventions:ruby-style-guide"; then
    allow_with_skill "ruby-conventions:ruby-style-guide" "Ruby"
  else
    deny_without_skill "ruby-conventions:ruby-style-guide" "Ruby"
  fi
  exit 0
fi

# For other files, proceed normally
log "BRANCH: No pattern matched -> allowing without skill requirement"
exit 0
