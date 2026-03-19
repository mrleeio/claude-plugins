# Weighted Composite Scoring Methodology

## Overview

The weighted composite score aggregates individual domain scores (1-5) into a single overall risk score by applying domain-specific weights. Weights reflect the relative importance of each domain based on the vendor's tier, data sensitivity, and industry context.

The composite score formula:

```
Composite Score = SUM(Domain Score x Domain Weight) / SUM(Domain Weights)
```

The result is a value between 1.0 and 5.0 that represents the vendor's overall risk posture.

---

## Default Weight Tables by Vendor Tier

Weights are expressed as multipliers. Higher weight means the domain contributes more to the composite score.

### Critical Tier (Tier 1)

Vendors with direct access to sensitive data, critical business processes, or whose failure would cause severe operational impact.

| Domain | Weight | Rationale |
|:-------|:------:|:----------|
| Data Security | 5 | Direct custody of sensitive data |
| Access Control | 5 | Controls who reaches the data |
| Network Security | 4 | Perimeter and segmentation protection |
| Incident Response | 5 | Speed and quality of breach response |
| Business Continuity | 5 | Operational dependency |
| Compliance | 4 | Regulatory exposure |
| Privacy | 4 | Data subject rights obligations |
| Vulnerability Management | 4 | Attack surface reduction |
| Change Management | 3 | Stability of production environment |
| Physical Security | 3 | Physical access to infrastructure |
| Human Resources Security | 3 | Insider threat mitigation |
| Third-Party Management | 4 | Nth-party risk propagation |
| Security Governance | 3 | Overall program maturity |
| Application Security | 4 | Code-level protections |
| Data Lifecycle Management | 4 | Retention, disposal, classification |

### High Tier (Tier 2)

Vendors with access to internal data, moderate operational dependency, or significant contractual obligations.

| Domain | Weight | Rationale |
|:-------|:------:|:----------|
| Data Security | 4 | Data access present but less sensitive |
| Access Control | 4 | Important but narrower scope |
| Network Security | 3 | Standard perimeter concerns |
| Incident Response | 4 | Response capability still important |
| Business Continuity | 4 | Moderate operational dependency |
| Compliance | 4 | Regulatory alignment required |
| Privacy | 3 | Some personal data processing |
| Vulnerability Management | 3 | Standard attack surface |
| Change Management | 3 | Production stability |
| Physical Security | 2 | Lower physical risk profile |
| Human Resources Security | 3 | Standard insider risk |
| Third-Party Management | 3 | Nth-party awareness needed |
| Security Governance | 3 | Program maturity baseline |
| Application Security | 3 | Standard code protections |
| Data Lifecycle Management | 3 | Standard data handling |

### Medium Tier (Tier 3)

Vendors with limited data access, non-critical services, or replaceable within reasonable timeframes.

| Domain | Weight | Rationale |
|:-------|:------:|:----------|
| Data Security | 3 | Limited data exposure |
| Access Control | 3 | Narrowly scoped access |
| Network Security | 2 | Minimal network integration |
| Incident Response | 3 | Basic response expectations |
| Business Continuity | 2 | Replaceable service |
| Compliance | 3 | Basic regulatory compliance |
| Privacy | 2 | Minimal personal data |
| Vulnerability Management | 2 | Smaller attack surface |
| Change Management | 2 | Lower change risk |
| Physical Security | 1 | Minimal physical concern |
| Human Resources Security | 2 | Standard vetting |
| Third-Party Management | 2 | Limited downstream risk |
| Security Governance | 2 | Baseline maturity expected |
| Application Security | 2 | Limited application exposure |
| Data Lifecycle Management | 2 | Basic data handling |

### Low Tier (Tier 4)

Vendors with no data access, commodity services, or trivially replaceable.

| Domain | Weight | Rationale |
|:-------|:------:|:----------|
| Data Security | 2 | No sensitive data |
| Access Control | 2 | Minimal access requirements |
| Network Security | 1 | No network integration |
| Incident Response | 2 | Basic expectations |
| Business Continuity | 1 | Easily replaceable |
| Compliance | 2 | Basic legal compliance |
| Privacy | 1 | No personal data processing |
| Vulnerability Management | 1 | Minimal exposure |
| Change Management | 1 | Low impact changes |
| Physical Security | 1 | Not applicable in most cases |
| Human Resources Security | 1 | Standard vetting |
| Third-Party Management | 1 | Negligible downstream risk |
| Security Governance | 1 | Basic expectations |
| Application Security | 1 | No application integration |
| Data Lifecycle Management | 1 | No data retention |

---

## Context-Based Weight Adjustments

Adjust the default weights to reflect industry-specific or scenario-specific risk factors. Apply these as additive modifiers to the base weight (cap at 5, floor at 1).

### Healthcare / HIPAA-Regulated

