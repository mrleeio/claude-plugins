---
name: team-research
description: Orchestrate an agent team for parallel vendor research across domain groups
allowed-tools: AskUserQuestion, Read, Glob, Grep, Write, Edit, Agent, WebSearch, WebFetch, Skill
---

# Team Research

Orchestrate an agent team that performs parallel vendor research across domain groups. This parallelizes the most time-intensive phase of a VRA — initial research.

## Context Gathering

Locate the assessment workspace:
- Use Glob to find `assessments/*/README.md` files
- If multiple assessments exist, ask the user which vendor to research
- Read the README to get vendor name, website, deployment model, tier, and data types

## Prerequisites

Load the vendor-research skill for context:
- `Skill(skill: "vendor-risk-assessment:vendor-research")`

## Task

Create an agent team with 4 domain-specific researcher teammates that investigate the vendor in parallel. Each teammate researches a group of related assessment domains simultaneously, then results are synthesized into a unified research dossier.

## Step 1: Confirm Research Scope

Present the research plan:

```
## Research Plan: [Vendor Name]

**Website:** [URL]
**Deployment Model:** [Model]
**Tier:** [Tier]

### Research Teams

| Teammate | Domains | Focus |
|----------|---------|-------|
| Security Researcher | InfoSec, Access Control, Network Security, Vulnerability Mgmt | Trust pages, pentest history, certs, CVEs |
| Compliance Researcher | Governance, Compliance/Legal, Regulatory Mapping, AI Risk | Regulatory filings, certs, DPAs, AI governance |
| Operations Researcher | Operations, BCP/DR, Incident Mgmt, HR Security, Physical Security | SOC 2 ops, incident history, uptime, DR |
| Supply Chain Researcher | Supply Chain, Fourth-Party Risk, Data Security, Continuous Monitoring | Sub-processors, SBOMs, security ratings |
```

Ask: "Ready to launch parallel research? (Y/N)"

## Step 2: Launch Agent Team

Use the Agent tool to spawn 4 researcher agents in parallel. Each agent should:

1. Load the vendor-research skill
2. Research their assigned domains using WebSearch and WebFetch
3. Write findings to the assessment directory

### Security Researcher Agent Prompt

```
You are a security researcher conducting vendor due diligence on [VENDOR_NAME] ([VENDOR_URL]).

Load the skill: Skill(skill: "vendor-risk-assessment:vendor-research")

Research these domains for [VENDOR_NAME]:
1. Information Security — Search for trust/security page, CISO/team, security program
2. Access Control — IAM practices, MFA, privileged access management
3. Network Security — Infrastructure security, segmentation, DDoS protection
4. Vulnerability Management — Patching cadence, bug bounty, pentest reports, CVE exposure

For each domain:
- Search at least 2-3 sources
- Note the source URL and date for every finding
- Rate the domain (Strong/Adequate/Weak/Unknown)
- Identify gaps and follow-up questions

Write your findings to: assessments/[vendor-dir]/research-security.md
```

### Compliance Researcher Agent Prompt

```
You are a compliance researcher conducting vendor due diligence on [VENDOR_NAME] ([VENDOR_URL]).

Load the skill: Skill(skill: "vendor-risk-assessment:vendor-research")

Research these domains for [VENDOR_NAME]:
1. Governance — Board oversight, risk management framework, security leadership
2. Compliance & Legal — Certifications (SOC 2, ISO 27001), audit history, DPA/BAA
3. Regulatory Mapping — Regulatory filings, compliance claims, jurisdiction
4. AI Risk — If vendor uses AI: model governance, training data, EU AI Act classification
5. Privacy — Privacy program, DSAR process, data minimization

For each domain:
- Search certification registries for validation
- Check for regulatory filings or enforcement actions
- Note the source URL and date for every finding
- Rate the domain (Strong/Adequate/Weak/Unknown)

Write your findings to: assessments/[vendor-dir]/research-compliance.md
```

### Operations Researcher Agent Prompt

```
You are an operations researcher conducting vendor due diligence on [VENDOR_NAME] ([VENDOR_URL]).

Load the skill: Skill(skill: "vendor-risk-assessment:vendor-research")

Research these domains for [VENDOR_NAME]:
1. Operations — Change management, asset management, configuration management
2. BCP/DR — Business continuity, disaster recovery, RTO/RPO, geographic redundancy
3. Incident Management — IR plan, breach history, notification timelines, status page
4. HR Security — Background checks, security training programs
5. Physical Security — Data center controls, certifications, environmental controls

For each domain:
- Search for status page and uptime history
- Check for past incidents and breach disclosures
- Search for SOC 2 operational controls
- Note the source URL and date for every finding
- Rate the domain (Strong/Adequate/Weak/Unknown)

Write your findings to: assessments/[vendor-dir]/research-operations.md
```

### Supply Chain Researcher Agent Prompt

```
You are a supply chain researcher conducting vendor due diligence on [VENDOR_NAME] ([VENDOR_URL]).

Load the skill: Skill(skill: "vendor-risk-assessment:vendor-research")

Research these domains for [VENDOR_NAME]:
1. Data Security — Encryption practices, key management, DLP, data handling
2. Supply Chain — Sub-processor list, vendor's own third-party risk management
3. Fourth-Party Risk — Cloud providers, shared dependencies, concentration risk
4. Continuous Monitoring — Security ratings (if available), breach monitoring status

For each domain:
- Search for sub-processor/subprocessor lists
- Check data processing agreements
- Identify cloud infrastructure providers
- Note the source URL and date for every finding
- Rate the domain (Strong/Adequate/Weak/Unknown)

Write your findings to: assessments/[vendor-dir]/research-supply-chain.md
```

## Step 3: Synthesize Findings

After all agents complete, read their individual findings files and synthesize into a unified research dossier:

1. Read all `research-*.md` files from the assessment directory
2. Merge findings into the unified `research-dossier.md` organized by all 15 domains
3. Resolve any contradictions between teammates' findings
4. Identify cross-domain patterns and systemic risks
5. Create a consolidated evidence inventory
6. List gaps requiring follow-up with the vendor

### Unified Dossier Format

```markdown
# Research Dossier: [Vendor Name]

**Date:** [Date]
**Methodology:** Parallel OSINT research across 4 domain groups
**Sources Consulted:** [Count]

## Executive Summary
[3-5 sentence overview synthesizing all research]

## Domain Findings

### 1. Information Security
**Rating:** [Strong/Adequate/Weak/Unknown]
**Evidence:**
- [Finding] — Source: [URL], Date: [Date]
**Gaps:**
- [Gap requiring follow-up]

[... all 15 domains ...]

## Cross-Domain Observations
- [Patterns spanning multiple domains]

## Evidence Inventory
| Type | Available | Source | Verified |
|------|:-:|--------|:-:|
| SOC 2 Type II | ✅/❌ | [source] | ✅/❌ |
| ... | | | |

## Recommended Follow-Up
1. [Priority evidence to request]
2. [Questions for vendor]
3. [Areas needing deeper investigation]
```

## Step 4: Update Assessment Status

- Update `README.md` checklist to mark research as complete
- Clean up individual research files (optionally keep as appendices)
- Notify the user of completion and recommend next steps
