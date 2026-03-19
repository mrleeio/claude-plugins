---
name: vendor-research
description: Research vendor security posture across 15 assessment domains using OSINT sources. Trigger phrases include "research vendor", "vendor security", "assess vendor", "vendor due diligence", "vendor investigation". (user)
---

# Vendor Research

Research a vendor's security posture across 15 assessment domains using open-source intelligence (OSINT) and structured questionnaire methodology.

## Quick Reference

| Domain | Key Areas |
|--------|-----------|
| Information Security | Security program maturity, CISO/team structure, policies |
| Access Control | IAM, MFA, RBAC/ABAC, privileged access management |
| Network Security | Segmentation, firewalls, IDS/IPS, DDoS protection |
| Data Security | Encryption (at-rest, in-transit, in-use), key management, DLP |
| Vulnerability Management | Scanning cadence, patching SLAs, bug bounty, pentest frequency |
| Governance | Board oversight, risk management framework, security budget |
| Compliance & Legal | Certifications, audit history, DPA/BAA, data residency |
| Operations | Change management, asset inventory, configuration management |
| BCP/DR | RTO/RPO, DR testing frequency, geographic redundancy |
| Incident Management | IR plan, breach history, notification timelines, tabletop exercises |
| HR Security | Background checks, security training, acceptable use, offboarding |
| Physical Security | Data center controls, visitor management, environmental controls |
| Supply Chain | Sub-processors, SBOM, fourth-party risk management |
| AI Risk | Model governance, training data practices, EU AI Act classification, bias monitoring |
| Privacy | Privacy program, DSAR process, data minimization, retention policies |

## Research Workflow

### Step 1: Identify Deployment Model

Determine if the vendor solution is:

- **SaaS/Cloud-hosted** — Focus on: shared responsibility model, tenant isolation, SOC 2 scope, data residency
- **Self-hosted/On-premises** — Focus on: deployment requirements, patch delivery, hardening guides, integration security
- **Hybrid** — Assess both models with clear scope boundaries

### Step 2: OSINT Research

Use WebSearch and WebFetch to investigate:

1. **Trust/Security page** — Search `[vendor] trust site:vendor.com` or `[vendor] security`
2. **Certifications** — SOC 2 Type II, ISO 27001, SOC 1, HITRUST, FedRAMP, PCI DSS
3. **Breach history** — Search `[vendor] data breach` or `[vendor] security incident`
4. **Sub-processor list** — Search `[vendor] sub-processors` or `[vendor] subprocessors`
5. **Status page** — Search `[vendor] status page` for uptime history
6. **CVE exposure** — Search `[vendor] CVE` for known vulnerabilities
7. **Pentest reports** — Check if vendor publishes pentest summaries
8. **Privacy policy & DPA** — Search `[vendor] DPA` or `[vendor] data processing agreement`

### Step 3: Domain-by-Domain Assessment

For each domain, gather evidence and assess against:

| Rating | Criteria |
|--------|----------|
| **Strong (4-5)** | Documented controls, third-party validated, exceeds requirements |
| **Adequate (3)** | Controls present, self-attested or partially validated |
| **Weak (1-2)** | Controls absent, undocumented, or known gaps |
| **Unknown (0)** | Insufficient evidence to assess |

### Step 4: AI Risk Assessment (Expanded)

For vendors using AI/ML, additionally assess:

- **EU AI Act classification** — Unacceptable / High / Limited / Minimal risk
- **NIST AI RMF alignment** — Govern, Map, Measure, Manage functions
- **ISO 42001** — AI management system certification status
- **Model transparency** — Explainability, bias testing, audit trails
- **Training data governance** — Data sourcing, consent, retention, opt-out
- **AI incident response** — Model drift detection, rollback procedures
- **Human oversight** — Human-in-the-loop requirements, override capabilities

## Do

- Search multiple independent sources to corroborate claims
- Note the date and source of every finding
- Distinguish between self-attested claims and third-party validated evidence
- Flag when a domain has insufficient publicly available information
- Check certification registry sites (e.g., AICPA for SOC 2, accreditation bodies for ISO)

## Don't

- Treat marketing pages as evidence of security controls
- Assume absence of public information means absence of controls
- Skip domains — mark as "Unknown" if no evidence found
- Mix findings from different vendor products/services without noting scope
- Accept expired certifications as current evidence

## Common Mistakes

1. **Confusing SOC 2 Type I with Type II** — Type I is point-in-time, Type II covers a period (typically 12 months)
2. **Ignoring certification scope** — A SOC 2 may not cover the specific product you're evaluating
3. **Overlooking sub-processor risk** — The vendor's security is only as strong as their weakest sub-processor
4. **Treating compliance as security** — Compliance frameworks set a floor, not a ceiling

## Output Format

Structure research findings as a dossier:

```markdown
# Vendor Research Dossier: [Vendor Name]

**Date:** [Assessment Date]
**Researcher:** Claude
**Deployment Model:** [SaaS | Self-hosted | Hybrid]

## Executive Summary
[2-3 sentence overview of vendor's security posture]

## Domain Findings

### 1. Information Security
**Rating:** [Strong/Adequate/Weak/Unknown]
**Evidence:**
- [Finding with source and date]
**Gaps:**
- [Identified gaps]

[... repeat for all 15 domains ...]

## Key Risks
1. [Risk with domain reference]

## Evidence Inventory
| Evidence Type | Available | Source |
|--------------|-----------|--------|
| SOC 2 Type II | Yes/No | [source] |
| ISO 27001 | Yes/No | [source] |
| Pentest Report | Yes/No | [source] |
| DPA/BAA | Yes/No | [source] |
```

## See Also

- [OSINT Sources](references/osint-sources.md) — Detailed OSINT source list and search strategies
- [Assessment Domains](references/assessment-domains.md) — Deep dive into all 15 assessment domains with specific questions
- [SaaS vs Hosted](references/saas-vs-hosted.md) — Deployment-model-specific assessment guidance