| Domain | Adjustment | Rationale |
|:-------|:----------:|:----------|
| Privacy | +2 | PHI protection requirements |
| Compliance | +1 | HIPAA/HITECH obligations |
| Incident Response | +1 | Breach notification requirements (60 days) |
| Data Lifecycle Management | +1 | PHI retention and disposal rules |
| Business Continuity | +1 | Patient safety implications |

### Financial Services / PCI-Regulated

| Domain | Adjustment | Rationale |
|:-------|:----------:|:----------|
| Compliance | +2 | PCI DSS, SOX, GLBA requirements |
| Data Security | +1 | Cardholder data / financial data protection |
| Access Control | +1 | Privileged access to financial systems |
| Network Security | +1 | Network segmentation requirements (PCI) |
| Change Management | +1 | Change control requirements under SOX |

### Government / FedRAMP

| Domain | Adjustment | Rationale |
|:-------|:----------:|:----------|
| Compliance | +2 | FedRAMP/FISMA requirements |
| Access Control | +2 | NIST 800-53 access control families |
| Physical Security | +1 | Facility clearance requirements |
| Human Resources Security | +1 | Background investigation requirements |
| Security Governance | +1 | System security plan requirements |

### E-Commerce / Consumer-Facing

| Domain | Adjustment | Rationale |
|:-------|:----------:|:----------|
| Privacy | +2 | Consumer data protection laws (CCPA, GDPR) |
| Application Security | +1 | Customer-facing application risk |
| Business Continuity | +1 | Revenue impact of downtime |
| Data Security | +1 | Payment and consumer data |

### SaaS / Cloud-Dependent

| Domain | Adjustment | Rationale |
|:-------|:----------:|:----------|
| Business Continuity | +2 | Cloud availability dependency |
| Third-Party Management | +1 | Cloud supply chain risk |
| Network Security | +1 | API and integration security |
| Application Security | +1 | Multi-tenant isolation |

---

## Composite Score Calculation Example

### Scenario

A Critical-tier SaaS vendor in the healthcare industry. Domain assessment results:

| Domain | Raw Score | Base Weight | Healthcare Adj. | Final Weight |
|:-------|:---------:|:-----------:|:---------------:|:------------:|
| Data Security | 4 | 5 | 0 | 5 |
| Access Control | 3 | 5 | 0 | 5 |
| Network Security | 3 | 4 | 0 | 4 |
| Incident Response | 4 | 5 | +1 | 5 (capped) |
| Business Continuity | 2 | 5 | +1 | 5 (capped) |
| Compliance | 4 | 4 | +1 | 5 |
| Privacy | 3 | 4 | +2 | 5 (capped) |
| Vulnerability Management | 4 | 4 | 0 | 4 |
| Change Management | 3 | 3 | 0 | 3 |
| Physical Security | 4 | 3 | 0 | 3 |
| Human Resources Security | 3 | 3 | 0 | 3 |
| Third-Party Management | 2 | 4 | 0 | 4 |
| Security Governance | 3 | 3 | 0 | 3 |
| Application Security | 3 | 4 | 0 | 4 |
| Data Lifecycle Management | 3 | 4 | +1 | 5 |

### Calculation

```
Weighted Sum = (4x5) + (3x5) + (3x4) + (4x5) + (2x5) + (4x5) + (3x5) + (4x4) +
               (3x3) + (4x3) + (3x3) + (2x4) + (3x3) + (3x4) + (3x5)
             = 20 + 15 + 12 + 20 + 10 + 20 + 15 + 16 +
               9 + 12 + 9 + 8 + 9 + 12 + 15
             = 202

Sum of Weights = 5 + 5 + 4 + 5 + 5 + 5 + 5 + 4 + 3 + 3 + 3 + 4 + 3 + 4 + 5
               = 63

Composite Score = 202 / 63 = 3.21
```

---

## Normalizing Domain Scores to 1-5 Scale

When domain scores are derived from sub-criteria with varying scales, normalize to the 1-5 scale before applying weights.

### Percentage-Based Normalization

If a domain assessment produces a percentage (e.g., 72% of controls effective):

```
Domain Score = 1 + (Percentage / 100) x 4
```

| Percentage | Domain Score |
|:-----------|:------------|
| 0-19%      | 1.0 - 1.8  |
| 20-49%     | 1.8 - 3.0  |
| 50-79%     | 3.0 - 4.2  |
| 80-100%    | 4.2 - 5.0  |

### Sub-Criteria Averaging

If a domain has multiple sub-criteria each scored 1-5, the domain score is the simple average:

```
Domain Score = SUM(Sub-Criteria Scores) / Number of Sub-Criteria
```

Round to one decimal place for the composite calculation.

### Binary Controls Normalization

If a domain uses a checklist of yes/no controls:

```
Domain Score = 1 + (Controls Present / Total Controls) x 4
```

---

