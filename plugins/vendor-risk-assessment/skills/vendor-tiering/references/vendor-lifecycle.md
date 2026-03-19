# Vendor Risk Management Lifecycle

## Overview

The vendor risk management lifecycle consists of five phases that ensure security considerations are integrated from initial vendor evaluation through relationship termination. Each phase has specific activities, deliverables, and approval gates.

---

## Phase 1: Pre-Engagement

### Purpose

Identify and evaluate security risks before committing to a vendor relationship. Establish security expectations early to avoid costly rework or unacceptable risk acceptance later.

### RFP Security Requirements

Include the following security sections in every RFP for vendors that will handle Confidential or Restricted data:

**Mandatory RFP Security Questions:**

1. **Certifications and Attestations**
   - List current security certifications (SOC 2, ISO 27001, PCI DSS, HITRUST, FedRAMP)
   - Provide dates and scope of most recent audits
   - Share any qualified findings or exceptions

2. **Data Protection**
   - Describe encryption capabilities (at rest, in transit, key management)
   - Describe data isolation architecture (single-tenant vs. multi-tenant)
   - Provide data residency and sovereignty options
   - Describe data backup and recovery capabilities

3. **Access Control**
   - Describe authentication mechanisms (SSO, MFA support)
   - Describe authorization model (RBAC, ABAC)
   - Describe privileged access management practices

4. **Incident Response**
   - Provide incident response plan summary
   - Describe breach notification process and committed timelines
   - Share history of security incidents in the past 3 years (if any)

5. **Business Continuity**
   - Provide RTO and RPO commitments
   - Describe DR architecture and geographic redundancy
   - Share results of most recent DR test

6. **Subprocessors**
   - List all sub-processors that would have access to our data
   - Describe sub-processor oversight and approval process

### Preliminary Risk Assessment

Before proceeding to due diligence, conduct a preliminary risk assessment:

1. **Determine preliminary tier** based on anticipated data classification and business criticality
2. **Identify regulatory requirements** applicable to the vendor relationship
3. **Check security ratings** (BitSight, SecurityScorecard) for initial posture assessment
4. **Review public breach history** and security reputation
5. **Assess geographic risk** based on vendor operations and data processing locations
6. **Identify potential deal-breakers** early (e.g., no SOC 2, data processed in high-risk jurisdiction)

**Deliverables:**
- Preliminary risk rating (Critical/High/Medium/Low)
- Preliminary tier assignment
- Go/No-Go recommendation for proceeding to due diligence
- List of specific concerns to investigate during due diligence

**Approval Gate:** Risk owner approval to proceed to Phase 2

---

## Phase 2: Due Diligence

### Purpose

Conduct a thorough assessment of the vendor's security posture commensurate with the assigned tier. Collect and evaluate evidence to inform the risk decision.

### Full Assessment Workflow

#### Step 1: Scoping (Days 1-3)

- Confirm vendor tier assignment
- Determine applicable assessment domains based on tier
- Select appropriate questionnaire (SIG, SIG Lite, custom lightweight)
- Identify specific evidence requirements
- Establish assessment timeline and vendor point of contact

#### Step 2: Questionnaire Distribution (Days 3-5)

- Send questionnaire with clear instructions and deadline
- Provide list of required evidence artifacts
- Schedule kickoff call to walk vendor through expectations
- Set follow-up reminders

#### Step 3: Response Review (Days 15-25)

- Review questionnaire responses for completeness
- Identify gaps, inconsistencies, or concerning responses
- Cross-reference responses with evidence artifacts
- Compare responses against security ratings data
- Document findings by assessment domain

#### Step 4: Evidence Collection and Validation (Days 20-30)

For Tier 1 (Critical) vendors, collect and validate:

| Evidence Type | What to Look For |
|---|---|
| SOC 2 Type II Report | Scope covers relevant services; review exceptions and complementary user entity controls; verify report is current (within 12 months) |
| Penetration Test Report | Scope covers relevant systems; review critical/high findings and remediation status; verify test is current (within 12 months) |
| BCP/DR Test Results | Verify RTO/RPO were met; review test scope and realism; confirm geographic redundancy |
| Security Policies | Review access control, data protection, incident response, acceptable use; verify policies are current and approved |
| Insurance Certificates | Verify cyber insurance coverage and limits; confirm coverage types (first-party, third-party, regulatory) |
| Data Flow Diagrams | Verify accuracy against stated architecture; identify all data processing locations and parties |
| Vulnerability Management Report | Review scan frequency, patching cadence, open critical/high vulnerabilities |

#### Step 5: Risk Analysis and Findings (Days 25-35)

