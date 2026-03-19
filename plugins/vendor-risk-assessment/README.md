# Vendor Risk Assessment Plugin

A Claude Code plugin for performing comprehensive vendor risk assessments (VRAs) following industry best practices including NIST, ISO 27001, SOC 2, SIG, CSA CCM, and FAIR methodologies.

## Features

- **15 Assessment Domains** — Information Security, Access Control, Network Security, Data Security, Vulnerability Management, Governance, Compliance & Legal, Operations, BCP/DR, Incident Management, HR Security, Physical Security, Supply Chain, AI Risk, Privacy
- **Automated Research** — OSINT-powered vendor research with parallel agent teams
- **Evidence Verification** — Structured evidence hierarchy with verification methods
- **Risk Scoring** — 5x5 qualitative matrix, FAIR quantitative analysis, weighted composite scoring
- **Vendor Tiering** — Critical/High/Medium/Low classification driving assessment depth
- **Regulatory Mapping** — DORA, NIS2, SEC Cyber, EU CRA, EU AI Act coverage
- **Report Generation** — 8-section VRA report with fill-in templates
- **Continuous Monitoring** — Post-assessment monitoring cadence and security ratings integration

## Getting Started

### Installation

```bash
claude --plugin-dir ./plugins/vendor-risk-assessment
```

### Start a New Assessment

```
/vendor-risk-assessment:new-assessment
```

This interactive wizard will:
1. Gather vendor information
2. Classify data sensitivity
3. Determine vendor tier (Critical/High/Medium/Low)
4. Identify applicable regulations
5. Scaffold the assessment workspace

### Parallel Research

```
/vendor-risk-assessment:team-research
```

Launches 4 agent teammates to research the vendor in parallel across domain groups:
- Security Researcher (InfoSec, Access Control, Network, Vulnerability Mgmt)
- Compliance Researcher (Governance, Compliance, Regulatory, AI Risk, Privacy)
- Operations Researcher (Operations, BCP/DR, Incident Mgmt, HR, Physical)
- Supply Chain Researcher (Data Security, Supply Chain, Fourth-Party, Monitoring)

### Score the Vendor

```
/vendor-risk-assessment:score-vendor
```

Domain-by-domain risk scoring with inherent/residual calculation and weighted composite.

### Check Progress

```
/vendor-risk-assessment:assessment-status
```

## Commands

| Command | Description |
|---------|-------------|
| `/vendor-risk-assessment:new-assessment` | Start a new vendor risk assessment |
| `/vendor-risk-assessment:score-vendor` | Score vendor risk across all domains |
| `/vendor-risk-assessment:assessment-status` | Check assessment progress and gaps |
| `/vendor-risk-assessment:team-research` | Launch parallel research agent team |

## Skills

| Skill | Description |
|-------|-------------|
| `vendor-research` | Research vendor security posture across 15 domains |
| `source-verification` | Verify vendor claims and evidence quality |
| `vra-report-writing` | Write VRA reports (8-section structure) |
| `risk-scoring` | 5x5 matrix, FAIR analysis, weighted composite |
| `vendor-tiering` | Tier classification and vendor lifecycle |
| `remediation-planning` | Now/Next/Later prioritization with SLAs |
| `fourth-party-risk` | Sub-processor, SBOM, and concentration risk |
| `regulatory-mapping` | Map to DORA, NIS2, SEC, EU AI Act |
| `continuous-monitoring` | Post-assessment monitoring and ratings |

## Agents

| Agent | Description |
|-------|-------------|
| `vendor-researcher` | Autonomous OSINT research agent |
| `vra-reviewer` | Report quality and completeness reviewer |
| `evidence-analyst` | Evidence file analysis and verification |

## Hooks

| Hook | Event | Purpose |
|------|-------|---------|
| `reference-loader.sh` | UserPromptSubmit | Auto-load relevant references based on keywords |
| `report-validator.sh` | PreToolUse | Block edits to assessment files until skill loaded |

## Assessment Workflow

```
1. New Assessment (/new-assessment)
   └── Vendor info → Tier determination → Workspace scaffold

2. Research (/team-research)
   └── 4 parallel agents → Unified research dossier

3. Evidence Collection
   └── Request SOC 2, ISO cert, pentest, DPA from vendor

4. Evidence Analysis (evidence-analyst agent)
   └── Analyze evidence → Map to domains → Flag red flags

5. Risk Scoring (/score-vendor)
   └── Domain scoring → Weighted composite → FAIR (Critical/High)

6. Report Writing (vra-report-writing skill)
   └── 8-section report from template

7. Review (vra-reviewer agent)
   └── Quality check → Consistency → Completeness

8. Remediation Planning (remediation-planning skill)
   └── Now/Next/Later → SLAs → Compensating controls

9. Final Recommendation
   └── Approve / Conditional Approve / Deny
```

## Frameworks Supported

- **NIST Cybersecurity Framework (CSF)**
- **ISO 27001:2022**
- **SOC 2 Trust Service Criteria**
- **Shared Information Gathering (SIG) Questionnaire**
- **CSA Cloud Controls Matrix (CCM)**
- **FAIR (Factor Analysis of Information Risk)**
- **DORA (Digital Operational Resilience Act)**
- **NIS2 Directive**
- **SEC Cybersecurity Disclosure Rules**
- **EU AI Act**
- **EU Cyber Resilience Act (CRA)**
- **NIST AI Risk Management Framework**
- **ISO 42001 (AI Management System)**

## License

MIT