## Interpreting Composite Scores

| Composite Score | Overall Risk Level | Interpretation |
|:---------------|:-------------------|:---------------|
| 4.5 - 5.0 | **Low Risk** | Vendor demonstrates strong controls across all weighted domains. Standard monitoring appropriate. Approve with standard terms. |
| 3.5 - 4.4 | **Moderate Risk** | Vendor has adequate controls with some gaps. Enhanced monitoring recommended. Approve with risk-mitigation clauses. |
| 2.5 - 3.4 | **High Risk** | Vendor has notable weaknesses in key domains. Remediation plan required before proceeding or renewing. Escalate to risk owner. |
| 1.5 - 2.4 | **Critical Risk** | Vendor has significant deficiencies across multiple domains. Engagement not recommended without substantial remediation. Escalate to senior leadership. |
| 1.0 - 1.4 | **Unacceptable Risk** | Vendor fails to meet minimum security standards. Do not engage or begin transition planning for existing relationships. |

### Decision Matrix

| Composite Score | New Vendor | Existing Vendor |
|:---------------|:-----------|:----------------|
| 4.5 - 5.0 | Approve | Continue; next review per standard schedule |
| 3.5 - 4.4 | Approve with conditions | Continue with enhanced monitoring; remediation within 90 days |
| 2.5 - 3.4 | Conditional approval; requires risk acceptance from business owner | Issue remediation plan; 60-day follow-up; escalate if no progress |
| 1.5 - 2.4 | Do not approve without executive risk acceptance | Begin transition planning; 30-day remediation deadline; executive escalation |
| 1.0 - 1.4 | Reject | Immediate transition planning; suspend data sharing if contractually possible |

---

## Inherent vs. Residual Composite Scores

Calculate two composite scores to demonstrate the effectiveness of compensating controls.

### Inherent Composite Score

Represents risk **before** compensating controls are applied. Use the vendor's raw domain scores based on their own controls and posture.

### Residual Composite Score

Represents risk **after** compensating controls are applied by the assessing organization. Adjust domain scores upward to reflect:

| Compensating Control | Domain Affected | Typical Score Adjustment |
|:---------------------|:----------------|:------------------------|
| Encryption of data before sending to vendor | Data Security | +0.5 to +1.0 |
| Network segmentation isolating vendor access | Network Security | +0.5 to +1.0 |
| Independent monitoring of vendor activity | Access Control, Security Governance | +0.5 per domain |
| Contractual SLAs with financial penalties | Business Continuity, Incident Response | +0.5 per domain |
| Cyber insurance covering vendor incidents | All domains (reduces financial impact) | +0.25 across all |
| Regular independent audits of vendor | Compliance, Security Governance | +0.5 per domain |
| Data minimization (reducing data shared) | Data Security, Privacy, Data Lifecycle | +0.5 to +1.0 per domain |
| Multi-vendor strategy (no single dependency) | Business Continuity | +1.0 |

**Cap adjusted scores at 5.0.** Compensating controls cannot raise a domain score above 5.

### Example: Inherent vs. Residual Comparison

Using the healthcare SaaS vendor example above:

```
Inherent Composite Score:  3.21 (High Risk)

Compensating controls applied:
- Encrypt data before transmission to vendor (Data Security: 4 -> 4.5)
- Independent monitoring of vendor access (Access Control: 3 -> 3.5)
- Multi-vendor strategy for continuity (Business Continuity: 2 -> 3)
- Cyber insurance ($5M coverage) (+0.25 across all domains)

Adjusted Weighted Sum = (4.5x5) + (3.5x5) + (3.25x4) + (4.25x5) + (3x5) + (4.25x5) +
                        (3.25x5) + (4.25x4) + (3.25x3) + (4.25x3) + (3.25x3) + (2.25x4) +
                        (3.25x3) + (3.25x4) + (3.25x5)
                      = 22.5 + 17.5 + 13 + 21.25 + 15 + 21.25 + 16.25 + 17 +
                        9.75 + 12.75 + 9.75 + 9 + 9.75 + 13 + 16.25
                      = 224

Residual Composite Score = 224 / 63 = 3.56 (Moderate Risk)

Risk Reduction = 3.56 - 3.21 = 0.35 points
Risk Level Change: High Risk -> Moderate Risk
```

This comparison demonstrates that compensating controls reduced the vendor's effective risk level from High to Moderate, supporting a decision to proceed with the engagement under enhanced monitoring rather than requiring vendor remediation before approval.

### Reporting the Gap

Always report both scores together:

```
Vendor: [Name]
Tier: Critical
Inherent Risk Score:  3.21 / 5.0  (High Risk)
Residual Risk Score:  3.56 / 5.0  (Moderate Risk)
Control Effectiveness: +0.35 improvement (10.9% risk reduction)
Recommendation: Approve with conditions; maintain compensating controls
```
