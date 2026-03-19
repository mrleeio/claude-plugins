---
name: regulatory-mapping
description: Map vendor assessment findings to regulatory frameworks including DORA, NIS2, SEC Cyber, EU CRA, and EU AI Act. Trigger phrases include "regulatory mapping", "DORA", "NIS2", "SEC cyber", "EU AI Act", "CRA", "compliance mapping", "regulation". (user)
---

# Regulatory Mapping

Map vendor risk assessment findings to applicable regulatory frameworks. Auto-scope regulations based on jurisdiction and sector.

## Quick Reference

### Regulatory Framework Overview

| Framework | Jurisdiction | Sector | Effective | Key VRA Requirements |
|-----------|-------------|--------|-----------|---------------------|
| **DORA** | EU | Financial services | Jan 2025 | ICT third-party risk management, concentration risk, exit strategies |
| **NIS2** | EU | Critical infrastructure (18 sectors) | Oct 2024 | Supply chain security, incident reporting, risk management |
| **SEC Cyber Disclosure** | US | Public companies | Dec 2023 | Material incident disclosure, risk management disclosure |
| **EU CRA** | EU | Digital products | ~2027 (phased) | Software supply chain, vulnerability handling, SBOM |
| **EU AI Act** | EU | AI systems | Aug 2024 (phased) | AI risk classification, transparency, governance |
| **HIPAA** | US | Healthcare | 1996+ | BAAs, PHI protection, breach notification |
| **PCI DSS 4.0** | Global | Payment processing | Mar 2025 | Service provider requirements, script integrity |
| **SOX** | US | Public companies | 2002+ | IT general controls, access management |

### Jurisdiction/Sector Selector

To auto-scope applicable regulations, identify:

1. **Your organization's jurisdiction(s):** Where you operate, where data subjects reside
2. **Your sector(s):** Financial services, healthcare, critical infrastructure, etc.
3. **Data types processed by vendor:** PII, PHI, PCI, financial, AI training data
4. **Vendor's jurisdiction:** Where vendor operates and processes data

### Breach Notification Timelines

| Regulation | Timeline | To Whom | Threshold |
|-----------|----------|---------|-----------|
| DORA | "Without undue delay" | Competent authority | Major ICT-related incidents |
| NIS2 | 24h early warning, 72h notification | CSIRT/competent authority | Significant incidents |
| SEC | 4 business days (8-K) | SEC + investors | Material cybersecurity incidents |
| GDPR | 72 hours | Supervisory authority | Personal data breach likely to result in risk |
| HIPAA | 60 days (to individuals), 60 days (to HHS) | Individuals + HHS | Unsecured PHI breach |
| PCI DSS | "Immediately" | Card brands + acquirer | Compromise of cardholder data |

## DORA (Digital Operational Resilience Act)

### Key Third-Party Requirements

| Article | Requirement | VRA Mapping |
|---------|-------------|-------------|
| Art. 28 | ICT third-party risk management framework | Governance, vendor lifecycle |
| Art. 29 | Preliminary assessment of ICT concentration risk | Fourth-party risk, concentration risk |
| Art. 30 | Key contractual provisions | Contract review, SLA assessment |
| Art. 31 | Designation of critical ICT third-party providers | Vendor tiering |
| Art. 28(8) | Exit strategies for critical providers | Vendor lifecycle (offboarding) |

### DORA-Specific Assessment Questions

- Does the vendor qualify as a "critical ICT third-party service provider"?
- What is the concentration risk if this vendor fails?
- Does the contract include all Article 30 required provisions?
- Is there a documented, tested exit strategy?
- Can the vendor support regulatory examination (right of access, inspection, audit)?

## NIS2 (Network and Information Security Directive)

### Supply Chain Requirements

| Requirement | VRA Mapping |
|-------------|-------------|
| Supply chain risk management policies | Fourth-party risk, sub-processor assessment |
| Security requirements for direct suppliers | Contract review, security requirements |
| Vulnerability disclosure and handling | Vulnerability management domain |
| Incident notification to authorities | Incident management domain |
| Business continuity measures | BCP/DR domain |

### NIS2 Sectors (Essential + Important)

**Essential:** Energy, Transport, Banking, Financial Market Infrastructure, Health, Drinking Water, Waste Water, Digital Infrastructure, ICT Service Management (B2B), Public Administration, Space

**Important:** Postal/Courier, Waste Management, Chemicals, Food, Manufacturing, Digital Providers, Research

## SEC Cyber Disclosure Rules

### Relevant Requirements

| Requirement | VRA Mapping |
|-------------|-------------|
| Risk management strategy disclosure | Governance domain, risk scoring methodology |
| Third-party risk management processes | Full VRA program description |
| Board oversight of cyber risk | Governance domain |
| Material incident determination | Incident management, risk scoring |
| Annual disclosure (10-K) | Assessment cadence, program maturity |

## EU AI Act

### AI Risk Classification for Vendor AI Systems

| Risk Level | Criteria | VRA Requirements |
|------------|----------|-----------------|
| **Unacceptable** | Social scoring, real-time biometric ID (exceptions apply) | Cannot use — assess for compliance violation |
| **High** | Safety components, biometrics, critical infrastructure, employment, law enforcement | Full AI risk assessment, conformity assessment |
| **Limited** | Chatbots, emotion recognition, deepfake generation | Transparency obligations |
| **Minimal** | AI-enabled games, spam filters | No additional requirements |

### High-Risk AI Assessment Areas

- Transparency and explainability
- Human oversight mechanisms
- Data governance (training data quality, bias)
- Technical documentation completeness
- Post-market monitoring system
- Incident reporting capability

## Do

- Use the jurisdiction/sector selector to scope applicable regulations before assessment
- Map every finding to applicable regulatory requirements
- Include regulatory mapping tables in report appendices
- Track breach notification timeline requirements per regulation
- Assess exit strategy requirements for DORA-regulated engagements
- Update regulatory mapping when new regulations take effect

## Don't

- Apply all regulations universally — scope based on jurisdiction and sector
- Treat regulatory mapping as a checkbox exercise — understand the intent
- Ignore upcoming regulations (EU CRA, additional NIS2 implementing acts)
- Assume vendor compliance equals your compliance
- Skip cross-border data transfer requirements (Schrems II, adequacy decisions)

## Common Mistakes

1. **Over-scoping regulations** — Not every vendor needs DORA mapping; only if you're in EU financial services
2. **Ignoring transitional provisions** — Some regulations have phased implementation
3. **Missing sector-specific regulations** — Healthcare has HIPAA, finance has GLBA, etc.
4. **Confusing vendor compliance with your compliance** — Your regulatory obligations don't transfer to the vendor

## See Also

- [DORA & NIS2](references/dora-nis2.md) — Detailed DORA and NIS2 mapping tables
- [SEC Cyber Rules](references/sec-cyber-rules.md) — SEC disclosure requirements and mapping
- [EU AI Act](references/eu-ai-act.md) — AI risk classification and assessment guide