- Score each assessment domain using the risk rating methodology
- Identify findings and classify by severity (Critical, High, Medium, Low)
- Determine overall risk rating
- Identify required remediation items vs. accepted risks
- Draft risk assessment report

#### Step 6: Risk Decision (Days 35-40)

- Present findings to risk owner and stakeholders
- Document risk acceptance decisions with business justification
- Identify compensating controls for accepted risks
- Obtain formal sign-off from appropriate authority:
  - **Critical risk:** CISO or equivalent
  - **High risk:** Security leadership
  - **Medium risk:** Risk owner
  - **Low risk:** Assessor

**Deliverables:**
- Completed risk assessment report
- Findings register with severity ratings
- Risk acceptance documentation (if applicable)
- Remediation plan for identified gaps
- Formal approval or rejection decision

**Approval Gate:** Risk decision sign-off at appropriate authority level

---

## Phase 3: Onboarding

### Purpose

Implement security controls, establish monitoring, and document the vendor relationship before production data access begins.

### Security Controls Implementation

#### Network and Access Controls

- Configure SSO integration if supported
- Enable MFA for all vendor access points
- Implement IP allowlisting where applicable
- Configure VPN or private connectivity if required
- Set up dedicated service accounts with least privilege
- Document all access grants in access management system

#### Data Protection Controls

- Configure encryption settings (at rest, in transit)
- Implement DLP rules for data shared with vendor
- Set up data classification labels/tags for vendor-bound data
- Configure data loss prevention monitoring
- Enable audit logging for all data access

#### Monitoring and Alerting

- Enroll vendor in continuous monitoring platform
- Configure security rating alert thresholds
- Set up breach notification monitoring
- Enable anomaly detection for vendor access patterns
- Configure SIEM rules for vendor-related events

### Data Flow Documentation

Before production data flows to the vendor, document:

1. **Complete data inventory** - Every data element shared, with classification
2. **Data flow diagrams** - Visual representation of all data movements
3. **Integration architecture** - Technical details of system connections
4. **Access matrix** - Who at the vendor can access what data
5. **Data processing locations** - All geographic locations where data is processed or stored
6. **Sub-processor data flows** - Data shared onward to sub-processors
7. **Backup and recovery flows** - Where backups are stored and how recovery works

### Onboarding Checklist

- [ ] Contract fully executed with security schedule
- [ ] DPA signed (if applicable)
- [ ] SSO/MFA configured and tested
- [ ] Access provisioned per least privilege
- [ ] DLP rules configured
- [ ] Continuous monitoring enrolled
- [ ] Data flow documentation completed
- [ ] Emergency contacts exchanged (security incident, business escalation)
- [ ] Vendor added to vendor inventory/register
- [ ] First reassessment date scheduled
- [ ] Onboarding security review meeting completed

**Deliverables:**
- Completed onboarding checklist
- Data flow documentation package
- Access provisioning records
- Monitoring configuration confirmation
- Vendor register entry

**Approval Gate:** Security team sign-off before production data access

---

## Phase 4: Ongoing Management

### Purpose

Continuously monitor vendor security posture, conduct periodic reassessments, and manage changes to the vendor relationship.

### Reassessment Schedule

| Vendor Tier | Full Reassessment | Interim Review | Continuous Monitoring |
|---|---|---|---|
| Tier 1 (Critical) | Annually | Quarterly | Real-time |
| Tier 2 (High) | Every 18 months | Semi-annually | Real-time |
| Tier 3 (Medium) | Every 24 months | Annually | Quarterly checks |
| Tier 4 (Low) | Every 36 months | At contract renewal | Annual checks |

### Reassessment Triggers

The following events trigger an immediate out-of-cycle reassessment regardless of schedule:

| Trigger | Required Response |
|---|---|
| Vendor reports a security incident/breach | Immediate incident assessment; full reassessment within 30 days |
| Significant security rating drop (>20 points) | Investigation within 5 business days; reassessment if confirmed |
| Vendor announces major infrastructure change | Assess impact; reassessment if material |
| Scope of services changes materially | Re-tier and reassess based on new scope |
| New regulatory requirement applies | Assess compliance gap; targeted reassessment |
| Vendor M&A activity | Full reassessment within 60 days of close |
| Vendor leadership change (CISO departure) | Monitor for impact; targeted review if concerns |
| Sub-processor change notification | Assess new sub-processor; update documentation |
| Failed audit or lost certification | Immediate impact assessment; remediation plan required |

### Change Management

When changes occur in the vendor relationship:

1. **Document the change** - What changed, when, who approved
2. **Assess the impact** - Does the change affect tier, risk rating, or controls?
3. **Update documentation** - Data flows, access matrix, vendor register
4. **Communicate** - Notify stakeholders of material changes
5. **Re-tier if needed** - Changes may warrant tier escalation or de-escalation

