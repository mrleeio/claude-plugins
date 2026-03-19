# Sub-Processor Management

## Overview

Sub-processors are third parties engaged by a vendor (the primary processor) to process data on behalf of your organization. Effective sub-processor management is essential for maintaining visibility into the full data processing chain and ensuring consistent security and privacy standards throughout.

---

## Sub-Processor Discovery and Inventory

### Discovery Methods

1. **Contractual disclosure** - Require vendors to list all sub-processors in the DPA or a referenced schedule. This is the primary and most reliable discovery method.

2. **Vendor questionnaire** - Include sub-processor questions in security assessments:
   - List all sub-processors that will access, process, or store our data
   - For each sub-processor, provide: name, location, service provided, data accessed
   - Describe your sub-processor due diligence process
   - How do you monitor sub-processor security posture?

3. **Public sub-processor lists** - Many vendors publish sub-processor lists on their websites (often required by GDPR). Check vendor trust centers, privacy pages, and DPA appendices.

4. **SOC 2 report review** - SOC 2 Type II reports typically identify sub-service organizations and whether they are included in the scope using the inclusive or carve-out method.

5. **Data flow analysis** - During technical assessment, map actual data flows to identify any data sharing with parties not previously disclosed.

6. **Continuous monitoring** - Monitor vendor communications, trust center updates, and privacy policy changes for sub-processor additions.

### Sub-Processor Inventory Template

For each identified sub-processor, document:

