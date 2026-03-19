#!/bin/bash
# PATTERN: Deny-Until-Skill-Loaded
# This hook blocks edits to VRA report and assessment files until the appropriate
# skill has been loaded in the current session. This ensures Claude reads
# the methodology before making changes to assessment deliverables.
#
# Flow:
#   1. Intercept Edit/Write/MultiEdit tool calls
#   2. Check if the file matches a VRA assessment pattern
#   3. Check if the required skill was loaded (grep transcript)
#   4. If not loaded: exit 2 (block) with instructions to load skill
#   5. If loaded: exit 0 (allow)

# Fail-safe: ANY unhandled error exits 0 (allow)
trap 'exit 0' ERR

# Check if jq is available
if ! command -v jq &>/dev/null; then
  exit 0
fi

# Read JSON input from stdin
input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name')
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')
skill_name=$(echo "$input" | jq -r '.tool_input.skill // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

# Always allow Skill tool
if [[ "$tool_name" == "Skill" && -n "$skill_name" ]]; then
  exit 0
fi

# Exit early if no file_path (not a file operation)
if [[ -z "$file_path" ]]; then
  exit 0
fi

# Function to check if skill was loaded in transcript
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
  exit 0
}

# ============================================
# VRA Report Files
# ============================================

# Final VRA report files
if [[ "$file_path" == */report.md ]] || [[ "$file_path" == *vra-report* ]] || [[ "$file_path" == *vendor-risk-assessment-report* ]]; then
  if skill_loaded "vendor-risk-assessment:vra-report-writing"; then
    allow_with_skill "vendor-risk-assessment:vra-report-writing"
  else
    deny_without_skill "vendor-risk-assessment:vra-report-writing" "VRA report"
  fi
  exit 0
fi

# ============================================
# Risk Scoring Files
# ============================================

# Scoring worksheets
if [[ "$file_path" == */scoring.md ]] || [[ "$file_path" == *risk-scoring* ]] || [[ "$file_path" == *risk-matrix* ]]; then
  if skill_loaded "vendor-risk-assessment:risk-scoring"; then
    allow_with_skill "vendor-risk-assessment:risk-scoring"
  else
    deny_without_skill "vendor-risk-assessment:risk-scoring" "risk scoring"
  fi
  exit 0
fi

# ============================================
# Remediation Plan Files
# ============================================

# Remediation plans
if [[ "$file_path" == */remediation.md ]] || [[ "$file_path" == *remediation-plan* ]]; then
  if skill_loaded "vendor-risk-assessment:remediation-planning"; then
    allow_with_skill "vendor-risk-assessment:remediation-planning"
  else
    deny_without_skill "vendor-risk-assessment:remediation-planning" "remediation plan"
  fi
  exit 0
fi

# ============================================
# Research Dossier Files
# ============================================

# Research dossiers
if [[ "$file_path" == */research-dossier.md ]] || [[ "$file_path" == *research-*.md ]]; then
  if skill_loaded "vendor-risk-assessment:vendor-research"; then
    allow_with_skill "vendor-risk-assessment:vendor-research"
  else
    deny_without_skill "vendor-risk-assessment:vendor-research" "research dossier"
  fi
  exit 0
fi

# ============================================
# Questionnaire Files
# ============================================

# Vendor questionnaires
if [[ "$file_path" == */questionnaire.md ]] || [[ "$file_path" == *vendor-questionnaire* ]]; then
  if skill_loaded "vendor-risk-assessment:vendor-research"; then
    allow_with_skill "vendor-risk-assessment:vendor-research"
  else
    deny_without_skill "vendor-risk-assessment:vendor-research" "vendor questionnaire"
  fi
  exit 0
fi

# For other files, proceed normally
exit 0