### Performance and Risk Metrics

Track and report on:

- Security rating trend over time
- Open findings and remediation progress
- SLA compliance (especially security-related SLAs)
- Incident history and response quality
- Questionnaire response timeliness
- Sub-processor changes
- Access review completion
- Contract compliance

**Deliverables:**
- Periodic reassessment reports
- Updated risk ratings
- Remediation tracking updates
- Change documentation
- Metrics dashboard/reporting

---

## Phase 5: Offboarding / Exit

### Purpose

Ensure secure termination of the vendor relationship with complete data return/destruction, access revocation, and knowledge capture.

### Data Return and Destruction

1. **Identify all data** held by the vendor, including backups, logs, and derived data
2. **Request data export** in agreed-upon format per contract terms
3. **Validate exported data** for completeness and integrity
4. **Request data destruction** for all remaining data
5. **Obtain destruction certificate** confirming:
   - Date of destruction
   - Method of destruction (cryptographic erasure, physical destruction, secure deletion)
   - Scope of destruction (primary storage, backups, logs, archives)
   - Attestation signed by authorized vendor representative
6. **Confirm sub-processor destruction** - Ensure sub-processors also destroy data
7. **Retain destruction certificate** per record retention requirements

### Access Revocation

1. **Revoke all vendor access** to organization systems immediately
   - Disable SSO/SAML connections
   - Revoke API keys and tokens
   - Remove VPN access
   - Disable service accounts
   - Remove IP allowlist entries
2. **Revoke organization access** to vendor systems
   - Deactivate user accounts
   - Retrieve any vendor-issued credentials or hardware
3. **Verify revocation** through access audit
4. **Update access management** records
5. **Rotate any shared secrets** or credentials

### Lessons Learned

Conduct a post-relationship review covering:

- **Risk management effectiveness** - Were risks identified and managed appropriately?
- **Incident history** - Were there security incidents, and how well were they handled?
- **Assessment accuracy** - Did the risk assessment accurately predict the actual risk?
- **Contract adequacy** - Were security terms sufficient? What should be improved?
- **Process improvements** - What would we do differently next time?
- **Knowledge transfer** - Document any institutional knowledge about this vendor type

### Offboarding Checklist

- [ ] Data export completed and validated
- [ ] Data destruction confirmed with certificate
- [ ] Sub-processor data destruction confirmed
- [ ] All vendor access to our systems revoked
- [ ] All our access to vendor systems deactivated
- [ ] Shared secrets/credentials rotated
- [ ] SSO/SAML connections removed
- [ ] API integrations decommissioned
- [ ] DLP rules updated/removed
- [ ] Continuous monitoring de-enrolled
- [ ] Vendor register updated (status: terminated)
- [ ] Lessons learned documented
- [ ] Final invoice reconciled
- [ ] Stakeholders notified of termination

---

## Exit Strategy Template

Every Tier 1 and Tier 2 vendor must have a documented exit strategy. Review and update annually.

### Exit Strategy Components

**1. Trigger Conditions**

Document conditions that would trigger an exit:
- Unresolved critical security findings
- Material breach of contract terms
- Loss of required certifications
- Regulatory action against vendor
- Vendor financial instability or insolvency
- Acquisition by an unacceptable party
- Strategic business decision to change providers

**2. Alternative Providers**

| Requirement | Primary Alternative | Secondary Alternative |
|---|---|---|
| [Service requirement 1] | [Provider name] | [Provider name] |
| [Service requirement 2] | [Provider name] | [Provider name] |

**3. Transition Plan**

- **Data migration approach** - How data will be migrated to the alternative provider
- **Timeline estimate** - Realistic migration timeline including assessment of new vendor
- **Resource requirements** - Internal and external resources needed
- **Parallel operation period** - Duration of running both vendors simultaneously
- **Testing and validation** - How the new setup will be validated before cutover

**4. Exit SLAs by Tier**

| Activity | Tier 1 SLA | Tier 2 SLA |
|---|---|---|
| Data export delivery | Within 30 days of request | Within 45 days of request |
| Data destruction certification | Within 60 days of relationship end | Within 90 days of relationship end |
| Transition assistance | 90 days minimum | 60 days minimum |
| Access revocation (our systems) | Within 24 hours of termination | Within 48 hours of termination |
| Access revocation (vendor systems) | Within 72 hours of termination | Within 72 hours of termination |

**5. Communication Plan**

- Internal stakeholders to notify
- Regulatory notifications required (if any)
- Customer communications (if vendor change affects service)
- Timeline for communications relative to transition