| Field | Description |
|---|---|
| Sub-Processor Name | Legal entity name |
| Parent Company | If subsidiary, identify parent |
| Service Provided | What function they perform |
| Data Accessed | What data types and classifications |
| Data Volume | Approximate volume of data processed |
| Processing Locations | Countries/regions where data is processed |
| Transfer Mechanism | If cross-border, what legal mechanism (SCCs, adequacy, etc.) |
| Certifications | SOC 2, ISO 27001, etc. |
| Criticality | Critical / High / Medium / Low (to the vendor's delivery of service to us) |
| Our Primary Vendor | Which of our vendors uses this sub-processor |
| Risk Assessment Status | Assessed / Not Assessed / Accepted |
| Last Assessed Date | When the sub-processor was last evaluated |
| Contractual Coverage | How sub-processor is covered in our vendor's contract |
| Notes | Any concerns or special considerations |

---

## Assessment Methodology for Sub-Processors

### Tiered Assessment Based on Materiality

Not all sub-processors require the same level of scrutiny. Assess based on materiality to your data and operations:

#### Tier A: Material Sub-Processors

**Definition:** Sub-processors that directly process, store, or have access to your Restricted or Confidential data, or that provide infrastructure critical to the vendor's service delivery.

**Assessment Approach:**
- Request the sub-processor's SOC 2 Type II report or ISO 27001 certificate through your vendor
- Review the primary vendor's SOC 2 report for sub-service organization treatment (inclusive vs. carve-out)
- If carve-out method is used, request Complementary Subservice Organization Controls (CSOCs)
- Assess the sub-processor's security posture via security ratings platform
- Review the vendor's due diligence documentation for this sub-processor
- Include sub-processor risk in the overall vendor risk assessment

**Examples:**
- Cloud infrastructure provider hosting the vendor's platform (AWS, Azure, GCP)
- Database hosting provider storing your data
- Managed security service provider with access to logs containing your data
- Payment processing sub-processor handling your customer transactions

#### Tier B: Significant Sub-Processors

**Definition:** Sub-processors that have limited access to your data (e.g., metadata, anonymized data) or provide important but not critical supporting services.

**Assessment Approach:**
- Verify relevant certifications (SOC 2 or ISO 27001 at minimum)
- Review security rating score
- Confirm contractual flow-down of security requirements
- Include in vendor reassessment cycle

**Examples:**
- Email delivery service that processes recipient addresses
- Analytics platform that receives usage data
- CDN provider that caches content
- Monitoring tools that may capture metadata

#### Tier C: Incidental Sub-Processors

**Definition:** Sub-processors with no access to your data or only access to fully anonymized/aggregated data. Their failure would not directly impact your data security.

**Assessment Approach:**
- Note in sub-processor inventory
- Verify no data access through vendor attestation
- No individual assessment required
- Review at vendor reassessment cycle

**Examples:**
- Vendor's internal HR platform
- Vendor's corporate email provider (no customer data access)
- Vendor's office productivity tools (no customer data access)

---

## Contractual Flow-Down Requirements

### Essential Contract Provisions

Your vendor contract should include the following provisions regarding sub-processors:

#### 1. Sub-Processor Restrictions

- Vendor shall not engage a new sub-processor without prior written notification to Customer
- Notification must be provided at least [30/60/90] days before the new sub-processor begins processing Customer data
- Customer has the right to object to a new sub-processor on reasonable grounds

#### 2. Sub-Processor Due Diligence

- Vendor shall conduct appropriate due diligence on sub-processors before engagement
- Due diligence must include assessment of the sub-processor's security practices, certifications, and data protection capabilities
- Vendor shall make due diligence results available to Customer upon request

#### 3. Contractual Flow-Down

- Vendor shall impose data protection obligations on sub-processors that are no less protective than those in the Customer-Vendor agreement
- Sub-processor contracts must include:
  - Confidentiality obligations
  - Data protection and security requirements
  - Breach notification obligations (with timelines no longer than Vendor's obligations to Customer)
  - Data return/destruction obligations
  - Audit rights (direct or through Vendor)

#### 4. Liability

- Vendor remains fully liable for the acts and omissions of its sub-processors
- Sub-processor breach is treated as Vendor breach for purposes of notification and liability

#### 5. Audit Rights

- Customer has the right to audit sub-processors directly or through Vendor
- Vendor shall facilitate sub-processor audits upon reasonable request
- Vendor shall provide sub-processor audit reports, certifications, or assessment results upon request

---

## GDPR Article 28 Requirements for Sub-Processors

GDPR Article 28(2) and (4) impose specific requirements on the use of sub-processors:

### Prior Authorization

- **General written authorization:** Processor may use sub-processors listed in the DPA schedule. Processor must inform Controller of any intended changes (additions or replacements). Controller must have the opportunity to object.
- **Specific written authorization:** Each sub-processor must be individually approved by the Controller before engagement.
- Determine which authorization model applies and document it in the DPA.

### Contractual Requirements (Article 28(4))

The sub-processor contract must:
- Impose the same data protection obligations as the Controller-Processor contract
- Provide sufficient guarantees to implement appropriate technical and organizational measures
- Ensure processing meets GDPR requirements

### Liability Chain

- The initial Processor (your vendor) remains fully liable to the Controller (your organization) for the sub-processor's performance
- If a sub-processor fails to fulfill its data protection obligations, the Processor is liable to the Controller

### Data Subject Rights

- Sub-processor arrangements must not impede the exercise of data subject rights
- Clear processes must exist for handling data subject requests that involve sub-processor-held data
- Response timelines must account for the sub-processor chain

### Record Keeping

- Maintain records of all sub-processors and their processing activities
- Include sub-processor details in the Record of Processing Activities (ROPA)
- Document the legal basis for each sub-processor's data processing

---

## Sub-Processor Change Notification Workflows

### Notification Receipt Process

When a vendor notifies you of a sub-processor change:

```
Day 0: Notification received
  │
  ├── Log notification in vendor management system
  ├── Identify which vendor tier this affects
  └── Assign to assessor for review
  │
Day 1-5: Initial Assessment
  │
  ├── Identify what data the new sub-processor will access
  ├── Determine data classification level
  ├── Check new sub-processor's security rating
  ├── Review certifications (SOC 2, ISO 27001)
  └── Classify sub-processor materiality (Tier A/B/C)
  │
Day 5-15: Detailed Review (if Tier A or B)
  │
  ├── Request sub-processor security documentation through vendor
  ├── Review data processing locations and transfer mechanisms
  ├── Assess concentration risk impact
  ├── Evaluate impact on overall vendor risk rating
  └── Document findings
  │
Day 15-25: Decision
  │
  ├── Accept: Document acceptance and update sub-processor inventory
  ├── Accept with conditions: Document required controls or contractual amendments
  ├── Object: Initiate objection process (see below)
  └── Update vendor risk assessment if material change
  │
Day 25-30: Documentation
  │
  ├── Update sub-processor inventory
  ├── Update data flow documentation
  ├── Update vendor risk register if applicable
  └── Communicate decision to vendor
```

### Objection Process

If you object to a proposed sub-processor:

1. **Document objection grounds** - Specific, reasonable grounds (e.g., security concerns, data residency issues, concentration risk)
2. **Notify vendor in writing** within the contractual objection period
3. **Propose alternatives** where possible (e.g., different sub-processor, enhanced controls)
4. **Negotiate resolution** - Options include:
   - Vendor uses a different sub-processor
   - Vendor implements additional controls to address concerns
   - Data is excluded from the sub-processor's processing
   - Contractual amendments to address specific risks
5. **Escalation** - If resolution cannot be reached, the contract typically provides for:
   - Vendor proceeds without using the objected sub-processor for your data
   - Termination right without penalty (GDPR-aligned contracts typically provide this)
6. **Document outcome** - Whatever the resolution, document the decision, rationale, and any conditions

---

## Dispute Resolution

### Common Disputes

| Dispute | Resolution Approach |
|---|---|
| Vendor adds sub-processor without notification | Escalate as contractual breach; require immediate disclosure; assess impact; consider whether to exercise audit rights |
| Vendor claims sub-processor change is not material | Review contractual definition of sub-processor; if entity processes any customer data, it qualifies regardless of materiality |
| Sub-processor refuses to cooperate with audit | Exercise rights through primary vendor; vendor is contractually obligated to facilitate or provide alternative assurance |
| Sub-processor has inadequate security posture | Object to sub-processor engagement; require vendor to implement compensating controls or use alternative |
| Sub-processor processes data in prohibited jurisdiction | Immediate objection; assess whether processing has already occurred; if so, assess exposure and notification obligations |
| Multiple vendors use same sub-processor, creating concentration risk | Portfolio-level risk discussion with leadership; may require contractual amendments or diversification strategy |

### Escalation Path

1. **Assessor level:** Attempt resolution with vendor security/privacy contact
2. **Risk owner level:** Engage business relationship owner and vendor management
3. **Security leadership:** Escalate unresolved disputes with documented positions
4. **Legal:** Engage legal counsel for contractual interpretation or enforcement
5. **Executive:** Final escalation for strategic decisions (vendor termination, risk acceptance)
