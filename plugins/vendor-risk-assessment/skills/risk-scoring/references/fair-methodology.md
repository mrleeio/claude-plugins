# FAIR Methodology for Vendor Risk Quantification

## Overview

FAIR (Factor Analysis of Information Risk) is a quantitative risk analysis framework that breaks risk into measurable components. Unlike qualitative scoring (Low/Medium/High), FAIR produces financial loss estimates expressed as ranges and probability distributions.

Use FAIR analysis for **Critical and High tier vendors** where the organization needs to understand risk in monetary terms to support investment decisions, executive reporting, or comparison across vendor relationships.

---

## FAIR Taxonomy

Risk in FAIR is decomposed into two primary branches:

```
Risk (Annualized Loss Exposure)
├── Loss Event Frequency (LEF)
│   ├── Threat Event Frequency (TEF)
│   │   ├── Contact Frequency
│   │   └── Probability of Action
│   └── Vulnerability (Vuln)
│       ├── Threat Capability (TCap)
│       └── Resistance Strength (RS)
└── Loss Magnitude (LM)
    ├── Primary Loss Magnitude (PLM)
    │   ├── Productivity Loss
    │   ├── Response Cost
    │   └── Replacement Cost
    └── Secondary Loss Magnitude (SLM)
        ├── Secondary Loss Event Frequency (SLEF)
        └── Secondary Loss Magnitude (per event)
            ├── Fines & Penalties
            ├── Reputation Damage
            └── Competitive Advantage Loss
```

---

## Step-by-Step FAIR Analysis Process

### Step 1: Identify the Risk Scenario

Define the scenario with precision using four components:

| Component | Description | Example |
|:----------|:------------|:--------|
| **Asset** | What is at risk | Customer PII stored by vendor |
| **Threat** | Who or what could cause loss | External malicious actor |
| **Effect** | What happens to the asset | Confidentiality breach (data exfiltration) |
| **Impact** | How the organization is affected | Regulatory fines, notification costs, reputation damage |

### Step 2: Estimate Threat Event Frequency (TEF)

TEF represents how often a threat agent is expected to act against the asset in a given year.

Estimate using a three-point range with confidence level:

| Parameter | Description |
|:----------|:------------|
| **Minimum** | Best-case scenario; fewest plausible events per year |
| **Most Likely** | Most realistic estimate based on available data |
| **Maximum** | Worst-case scenario; most plausible events per year |
| **Confidence** | Subjective confidence in the estimate (Low/Medium/High) |

**Guidance for estimation:**

| TEF Range (per year) | Interpretation |
|:---------------------|:---------------|
| 0.01 - 0.1 | Rare; less than once per decade to about once per decade |
| 0.1 - 1.0 | Infrequent; once every few years to about once per year |
| 1.0 - 10 | Frequent; one to several times per year |
| 10 - 100 | Very frequent; multiple times per month |
| 100+ | Constant; daily or continuous attempts |

**Sources for TEF estimation:**
- Vendor's incident history (from questionnaire and prior assessments)
- Industry breach databases (e.g., Verizon DBIR, IBM Cost of a Data Breach)
- Threat intelligence feeds relevant to vendor's industry
- Regulatory enforcement actions in vendor's sector

### Step 3: Estimate Vulnerability (Vuln)

Vulnerability is the probability that a threat event results in a loss event. It is determined by the relationship between **Threat Capability (TCap)** and **Resistance Strength (RS)**.

| Vuln Range | Interpretation | Typical Vendor Profile |
|:-----------|:---------------|:-----------------------|
| 0.01 - 0.10 | Very Low | Strong controls across all domains; mature security program; current certifications |
| 0.10 - 0.30 | Low | Adequate controls with minor gaps; established security program |
| 0.30 - 0.50 | Moderate | Mixed control effectiveness; some domains weak |
| 0.50 - 0.70 | High | Weak controls in multiple domains; immature security program |
| 0.70 - 1.00 | Very High | Absent or ineffective controls; no formal security program |

