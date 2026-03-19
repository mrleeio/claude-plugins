---
name: risk-scoring
description: Score vendor risk using 5x5 matrix, FAIR quantitative methodology, and weighted composite scoring. Trigger phrases include "score risk", "risk matrix", "risk rating", "calculate risk", "FAIR analysis", "risk quantification". (user)
---

# Risk Scoring

Assess and quantify vendor risk using a 5x5 qualitative matrix, FAIR quantitative methodology, and weighted composite scoring across assessment domains.

## Quick Reference

### 5x5 Risk Matrix

| Likelihood ↓ / Impact → | Negligible (1) | Minor (2) | Moderate (3) | Major (4) | Severe (5) |
|--------------------------|:-:|:-:|:-:|:-:|:-:|
| **Almost Certain (5)** | 5 | 10 | 15 | 20 | **25** |
| **Likely (4)** | 4 | 8 | 12 | **16** | **20** |
| **Possible (3)** | 3 | 6 | **9** | **12** | **15** |
| **Unlikely (2)** | 2 | 4 | 6 | 8 | 10 |
| **Rare (1)** | 1 | 2 | 3 | 4 | 5 |

### Risk Levels

| Score Range | Level | Color | Action |
|-------------|-------|-------|--------|
| 1-4 | Low | Green | Accept with standard monitoring |
| 5-9 | Medium | Yellow | Accept with enhanced monitoring |
| 10-15 | High | Orange | Remediation required, compensating controls |
| 16-25 | Critical | Red | Deny or require immediate remediation |

### Inherent vs Residual Risk

| Concept | Definition |
|---------|------------|
| **Inherent Risk** | Risk before considering any vendor controls |
| **Control Effectiveness** | How well vendor controls mitigate inherent risk (0-100%) |
| **Residual Risk** | Risk remaining after vendor controls are applied |

**Formula:** `Residual Risk = Inherent Risk × (1 - Control Effectiveness)`

## Scoring Methodology

### Step 1: Inherent Risk Assessment

Rate likelihood and impact for each domain WITHOUT considering vendor controls:

- **Likelihood:** How likely is a security event in this domain given the vendor's exposure?
- **Impact:** If a security event occurs, what is the impact to YOUR organization?

Impact should consider:
- Data sensitivity and volume
- Business process criticality
- Regulatory implications
- Reputational damage
- Financial exposure

### Step 2: Control Effectiveness Assessment

For each domain, assess vendor control effectiveness:

| Rating | Effectiveness | Description |
|--------|:---:|-------------|
| Strong | 80-100% | Documented, tested, third-party validated controls |
| Adequate | 50-79% | Controls present, partially validated or self-attested |
| Weak | 20-49% | Minimal controls, significant gaps |
| Absent | 0-19% | No meaningful controls in place |

### Step 3: Residual Risk Calculation

For each domain:
1. Calculate inherent risk score: `Likelihood × Impact`
2. Apply control effectiveness: `Inherent × (1 - Effectiveness)`
3. Normalize to 1-5 scale for composite scoring

### Step 4: Weighted Composite Score

Apply domain weights based on vendor tier and data classification:

| Domain | Critical Tier | High Tier | Medium Tier | Low Tier |
|--------|:-:|:-:|:-:|:-:|
| Information Security | 12% | 12% | 15% | 15% |
| Access Control | 10% | 10% | 10% | 10% |
| Data Security | 12% | 12% | 15% | 10% |
| Network Security | 8% | 8% | 8% | 8% |
| Vulnerability Mgmt | 8% | 8% | 8% | 8% |
| Compliance & Legal | 8% | 10% | 10% | 12% |
| Governance | 6% | 6% | 6% | 8% |
| BCP/DR | 8% | 8% | 5% | 5% |
| Incident Mgmt | 8% | 8% | 5% | 5% |
| Operations | 4% | 4% | 4% | 4% |
| HR Security | 3% | 3% | 3% | 3% |
| Physical Security | 3% | 3% | 3% | 4% |
| Supply Chain | 4% | 4% | 3% | 3% |
| AI Risk | 4% | 2% | 3% | 3% |
| Privacy | 2% | 2% | 2% | 2% |

**Composite Score** = Σ (Domain Residual Risk × Domain Weight)

### Step 5: FAIR Quantitative Analysis (Critical/High Tier)

For Critical and High tier vendors, supplement qualitative scoring with FAIR:

| FAIR Component | Description |
|----------------|-------------|
| **Loss Event Frequency (LEF)** | How often a loss event is expected |
| **Threat Event Frequency (TEF)** | How often threat agents act against the asset |
| **Vulnerability (Vuln)** | Probability that a threat event becomes a loss event |
| **Primary Loss Magnitude (PLM)** | Direct losses (response, replacement, fines) |
| **Secondary Loss Magnitude (SLM)** | Indirect losses (reputation, competitive, legal) |

Express risk in dollar terms using ranges (e.g., 90th percentile annual loss expectancy).

## Do

- Score inherent risk BEFORE assessing controls
- Use the same scale consistently across all domains
- Weight domains according to the vendor's tier and your data classification
- Document assumptions behind likelihood and impact ratings
- Include both qualitative matrix and quantitative FAIR for Critical vendors
- Show the delta between inherent and residual risk

## Don't

- Skip domains — assign "Unknown" impact if evidence is insufficient
- Average scores without weighting — domain importance varies by context
- Conflate likelihood with impact — they are independent dimensions
- Use FAIR without calibrated estimates — garbage in, garbage out
- Present a single number without the supporting matrix

## Common Mistakes

1. **Rating likelihood based on "gut feel"** — Use threat intelligence and breach frequency data
2. **Ignoring YOUR exposure** — Impact is about YOUR organization, not the vendor's
3. **Double-counting controls** — Don't count the same control in multiple domains
4. **Treating composite as absolute** — The composite score is relative and comparative

## See Also

- [Scoring Matrix](references/scoring-matrix.md) — Detailed scoring criteria per domain
- [FAIR Methodology](references/fair-methodology.md) — Step-by-step FAIR analysis guide
- [Weighted Composite](references/weighted-composite.md) — Weight calibration and examples
