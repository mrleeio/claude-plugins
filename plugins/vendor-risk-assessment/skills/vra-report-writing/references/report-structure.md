# VRA Report Structure

Detailed guidance for each of the 8 sections that comprise a complete Vendor Risk Assessment report.

---

## 1. Executive Summary

### Purpose
Provide a concise, 1-page overview that enables leadership to understand the vendor risk posture and the assessment recommendation without reading the full report.

### Audience
CISO, security leadership, executive sponsors, and board-level stakeholders who need the bottom line without technical depth.

### Content Requirements
- **Lead with the recommendation** (Approve / Conditional Approve / Deny) in the first sentence
- Overall residual risk score with risk level label (Low / Medium / High / Critical)
- Vendor name, tier classification, and assessment date
- Top 3 risks with brief descriptions (1-2 sentences each)
- Top 3 strengths with brief descriptions (1-2 sentences each)
- Key conditions for conditional approvals
- Next review date based on tier cadence

### Length
- Strictly 1 page (approximately 400-500 words)
- Use bullet points and tables to maximize information density
- No domain-level detail; save that for Section 4

### Tone
- Direct and decisive; avoid hedging language
- Non-technical; translate security concepts for business leaders
- Action-oriented; make the recommendation unmistakable

### Structure
1. Recommendation statement (1 sentence)
2. Risk score summary (brief table or callout)
3. Vendor identification and context (2-3 sentences)
4. Top risks (bulleted list)
5. Top strengths (bulleted list)
6. Conditions and next steps (if applicable)

---

## 2. Vendor Profile

### Purpose
Establish the vendor's identity, the product/service under assessment, and how it integrates with your environment. This section provides the factual foundation for the entire report.

### Content Requirements

#### Company Information
- Legal entity name and any DBA names
- Headquarters location and countries of operation
- Year founded and current employee count
- Publicly traded status (ticker if applicable)
- Recent M&A activity or significant corporate events

#### Product/Service Details
- Specific product or service being assessed (not the entire company)
- Product version or release if relevant
- Core functionality and use case within your organization

#### Deployment Model
- SaaS (single-tenant vs multi-tenant)
- Self-hosted / on-premises
- Hybrid
- Hosting provider and data center locations
- Environment isolation approach

#### Data Flows
- What data your organization sends to the vendor
- What data the vendor returns or generates
- Data classification of each flow (Public / Internal / Confidential / Restricted)
- Data residency and geographic routing
- Narrative or diagram describing the end-to-end flow

#### Integration Points
- APIs, connectors, and protocols used
- Network connectivity requirements (VPN, private link, public internet)
- Authentication mechanisms for integration
- Dependent systems in your environment

#### Key Contacts
- Vendor relationship owner (your side)
- Vendor account manager
- Vendor security contact (if established)

---

## 3. Assessment Scope

### Purpose
Define the boundaries of the assessment, justify the tier classification, and document the methodology used. This section establishes credibility and enables reviewers to evaluate the rigor of the assessment.

### Content Requirements

#### Tier Justification
- Assigned tier: Critical / High / Medium / Low
- Justification criteria applied:
  - Data sensitivity and volume
  - Business process criticality
  - Replaceability and switching cost
  - User population size and scope
- Reference the tiering methodology used

#### Data Classification
- Classification of data shared with or processed by the vendor
- Classification scheme used (e.g., Public / Internal / Confidential / Restricted)
- Volume and sensitivity narrative

#### Applicable Regulations
- List each regulatory framework that applies to this vendor relationship
- Map regulations to the relevant assessment domains
- Note any jurisdiction-specific requirements
- Common frameworks: SOC 2, ISO 27001, GDPR, HIPAA, PCI DSS, CCPA, DORA, NIS2

#### Assessment Methodology
- Frameworks and standards used as the assessment basis
- Questionnaire standard (SIG Lite, SIG Core, CAIQ, custom)
- Evidence collection approach (document review, interviews, technical testing)
- Assessment timeline (start date, completion date)
- Assessor qualifications

#### Exclusions
- Domains or areas explicitly excluded from scope
- Reason for each exclusion
- Impact of exclusion on overall risk rating
- Plans to address excluded areas in future assessments

---

## 4. Domain Findings

### Purpose
Present detailed findings for each of the 15 assessment domains. This is the core analytical section of the report and provides the evidence basis for the risk score and recommendation.

### Per-Domain Format

Each domain section must follow this consistent structure:

