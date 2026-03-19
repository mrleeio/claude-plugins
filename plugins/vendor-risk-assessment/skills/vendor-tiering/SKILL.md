---
name: vendor-tiering
description: Classify vendors into Critical/High/Medium/Low tiers driving assessment depth, cadence, and monitoring requirements. Trigger phrases include "vendor tier", "classify vendor", "vendor classification", "vendor lifecycle", "data classification". (user)
---

# Vendor Tiering

Classify vendors into tiers that determine assessment depth, cadence, monitoring requirements, and lifecycle management.

## Quick Reference

### Tier Definitions

| Tier | Criteria | Assessment Depth | Cadence | Examples |
|------|----------|-----------------|---------|---------|
| **Critical** | Processes sensitive data AND business-critical AND difficult to replace | Full 15-domain assessment + FAIR | Annual + continuous monitoring | Cloud infrastructure, EHR, payment processor |
| **High** | Processes sensitive data OR business-critical | Full 15-domain assessment | Annual | Email provider, CRM with PII, SIEM |
| **Medium** | Limited sensitive data, replaceable, moderate business impact | Focused assessment (8-10 key domains) | Biennial | Project management, analytics, CI/CD |
| **Low** | No sensitive data, easily replaceable, minimal business impact | Lightweight questionnaire | Triennial or on renewal | Office supplies, marketing tools (no PII) |

### Tier Decision Matrix

| Factor | Critical (4) | High (3) | Medium (2) | Low (1) |
|--------|:-:|:-:|:-:|:-:|
| **Data Sensitivity** | Regulated PII, PHI, financial, credentials | PII, business confidential | Internal, limited PII | Public, non-sensitive |
| **Business Criticality** | Core operations halt without vendor | Significant disruption | Inconvenient but workarounds exist | Minimal impact |
| **Replaceability** | 6+ months to replace, high switching cost | 3-6 months, moderate cost | 1-3 months, manageable | Weeks, low cost |
| **Integration Depth** | Deep API/data integration, shared infrastructure | Moderate integration | Light integration, SSO only | Standalone, no integration |
| **Regulatory Exposure** | Directly subject to regulations (HIPAA, PCI, SOX) | Indirectly supports compliance | Limited regulatory relevance | No regulatory impact |

**Scoring:** Sum the factor scores. Critical ≥ 16, High ≥ 12, Medium ≥ 8, Low < 8.

### Data Classification

| Level | Description | Examples | Handling Requirements |
|-------|-------------|----------|----------------------|
| **Restricted** | Highest sensitivity, regulatory requirements | PHI, PCI data, credentials, encryption keys | Encryption required, access logging, DLP, minimal retention |
| **Confidential** | Business-sensitive, limited distribution | PII, financial data, trade secrets, contracts | Encryption at rest + transit, RBAC, audit trails |
| **Internal** | For internal use, not public | Internal comms, project data, employee info | Access controls, no public sharing |
| **Public** | No sensitivity, freely shareable | Marketing content, public docs, open-source | No special handling |

## Vendor Lifecycle Management

### Phase 1: Pre-Engagement

- Vendor identification and business case
- Preliminary risk assessment (tier determination)
- Data classification of data to be shared
- Regulatory applicability check
- Security requirements in RFP/RFI

### Phase 2: Due Diligence

- Full risk assessment per tier requirements
- Evidence collection and verification
- Risk scoring (qualitative + quantitative for Critical/High)
- Remediation planning for identified gaps
- Contract negotiation (security addendum, DPA, SLAs)

### Phase 3: Onboarding

- Security controls implementation (SSO, access provisioning)
- Data flow documentation
- Integration security review
- Monitoring enrollment per tier
- Incident response coordination plan

### Phase 4: Ongoing Management

- Periodic reassessment per tier cadence
- Continuous monitoring per tier requirements
- Contract and certification renewal tracking
- Performance against SLAs
- Change management (vendor acquisitions, service changes)

### Phase 5: Offboarding / Exit Strategy

- Data return/destruction verification
- Access revocation confirmation
- Certificate/key rotation for shared credentials
- Sub-processor notification
- Lessons learned documentation
- Replacement vendor assessment (if applicable)

**Exit Strategy Requirements by Tier:**

| Tier | Exit Plan Required | Data Return SLA | Access Revocation SLA |
|------|:-:|:-:|:-:|
| Critical | Mandatory, tested annually | 30 days | 24 hours |
| High | Required | 60 days | 48 hours |
| Medium | Recommended | 90 days | 1 week |
| Low | Optional | Best effort | 2 weeks |

## Do

- Reassess tier when vendor scope changes (new data types, deeper integration)
- Document tier justification with specific factors and scores
- Include exit strategy planning for Critical and High tier vendors
- Consider concentration risk in tiering (single points of failure)
- Update tier if vendor is acquired or undergoes significant changes

## Don't

- Auto-assign tiers without the decision matrix
- Treat all SaaS vendors as the same tier
- Forget to tier shadow IT and unofficial vendor usage
- Skip lifecycle phases — each phase builds on the previous
- Ignore exit strategy for Critical vendors

## Common Mistakes

1. **Under-tiering due to "small vendor" bias** — A 5-person SaaS startup processing your PHI is still Critical tier
2. **Not considering integration depth** — A vendor with deep API access is higher risk than a standalone tool
3. **Forgetting data aggregation** — A vendor with "just email addresses" across all customers has a significant data store
4. **Static tiering** — Tiers should be reassessed when scope, data, or business reliance changes

## See Also

- [Tier Definitions](references/tier-definitions.md) — Detailed tier criteria and assessment requirements
- [Data Classification](references/data-classification.md) — Classification levels and handling requirements
- [Vendor Lifecycle](references/vendor-lifecycle.md) — Phase-by-phase lifecycle management guide