**Mapping qualitative domain scores to Vulnerability:**

Use the vendor's domain assessment scores to calibrate Vulnerability. Average the relevant domain scores (Data Security, Access Control, Network Security, Vulnerability Management, Application Security) and map:

| Average Domain Score | Estimated Vulnerability |
|:---------------------|:-----------------------|
| 4.5 - 5.0 | 0.05 (min 0.01, max 0.15) |
| 3.5 - 4.4 | 0.15 (min 0.05, max 0.30) |
| 2.5 - 3.4 | 0.35 (min 0.20, max 0.55) |
| 1.5 - 2.4 | 0.60 (min 0.40, max 0.80) |
| 1.0 - 1.4 | 0.85 (min 0.70, max 0.95) |

### Step 4: Calculate Loss Event Frequency (LEF)

```
LEF = TEF x Vulnerability
```

Express as a range derived from the component ranges. For Monte Carlo simulation, sample TEF and Vuln independently and multiply.

### Step 5: Estimate Primary Loss Magnitude (PLM)

Primary losses are directly caused by the loss event. Estimate each category independently.

| Category | Description | Estimation Guidance |
|:---------|:------------|:--------------------|
| **Productivity Loss** | Cost of disrupted operations | (Hourly revenue or labor cost) x (hours of disruption) x (percentage of operations affected) |
| **Response Cost** | Investigation, containment, recovery | Internal labor hours + external forensics/legal retainer + technology remediation. Typical data breach IR engagement: $200K-$500K for mid-size incidents. |
| **Replacement Cost** | Restoring or replacing affected assets | Cost to rebuild systems, re-create data, transition to alternate vendor. Include transition costs if vendor replacement is necessary. |

### Step 6: Estimate Secondary Loss Magnitude (SLM)

Secondary losses result from the reaction of external stakeholders (regulators, customers, market).

First, estimate **Secondary Loss Event Frequency (SLEF)** -- the probability that a primary loss event triggers secondary effects:

| Scenario | Typical SLEF |
|:---------|:-------------|
| Breach of < 1,000 records, no sensitive data | 0.10 - 0.30 |
| Breach of 1,000-100,000 records with PII | 0.50 - 0.80 |
| Breach of > 100,000 records or sensitive data | 0.80 - 1.00 |
| Service outage < 4 hours | 0.05 - 0.15 |
| Service outage > 24 hours | 0.40 - 0.70 |

Then estimate secondary loss magnitude per event:

| Category | Description | Estimation Guidance |
|:---------|:------------|:--------------------|
| **Fines & Penalties** | Regulatory penalties | Reference applicable regulations. GDPR: up to 4% of global annual turnover. HIPAA: $100-$50,000 per violation. State breach notification: varies by jurisdiction. |
| **Reputation Damage** | Customer attrition and revenue impact | Estimate customer churn rate increase x customer lifetime value x affected customer base. Typical range: 1-7% incremental churn for significant breaches. |
| **Competitive Advantage Loss** | Loss of proprietary information value | Estimate R&D replacement cost or market advantage erosion. Highly scenario-dependent. |

### Step 7: Calculate Annualized Loss Exposure (ALE)

```
Total Loss Magnitude = PLM + (SLEF x SLM)
Annualized Loss Exposure (ALE) = LEF x Total Loss Magnitude
```

---

## Monte Carlo Simulation

For rigorous analysis, use Monte Carlo simulation rather than single-point estimates.

### Process

1. **Define distributions** for each input variable (TEF, Vuln, PLM components, SLEF, SLM components) using the min/most-likely/max estimates as parameters for a PERT or triangular distribution.
2. **Run 10,000+ iterations**, sampling from each distribution independently per iteration.
3. **Calculate ALE** for each iteration.
4. **Analyze results** using percentiles:

| Percentile | Use |
|:-----------|:----|
| P10 | Optimistic scenario; use for best-case planning |
| P50 (median) | Most likely outcome; use for budgeting and resource planning |
| P90 | Pessimistic scenario; use for risk appetite comparison and worst-case planning |
| P95/P99 | Tail risk; use for stress testing and insurance coverage decisions |

