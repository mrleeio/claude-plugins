---
name: vra-report-writing
description: Write vendor risk assessment reports following the 8-section deliverable structure with regulatory mapping. Trigger phrases include "write report", "vra report", "assessment report", "vendor report", "risk report". (user)
---

# VRA Report Writing

Write comprehensive Vendor Risk Assessment reports following the standardized 8-section structure with regulatory mapping appendices.

## Quick Reference

### Report Structure (8 Sections)

| # | Section | Purpose |
|---|---------|---------|
| 1 | Executive Summary | 1-page overview for leadership: vendor, tier, overall risk, recommendation |
| 2 | Vendor Profile | Company details, deployment model, data flows, integration points |
| 3 | Assessment Scope | Tier justification, data classification, applicable regulations, methodology |
| 4 | Domain Findings | All 15 domains with ratings, evidence, gaps — the core of the report |
| 5 | Risk Scoring | Inherent risk, control effectiveness, residual risk with scoring matrices |
| 6 | Comparative Analysis | Benchmark against similar vendors/industry (if applicable) |
| 7 | Remediation Plan | Now/Next/Later prioritization with SLAs and compensating controls |
| 8 | Recommendation | Approve / Conditional Approve / Deny with conditions and review date |

### Writing Standards

| Aspect | Standard |
|--------|----------|
| Tone | Professional, objective, evidence-based |
| Audience | Primary: CISO/Security leadership. Secondary: Procurement, Legal, Business owners |
| Evidence | Every finding must cite its source and evidence tier |
| Ratings | Use consistent 1-5 scale with defined criteria |
| Risks | State as "risk of [impact] due to [cause]" |
| Recommendations | Specific, actionable, time-bound |

### Recommendation Decision Framework

| Overall Risk | Recommendation | Conditions |
|-------------|----------------|------------|
| Low (1.0-2.0) | **Approve** | Standard monitoring per tier |
| Medium (2.1-3.0) | **Conditional Approve** | Specific remediation items with SLAs |
| High (3.1-4.0) | **Conditional Approve** | Significant remediation + compensating controls required |
| Critical (4.1-5.0) | **Deny** | Unacceptable risk; remediation required before re-assessment |

## Section Guidelines

### 1. Executive Summary

- Maximum 1 page
- Lead with the recommendation (Approve/Conditional/Deny)
- State the overall residual risk score
- Highlight top 3 risks and top 3 strengths
- Include vendor tier and assessment date
- Write for a non-technical audience

### 2. Vendor Profile

- Company name, headquarters, founded date, employee count
- Product/service being assessed (be specific)
- Deployment model (SaaS, self-hosted, hybrid)
- Data flow diagram description
- Integration points with your environment
- Key contacts and relationship owner

### 3. Assessment Scope

- Vendor tier (Critical/High/Medium/Low) with justification
- Data classification of data shared/processed
- Applicable regulatory frameworks
- Assessment methodology (frameworks used)
- Assessment timeline and participants
- Exclusions (what was NOT assessed and why)

### 4. Domain Findings

For each of the 15 domains:

```markdown
### [Domain Name]
**Rating:** [1-5] — [Strong/Adequate/Weak]
**Evidence Tier:** [1-7]

**Findings:**
- [Specific finding with evidence citation]

**Gaps:**
- [Identified gap or concern]

**Questions for Vendor:**
- [Follow-up questions if evidence insufficient]
```

### 5. Risk Scoring

- Present the 5x5 risk matrix with inherent risk placement
- Show control effectiveness assessment
- Calculate residual risk
- Include weighted composite score across domains
- FAIR quantitative analysis for Critical/High tier vendors

### 6. Comparative Analysis

- Benchmark against industry peers (if data available)
- Note areas where vendor exceeds or falls below industry norms
- Reference security ratings (BitSight, SecurityScorecard) if available

### 7. Remediation Plan

- Use Now/Next/Later prioritization
- Each item: finding reference, required action, severity, SLA, owner
- Include compensating controls for risks that cannot be immediately remediated
- Conditional approval items clearly marked

### 8. Recommendation

- Clear Approve / Conditional Approve / Deny
- Summary of conditions (if conditional)
- Review cadence based on tier
- Next assessment date
- Escalation path if conditions not met

## Do

- Use templates from `assets/templates/` as starting points
- Cite evidence tier for every finding
- Include regulatory mapping in appendices
- Write risks in "risk of [impact] due to [cause]" format
- Keep executive summary to 1 page
- Use consistent rating scales throughout

## Don't

- Include raw questionnaire responses in the main report (use appendices)
- Make findings without evidence citations
- Use vague language ("seems secure", "appears adequate")
- Mix inherent and residual risk without clear labels
- Omit the recommendation or make it ambiguous
- Write more than 2-3 pages per domain finding

## Common Mistakes

1. **Burying the lead** — The recommendation should be in the first paragraph of the executive summary
2. **Inconsistent ratings** — Using different scales in different sections
3. **Missing evidence citations** — Every finding must reference its source
4. **Vague remediation items** — "Improve security" is not actionable; "Implement MFA for admin accounts within 30 days" is
5. **Forgetting regulatory mapping** — Reports for regulated industries must map findings to applicable frameworks

## See Also

- [Report Structure](references/report-structure.md) — Detailed section-by-section guidance
- [Writing Standards](references/writing-standards.md) — Tone, formatting, and citation standards
- **Templates:**
  - [Executive Summary Template](assets/templates/executive-summary.md)
  - [Findings Section Template](assets/templates/findings-section.md)
  - [Remediation Plan Template](assets/templates/remediation-plan.md)
  - [Full Report Template](assets/templates/full-report.md)
