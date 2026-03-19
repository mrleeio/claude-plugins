---
name: source-verification
description: Verify vendor security claims and validate evidence quality. Trigger phrases include "verify evidence", "check certification", "validate claim", "evidence review", "source verification". (user)
---

# Source Verification

Validate vendor security claims and evidence using a structured evidence hierarchy and verification methodology.

## Quick Reference

### Evidence Hierarchy (Strongest to Weakest)

| Tier | Evidence Type | Trust Level | Verification |
|------|--------------|-------------|--------------|
| 1 | SOC 2 Type II report | Highest | Independent auditor, covers operating effectiveness over period |
| 2 | ISO 27001 certificate | High | Accredited certification body, annual surveillance audits |
| 3 | Penetration test report | High | Independent tester, point-in-time but technical depth |
| 4 | SOC 2 Type I report | Medium-High | Independent auditor, point-in-time design only |
| 5 | Completed SIG/CAIQ questionnaire | Medium | Self-attested but structured and comprehensive |
| 6 | Vendor-provided documentation | Medium-Low | Self-attested, may be aspirational |
| 7 | Marketing/trust page claims | Low | Unverified, often vague or misleading |

### Red Flags

| Red Flag | What It Suggests |
|----------|-----------------|
| Certification issued by unknown body | Potentially fraudulent or non-accredited certification |
| SOC 2 scope excludes key services | Critical systems may be unaudited |
| Certificate expired > 3 months ago | Vendor may have failed re-certification |
| "Compliant with" vs "Certified to" | Self-assessed, not independently verified |
| No bridge letter for SOC 2 gap | Operating effectiveness not maintained between audit periods |
| Pentest report is > 12 months old | May not reflect current security posture |
| Questionnaire answers are copy-pasted | Responses may not reflect actual practices |

## Verification Methods

### SOC 2 Report Verification

1. **Confirm report type** — Type I (design only) vs Type II (operating effectiveness)
2. **Check audit period** — Should cover at least 6 months, ideally 12
3. **Verify auditor** — Must be a licensed CPA firm; check AICPA registry
4. **Review scope** — Does the report cover the specific services you use?
5. **Check Trust Service Criteria** — Security is mandatory; Availability, Confidentiality, Processing Integrity, Privacy are optional
6. **Read exceptions** — Any qualified opinions or noted exceptions?
7. **Check complementary user entity controls (CUECs)** — Your organization's responsibilities
8. **Bridge letter** — If report period ended > 3 months ago, request a bridge letter

### ISO 27001 Verification

1. **Check certificate validity** — Must be current (3-year cycle with annual surveillance)
2. **Verify certification body** — Must be accredited (check IAF, UKAS, ANAB)
3. **Review scope** — Statement of Applicability (SoA) should cover relevant services
4. **Check version** — ISO 27001:2022 is current; 2013 transition deadline passed
5. **Surveillance audits** — Confirm annual surveillance audits are being completed

### Penetration Test Verification

1. **Tester independence** — Must be a third-party firm, not internal
2. **Scope coverage** — External, internal, web app, API, mobile as relevant
3. **Methodology** — OWASP, PTES, or NIST SP 800-115
4. **Findings remediation** — Were critical/high findings remediated? Retest evidence?
5. **Recency** — Should be within last 12 months

### Questionnaire Response Verification

1. **Completeness** — All sections answered? N/A responses justified?
2. **Specificity** — Answers reference specific tools, processes, teams?
3. **Consistency** — Do answers align across related questions?
4. **Evidence references** — Do answers point to supporting documentation?
5. **Copy-paste detection** — Generic or templated responses suggest low effort

## Do

- Always verify certification scope matches the services being assessed
- Cross-reference vendor claims against independent sources
- Check certification registry databases directly
- Note the evidence tier for every finding in your assessment
- Request bridge letters for SOC 2 reports with gaps > 3 months
- Track certification expiry dates for ongoing monitoring

## Don't

- Accept screenshots of certifications as evidence (request original documents)
- Treat Type I SOC 2 reports as equivalent to Type II
- Assume all services are covered by a certification without checking scope
- Accept marketing claims without supporting evidence
- Skip reading SOC 2 exceptions and qualified opinions

## Common Mistakes

1. **Not checking SOC 2 scope** — A vendor may have SOC 2 for one product but not the one you use
2. **Ignoring CUECs** — Complementary user entity controls are YOUR responsibilities
3. **Accepting expired certs** — An expired ISO 27001 cert means the vendor may have failed audit
4. **Missing bridge letter gaps** — A SOC 2 from January doesn't cover what happened in February through now

## See Also

- [Evidence Types](references/evidence-types.md) — Detailed breakdown of each evidence type
- [Verification Methods](references/verification-methods.md) — Step-by-step verification procedures