```
### [Domain Name]

**Rating:** [1-5] — [Critical Weakness | Significant Gaps | Partial Implementation | Adequate | Strong]
**Evidence Tier:** [1-7] (1 = third-party validated, 7 = no evidence)
**Evidence Sources:** [List of documents, certifications, or attestations reviewed]

#### Findings
- [Specific finding with evidence citation, e.g., "SOC 2 Type II report (2025) confirms annual penetration testing (Ref: CC7.1)"]
- [Additional findings...]

#### Gaps
- [Identified gap or concern, stated as "Risk of [impact] due to [cause]"]
- [Additional gaps...]

#### Compensating Controls
- [Any compensating controls that partially mitigate identified gaps]

#### Follow-Up Questions
- [Questions for the vendor where evidence was insufficient or ambiguous]
- [Additional questions...]
```

### Rating Scale (1-5)

| Rating | Label | Definition |
|--------|-------|------------|
| 1 | Critical Weakness | No controls or fundamentally inadequate controls; immediate risk |
| 2 | Significant Gaps | Controls exist but have major gaps; remediation required |
| 3 | Partial Implementation | Controls partially implemented; some gaps remain |
| 4 | Adequate | Controls meet baseline expectations; minor improvements possible |
| 5 | Strong | Controls exceed expectations; validated by independent third party |

### Evidence Tier Scale (1-7)

| Tier | Description | Confidence |
|------|-------------|------------|
| 1 | Third-party audit/certification (SOC 2, ISO 27001) | Highest |
| 2 | Independent penetration test or technical assessment | High |
| 3 | Vendor-provided documentation with corroboration | Moderate-High |
| 4 | Vendor self-attestation with supporting evidence | Moderate |
| 5 | Vendor self-attestation without supporting evidence | Low-Moderate |
| 6 | Publicly available information only | Low |
| 7 | No evidence provided | Lowest |

### The 15 Assessment Domains

1. Information Security Program
2. Access Control
3. Data Security & Encryption
4. Network Security
5. Vulnerability Management
6. Compliance & Legal
7. Governance & Risk Management
8. Business Continuity & Disaster Recovery
9. Incident Management
10. Operations Security
11. Human Resources Security
12. Physical Security
13. Supply Chain / Third-Party Risk
14. AI / Machine Learning Risk
15. Privacy

### Writing Guidance
- Keep each domain to 1-2 pages maximum
- Lead with the most significant finding or gap
- Always cite the evidence source and tier for every finding
- State gaps using the standard risk format: "Risk of [impact] due to [cause]"
- If evidence is insufficient, say so clearly and add follow-up questions
- Do not repeat information across domains; cross-reference instead

---

## 5. Risk Scoring

### Purpose
Present the quantitative risk assessment using the 5x5 matrix, calculate composite scores, and clearly distinguish between inherent and residual risk.

### Content Requirements

#### Risk Matrix Presentation
- Show the 5x5 risk matrix with the vendor's inherent risk placement highlighted
- Use color coding: Green (1-4), Yellow (5-9), Orange (10-15), Red (16-25)
- Plot each domain on the matrix

#### Inherent Risk Summary Table

| Domain | Likelihood | Impact | Inherent Score | Level |
|--------|:---:|:---:|:---:|-------|
| [Domain] | [1-5] | [1-5] | [L x I] | [Low/Med/High/Critical] |

#### Control Effectiveness Table

| Domain | Inherent Score | Control Effectiveness | Residual Score | Delta |
|--------|:---:|:---:|:---:|:---:|
| [Domain] | [Score] | [Strong/Adequate/Weak/Absent] | [Score] | [Reduction] |

