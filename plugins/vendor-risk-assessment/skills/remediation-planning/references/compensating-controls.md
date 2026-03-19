# Compensating Controls Reference

## Overview

Compensating controls are alternative security measures implemented when a primary control cannot be fully implemented. They must provide a comparable level of risk reduction and are always temporary -- they exist to bridge the gap while the primary control is being implemented or while a risk acceptance decision is being made.

---

## Common Compensating Control Patterns

### Authentication and Access Gaps

| Primary Control Gap | Compensating Controls | Effectiveness |
|---|---|---|
| **MFA not available for vendor platform** | IP allowlisting to corporate egress IPs + enhanced password policy (20+ chars, rotation) + session timeout (15 min) + login anomaly alerting | High - Multiple layers significantly reduce unauthorized access risk |
| **SSO integration not supported** | Dedicated strong passwords managed in enterprise password vault + quarterly access reviews + session monitoring + account lockout policies | Medium - Reduces risk but lacks centralized lifecycle management |
| **No RBAC in vendor platform** | Minimized account provisioning (fewest users possible) + regular access audits + documented access justification + activity logging review | Medium - Limits exposure but lacks granular control |
| **Shared service accounts required** | Privileged access management (PAM) for credential checkout + session recording + dual authorization for sensitive actions + enhanced audit logging | Medium-High - Provides accountability despite shared credential |
| **Vendor admin access too broad** | Time-limited access windows + change management approval for admin actions + enhanced monitoring of admin activity + regular admin access recertification | Medium - Limits exposure window and adds oversight |

### Data Protection Gaps

| Primary Control Gap | Compensating Controls | Effectiveness |
|---|---|---|
| **Encryption at rest not available** | Network segmentation isolating the data store + enhanced access controls (MFA, PAM) + DLP monitoring on all data egress points + database activity monitoring + enhanced audit logging | Medium - Reduces exposure but data remains vulnerable to storage-level compromise |
| **Field-level encryption not supported** | Data minimization (send only required fields) + tokenization of sensitive fields before sending + contractual restrictions on data use + enhanced access controls at application level | High - Tokenization effectively removes sensitive data from vendor environment |
| **No DLP on vendor platform** | Pre-transfer data scanning + contractual data handling restrictions + periodic data inventory audits + endpoint DLP before data leaves organization + vendor access limited to need-to-know | Medium - Prevents some data loss but lacks real-time vendor-side detection |
| **Vendor cannot guarantee data residency** | Contractual data residency requirements with penalties + data flow monitoring + SCCs or other transfer mechanisms in place + regular audit of actual data locations + vendor attestation of compliance | Medium - Contractual protection without technical enforcement |

### Certification and Attestation Gaps

| Primary Control Gap | Compensating Controls | Effectiveness |
|---|---|---|
| **No SOC 2 report available** | ISO 27001 certification + SIG questionnaire with evidence review + independent penetration test report + enhanced contractual security requirements + more frequent reassessment cycle | High - Multiple alternative attestations provide broad coverage |
| **SOC 2 report has qualified findings** | Detailed review of qualified areas + vendor remediation plan with timeline + additional evidence for qualified areas + compensating controls for specific gap areas + interim reassessment scheduled | Medium-High - Depends on nature and severity of qualifications |
| **No penetration test report** | Vulnerability scan results + bug bounty program evidence + application security testing results + secure SDLC documentation + vendor agreement to complete pen test within defined timeline | Medium - Automated testing provides partial coverage but lacks manual testing depth |
| **Certification scope does not cover our services** | Vendor attestation letter covering our services + targeted questionnaire for out-of-scope services + additional evidence for uncovered areas + contractual commitment to expand certification scope | Medium - Attestation is less rigorous than independent certification |

### Infrastructure and Network Gaps

| Primary Control Gap | Compensating Controls | Effectiveness |
|---|---|---|
| **No network segmentation** | Enhanced endpoint protection + micro-segmentation where possible + host-based firewalls + intensive monitoring and alerting + zero-trust network access policies | Medium - Defense-in-depth without proper segmentation |
| **No WAF deployed** | Application-level input validation + rate limiting + enhanced application logging and monitoring + regular application security testing + CDN-based basic protections | Medium - Application-layer controls help but lack WAF-specific protections |
| **Legacy TLS versions in use** | Restrict connections to TLS 1.2+ from our systems + VPN tunnel wrapping legacy connections + monitoring for downgrade attacks + vendor commitment to upgrade timeline | Medium-High - VPN wrapping effectively mitigates transport risk |

