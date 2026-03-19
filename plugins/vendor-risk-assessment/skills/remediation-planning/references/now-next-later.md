# Now / Next / Later Prioritization Framework

## Overview

The Now/Next/Later framework provides a structured approach to prioritizing vendor risk remediation findings. It balances urgency, impact, and feasibility to create actionable remediation roadmaps that address the most pressing risks first while maintaining progress on longer-term improvements.

---

## Priority Definitions

### NOW (Immediate: 0-30 Days)

Findings that require immediate action due to active or imminent risk of harm. These represent conditions where the current exposure is unacceptable and compensating controls are insufficient.

**Criteria (any one is sufficient):**
- Active exploitation or known vulnerability being exploited in the wild
- Critical finding (CVSS 9.0+) with no compensating controls
- Regulatory non-compliance with imminent enforcement risk
- Direct exposure of Restricted data without adequate protection
- Missing fundamental security controls (no encryption on Restricted data, no authentication on external-facing systems)
- Breach notification obligation not met
- Finding that would be immediately flagged by a regulator or auditor

**Expected Response:**
- Remediation plan due within 48 hours
- Remediation complete within 30 days
- Interim compensating controls implemented within 72 hours if full remediation takes longer
- Executive visibility required
- Progress updates weekly

### NEXT (Short-Term: 30-90 Days)

Findings that represent significant risk requiring timely remediation but where immediate harm is unlikely due to existing partial controls or limited exposure.

**Criteria (any one is sufficient):**
- High severity finding (CVSS 7.0-8.9) with partial compensating controls
- Confidential data protection gap with some mitigating factors
- Compliance gap with upcoming audit or regulatory deadline
- Missing security control that is standard for the vendor tier
- Finding that increases risk of a successful attack but requires additional conditions
- Process gap that could lead to security failure if not addressed

**Expected Response:**
- Remediation plan due within 2 weeks
- Remediation complete within 90 days
- Progress updates bi-weekly
- Risk owner oversight required

### LATER (Medium-Term: 90-180 Days)

Findings that represent manageable risk with adequate compensating controls in place, or improvements that would strengthen the security posture but are not addressing active gaps.

**Criteria (any one is sufficient):**
- Medium severity finding (CVSS 4.0-6.9) with adequate compensating controls
- Best practice recommendations not yet implemented
- Internal data protection improvements
- Defense-in-depth enhancements
- Process maturity improvements
- Documentation or formalization of existing practices
- Long-term architectural improvements

**Expected Response:**
- Remediation plan due within 30 days
- Remediation complete within 180 days
- Progress updates monthly
- Standard tracking through risk register

---

## Decision Tree for Priority Assignment

Use this decision tree to assign priority to each finding:

```
1. Is there active exploitation or imminent threat?
   YES → NOW
   NO  → Continue to 2

2. Does the finding involve Restricted data with inadequate protection?
   YES → NOW
   NO  → Continue to 3

3. Is the finding a regulatory non-compliance with enforcement risk?
   YES → Is enforcement imminent (within 90 days)?
         YES → NOW
         NO  → NEXT
   NO  → Continue to 4

4. Is the finding rated Critical severity (CVSS 9.0+)?
   YES → Are effective compensating controls in place?
         YES → NEXT
         NO  → NOW
   NO  → Continue to 5

5. Is the finding rated High severity (CVSS 7.0-8.9)?
   YES → Are effective compensating controls in place?
         YES → NEXT (lower end of range)
         NO  → NEXT (upper end, consider NOW if vendor is Tier 1)
   NO  → Continue to 6

6. Is the finding rated Medium severity (CVSS 4.0-6.9)?
   YES → NEXT or LATER based on:
         - Data classification involved (Confidential → NEXT, Internal → LATER)
         - Vendor tier (Tier 1/2 → NEXT, Tier 3/4 → LATER)
         - Availability of compensating controls
   NO  → Continue to 7

7. Is the finding rated Low severity (CVSS < 4.0)?
   YES → LATER (or accept risk with documentation)
   NO  → LATER
```

---

## Examples of Findings by Priority

### NOW Examples

| Finding | Rationale |
|---|---|
| Vendor stores passwords in plaintext | Critical vulnerability, Restricted data exposed, no compensating control possible |
| No encryption on database containing PHI | Regulatory non-compliance (HIPAA), Restricted data at rest unprotected |
| Vendor has no incident response plan or contact | Fundamental gap; if breach occurs, no process to detect or respond |
| Default credentials on internet-facing admin panel | Active exploitation risk, trivially exploitable |
| SOC 2 report reveals qualified opinion on access controls for Tier 1 vendor | Tier 1 vendor with validated control failure in critical domain |
| Vendor suffered a breach and has not notified per contract terms | Contractual and potentially regulatory violation |