### Simplified Estimation Without Simulation

When full simulation is not practical, use the PERT formula for a weighted estimate:

```
Expected Value = (Minimum + 4 x Most Likely + Maximum) / 6
```

Apply this to each component, then multiply through the FAIR taxonomy.

---

## Example FAIR Analysis: Vendor Data Breach Scenario

**Scenario:** A Critical-tier SaaS vendor processes 500,000 customer records containing PII. Assess the annualized risk of a data breach resulting from an external attack.

### Input Estimates

| Variable | Min | Most Likely | Max | Confidence |
|:---------|:----|:------------|:----|:-----------|
| **TEF** (attacks/year) | 5 | 15 | 50 | Medium |
| **Vulnerability** | 0.05 | 0.15 | 0.30 | Medium |
| **Productivity Loss** | $50K | $200K | $500K | Medium |
| **Response Cost** | $150K | $350K | $800K | Medium |
| **Replacement Cost** | $25K | $75K | $200K | Low |
| **SLEF** | 0.60 | 0.80 | 0.95 | Medium |
| **Fines & Penalties** | $100K | $500K | $2M | Low |
| **Reputation Damage** | $200K | $1M | $5M | Low |
| **Competitive Advantage Loss** | $0 | $50K | $500K | Low |

### PERT Calculations

```
TEF = (5 + 4(15) + 50) / 6 = 18.3 events/year
Vuln = (0.05 + 4(0.15) + 0.30) / 6 = 0.16
LEF = 18.3 x 0.16 = 2.9 loss events/year

PLM = $50K + $200K + $500K averaged components
    Productivity = (50 + 4(200) + 500) / 6 = $225K
    Response     = (150 + 4(350) + 800) / 6 = $392K
    Replacement  = (25 + 4(75) + 200) / 6 = $88K
    Total PLM    = $705K

SLM components:
    Fines      = (100 + 4(500) + 2000) / 6 = $683K
    Reputation = (200 + 4(1000) + 5000) / 6 = $1.53M
    Competitive = (0 + 4(50) + 500) / 6 = $117K
    Total SLM  = $2.33M

SLEF = (0.60 + 4(0.80) + 0.95) / 6 = 0.79

Total Loss Magnitude = $705K + (0.79 x $2.33M) = $705K + $1.84M = $2.55M

ALE = 2.9 x $2.55M = $7.4M
```

### Interpretation

The expected annualized loss exposure from this vendor relationship (for this specific scenario) is approximately **$7.4M**. A Monte Carlo simulation would provide a distribution; the P90 value might be $15-20M, informing risk appetite decisions and control investment justification.

---

## When to Use FAIR vs. Qualitative Scoring

| Criterion | Use FAIR | Use Qualitative (5x5 Matrix) |
|:----------|:---------|:-----------------------------|
| **Vendor Tier** | Critical, High | Medium, Low |
| **Decision Context** | Investment justification, insurance, executive reporting | Routine risk acceptance, periodic review |
| **Data Availability** | Sufficient incident data or industry benchmarks available | Limited data; broad categorization sufficient |
| **Stakeholder Audience** | CFO, Board, regulators requiring financial quantification | Risk committee, operational management |
| **Time/Resources** | Analyst time available for detailed modeling | Rapid assessment needed |
| **Risk Level** | High/Critical qualitative scores that need further analysis | Low/Medium scores where qualitative ranking is sufficient |

### Hybrid Approach

For most vendor risk programs, the recommended approach is:

1. **Screen all vendors** with qualitative scoring (5x5 matrix).
2. **Apply FAIR analysis** to Critical-tier vendors and any High-tier vendor where the qualitative score is High or Critical.
3. **Use FAIR outputs** to prioritize remediation investment and set contractual risk-transfer requirements (insurance, liability caps, SLAs).
4. **Re-run FAIR analysis** annually for Critical-tier vendors or when material changes occur (new data types, expanded scope, significant incidents).