### Incident Response Gaps

| Primary Control Gap | Compensating Controls | Effectiveness |
|---|---|---|
| **No formal incident response plan** | Documented escalation contacts + contractual breach notification requirements with short timelines + vendor agreement to participate in joint tabletop exercise + enhanced monitoring of vendor environment from our side | Low-Medium - Reactive rather than proactive; risk remains that incidents are poorly handled |
| **Breach notification timeline exceeds requirements** | Contractual amendment for shorter notification + automated monitoring for vendor breach indicators + enhanced security rating monitoring + vendor agreement to immediate verbal notification pending formal written notice | Medium - Contractual improvement with monitoring backup |

---

## Compensating Control Selection Criteria

When selecting compensating controls, evaluate each option against these criteria:

### 1. Risk Reduction Equivalence

The compensating control must address the same risk that the primary control would address. Ask:
- Does this control mitigate the same threat vector?
- Does it protect the same asset or data?
- Does it reduce the likelihood or impact of the same risk scenarios?

### 2. Independence

The compensating control should not rely on the same mechanism that makes the primary control unavailable. Ask:
- If the primary control failed due to a technical limitation, does the compensating control rely on the same technology?
- Is the compensating control under our control or the vendor's control?
- Can we verify the compensating control independently?

### 3. Feasibility

The compensating control must be practically implementable. Ask:
- Can this be implemented within an acceptable timeframe?
- Do we have the resources and expertise to implement and maintain it?
- Does the vendor need to cooperate, and will they?

### 4. Sustainability

The compensating control must be maintainable for its expected duration. Ask:
- Can we monitor the compensating control's effectiveness over time?
- Is the compensating control automated or does it require manual effort?
- What happens if the compensating control fails -- is there a detection mechanism?

### 5. Verifiability

The effectiveness of the compensating control must be measurable. Ask:
- How do we know the control is working?
- Can we test the control periodically?
- Is there evidence that the control is functioning (logs, reports, metrics)?

---

## Documentation Requirements

Every compensating control must be formally documented with the following information:

### Compensating Control Record

| Field | Description |
|---|---|
| Control ID | Unique identifier (e.g., CC-VRA-2024-001) |
| Associated Finding ID | The finding this control compensates for |
| Vendor Name | Vendor relationship |
| Primary Control Gap | Description of the control that is missing or deficient |
| Compensating Control Description | Detailed description of what is implemented |
| Risk Addressed | What risk scenario this control mitigates |
| Residual Risk | Risk that remains even with the compensating control |
| Effectiveness Rating | High / Medium-High / Medium / Low-Medium / Low |
| Implementation Date | When the compensating control was put in place |
| Implemented By | Who implemented the control |
| Expiration Date | When the compensating control must be reviewed/renewed |
| Review Frequency | How often effectiveness is assessed |
| Evidence | How effectiveness is demonstrated (logs, reports, test results) |
| Exit Criteria | What must happen for this compensating control to no longer be needed |
| Approved By | Risk owner or authority who approved the compensating control |
| Approval Date | Date of formal approval |

### Approval Requirements

| Compensating Control Effectiveness | Approval Authority |
|---|---|
| High (fully compensates) | Risk owner |
| Medium-High | Risk owner + security leadership awareness |
| Medium | Security leadership approval |
| Low-Medium | CISO approval required |
| Low | Not acceptable as a standalone compensating control; must combine multiple controls or escalate |

---

## Effectiveness Assessment

### Initial Assessment

When a compensating control is first implemented:

1. **Validate implementation** - Confirm the control is actually in place and functioning
2. **Test effectiveness** - Verify the control works as intended (e.g., test that IP allowlisting actually blocks unauthorized IPs)
3. **Assess coverage** - Determine what percentage of the original risk is mitigated
4. **Identify residual risk** - Document what risk remains despite the compensating control
5. **Assign effectiveness rating** using the scale above

### Ongoing Assessment

At each review interval:

1. **Confirm the control is still in place** - Controls can degrade, be removed, or be bypassed
2. **Verify continued effectiveness** - Threat landscape changes; what was effective may no longer be
3. **Review incidents** - Any incidents that occurred despite the compensating control
4. **Assess whether the primary control is now available** - Regularly check if the gap can be closed
5. **Update documentation** with assessment findings

### Effectiveness Rating Criteria

