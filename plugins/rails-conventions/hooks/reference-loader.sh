#!/bin/bash
# UserPromptSubmit hook: Load relevant API reference files based on keywords in user prompt
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
# ViewComponent Reference Detection
# ============================================

# Slots API - renders_one, renders_many, slot patterns
if echo "$prompt_lower" | grep -qE 'renders_one|renders_many|slot|polymorphic|with_header|with_footer|with_item'; then
  ref_file="$refs_base/rails-viewcomponent/references/slots.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Testing API - render_inline, assert_selector, test cases
if echo "$prompt_lower" | grep -qE 'render_inline|assert_selector|viewcomponent::testcase|component test|render_preview|testing component'; then
  ref_file="$refs_base/rails-viewcomponent/references/testing.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Previews API - Preview class, preview methods
if echo "$prompt_lower" | grep -qE 'preview|viewcomponent::preview|rails/view_components|lookbook'; then
  ref_file="$refs_base/rails-viewcomponent/references/previews.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Collections API - with_collection, counters, iteration
if echo "$prompt_lower" | grep -qE 'with_collection|_counter|_iteration|collection_parameter|collection_iteration'; then
  ref_file="$refs_base/rails-viewcomponent/references/collections.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Lifecycle API - before_render, around_render hooks
if echo "$prompt_lower" | grep -qE 'before_render|around_render|after_initialize|lifecycle|render\?'; then
  ref_file="$refs_base/rails-viewcomponent/references/lifecycle.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Templates API - inline templates, variants
if echo "$prompt_lower" | grep -qE 'erb_template|call method|inline template|template variant|sidecar'; then
  ref_file="$refs_base/rails-viewcomponent/references/templates.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Translations/i18n
if echo "$prompt_lower" | grep -qE 'i18n|translation|locale|t\(|translate'; then
  ref_file="$refs_base/rails-viewcomponent/references/translations.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Helpers
if echo "$prompt_lower" | grep -qE 'helpers\.|helper method|view context|content_tag'; then
  ref_file="$refs_base/rails-viewcomponent/references/helpers.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Hotwire/Turbo Reference Detection
# ============================================

# Turbo Streams - turbo_stream, broadcasts, DOM operations
if echo "$prompt_lower" | grep -qE 'turbo.stream|turbo_stream|broadcasts_to|broadcast_append|broadcast_replace|broadcast_remove|turbo_stream_from'; then
  ref_file="$refs_base/rails-hotwire/references/turbo.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Turbo Frames - turbo-frame, lazy loading
if echo "$prompt_lower" | grep -qE 'turbo.frame|turbo-frame|data-turbo-frame|lazy loading frame'; then
  ref_file="$refs_base/rails-hotwire/references/turbo.md"
  if [[ -f "$ref_file" ]] && [[ "$load_refs" != *"Turbo API Reference"* ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Turbo Drive
if echo "$prompt_lower" | grep -qE 'turbo.drive|data-turbo="false"|turbo-cache-control|turbo-progress-bar'; then
  ref_file="$refs_base/rails-hotwire/references/turbo.md"
  if [[ -f "$ref_file" ]] && [[ "$load_refs" != *"Turbo API Reference"* ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Stimulus Reference Detection
# ============================================

# Stimulus controllers, targets, values, actions
if echo "$prompt_lower" | grep -qE 'stimulus|data-controller|data-action|static targets|static values|connect\(\)|disconnect\(\)|controller\.js'; then
  ref_file="$refs_base/rails-hotwire/references/stimulus.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Stimulus outlets
if echo "$prompt_lower" | grep -qE 'static outlets|outlet|outletconnected'; then
  ref_file="$refs_base/rails-hotwire/references/stimulus.md"
  if [[ -f "$ref_file" ]] && [[ "$load_refs" != *"Stimulus API Reference"* ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Stimulus classes
if echo "$prompt_lower" | grep -qE 'static classes|hasactiveclass|activeclass'; then
  ref_file="$refs_base/rails-hotwire/references/stimulus.md"
  if [[ -f "$ref_file" ]] && [[ "$load_refs" != *"Stimulus API Reference"* ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Output loaded references as context (stdout with exit 0 = injected context)
if [[ -n "$load_refs" ]]; then
  echo "# Relevant API References (auto-loaded based on your question)"
  echo ""
  echo "$load_refs"
fi

exit 0
