---
name: remediation-planning
description: Create remediation plans using Now/Next/Later prioritization with severity SLAs and compensating controls. Trigger phrases include "remediation plan", "remediation", "compensating controls", "conditional approval", "remediation SLA". (user)
---

# Remediation Planning

Create structured remediation plans using Now/Next/Later prioritization, severity-based SLAs, compensating controls, and conditional approval frameworks.

## Quick Reference

### Now/Next/Later Framework

| Priority | Timeframe | Criteria | Examples |
|----------|-----------|----------|---------|
| **Now** | 0-30 days | Critical/High severity, actively exploitable, regulatory violation, no compensating control | Missing MFA on admin accounts, unencrypted PII in transit |
| **Next** | 31-90 days | Medium severity, compensating controls possible, significant gap but not immediately exploitable | No formal IR plan, incomplete access reviews |
| **Later** | 91-180 days | Low severity, best practice improvements, defense-in-depth enhancements | Security awareness training gaps, documentation improvements |

### Severity SLAs

| Severity | Remediation SLA | Escalation | Re-assessment |
|----------|:-:|:-:|:-:|
| **Critical** | 15 days | CISO + Business Owner at day 1 | Verify remediation within 30 days |
| **High** | 30 days | Security Lead at day 15 | Verify at next quarterly review |
| **Medium** | 90 days | Standard tracking | Verify at next periodic assessment |
| **Low** | 180 days | Standard tracking | Verify at next periodic assessment |

### Conditional Approval Framework

| Condition Type | Description | Example |
|---------------|-------------|---------|
| **Must-fix** | Required before go-live or continued use | "Implement MFA within 30 days" |
| **Should-fix** | Required within defined SLA, compensating control interim | "Complete SOC 2 Type II within 12 months" |
| **Monitor** | Accepted risk with enhanced monitoring | "Monitor for breach disclosures quarterly" |

## Remediation Plan Structure

### For Each Finding

```markdown
### [Finding ID]: [Finding Title]
**Domain:** [Assessment domain]
**Severity:** Critical | High | Medium | Low
**Priority:** Now | Next | Later
**Inherent Risk:** [Score]
**Current State:** [What exists today]

**Required Action:** [Specific, measurable action the vendor must take]

**Compensating Control (if applicable):**
[Interim control that reduces risk while remediation is in progress]

**Acceptance Criteria:**
- [ ] [Specific, verifiable completion criterion]
- [ ] [Evidence required to close]

**SLA:** [Date]
**Owner:** [Vendor contact / Internal sponsor]
**Escalation:** [Who to notify if SLA is missed]
```

### Compensating Controls

When a finding cannot be immediately remediated, compensating controls reduce risk:

| Gap | Compensating Control | Risk Reduction |
|-----|---------------------|:-:|
| No MFA on vendor portal | IP allowlisting + VPN requirement | Partial |
| Missing SOC 2 Type II | ISO 27001 cert + completed SIG questionnaire | Moderate |
| No encryption at rest | Strong access controls + DLP + monitoring | Partial |
| No formal IR plan | Contractual SLA for incident notification + your IR plan covers vendor | Moderate |
| Outdated pentest | Recent vulnerability scan results + bug bounty program | Partial |

**Compensating controls must be:**
- Documented with clear justification
- Temporary with a defined end date
- Reviewed at each assessment cycle
- Approved by risk owner

## Do

- Make every remediation item specific, measurable, and time-bound
- Assign clear ownership (vendor-side AND internal sponsor)
- Document compensating controls with expiration dates
- Track remediation items in a centralized system
- Escalate missed SLAs per the escalation framework
- Re-assess risk score after remediation is verified

## Don't

- Accept "we'll work on it" as a remediation commitment
- Allow compensating controls to become permanent without review
- Set unrealistic SLAs that the vendor cannot meet
- Group multiple findings into a single remediation item
- Skip verification — self-attestation of remediation is insufficient

## Common Mistakes

1. **Vague actions** — "Improve security" vs "Implement MFA for all admin accounts using TOTP or hardware keys"
2. **No escalation path** — If nobody is accountable for missed SLAs, they will be missed
3. **Permanent compensating controls** — Every compensating control needs a review date
4. **Missing acceptance criteria** — How do you know the finding is actually fixed?

## See Also

- [Now/Next/Later](references/now-next-later.md) — Detailed prioritization criteria and examples
- [Compensating Controls](references/compensating-controls.md) — Control selection and documentation guide
