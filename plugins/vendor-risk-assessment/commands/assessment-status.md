---
name: assessment-status
description: Check the progress of a vendor risk assessment — completed sections, evidence inventory, outstanding items
allowed-tools: Read, Glob, Grep, AskUserQuestion
---

# Assessment Status

Check the progress of a vendor risk assessment, identify completed and outstanding items, and highlight gaps.

## Context Gathering

Find all assessment workspaces:
- Use Glob to find `assessments/*/README.md` files
- If multiple assessments exist, ask the user which vendor to check
- If only one exists, use it automatically

## Task

Read the assessment workspace files and generate a comprehensive status report.

## Steps

### Step 1: Read Assessment Files

Read all available files in the assessment directory:
- `README.md` — Assessment overview and checklist
- `research-dossier.md` — Research findings
- `evidence/` — List evidence files collected
- `questionnaire.md` — Vendor questionnaire status
- `scoring.md` — Risk scoring status
- `report.md` — Report draft status
- `remediation.md` — Remediation plan status

### Step 2: Assess Completion

For each assessment phase, determine status:

| Phase | How to Check | Status |
|-------|-------------|--------|
| **Research** | `research-dossier.md` exists and has content per domain | ✅ Complete / 🔄 In Progress / ❌ Not Started |
| **Evidence Collection** | Files in `evidence/` directory | ✅ / 🔄 / ❌ |
| **Evidence Verification** | Verification notes in research dossier or scoring | ✅ / 🔄 / ❌ |
| **Domain Scoring** | `scoring.md` has scores for all 15 domains | ✅ / 🔄 / ❌ |
| **Report Draft** | `report.md` has content beyond template placeholders | ✅ / 🔄 / ❌ |
| **Report Review** | Review notes or approval markers | ✅ / 🔄 / ❌ |
| **Remediation Plan** | `remediation.md` has findings and SLAs | ✅ / 🔄 / ❌ |
| **Final Recommendation** | Report has non-placeholder recommendation | ✅ / 🔄 / ❌ |

### Step 3: Evidence Inventory

List all collected evidence and identify gaps:

```markdown
## Evidence Inventory

| Evidence Type | Status | File | Notes |
|--------------|:------:|------|-------|
| SOC 2 Type II | ✅/❌ | [filename] | [scope, period] |
| ISO 27001 | ✅/❌ | [filename] | [expiry, scope] |
| Pentest Report | ✅/❌ | [filename] | [date, scope] |
| DPA/BAA | ✅/❌ | [filename] | |
| Sub-processor List | ✅/❌ | [filename] | |
| SIG/CAIQ | ✅/❌ | [filename] | |
| Privacy Policy | ✅/❌ | [filename] | |
| Security Whitepaper | ✅/❌ | [filename] | |
```

### Step 4: Regulatory Coverage Check

Based on applicable regulations from the README:
- Check which regulatory requirements have been mapped
- Identify coverage gaps

### Step 5: Domain Coverage Check

For each of the 15 assessment domains:
- Has research been conducted?
- Has evidence been collected?
- Has scoring been completed?
- Are there outstanding questions for the vendor?

### Step 6: Generate Status Report

```markdown
# Assessment Status: [Vendor Name]

**Tier:** [Tier]
**Started:** [Date]
**Target Completion:** [Date]

## Overall Progress

[==========----------] 50% Complete

| Phase | Status | Details |
|-------|:------:|---------|
| Research | ✅ | 15/15 domains researched |
| Evidence | 🔄 | 4/7 key documents collected |
| Scoring | ❌ | Not started |
| Report | ❌ | Not started |
| Remediation | ❌ | Not started |

## Outstanding Items

### Evidence Gaps (Request from Vendor)
1. [ ] SOC 2 Type II report — request sent [date]?
2. [ ] Penetration test summary
3. [ ] Sub-processor list

### Domains Needing Attention
1. [ ] [Domain] — No evidence or research found
2. [ ] [Domain] — Conflicting information needs resolution

### Regulatory Coverage Gaps
1. [ ] [Regulation] — [Specific requirement not yet mapped]

## Recommended Next Steps
1. [Most impactful next action]
2. [Second priority]
3. [Third priority]
```
