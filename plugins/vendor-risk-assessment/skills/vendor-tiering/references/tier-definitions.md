# Vendor Tier Definitions

## Tier Overview

Vendor tiering determines the depth of assessment, monitoring cadence, and contractual requirements applied to each vendor relationship. Tiering is based on data sensitivity, business criticality, integration depth, and regulatory exposure.

---

## Tier 1: Critical

### Criteria

- Processes or stores Restricted or Confidential data (PHI, PCI, PII at scale, credentials)
- Direct integration with production systems or infrastructure
- Single point of failure for a core business process
- Regulatory obligation tied to vendor performance (e.g., HIPAA BAA, PCI DSS service provider)
- Breach at vendor would trigger regulatory notification obligations
- Revenue impact of vendor failure exceeds defined threshold (typically >5% annual revenue)

### Assessment Requirements

- **Domains assessed:** All 8 domains (Security Governance, Access Control, Data Protection, Infrastructure Security, Application Security, Incident Response, Business Continuity, Compliance)
- **Depth:** Full evidence-based assessment with artifact review
- **Evidence required:** SOC 2 Type II, penetration test reports, BCP/DR test results, security policies, insurance certificates, data flow diagrams
- **On-site/virtual assessment:** Required annually
- **SIG/SIG Lite:** Full SIG questionnaire

### Monitoring Cadence

- Continuous monitoring via security ratings platform (BitSight, SecurityScorecard)
- Full reassessment annually
- Quarterly business review with security agenda item
- Real-time breach notification monitoring
- Annual penetration test report review

### Contract Requirements

- Data Processing Agreement (DPA) with specific security schedule
- Right to audit clause (on-site and remote)
- Breach notification within 24 hours
- Cyber insurance minimums specified
- Security SLAs with remediation timelines
- Subprocessor notification and approval rights
- Data return/destruction obligations with certification
- Business continuity and disaster recovery commitments with RTOs/RPOs

### Examples

- Cloud infrastructure providers (AWS, Azure, GCP)
- EHR/EMR systems (for healthcare)
- Payment processors
- Core banking platforms
- Identity providers (Okta, Azure AD)
- Primary CRM holding customer PII (Salesforce)

---

## Tier 2: High

### Criteria

- Processes or stores Confidential data in moderate volume
- Integration with internal systems but not sole dependency
- Supports a significant business function with available alternatives
- Some regulatory relevance but not primary compliance dependency
- Breach would cause significant but manageable impact

### Assessment Requirements

- **Domains assessed:** Security Governance, Access Control, Data Protection, Incident Response, Compliance (5 of 8 domains)
- **Depth:** Questionnaire-based with selective evidence review
- **Evidence required:** SOC 2 Type II or ISO 27001 certificate, penetration test summary, data handling documentation
- **On-site/virtual assessment:** Virtual assessment recommended, on-site optional
- **SIG/SIG Lite:** SIG Lite questionnaire

### Monitoring Cadence

- Continuous monitoring via security ratings platform
- Full reassessment every 18 months
- Semi-annual check-in with security topics
- Breach notification monitoring

### Contract Requirements

- Data Processing Agreement (DPA)
- Audit rights clause (remote)
- Breach notification within 48 hours
- Security standards adherence clause
- Subprocessor notification rights
- Data return/destruction obligations

### Examples

- SaaS HR platforms (Workday, BambooHR)
- Marketing automation with customer data (HubSpot, Marketo)
- Collaboration tools with file sharing (Slack, Microsoft Teams)
- Secondary cloud services with data access
- Managed security service providers

---

## Tier 3: Medium

### Criteria

- Processes or stores Internal data only
- Limited or no direct system integration
- Supports operational efficiency but not a core business function
- Minimal regulatory exposure
- Breach impact limited to internal operations

### Assessment Requirements

- **Domains assessed:** Security Governance, Data Protection, Compliance (3 of 8 domains)
- **Depth:** Self-attestation questionnaire with spot-check verification
- **Evidence required:** ISO 27001 or SOC 2 certificate (either type), privacy policy review
- **On-site/virtual assessment:** Not required
- **SIG/SIG Lite:** Custom lightweight questionnaire (20-30 questions)

### Monitoring Cadence

- Periodic security rating checks (quarterly)
- Reassessment every 24 months
- Annual contract review with security considerations
- Breach notification monitoring (passive)

### Contract Requirements

- Standard terms with security addendum
- Confidentiality/NDA
- Breach notification within 72 hours
- General security standards clause
- Data handling restrictions

### Examples

- Project management tools (Jira, Asana)
- Internal communication tools (limited data)
- Office productivity suites (Google Workspace, Microsoft 365 for non-sensitive use)
- Travel booking platforms
- Expense management tools

---

## Tier 4: Low

### Criteria

- Accesses only Public data or no data at all
- No system integration or network access
- Easily replaceable commodity service
- No regulatory implications
- Breach has negligible business impact

### Assessment Requirements

- **Domains assessed:** Basic security hygiene review only
- **Depth:** Automated assessment or web presence review
- **Evidence required:** Privacy policy exists, basic security posture (HTTPS, etc.)
- **On-site/virtual assessment:** Not required
- **SIG/SIG Lite:** Not required

### Monitoring Cadence

- Annual automated security rating check
- Reassessment every 36 months or at contract renewal
- No active monitoring required

### Contract Requirements

- Standard terms of service review
- NDA if any proprietary information shared
- Basic data handling clause
- Standard vendor terms acceptable

### Examples

- Office supply vendors
- Catering and facilities services
- Public SaaS tools with no data upload (website analytics on public site)
- Consulting firms with no system access
- Event management platforms (no attendee PII)

---

## Tier Escalation Triggers

A vendor should be escalated to a higher tier when any of the following occur:

| Trigger | Action |
|---|---|
| Vendor begins processing a higher data classification level | Reassess tier based on new data classification |
| New system integration or API connection established | Evaluate integration depth and escalate if production systems involved |
| Vendor becomes single point of failure for a process | Escalate to at least Tier 2 |
| Regulatory change increases compliance obligations | Reassess against new regulatory requirements |
| Vendor experiences a material security incident | Immediate reassessment; temporary escalation to next tier |
| Scope of services expands significantly | Reassess based on expanded scope |
| Vendor acquires or merges with another entity | Reassess entire relationship |

## Tier De-escalation Triggers

A vendor may be de-escalated to a lower tier when:

| Trigger | Action |
|---|---|
| Data classification of processed data decreases | Reassess after confirming data migration/deletion |
| System integration removed or reduced | Verify no residual access before de-escalation |
| Alternative vendors established reducing dependency | Document alternatives and update BCP |
| Scope of services reduced | Reassess based on reduced scope |
| Regulatory obligations no longer apply | Confirm with legal/compliance before de-escalation |

De-escalation requires sign-off from the risk owner and must be documented with justification.
