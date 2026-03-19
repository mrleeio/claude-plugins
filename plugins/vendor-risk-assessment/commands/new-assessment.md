---
name: new-assessment
description: Interactive wizard to start a new vendor risk assessment — gather vendor info, determine tier, identify regulations, scaffold workspace
allowed-tools: AskUserQuestion, Read, Glob, Grep, Write, Bash(mkdir *), WebSearch, WebFetch, Skill
---

# New Vendor Risk Assessment

Guide the user through starting a new vendor risk assessment by gathering requirements, determining the vendor tier, and scaffolding the assessment workspace.

## Context Gathering

Before starting, load the vendor-tiering skill:
- `Skill(skill: "vendor-risk-assessment:vendor-tiering")`

## Step 1: Gather Vendor Information

Use AskUserQuestion to collect:

**Question 1: Vendor Name**
Ask: "What is the vendor's name?"

**Question 2: Product/Service**
Ask: "What specific product or service are you assessing?"

**Question 3: Vendor Website**
Ask: "What is the vendor's website URL?"

**Question 4: Deployment Model**
Ask: "What is the deployment model?"
Options:
- **SaaS / Cloud-hosted** — Vendor manages infrastructure
- **Self-hosted / On-premises** — Deployed in your environment
- **Hybrid** — Mix of cloud and on-premises components

**Question 5: Business Purpose**
Ask: "What business function does this vendor support? (e.g., CRM, payment processing, email, analytics)"

## Step 2: Data Classification

**Question 6: Data Types**
Ask: "What types of data will this vendor access or process?" (multiSelect: true)
Options:
- **PHI** — Protected Health Information
- **PCI** — Payment Card Industry data
- **PII** — Personally Identifiable Information (names, emails, SSNs, etc.)
- **Financial** — Financial records, revenue data, banking info
- **Credentials** — Passwords, API keys, tokens, certificates
- **Business Confidential** — Trade secrets, contracts, internal strategy
- **Internal** — Internal communications, project data
- **Public** — Marketing content, public documentation

**Question 7: Data Volume**
Ask: "Approximately how many records/individuals' data will the vendor process?"
Options:
- **< 1,000** records
- **1,000 - 10,000** records
- **10,000 - 100,000** records
- **100,000 - 1,000,000** records
- **> 1,000,000** records

## Step 3: Business Impact Assessment

**Question 8: Business Criticality**
Ask: "What happens if this vendor is unavailable for 24+ hours?"
Options:
- **Core operations halt** — Business cannot function
- **Significant disruption** — Major processes impacted
- **Inconvenient** — Workarounds exist, productivity reduced
- **Minimal impact** — Business continues normally

**Question 9: Replaceability**
Ask: "How long would it take to replace this vendor?"
Options:
- **6+ months** — Deep integration, high switching cost
- **3-6 months** — Moderate integration, significant effort
- **1-3 months** — Manageable transition
- **< 1 month** — Easy to switch, many alternatives

**Question 10: Integration Depth**
Ask: "How deeply does this vendor integrate with your systems?"
Options:
- **Deep** — API/data integration, shared infrastructure, SSO + data sync
- **Moderate** — SSO, some API integration
- **Light** — SSO only or basic web access
- **Standalone** — No integration, independent tool

## Step 4: Regulatory Context

**Question 11: Jurisdiction**
Ask: "In what jurisdictions does your organization operate?" (multiSelect: true)
Options:
- **United States**
- **European Union**
- **United Kingdom**
- **Canada**
- **Asia-Pacific**
- **Other** (specify)

**Question 12: Industry Sector**
Ask: "What is your organization's industry sector?" (multiSelect: true)
Options:
- **Financial Services** (banking, insurance, fintech)
- **Healthcare**
- **Technology / SaaS**
- **Government / Public Sector**
- **Critical Infrastructure** (energy, utilities, transport)
- **Retail / E-commerce**
- **Manufacturing**
- **Education**
- **Other** (specify)

**Question 13: Existing Compliance**
Ask: "What compliance frameworks apply to your organization?" (multiSelect: true)
Options:
- **SOC 2**
- **ISO 27001**
- **HIPAA**
- **PCI DSS**
- **SOX**
- **GDPR**
- **DORA**
- **NIS2**
- **FedRAMP**
- **Other** (specify)
- **Not sure**

