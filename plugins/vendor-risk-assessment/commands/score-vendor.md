---
name: score-vendor
description: Score a vendor's risk across all assessment domains with weighted composite calculation
allowed-tools: AskUserQuestion, Read, Glob, Grep, Write, Edit, Skill
---

# Score Vendor Risk

Perform domain-by-domain risk scoring for a vendor assessment, calculate weighted composite scores, and generate a formatted risk summary.

## Context Gathering

Before scoring, load the risk-scoring skill:
- `Skill(skill: "vendor-risk-assessment:risk-scoring")`

Then locate the assessment workspace:
- Use Glob to find `assessments/*/README.md` files
- If multiple assessments exist, ask the user which vendor to score
- Read the assessment README to understand the vendor tier, data types, and applicable regulations
- Read the research dossier (`research-dossier.md`) for evidence gathered

## Step 1: Confirm Scoring Context

Present the scoring context to the user:

```
## Scoring Context

**Vendor:** [Name]
**Tier:** [Critical/High/Medium/Low]
**Data Classification:** [Level]
**Applicable Weights:** [Tier-specific weight table]
```

Ask: "Would you like to adjust the domain weights for this vendor, or use the standard weights for their tier?"

## Step 2: Domain-by-Domain Scoring

For each of the 15 domains, guide the user through scoring:

### For Each Domain

1. **Present available evidence** — Show what the research dossier found for this domain
2. **Score Inherent Risk**
   - Ask: "For [Domain], what is the likelihood of a security event? (1-Rare to 5-Almost Certain)"
   - Ask: "What would be the impact to your organization? (1-Negligible to 5-Severe)"
   - Calculate: `Inherent Risk = Likelihood × Impact`
3. **Assess Control Effectiveness**
   - Ask: "Based on the evidence, how effective are the vendor's controls for [Domain]? (Strong 80-100% / Adequate 50-79% / Weak 20-49% / Absent 0-19%)"
4. **Calculate Residual Risk**
   - `Residual Risk = Inherent Risk × (1 - Control Effectiveness)`
   - Normalize to 1-5 scale

Record in a scoring table:

```markdown
### [Domain Name]
| Metric | Value |
|--------|-------|
| Likelihood | [1-5] |
| Impact | [1-5] |
| Inherent Risk | [1-25] |
| Control Effectiveness | [%] |
| Residual Risk | [1-25] |
| Normalized (1-5) | [X.X] |
| Evidence Tier | [1-7] |
| Notes | [Key observations] |
```

## Step 3: Weighted Composite Calculation

After all domains are scored:

1. Apply tier-appropriate weights to each domain's normalized residual risk
2. Calculate: `Composite Score = Σ (Domain Score × Domain Weight)`
3. Determine overall risk level:
   - 1.0-2.0: Low (Green)
   - 2.1-3.0: Medium (Yellow)
   - 3.1-4.0: High (Orange)
   - 4.1-5.0: Critical (Red)

## Step 4: Generate Risk Summary

Output a formatted risk summary:

```markdown
# Risk Scoring Summary: [Vendor Name]

**Assessment Date:** [Date]
**Vendor Tier:** [Tier]
**Overall Residual Risk:** [Score] — [Level]

## Composite Scoring

| Domain | Weight | Inherent | Controls | Residual | Weighted |
|--------|:------:|:--------:|:--------:|:--------:|:--------:|
| Information Security | [%] | [X.X] | [%] | [X.X] | [X.XX] |
| Access Control | [%] | [X.X] | [%] | [X.X] | [X.XX] |
| ... | | | | | |
| **Composite** | **100%** | **[X.X]** | | **[X.X]** | **[X.XX]** |

## Risk Matrix Placement

| | Negligible | Minor | Moderate | Major | Severe |
|---|:-:|:-:|:-:|:-:|:-:|
| Almost Certain | | | | | |
| Likely | | | | | |
| Possible | | | [HERE] | | |
| Unlikely | | | | | |
| Rare | | | | | |

## Inherent vs Residual Comparison

| Domain | Inherent | Residual | Δ | Controls Working? |
|--------|:--------:|:--------:|:-:|:-:|
| Information Security | [X.X] | [X.X] | [-X.X] | ✅/⚠️/❌ |
| ... | | | | |

## Top 5 Risk Areas
1. [Domain] — Residual [X.X]: [Key concern]
2. ...

## Top 5 Strengths
1. [Domain] — Residual [X.X]: [Key strength]
2. ...

## Recommendation
Based on the composite residual risk score of [X.X]:
- **[Approve / Conditional Approve / Deny]**
- [Key conditions if conditional]
```

## Step 5: Save Results

Write the scoring results to the assessment workspace:
- Update `scoring.md` with the full scoring detail
- Update `README.md` to mark "Domain scoring complete"

If the vendor is Critical or High tier, ask:
"This is a [Critical/High] tier vendor. Would you like to perform a FAIR quantitative analysis for the top risk areas? This will estimate risk in dollar terms."

If yes, load the FAIR methodology reference and guide through the FAIR analysis for the top 3-5 risk areas.
