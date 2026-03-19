#!/bin/bash
# UserPromptSubmit hook: Load relevant VRA reference files based on keywords in user prompt
# This reduces context bloat by loading only the references needed for the current question

# Fail-safe: ANY unhandled error exits 0 (allow)
trap 'exit 0' ERR

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
# Vendor Research Reference Detection
# ============================================

# Assessment domains - vendor research, security posture, due diligence
if echo "$prompt_lower" | grep -qE 'research vendor|vendor security|assess vendor|vendor due diligence|vendor investigation|security posture|osint'; then
  ref_file="$refs_base/vendor-research/references/assessment-domains.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# OSINT sources
if echo "$prompt_lower" | grep -qE 'osint|open source intelligence|trust page|security page|breach database|certification registry'; then
  ref_file="$refs_base/vendor-research/references/osint-sources.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# SaaS vs hosted assessment
if echo "$prompt_lower" | grep -qE 'saas|self-hosted|on-prem|deployment model|shared responsibility|tenant isolation'; then
  ref_file="$refs_base/vendor-research/references/saas-vs-hosted.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Source Verification Reference Detection
# ============================================

# Evidence verification
if echo "$prompt_lower" | grep -qE 'verify evidence|check certification|validate claim|evidence review|source verification|evidence hierarchy'; then
  ref_file="$refs_base/source-verification/references/evidence-types.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
  ref_file="$refs_base/source-verification/references/verification-methods.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# SOC 2 specific
if echo "$prompt_lower" | grep -qE 'soc 2|soc2|type ii|type 2|audit report|trust service|cuec'; then
  ref_file="$refs_base/source-verification/references/evidence-types.md"
  if [[ -f "$ref_file" ]] && [[ "$load_refs" != *"Evidence Type Reference"* ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Risk Scoring Reference Detection
# ============================================

# Risk scoring, matrix, FAIR
if echo "$prompt_lower" | grep -qE 'risk score|risk matrix|risk rating|calculate risk|risk quantification|likelihood.*impact|inherent.*residual'; then
  ref_file="$refs_base/risk-scoring/references/scoring-matrix.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# FAIR methodology
if echo "$prompt_lower" | grep -qE 'fair analysis|fair methodology|loss event frequency|threat event frequency|quantitative risk|annualized loss'; then
  ref_file="$refs_base/risk-scoring/references/fair-methodology.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Weighted composite
if echo "$prompt_lower" | grep -qE 'weighted composite|domain weight|composite score|weighted score'; then
  ref_file="$refs_base/risk-scoring/references/weighted-composite.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Report Writing Reference Detection
# ============================================

# VRA report writing
if echo "$prompt_lower" | grep -qE 'write report|vra report|assessment report|vendor report|risk report|report structure|report template'; then
  ref_file="$refs_base/vra-report-writing/references/report-structure.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Writing standards
if echo "$prompt_lower" | grep -qE 'writing standard|report format|citation|tone|professional writing'; then
  ref_file="$refs_base/vra-report-writing/references/writing-standards.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Vendor Tiering Reference Detection
# ============================================

# Vendor tiering and classification
if echo "$prompt_lower" | grep -qE 'vendor tier|classify vendor|vendor classification|critical vendor|high tier|medium tier|low tier'; then
  ref_file="$refs_base/vendor-tiering/references/tier-definitions.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Data classification
if echo "$prompt_lower" | grep -qE 'data classification|data sensitivity|restricted data|confidential data|data handling|data type'; then
  ref_file="$refs_base/vendor-tiering/references/data-classification.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Vendor lifecycle
if echo "$prompt_lower" | grep -qE 'vendor lifecycle|onboarding|offboarding|exit strategy|vendor management|pre-engagement'; then
  ref_file="$refs_base/vendor-tiering/references/vendor-lifecycle.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Remediation Reference Detection
# ============================================

# Remediation planning
if echo "$prompt_lower" | grep -qE 'remediation|now.next.later|compensating control|conditional approval|remediation sla|severity sla'; then
  ref_file="$refs_base/remediation-planning/references/now-next-later.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Compensating controls
if echo "$prompt_lower" | grep -qE 'compensating control|interim control|mitigating control|control gap'; then
  ref_file="$refs_base/remediation-planning/references/compensating-controls.md"
  if [[ -f "$ref_file" ]] && [[ "$load_refs" != *"Compensating Controls"* ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Fourth-Party Risk Reference Detection
# ============================================

# Fourth-party, sub-processor, supply chain
if echo "$prompt_lower" | grep -qE 'fourth.party|sub.processor|subprocessor|supply chain risk|sbom|software bill'; then
  ref_file="$refs_base/fourth-party-risk/references/sub-processor-management.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Concentration risk
if echo "$prompt_lower" | grep -qE 'concentration risk|single point of failure|cloud provider dependency|shared fourth.party'; then
  ref_file="$refs_base/fourth-party-risk/references/concentration-risk.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Regulatory Mapping Reference Detection
# ============================================

# DORA and NIS2
if echo "$prompt_lower" | grep -qE 'dora|digital operational resilience|nis2|nis 2|network and information security'; then
  ref_file="$refs_base/regulatory-mapping/references/dora-nis2.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# SEC cyber rules
if echo "$prompt_lower" | grep -qE 'sec cyber|sec disclosure|8-k|10-k|materiality|sec rule'; then
  ref_file="$refs_base/regulatory-mapping/references/sec-cyber-rules.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# EU AI Act
if echo "$prompt_lower" | grep -qE 'eu ai act|ai act|ai risk classification|ai regulation|high.risk ai'; then
  ref_file="$refs_base/regulatory-mapping/references/eu-ai-act.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# ============================================
# Continuous Monitoring Reference Detection
# ============================================

# Continuous monitoring
if echo "$prompt_lower" | grep -qE 'continuous monitoring|vendor monitoring|ongoing monitoring|post.assessment|monitoring cadence'; then
  ref_file="$refs_base/continuous-monitoring/references/monitoring-tiers.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Security ratings
if echo "$prompt_lower" | grep -qE 'security rating|bitsight|securityscorecard|riskrecon|upguard|panorays|vendor score'; then
  ref_file="$refs_base/continuous-monitoring/references/security-ratings.md"
  if [[ -f "$ref_file" ]]; then
    load_refs+="$(cat "$ref_file")"
    load_refs+=$'\n\n---\n\n'
  fi
fi

# Output loaded references as context (stdout with exit 0 = injected context)
if [[ -n "$load_refs" ]]; then
  echo "# Relevant VRA References (auto-loaded based on your question)"
  echo ""
  echo "$load_refs"
fi

exit 0