#### Composite Score Calculation
- Show the weighted composite calculation
- Display domain weights used (per the vendor's tier)
- Present the final composite score on a 1-5 scale
- Map composite to overall risk level and recommendation

#### FAIR Analysis (Critical/High Tier Only)
- Loss Event Frequency estimate with confidence interval
- Primary and Secondary Loss Magnitude ranges
- Annual Loss Expectancy at 10th, 50th, and 90th percentiles
- Key assumptions documented

### Presentation Guidelines
- Always show inherent risk BEFORE residual risk
- Clearly label every score as inherent or residual
- Include a visual (matrix or chart) for quick comprehension
- Document all assumptions behind likelihood and impact ratings
- Show the delta between inherent and residual to demonstrate control value

---

## 6. Comparative Analysis

### Purpose
Place the vendor's risk posture in context by benchmarking against similar vendors, industry norms, or security rating platforms. This section helps stakeholders understand whether the vendor's security posture is above, at, or below expectations.

### Content Requirements

#### Peer Benchmarking
- Compare against other vendors in the same category (e.g., CRM, cloud storage, HRIS)
- Use anonymized comparisons if contractual obligations require it
- Highlight domains where the vendor excels vs falls behind peers
- Note sample size and basis for comparison

#### Security Ratings Comparison
- Include external security ratings if available:
  - BitSight score and grade
  - SecurityScorecard overall score and factor grades
  - UpGuard rating
  - Other applicable platforms
- Note the date of the rating snapshot
- Caveat that external ratings are supplementary, not primary assessment data

#### Industry Benchmarking
- Compare against industry baselines (e.g., BSIMM for software security, CIS benchmarks)
- Reference any sector-specific maturity models
- Note where the vendor exceeds or falls below industry median

#### Trend Analysis
- If the vendor has been previously assessed, show trend data
- Highlight improving or deteriorating domains
- Note whether prior remediation items were completed

### Presentation Guidelines
- Use tables for side-by-side comparison
- Keep comparisons fair; compare like-for-like (same tier, similar data sensitivity)
- Clearly label data sources and dates
- State limitations of comparative data (sample size, methodology differences)

---

## 7. Remediation Plan

### Purpose
Translate identified gaps into a prioritized, actionable remediation plan with clear ownership, timelines, and acceptance criteria. This section is the operational output of the assessment.

### Now / Next / Later Framework

#### Now (0-30 days)
- Critical and high-severity findings
- Items blocking approval
- Quick wins that significantly reduce risk
- Required compensating controls for immediate risk reduction

#### Next (30-90 days)
- Medium-severity findings
- Items listed as conditions for continued approval
- Process improvements and documentation gaps
- Control enhancements that require planning

#### Later (90-180 days)
- Low-severity findings
- Best-practice improvements
- Strategic security program enhancements
- Items dependent on vendor roadmap

### Per-Item Format

Each remediation item must include:

| Field | Description |
|-------|-------------|
| Finding ID | Reference to the specific finding in Section 4 |
| Title | Short descriptive title of the remediation item |
| Domain | Which of the 15 domains this relates to |
| Severity | Critical / High / Medium / Low |
| Priority | Now / Next / Later |
| Required Action | Specific, measurable action the vendor must take |
| Compensating Control | Interim control your organization will implement (if applicable) |
| Acceptance Criteria | How completion will be verified |
| SLA | Deadline for completion |
| Owner | Responsible party (vendor contact or internal) |
| Escalation Contact | Who to escalate to if SLA is at risk |

### SLA Guidelines

| Priority | Default SLA | Escalation Trigger |
|----------|-------------|-------------------|
| Now | 30 days | Day 15 with no progress |
| Next | 90 days | Day 45 with no progress |
| Later | 180 days | Day 120 with no progress |

### Compensating Controls
- Document compensating controls for any risk accepted on an interim basis
- Specify the compensating control owner (your organization, not the vendor)
- Set an expiration date; compensating controls are temporary
- Describe the residual risk even with the compensating control in place

---

## 8. Recommendation

### Purpose
State the final assessment recommendation clearly and unambiguously, with all supporting conditions, timelines, and escalation paths.

### Decision Framework

| Overall Residual Risk | Recommendation | Typical Conditions |
|----------------------|----------------|--------------------|
| Low (1.0-2.0) | **Approve** | Standard monitoring per tier |
| Medium (2.1-3.0) | **Conditional Approve** | Specific remediation with SLAs |
| High (3.1-4.0) | **Conditional Approve** | Significant remediation + compensating controls |
| Critical (4.1-5.0) | **Deny** | Remediation required before re-assessment |

### Content Requirements

#### Recommendation Statement
- Exactly one of: Approve, Conditional Approve, Deny
- Stated clearly in the first sentence
- Accompanied by the overall residual risk score

#### Conditions (for Conditional Approve)
- Numbered list of specific conditions
- Each condition cross-referenced to a remediation item in Section 7
- Clear acceptance criteria for each condition
- Consequence of non-compliance (e.g., relationship review, termination clause activation)

#### Review Cadence

| Vendor Tier | Standard Review | Conditional Review |
|-------------|:-:|:-:|
| Critical | Annual | Semi-annual |
| High | Annual | Semi-annual |
| Medium | Biennial | Annual |
| Low | Triennial | Biennial |

#### Next Assessment Date
- Specify the exact date or quarter of the next scheduled assessment
- Note any triggers that would force an earlier review (breach, M&A, scope change)

#### Escalation Path
- Who approves risk acceptance if conditions are not met by SLA
- Decision authority chain (e.g., Security Lead -> CISO -> CRO -> Board)
- Contractual remedies available (termination for cause, penalty clauses)

#### Sign-Off
- Assessor name and title
- Reviewer name and title
- Approval authority name and title
- Date of final approval
