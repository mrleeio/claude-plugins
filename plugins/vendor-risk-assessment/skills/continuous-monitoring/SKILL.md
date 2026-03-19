---
name: continuous-monitoring
description: Post-assessment continuous vendor monitoring using security ratings, breach monitoring, and tier-based cadence. Trigger phrases include "continuous monitoring", "vendor monitoring", "security ratings", "BitSight", "SecurityScorecard", "dark web monitoring", "ongoing monitoring". (user)
---

# Continuous Monitoring

Implement post-assessment continuous vendor monitoring with tier-based cadence, security ratings integration, and automated alert triggers.

## Quick Reference

### Monitoring Cadence by Tier

| Activity | Critical | High | Medium | Low |
|----------|:-:|:-:|:-:|:-:|
| **Security ratings check** | Real-time/daily | Weekly | Monthly | Quarterly |
| **Breach/incident monitoring** | Real-time | Daily | Weekly | Monthly |
| **Dark web monitoring** | Continuous | Weekly | Monthly | N/A |
| **Certification/compliance review** | Quarterly | Semi-annual | Annual | On renewal |
| **Full reassessment** | Annual | Annual | Biennial | Triennial |
| **Sub-processor list review** | Quarterly | Semi-annual | Annual | On renewal |
| **Contract/SLA review** | Annual | Annual | On renewal | On renewal |
| **Remediation tracking** | Weekly | Bi-weekly | Monthly | Quarterly |

### Security Ratings Services

| Service | What It Measures | Use Case |
|---------|-----------------|----------|
| **BitSight** | External security posture (network security, patching, endpoint security) | Continuous risk quantification, benchmarking |
| **SecurityScorecard** | 10 risk factor groups (application security, DNS health, network security, etc.) | Portfolio monitoring, due diligence |
| **RiskRecon** | Internet-facing asset security across 11 domains | Asset discovery, ongoing assessment |
| **UpGuard** | Website risks, data leak detection, questionnaire automation | Data exposure monitoring |
| **Panorays** | Automated security assessments, supply chain mapping | Third-party ecosystem visibility |

### Alert Triggers

| Trigger | Severity | Action |
|---------|----------|--------|
| Security rating drops >10% | High | Immediate investigation, vendor outreach |
| Data breach disclosed | Critical | Activate IR coordination, assess exposure |
| Certification expired | High | Verify renewal status, assess gap risk |
| Critical CVE in vendor product | Critical | Assess exposure, verify vendor response |
| Sub-processor change | Medium | Review new sub-processor, assess impact |
| Vendor acquisition/merger | High | Reassess tier, review continuity plans |
| Regulatory action against vendor | High | Assess impact, review compliance status |
| Dark web mention (credentials/data) | Critical | Verify, assess exposure, coordinate response |
| SLA breach | Medium-High | Document, escalate per contract |
| Negative media coverage (security) | Medium | Investigate, assess materiality |

### Monitoring Program Maturity Levels

| Level | Characteristics | Typical State |
|-------|----------------|---------------|
| **1 — Ad Hoc** | No formal monitoring, reactive only | Spreadsheet tracking, manual cert checks |
| **2 — Defined** | Documented cadence, manual execution | Calendar reminders, periodic reviews |
| **3 — Managed** | Security ratings integrated, some automation | Dashboard monitoring, automated alerts |
| **4 — Optimized** | Fully automated, continuous, integrated with GRC | Real-time monitoring, automated workflows, API integrations |

## Monitoring Workflows

### Daily/Continuous (Critical Tier)

1. Check security ratings dashboard for score changes
2. Review automated alerts (breach feeds, dark web, CVE)
3. Triage any triggered alerts per severity
4. Document significant changes in vendor risk register

### Weekly (High Tier)

1. Review security ratings trends
2. Check breach notification feeds
3. Review remediation item progress
4. Escalate overdue SLA items

### Monthly (Medium Tier)

1. Security ratings review
2. Breach and incident check
3. Certification expiry calendar review
4. Remediation progress check

### Quarterly (Critical/High Tier)

1. Sub-processor list comparison (changes since last review)
2. Certification and compliance status verification
3. Remediation plan progress review with vendor
4. Contract SLA performance review
5. Update risk scores based on new information

## Escalation Framework

| Severity | Initial Response | Escalation Path | Communication |
|----------|-----------------|-----------------|---------------|
| **Critical** | Within 1 hour | CISO → CRO → Board | Immediate stakeholder notification |
| **High** | Within 4 hours | Security Lead → CISO | Same-day notification |
| **Medium** | Within 1 business day | Risk Analyst → Security Lead | Weekly report inclusion |
| **Low** | Within 1 week | Standard tracking | Monthly report inclusion |

## Do

- Integrate security ratings into your GRC platform for automated monitoring
- Set up automated alerts for breach disclosures and CVE publications
- Track monitoring activities in a centralized system with audit trails
- Review and update monitoring cadence when vendor tier changes
- Correlate security ratings changes with known events (breaches, patches)
- Maintain a vendor risk register with current status and trend data

## Don't

- Rely solely on security ratings — they measure external posture only
- Monitor all vendors at the same intensity — use tier-based cadence
- Ignore "noise" alerts without investigation — triage and document
- Wait for the annual reassessment to act on significant changes
- Skip documentation of monitoring activities and decisions

## Common Mistakes

1. **Set and forget** — Monitoring programs require ongoing investment and tuning
2. **Alert fatigue** — Too many low-quality alerts lead to missed critical signals
3. **Single-source monitoring** — No single tool covers all risk dimensions
4. **Not acting on findings** — Monitoring without response is just observation

## See Also

- [Monitoring Tiers](references/monitoring-tiers.md) — Detailed tier-specific monitoring procedures
- [Security Ratings](references/security-ratings.md) — Security ratings service comparison and integration guide
