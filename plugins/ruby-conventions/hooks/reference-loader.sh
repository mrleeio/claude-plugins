#!/bin/bash
# UserPromptSubmit hook: Load relevant Ruby reference files based on keywords in user prompt
# This reduces context bloat by loading only the references needed for the current question

# Read JSON input from stdin
input=$(cat)

prompt=$(echo "$input" | jq -r '.user_prompt // empty')
plugin_root="${CLAUDE_PLUGIN_ROOT}"
refs_base="$plugin_root/skills"

# Exit if no prompt
if [[ -z "$prompt" ]]; then
  exit 0
fi

# Convert prompt to lowercase for case-insensitive matching
prompt_lower=$(echo "$prompt" | tr '[:upper:]' '[:lower:]')

load_refs=""

# ============================================
# RSpec Reference Detection
# ============================================

if echo "$prompt_lower" | grep -qE 'rspec|describe.*do|context.*do|it.*do|let\(|subject\(|shared_examples|shared_context|before.*do|expect\(|allow\(|receive\('; then
  ref_file="$refs_base/ruby-testing/references/rspec.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Minitest Reference Detection
# ============================================

if echo "$prompt_lower" | grep -qE 'minitest|assert_equal|assert_nil|assert_raises|assert_includes|assert_difference|activesupport::testcase|test.*do'; then
  ref_file="$refs_base/ruby-testing/references/minitest.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Class Design Patterns Reference Detection
# ============================================

if echo "$prompt_lower" | grep -qE 'value object|service object|query object|form object|design pattern|solid|composition|builder pattern|decorator'; then
  ref_file="$refs_base/ruby-class-design/references/design-patterns.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Class Structure Reference Detection
# ============================================

if echo "$prompt_lower" | grep -qE 'class structure|class order|attr_reader|attr_accessor|belongs_to|has_many|validates|before_save|after_create'; then
  ref_file="$refs_base/ruby-style-guide/references/class-structure.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Gem/Bundler Reference Detection
# ============================================

if echo "$prompt_lower" | grep -qE 'gemfile|gemspec|bundle|gem version|version constraint|pessimistic|bundler'; then
  ref_file="$refs_base/ruby-gem-conventions/references/version-constraints.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

if echo "$prompt_lower" | grep -qE 'bundle install|bundle update|bundle exec|bundle add|bundle outdated|bundle audit|bundle config'; then
  ref_file="$refs_base/ruby-gem-conventions/references/bundle-commands.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

if echo "$prompt_lower" | grep -qE 'gemspec|spec\.name|spec\.version|add_dependency|add_development_dependency'; then
  ref_file="$refs_base/ruby-gem-conventions/references/gemspec-guide.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Output loaded references as context (stdout with exit 0 = injected context)
if [[ -n "$load_refs" ]]; then
  echo "# Relevant Ruby API References (auto-loaded based on your question)"
  echo ""
  echo "$load_refs"
fi

exit 0