| Rating | Description | Criteria |
|---|---|---|
| High | Fully compensates for the primary control gap | Addresses the same risk scenarios; independently verifiable; automated; does not introduce new risks |
| Medium-High | Substantially compensates with minor residual risk | Addresses most risk scenarios; some manual components; minor gaps in coverage |
| Medium | Partially compensates; material residual risk remains | Addresses some risk scenarios; significant manual effort; notable coverage gaps |
| Low-Medium | Minimally compensates; significant residual risk | Addresses limited risk scenarios; highly manual; significant gaps |
| Low | Inadequate compensation | Does not materially reduce the risk; should not be relied upon alone |

---

## Review and Expiration Tracking

### Review Schedule

| Compensating Control Effectiveness | Review Frequency |
|---|---|
| High | Every 6 months |
| Medium-High | Every 3 months |
| Medium | Every 2 months |
| Low-Medium | Monthly |
| Low | Not acceptable; escalate immediately |

### Expiration Rules

- **Maximum duration without renewal:** 12 months regardless of effectiveness rating
- **Renewal requires:** Re-assessment of effectiveness, confirmation that primary control is still unavailable, updated approval
- **Automatic escalation:** If a compensating control has been renewed more than twice (spanning more than 24 months), escalate to security leadership for a strategic decision on risk acceptance vs. vendor change
- **Sunset tracking:** Track all compensating controls approaching expiration in the monthly vendor risk dashboard

### Expiration Actions

When a compensating control reaches its expiration date:

1. **30 days before expiration:** Notify risk owner and compensating control owner
2. **14 days before expiration:** Escalate if renewal or resolution not in progress
3. **At expiration:** If not renewed or resolved:
   - Reassess the associated finding severity
   - Escalate to appropriate approval authority
   - Consider whether the vendor relationship should be re-evaluated
4. **Post-expiration:** If more than 30 days past expiration with no action, escalate to CISO

---

## Detailed Examples

### Example 1: MFA Gap with IP Allowlisting Compensation

**Scenario:** Tier 2 SaaS vendor does not support MFA for their admin portal. Vendor is on roadmap to add MFA in 6 months.

**Compensating Controls Implemented:**
1. IP allowlisting configured to only allow access from corporate office and VPN egress IPs
2. Password policy enforced: 24-character minimum, no password reuse, 90-day rotation
3. Account lockout after 5 failed attempts with 30-minute lockout period
4. Session timeout set to 15 minutes of inactivity
5. Weekly review of admin login audit logs for anomalies
6. Alerting configured for logins outside business hours

**Effectiveness Rating:** High -- Combined controls significantly reduce unauthorized access risk. IP allowlisting alone prevents most remote attack scenarios.

**Exit Criteria:** Vendor enables MFA; all admin accounts enrolled in MFA; IP allowlisting maintained as defense-in-depth.

### Example 2: SOC 2 Gap with Alternative Attestations

**Scenario:** Tier 1 vendor (critical data processor) does not have SOC 2 Type II. They have ISO 27001 and are willing to complete a SIG questionnaire.

**Compensating Controls Implemented:**
1. ISO 27001 certificate reviewed and confirmed to cover relevant services
2. Full SIG questionnaire completed with evidence review for all domains
3. Independent penetration test report reviewed (within last 6 months)
4. Enhanced contractual security requirements with right to audit clause
5. Reassessment cycle shortened from 12 months to 6 months
6. Continuous security rating monitoring with 10-point drop alert threshold

**Effectiveness Rating:** Medium-High -- ISO 27001 + SIG provides broad coverage but lacks the specific control testing rigor of SOC 2 Type II. Pen test adds technical validation.

**Exit Criteria:** Vendor obtains SOC 2 Type II report covering relevant services. Contractual requirement added for SOC 2 completion within 12 months.

### Example 3: Encryption at Rest Gap with Access Controls and DLP

**Scenario:** Tier 1 vendor's legacy platform does not support encryption at rest for stored files. Data includes Confidential customer information.

**Compensating Controls Implemented:**
1. Data minimization: only essential fields sent to vendor (PII stripped where possible)
2. Client-side encryption of files before upload using organization-managed keys
3. Enhanced access controls: only 3 named individuals at vendor with access, MFA required
4. DLP monitoring on all data egress paths from vendor environment
5. Database activity monitoring logging all queries against the data store
6. Quarterly data inventory audit to verify no data sprawl
7. Network segmentation isolating the data store from other vendor systems

**Effectiveness Rating:** Medium-High -- Client-side encryption is the strongest control, effectively providing encryption at rest from the organization's perspective. Other controls add defense-in-depth.

**Exit Criteria:** Vendor migrates to platform supporting encryption at rest, or data is migrated to an alternative vendor with encryption capability. Timeline contractually committed.