### NEXT Examples

| Finding | Rationale |
|---|---|
| MFA not enforced for vendor admin accounts (SSO is in place) | High risk but SSO provides partial mitigation |
| Penetration test shows high-severity finding, vendor has remediation plan | Significant vulnerability but vendor is actively addressing |
| Vendor lacks formal change management process | Process gap that increases risk but not an active vulnerability |
| No data flow diagram documented for Tier 2 vendor | Documentation gap limits visibility but data protection controls exist |
| Vendor's DR test showed RTO exceeded by 2x | Resilience gap requiring improvement but not an active threat |
| Sub-processor list not maintained or updated | Visibility gap into fourth-party risk |

### LATER Examples

| Finding | Rationale |
|---|---|
| Vendor uses TLS 1.1 for internal communications (TLS 1.2 for external) | Below best practice but limited exposure since internal only |
| Security awareness training is annual instead of quarterly | Best practice improvement, annual training still meets baseline |
| Vulnerability scans are monthly instead of weekly | Improvement needed but monthly scanning provides baseline coverage |
| BCP plan has not been tested in 18 months (Tier 3 vendor) | Below best practice but lower-tier vendor with limited criticality |
| Vendor lacks a formal risk register | Maturity improvement, does not indicate missing controls |
| Access reviews conducted annually instead of semi-annually for Tier 2 vendor | Frequency improvement; annual reviews still provide baseline coverage |

---

## Prioritization Conflicts and Resolution

### Common Conflicts

**Conflict 1: High severity but strong compensating controls**
- Default would be NEXT, but may be LATER if compensating controls fully address the risk
- Resolution: Document the compensating controls and their effectiveness; if they reduce residual risk to acceptable levels, LATER is appropriate

**Conflict 2: Low severity but regulatory requirement**
- Default would be LATER, but regulatory non-compliance may require NEXT or NOW
- Resolution: Regulatory requirements take priority; escalate based on enforcement timeline

**Conflict 3: Multiple medium findings that compound**
- Individual findings might be LATER, but together they create a significant gap
- Resolution: Assess the compound risk; if combined findings create a high-risk scenario, elevate the most impactful finding to NEXT

**Conflict 4: Vendor pushback on NOW timeline**
- Vendor claims remediation is not feasible within 30 days
- Resolution: Require compensating controls within 72 hours while full remediation proceeds; extend to NEXT timeline only with documented compensating controls and executive approval

**Conflict 5: Business pressure to downgrade priority**
- Stakeholders want to accept risk to avoid disrupting vendor relationship
- Resolution: Document the risk formally with the appropriate approval level; ensure the business owner signs off on risk acceptance

### Escalation Path

When priority assignment is disputed:
1. Assessor and risk owner attempt to resolve based on criteria above
2. If unresolved, escalate to security leadership with documented positions
3. Security leadership makes final determination with documented rationale
4. For Tier 1 vendors, CISO has final authority on NOW classifications

---

## Tracking and Reporting

### Finding Tracker Template

| Field | Description |
|---|---|
| Finding ID | Unique identifier (e.g., VRA-2024-001) |
| Vendor Name | Name of the assessed vendor |
| Vendor Tier | Tier 1-4 |
| Finding Title | Brief description of the finding |
| Domain | Assessment domain (e.g., Access Control) |
| Severity | Critical / High / Medium / Low |
| Priority | NOW / NEXT / LATER |
| Description | Detailed description of the finding |
| Risk | What could happen if not remediated |
| Recommendation | Specific remediation action |
| Compensating Controls | Any interim controls in place |
| Remediation Owner | Vendor contact responsible |
| Internal Owner | Internal risk owner |
| Target Date | Expected remediation completion date |
| Status | Open / In Progress / Remediated / Accepted / Overdue |
| Evidence of Remediation | How remediation will be validated |
| Last Updated | Date of most recent status update |
| Notes | Additional context |

### Reporting Cadence

| Report | Audience | Frequency | Content |
|---|---|---|---|
| NOW Findings Status | CISO, Security Leadership | Weekly | All open NOW findings, status, blockers |
| Remediation Progress | Risk Owners | Bi-weekly | All open findings by vendor, progress |
| Vendor Risk Dashboard | Security Leadership | Monthly | Aggregate metrics, trends, overdue items |
| Executive Summary | Executive Team | Quarterly | Portfolio risk posture, key risks, trends |

### Key Metrics to Track

- Total open findings by priority (NOW/NEXT/LATER)
- Findings overdue by priority
- Average time to remediate by priority
- Findings by assessment domain (identify systemic issues)
- Findings by vendor tier
- Risk acceptance rate and trends
- Compensating control expiration upcoming
