# Vendor Risk Assessment Report

> **Instructions:** This is the master template for a complete VRA report. Replace all `[PLACEHOLDER]` values with assessment-specific information. Remove all instruction blocks (blockquotes starting with "Instructions" or "Remove") before finalizing.

---

**Document Classification:** [CLASSIFICATION] (e.g., CONFIDENTIAL)
**Version:** [VERSION]
**Date:** [REPORT_DATE]
**Author:** [ASSESSOR_NAME], [ASSESSOR_TITLE]
**Distribution:** [DISTRIBUTION_LIST]

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Vendor Profile](#2-vendor-profile)
3. [Assessment Scope](#3-assessment-scope)
4. [Domain Findings](#4-domain-findings)
5. [Risk Scoring](#5-risk-scoring)
6. [Comparative Analysis](#6-comparative-analysis)
7. [Remediation Plan](#7-remediation-plan)
8. [Recommendation](#8-recommendation)
- [Appendix A: Regulatory Mapping](#appendix-a-regulatory-mapping)
- [Appendix B: Evidence Inventory](#appendix-b-evidence-inventory)
- [Appendix C: Acronyms and Definitions](#appendix-c-acronyms-and-definitions)

---

## 1. Executive Summary

**Recommendation: [RECOMMENDATION]** (Approve / Conditional Approve / Deny)

| Field | Value |
|-------|-------|
| **Vendor** | [VENDOR_NAME] |
| **Product/Service** | [PRODUCT_SERVICE] |
| **Vendor Tier** | [TIER] (Critical / High / Medium / Low) |
| **Assessment Date** | [ASSESSMENT_DATE] |
| **Overall Residual Risk Score** | [OVERALL_RISK_SCORE] / 5.0 |
| **Risk Level** | [RISK_LEVEL] (Low / Medium / High / Critical) |
| **Next Review Date** | [NEXT_REVIEW_DATE] |

### Assessment Context

[VENDOR_NAME] provides [PRODUCT_SERVICE] to [YOUR_ORGANIZATION], classified as a [TIER]-tier vendor due to [TIER_JUSTIFICATION]. This assessment evaluated [VENDOR_NAME] across 15 security domains using [METHODOLOGY] and [EVIDENCE_SOURCES_SUMMARY].

### Top Risks

1. **[RISK_1_TITLE]:** Risk of [RISK_1_IMPACT] due to [RISK_1_CAUSE]. (Severity: [RISK_1_SEVERITY])
2. **[RISK_2_TITLE]:** Risk of [RISK_2_IMPACT] due to [RISK_2_CAUSE]. (Severity: [RISK_2_SEVERITY])
3. **[RISK_3_TITLE]:** Risk of [RISK_3_IMPACT] due to [RISK_3_CAUSE]. (Severity: [RISK_3_SEVERITY])

### Top Strengths

1. **[STRENGTH_1_TITLE]:** [STRENGTH_1_DESCRIPTION] [STRENGTH_1_EVIDENCE]
2. **[STRENGTH_2_TITLE]:** [STRENGTH_2_DESCRIPTION] [STRENGTH_2_EVIDENCE]
3. **[STRENGTH_3_TITLE]:** [STRENGTH_3_DESCRIPTION] [STRENGTH_3_EVIDENCE]

### Conditions for Approval

> *Remove this subsection if the recommendation is Approve or Deny.*

| # | Condition | SLA | Remediation Ref |
|---|-----------|-----|-----------------|
| 1 | [CONDITION_1] | [SLA_1] | [FINDING_REF_1] |
| 2 | [CONDITION_2] | [SLA_2] | [FINDING_REF_2] |
| 3 | [CONDITION_3] | [SLA_3] | [FINDING_REF_3] |

---

## 2. Vendor Profile

### Company Information

| Field | Detail |
|-------|--------|
| **Legal Entity Name** | [LEGAL_NAME] |
| **DBA / Trade Name** | [DBA_NAME] |
| **Headquarters** | [HQ_LOCATION] |
| **Countries of Operation** | [COUNTRIES] |
| **Year Founded** | [YEAR_FOUNDED] |
| **Employee Count** | [EMPLOYEE_COUNT] |
| **Public/Private** | [PUBLIC_PRIVATE] (Ticker: [TICKER] if applicable) |
| **Recent M&A Activity** | [MA_ACTIVITY] |

### Product/Service Under Assessment

| Field | Detail |
|-------|--------|
| **Product/Service Name** | [PRODUCT_SERVICE] |
| **Version / Release** | [VERSION_RELEASE] |
| **Core Functionality** | [FUNCTIONALITY] |
| **Use Case** | [USE_CASE_IN_YOUR_ORG] |

### Deployment Model

| Field | Detail |
|-------|--------|
| **Deployment Type** | [DEPLOYMENT_TYPE] (SaaS / Self-Hosted / Hybrid) |
| **Tenancy Model** | [SINGLE_MULTI_TENANT] |
| **Hosting Provider** | [HOSTING_PROVIDER] |
| **Data Center Locations** | [DATA_CENTER_LOCATIONS] |
| **Environment Isolation** | [ISOLATION_APPROACH] |

### Data Flows

| Data Flow | Classification | Direction | Description |
|-----------|---------------|-----------|-------------|
| [DATA_FLOW_1] | [CLASSIFICATION] | [IN/OUT/BIDIRECTIONAL] | [DESCRIPTION] |
| [DATA_FLOW_2] | [CLASSIFICATION] | [IN/OUT/BIDIRECTIONAL] | [DESCRIPTION] |
| [DATA_FLOW_3] | [CLASSIFICATION] | [IN/OUT/BIDIRECTIONAL] | [DESCRIPTION] |

**Data Residency:** [DATA_RESIDENCY_DETAILS]

### Integration Points

| Integration | Protocol | Authentication | Dependent System |
|-------------|----------|---------------|-----------------|
| [INTEGRATION_1] | [PROTOCOL] | [AUTH_METHOD] | [SYSTEM] |
| [INTEGRATION_2] | [PROTOCOL] | [AUTH_METHOD] | [SYSTEM] |

### Key Contacts

| Role | Name | Email |
|------|------|-------|
| Relationship Owner (Internal) | [NAME] | [EMAIL] |
| Account Manager (Vendor) | [NAME] | [EMAIL] |
| Security Contact (Vendor) | [NAME] | [EMAIL] |

---

## 3. Assessment Scope

### Tier Classification

| Field | Detail |
|-------|--------|
| **Assigned Tier** | [TIER] (Critical / High / Medium / Low) |
| **Data Sensitivity** | [DATA_SENSITIVITY] |
| **Business Criticality** | [BUSINESS_CRITICALITY] |
| **Replaceability** | [REPLACEABILITY] |
| **User Population** | [USER_POPULATION] |
| **Justification** | [TIER_JUSTIFICATION] |

### Data Classification

| Data Type | Classification | Volume | Sensitivity Notes |
|-----------|---------------|--------|-------------------|
| [DATA_TYPE_1] | [CLASSIFICATION] | [VOLUME] | [NOTES] |
| [DATA_TYPE_2] | [CLASSIFICATION] | [VOLUME] | [NOTES] |

### Applicable Regulations

| Regulation | Jurisdiction | Relevance | Key Requirements |
|-----------|-------------|-----------|-----------------|
| [REGULATION_1] | [JURISDICTION] | [RELEVANCE] | [REQUIREMENTS] |
| [REGULATION_2] | [JURISDICTION] | [RELEVANCE] | [REQUIREMENTS] |
| [REGULATION_3] | [JURISDICTION] | [RELEVANCE] | [REQUIREMENTS] |

### Assessment Methodology

| Field | Detail |
|-------|--------|
| **Frameworks Used** | [FRAMEWORKS] |
| **Questionnaire** | [QUESTIONNAIRE_STANDARD] (SIG Lite / SIG Core / CAIQ / Custom) |
| **Evidence Collection** | [EVIDENCE_APPROACH] |
| **Assessment Period** | [START_DATE] to [END_DATE] |
| **Assessor(s)** | [ASSESSOR_NAMES_AND_QUALIFICATIONS] |

### Exclusions

| Excluded Area | Reason | Impact on Rating | Future Plan |
|---------------|--------|-----------------|-------------|
| [EXCLUSION_1] | [REASON] | [IMPACT] | [PLAN] |
| [EXCLUSION_2] | [REASON] | [IMPACT] | [PLAN] |

---

## 4. Domain Findings

> **Instructions:** Repeat the domain finding block below for each of the 15 domains. See the [findings section template](findings-section.md) for detailed guidance.

### 4.1 Information Security Program

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.2 Access Control

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.3 Data Security & Encryption

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.4 Network Security

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.5 Vulnerability Management

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.6 Compliance & Legal

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.7 Governance & Risk Management

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.8 Business Continuity & Disaster Recovery

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.9 Incident Management

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.10 Operations Security

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.11 Human Resources Security

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.12 Physical Security

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.13 Supply Chain / Third-Party Risk

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.14 AI / Machine Learning Risk

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### 4.15 Privacy

| Attribute | Value |
|-----------|-------|
| **Rating** | [RATING] / 5 — [RATING_LABEL] |
| **Evidence Tier** | Tier [EVIDENCE_TIER] — [EVIDENCE_TIER_LABEL] |
| **Evidence Sources** | [EVIDENCE_SOURCES] |

**Findings:**
- **[FINDING_ID]:** [FINDING_DESCRIPTION] [EVIDENCE_CITATION] (Tier [TIER])

**Gaps:**
- **[GAP_ID]:** Risk of [IMPACT] due to [CAUSE]. (Severity: [SEVERITY])

**Follow-Up Questions:**
- [QUESTION]

---

### Domain Summary

| # | Domain | Rating | Evidence Tier | Inherent Risk | Residual Risk | Gaps |
|---|--------|:------:|:---:|:---:|:---:|:---:|
| 1 | Information Security Program | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 2 | Access Control | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 3 | Data Security & Encryption | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 4 | Network Security | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 5 | Vulnerability Management | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 6 | Compliance & Legal | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 7 | Governance & Risk Management | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 8 | Business Continuity & Disaster Recovery | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 9 | Incident Management | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 10 | Operations Security | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 11 | Human Resources Security | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 12 | Physical Security | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 13 | Supply Chain / Third-Party Risk | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 14 | AI / Machine Learning Risk | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| 15 | Privacy | [RATING] | [TIER] | [SCORE] | [SCORE] | [COUNT] |
| | **Weighted Average** | **[AVG]** | | | **[COMPOSITE]** | **[TOTAL]** |

---

## 5. Risk Scoring

### 5x5 Risk Matrix

| Likelihood / Impact | Negligible (1) | Minor (2) | Moderate (3) | Major (4) | Severe (5) |
|---------------------|:-:|:-:|:-:|:-:|:-:|
| **Almost Certain (5)** | 5 | 10 | 15 | 20 | **25** |
| **Likely (4)** | 4 | 8 | 12 | **16** | **20** |
| **Possible (3)** | 3 | 6 | **9** | **12** | **15** |
| **Unlikely (2)** | 2 | 4 | 6 | 8 | 10 |
| **Rare (1)** | 1 | 2 | 3 | 4 | 5 |

> Color key: Green (1-4 Low) | Yellow (5-9 Medium) | Orange (10-15 High) | Red (16-25 Critical)

### Inherent Risk Assessment

| # | Domain | Likelihood | Impact | Inherent Score | Level |
|---|--------|:---:|:---:|:---:|-------|
| 1 | Information Security Program | [L] | [I] | [SCORE] | [LEVEL] |
| 2 | Access Control | [L] | [I] | [SCORE] | [LEVEL] |
| 3 | Data Security & Encryption | [L] | [I] | [SCORE] | [LEVEL] |
| 4 | Network Security | [L] | [I] | [SCORE] | [LEVEL] |
| 5 | Vulnerability Management | [L] | [I] | [SCORE] | [LEVEL] |
| 6 | Compliance & Legal | [L] | [I] | [SCORE] | [LEVEL] |
| 7 | Governance & Risk Management | [L] | [I] | [SCORE] | [LEVEL] |
| 8 | Business Continuity & Disaster Recovery | [L] | [I] | [SCORE] | [LEVEL] |
| 9 | Incident Management | [L] | [I] | [SCORE] | [LEVEL] |
| 10 | Operations Security | [L] | [I] | [SCORE] | [LEVEL] |
| 11 | Human Resources Security | [L] | [I] | [SCORE] | [LEVEL] |
| 12 | Physical Security | [L] | [I] | [SCORE] | [LEVEL] |
| 13 | Supply Chain / Third-Party Risk | [L] | [I] | [SCORE] | [LEVEL] |
| 14 | AI / Machine Learning Risk | [L] | [I] | [SCORE] | [LEVEL] |
| 15 | Privacy | [L] | [I] | [SCORE] | [LEVEL] |

### Control Effectiveness and Residual Risk

| # | Domain | Inherent Score | Control Effectiveness | Residual Score | Delta |
|---|--------|:---:|:---:|:---:|:---:|
| 1 | Information Security Program | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 2 | Access Control | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 3 | Data Security & Encryption | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 4 | Network Security | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 5 | Vulnerability Management | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 6 | Compliance & Legal | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 7 | Governance & Risk Management | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 8 | Business Continuity & Disaster Recovery | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 9 | Incident Management | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 10 | Operations Security | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 11 | Human Resources Security | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 12 | Physical Security | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 13 | Supply Chain / Third-Party Risk | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 14 | AI / Machine Learning Risk | [SCORE] | [EFF]% | [SCORE] | [DELTA] |
| 15 | Privacy | [SCORE] | [EFF]% | [SCORE] | [DELTA] |

### Weighted Composite Score

| # | Domain | Residual Score (1-5) | Weight ([TIER] Tier) | Weighted Score |
|---|--------|:---:|:---:|:---:|
| 1 | Information Security Program | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 2 | Access Control | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 3 | Data Security & Encryption | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 4 | Network Security | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 5 | Vulnerability Management | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 6 | Compliance & Legal | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 7 | Governance & Risk Management | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 8 | Business Continuity & Disaster Recovery | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 9 | Incident Management | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 10 | Operations Security | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 11 | Human Resources Security | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 12 | Physical Security | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 13 | Supply Chain / Third-Party Risk | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 14 | AI / Machine Learning Risk | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| 15 | Privacy | [SCORE] | [WEIGHT]% | [WEIGHTED] |
| | **Composite Score** | | **100%** | **[OVERALL_RISK_SCORE]** |

### FAIR Quantitative Analysis

> *Include for Critical and High tier vendors only. Remove for Medium and Low tier.*

| FAIR Component | Estimate | Confidence | Assumptions |
|---------------|----------|:---:|-------------|
| Threat Event Frequency (TEF) | [ESTIMATE] per year | [CONFIDENCE] | [ASSUMPTIONS] |
| Vulnerability (Vuln) | [ESTIMATE]% | [CONFIDENCE] | [ASSUMPTIONS] |
| Loss Event Frequency (LEF) | [ESTIMATE] per year | [CONFIDENCE] | [ASSUMPTIONS] |
| Primary Loss Magnitude (PLM) | [RANGE] | [CONFIDENCE] | [ASSUMPTIONS] |
| Secondary Loss Magnitude (SLM) | [RANGE] | [CONFIDENCE] | [ASSUMPTIONS] |

**Annual Loss Expectancy (ALE):**

| Percentile | ALE |
|:---:|----:|
| 10th | [ALE_10] |
| 50th | [ALE_50] |
| 90th | [ALE_90] |

---

## 6. Comparative Analysis

### Peer Comparison

> *Compare against other assessed vendors in the same category. Use anonymized names if required.*

| Domain | [VENDOR_NAME] | Peer Average | Peer Best | Notes |
|--------|:---:|:---:|:---:|-------|
| Information Security Program | [SCORE] | [AVG] | [BEST] | [NOTES] |
| Access Control | [SCORE] | [AVG] | [BEST] | [NOTES] |
| Data Security & Encryption | [SCORE] | [AVG] | [BEST] | [NOTES] |
| [CONTINUE_FOR_RELEVANT_DOMAINS] | | | | |

### External Security Ratings

> *Include if external rating data is available. Remove if not.*

| Platform | Score | Grade | Date | Notes |
|----------|:-----:|:-----:|------|-------|
| BitSight | [SCORE] | [GRADE] | [DATE] | [NOTES] |
| SecurityScorecard | [SCORE] | [GRADE] | [DATE] | [NOTES] |
| [OTHER_PLATFORM] | [SCORE] | [GRADE] | [DATE] | [NOTES] |

### Trend Analysis

> *Include if vendor has been previously assessed. Remove if first assessment.*

| Domain | Prior Rating ([PRIOR_DATE]) | Current Rating | Trend | Notes |
|--------|:---:|:---:|:---:|-------|
| [DOMAIN] | [PRIOR_RATING] | [CURRENT_RATING] | [IMPROVING/STABLE/DECLINING] | [NOTES] |

### Prior Remediation Status

> *Include if vendor had prior remediation items. Remove if first assessment.*

| Prior Item | Status | Notes |
|-----------|--------|-------|
| [PRIOR_ITEM_1] | [COMPLETED/PARTIAL/OPEN] | [NOTES] |
| [PRIOR_ITEM_2] | [COMPLETED/PARTIAL/OPEN] | [NOTES] |

---

## 7. Remediation Plan

**Total Items:** [TOTAL_COUNT] (Now: [NOW_COUNT] | Next: [NEXT_COUNT] | Later: [LATER_COUNT])

### Now (0-30 Days)

> Critical and high-severity items.

| ID | Title | Domain | Severity | Required Action | SLA | Owner |
|----|-------|--------|----------|----------------|-----|-------|
| [ID] | [TITLE] | [DOMAIN] | [SEVERITY] | [ACTION] | [SLA] | [OWNER] |
| [ID] | [TITLE] | [DOMAIN] | [SEVERITY] | [ACTION] | [SLA] | [OWNER] |

### Next (30-90 Days)

> Medium-severity items and conditions for continued approval.

| ID | Title | Domain | Severity | Required Action | SLA | Owner |
|----|-------|--------|----------|----------------|-----|-------|
| [ID] | [TITLE] | [DOMAIN] | [SEVERITY] | [ACTION] | [SLA] | [OWNER] |
| [ID] | [TITLE] | [DOMAIN] | [SEVERITY] | [ACTION] | [SLA] | [OWNER] |

### Later (90-180 Days)

> Low-severity items and best-practice improvements.

| ID | Title | Domain | Severity | Required Action | SLA | Owner |
|----|-------|--------|----------|----------------|-----|-------|
| [ID] | [TITLE] | [DOMAIN] | [SEVERITY] | [ACTION] | [SLA] | [OWNER] |
| [ID] | [TITLE] | [DOMAIN] | [SEVERITY] | [ACTION] | [SLA] | [OWNER] |

### Compensating Controls

| ID | Remediation Ref | Control | Owner | Expiration |
|----|----------------|---------|-------|-----------|
| CC-[NUM] | [REM_ID] | [CONTROL] | [OWNER] | [DATE] |

### Escalation Path

1. **First:** [NAME], [TITLE]
2. **Second:** [NAME], [TITLE]
3. **Final:** [NAME], [TITLE]

---

## 8. Recommendation

### Decision

**Recommendation: [RECOMMENDATION]** (Approve / Conditional Approve / Deny)

**Overall Residual Risk Score:** [OVERALL_RISK_SCORE] / 5.0 ([RISK_LEVEL])

[RECOMMENDATION_NARRATIVE — 2-3 sentences explaining the basis for the recommendation, referencing key findings and the composite risk score.]

### Conditions

> *Remove this subsection if recommendation is Approve or Deny.*

| # | Condition | Remediation Ref | SLA | Consequence if Not Met |
|---|-----------|----------------|-----|----------------------|
| 1 | [CONDITION_1] | [REM_ID] | [SLA] | [CONSEQUENCE] |
| 2 | [CONDITION_2] | [REM_ID] | [SLA] | [CONSEQUENCE] |

### Review Cadence

| Field | Detail |
|-------|--------|
| **Standard Review Cycle** | [REVIEW_CYCLE] (Annual / Biennial / Triennial) |
| **Next Scheduled Assessment** | [NEXT_REVIEW_DATE] |
| **Early Review Triggers** | [TRIGGERS] (e.g., data breach, M&A, scope change) |

### Sign-Off

| Role | Name | Title | Date |
|------|------|-------|------|
| Assessor | [ASSESSOR_NAME] | [ASSESSOR_TITLE] | [DATE] |
| Reviewer | [REVIEWER_NAME] | [REVIEWER_TITLE] | [DATE] |
| Approval Authority | [APPROVER_NAME] | [APPROVER_TITLE] | [DATE] |

---

## Appendix A: Regulatory Mapping

| Finding/Gap ID | Domain | Regulation | Requirement | Status |
|---------------|--------|-----------|-------------|--------|
| [ID] | [DOMAIN] | [REGULATION] | [REQUIREMENT] | [MET/PARTIAL/NOT MET] |
| [ID] | [DOMAIN] | [REGULATION] | [REQUIREMENT] | [MET/PARTIAL/NOT MET] |

---

## Appendix B: Evidence Inventory

| # | Evidence Type | Document Name | Date | Tier | Domains Covered |
|---|--------------|---------------|------|:---:|----------------|
| 1 | [TYPE] | [NAME] | [DATE] | [TIER] | [DOMAINS] |
| 2 | [TYPE] | [NAME] | [DATE] | [TIER] | [DOMAINS] |

---

## Appendix C: Acronyms and Definitions

| Acronym | Definition |
|---------|------------|
| ALE | Annual Loss Expectancy |
| BCP | Business Continuity Plan |
| CAIQ | Consensus Assessments Initiative Questionnaire |
| DR | Disaster Recovery |
| FAIR | Factor Analysis of Information Risk |
| MFA | Multi-Factor Authentication |
| RTO | Recovery Time Objective |
| RPO | Recovery Point Objective |
| SIG | Standardized Information Gathering |
| SLA | Service Level Agreement |
| SOC | System and Organization Controls |
| VRA | Vendor Risk Assessment |
| [ADD_PROJECT_SPECIFIC_ACRONYMS] | [DEFINITION] |