## Step 5: Determine Vendor Tier

Based on the gathered information, calculate the tier using the decision matrix:

1. Score each factor (Data Sensitivity, Business Criticality, Replaceability, Integration Depth, Regulatory Exposure) on a 1-4 scale
2. Sum the scores
3. Determine tier: Critical (≥16), High (≥12), Medium (≥8), Low (<8)

Present the tier determination with justification:

```
## Vendor Tier Assessment

**Vendor:** [Name]
**Calculated Tier:** [Critical/High/Medium/Low]
**Score:** [X/20]

| Factor | Rating | Score | Justification |
|--------|--------|:-----:|---------------|
| Data Sensitivity | [Level] | [1-4] | [Why] |
| Business Criticality | [Level] | [1-4] | [Why] |
| Replaceability | [Level] | [1-4] | [Why] |
| Integration Depth | [Level] | [1-4] | [Why] |
| Regulatory Exposure | [Level] | [1-4] | [Why] |
```

Confirm the tier with the user and allow override if they disagree.

## Step 6: Identify Applicable Regulations

Based on jurisdiction, sector, and data types, auto-identify applicable regulations:

- **EU + Financial Services** → DORA, NIS2, GDPR
- **US + Public Company** → SEC Cyber Disclosure, SOX
- **US + Healthcare** → HIPAA
- **EU + AI vendor** → EU AI Act
- **Payment processing** → PCI DSS 4.0
- **EU + Digital products** → EU CRA (upcoming)
- **Critical Infrastructure** → NIS2

Present the list and confirm with user.

## Step 7: Scaffold Assessment Workspace

Create the assessment directory structure:

```
assessments/[vendor-name-lowercase]/
├── README.md              # Assessment overview, tier, timeline
├── research-dossier.md    # Research findings by domain
├── evidence/              # Directory for collected evidence files
│   └── .gitkeep
├── questionnaire.md       # Vendor questionnaire (populated per tier)
├── scoring.md             # Risk scoring worksheet
├── report.md              # Final VRA report (from template)
└── remediation.md         # Remediation tracking
```

### README.md Content

```markdown
# Vendor Risk Assessment: [Vendor Name]

**Product/Service:** [Product]
**Vendor Website:** [URL]
**Deployment Model:** [SaaS/Self-hosted/Hybrid]
**Business Purpose:** [Purpose]

## Assessment Details

| Field | Value |
|-------|-------|
| **Tier** | [Critical/High/Medium/Low] |
| **Data Classification** | [Restricted/Confidential/Internal/Public] |
| **Data Types** | [PHI, PII, etc.] |
| **Applicable Regulations** | [DORA, HIPAA, etc.] |
| **Assessment Start Date** | [Date] |
| **Target Completion** | [Date + cadence] |
| **Assessor** | [Name] |

## Assessment Progress

- [ ] Vendor research complete
- [ ] Evidence collected
- [ ] Evidence verified
- [ ] Domain scoring complete
- [ ] Report drafted
- [ ] Report reviewed
- [ ] Remediation plan created
- [ ] Final recommendation issued

## Next Steps

1. Run `/vendor-risk-assessment:team-research` to start parallel vendor research
2. Collect evidence (SOC 2 report, ISO cert, pentest, DPA)
3. Complete domain scoring with `/vendor-risk-assessment:score-vendor`
4. Draft report using the vra-report-writing skill
5. Review with `/agents vendor-risk-assessment:vra-reviewer`
```

### report.md

Copy the full report template from `skills/vra-report-writing/assets/templates/full-report.md` and pre-fill:
- Vendor name, product, deployment model
- Tier and justification
- Data classification
- Applicable regulations
- Assessment date

## Step 8: Summary and Next Steps

Present a summary of everything set up and recommend the next actions:

1. **Start research** — Run `/vendor-risk-assessment:team-research` for parallel OSINT research
2. **Request evidence** — List specific documents to request from the vendor based on tier
3. **Timeline** — Suggest assessment completion timeline based on tier
