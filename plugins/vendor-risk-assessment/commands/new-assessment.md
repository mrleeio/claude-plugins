---
name: new-assessment
description: Interactive wizard to start a new vendor risk assessment — gather vendor info, determine tier, identify regulations, scaffold workspace
allowed-tools: AskUserQuestion, Read, Glob, Grep, Write, Bash(mkdir *), WebSearch, WebFetch, Skill
---

# New Vendor Risk Assessment

Guide the user through starting a new vendor risk assessment in 3-4 interaction rounds (down from 13) by combining questions, auto-detecting vendor details via web research, and inferring business impact scores.

## Setup

Load the vendor-tiering skill:
- `Skill(skill: "vendor-risk-assessment:vendor-tiering")`

---

## Round 1: Vendor Identity (1 compound question)

Use AskUserQuestion to collect three fields in a **single question**:

Ask:
> **Let's start a new vendor risk assessment.**
>
> Please provide the following:
> 1. **Vendor name** — the company name
> 2. **Product/Service** — the specific product or service you're assessing
> 3. **Website URL** — the vendor's website (e.g., https://example.com)

Parse the three values from the response. If any are missing, ask a brief follow-up for just the missing field(s).

---

## AI Research Phase (no user interaction)

After Round 1, research the vendor using WebSearch and WebFetch. Do NOT ask the user anything during this phase — work silently and present findings in Round 2.

### Research Steps

1. **WebSearch** for `"[vendor name]" site:trust OR security OR compliance` to find their trust/security page
2. **WebFetch** the vendor's website (homepage or /security, /trust, /compliance page) to extract:
   - **Deployment model** — look for terms like "cloud-hosted", "SaaS", "self-hosted", "on-premises", "hybrid"
   - **Business purpose** — extract the product's core value proposition
   - **Certifications** — SOC 2, ISO 27001, HIPAA, PCI DSS, FedRAMP, etc.
3. **WebSearch** for `"[vendor name]" SOC 2 OR "ISO 27001" OR HIPAA OR "PCI DSS"` to find certification mentions
4. **WebSearch** for `"[vendor name]" sub-processors OR subprocessors` to check for a sub-processor list (indicates SaaS model)

### Research Output (internal — not shown to user yet)

Compile findings into these variables for use in Round 2:
- `detected_deployment_model`: SaaS / Self-hosted / Hybrid / Unknown
- `detected_business_purpose`: one-line description or Unknown
- `detected_certifications`: list of found certifications or empty
- `research_confidence`: High (multiple sources confirm) / Medium (single source) / Low (inferred) / None

If research yields nothing useful (all Unknown), fall back to asking these in Round 2.

---

## Round 2: Assessment Context (1 compound question)

Present research findings and ask for user-known details in a **single question**.

### If research found results:

Ask:
> **Here's what I found about [Vendor Name]:**
>
> | Detail | Auto-detected | Source |
> |--------|--------------|--------|
> | Deployment Model | [detected_deployment_model] | [URL or "vendor website"] |
> | Business Purpose | [detected_business_purpose] | [URL or "vendor website"] |
> | Certifications | [detected_certifications] | [URL(s)] |
>
> **Corrections?** If any of the above are wrong, let me know and I'll update them.
>
> Now I need a few things only you would know:
>
> 1. **Data types** this vendor will access (select all that apply):
>    - PHI (Protected Health Information)
>    - PCI (Payment Card Industry data)
>    - PII (names, emails, SSNs, etc.)
>    - Financial (financial records, banking info)
>    - Credentials (passwords, API keys, tokens)
>    - Business Confidential (trade secrets, contracts)
>    - Internal (internal comms, project data)
>    - Public (marketing content, public docs)
>
> 2. **Data volume** — approximately how many records/individuals:
>    - Less than 1,000
>    - 1,000 – 100,000
>    - More than 100,000
>
> 3. **Integration depth** — how will this connect to your systems?
>    - **Deep** — API/data integration, shared infrastructure, SSO + data sync
>    - **Moderate** — SSO, some API integration
>    - **Light** — SSO only or basic web access
>    - **Standalone** — no integration, independent tool

### If research found nothing:

Ask the same question but replace the findings table with direct questions for deployment model and business purpose:
> I wasn't able to find security details for [Vendor Name] online. I'll need a few extra details from you:
>
> 1. **Deployment model**:
>    - SaaS / Cloud-hosted
>    - Self-hosted / On-premises
>    - Hybrid
>
> 2. **Business purpose** — what business function does this support?
>
> 3-5. [same data types, volume, and integration depth questions as above]

Parse all values from the response. Apply any corrections the user provides to the auto-detected values.

---

## Infer Business Impact (no user interaction)

Instead of asking the user "what happens if this vendor is unavailable" (which assumes internal knowledge), **derive Business Criticality and Replaceability from known data**.

### Business Criticality Inference

Based on **data types** and **integration depth**:

| Integration Depth | Restricted Data (PHI/PCI/Credentials) | Confidential Data (PII/Financial/Biz Conf) | Internal/Public Only |
|-------------------|:---:|:---:|:---:|
| **Deep** | 4 — Core operations halt | 3 — Significant disruption | 3 — Significant disruption |
| **Moderate** | 3 — Significant disruption | 2 — Inconvenient | 2 — Inconvenient |
| **Light** | 2 — Inconvenient | 2 — Inconvenient | 1 — Minimal impact |
| **Standalone** | 2 — Inconvenient | 1 — Minimal impact | 1 — Minimal impact |

**Data sensitivity level** is determined by the highest-sensitivity data type selected:
- **Restricted**: PHI, PCI, Credentials
- **Confidential**: PII, Financial, Business Confidential
- **Internal/Public**: Internal, Public

### Replaceability Inference

Based on **integration depth** and **deployment model**:

| Integration Depth | SaaS | Self-hosted | Hybrid |
|-------------------|:---:|:---:|:---:|
| **Deep** | 4 — 6+ months | 3 — 3-6 months | 4 — 6+ months |
| **Moderate** | 3 — 3-6 months | 2 — 1-3 months | 3 — 3-6 months |
| **Light** | 2 — 1-3 months | 2 — 1-3 months | 2 — 1-3 months |
| **Standalone** | 1 — < 1 month | 1 — < 1 month | 1 — < 1 month |

---

## Round 3: Organization Profile (conditional — first assessment only)

Check if `assessments/.org-profile.json` exists using Glob.

### If the file does NOT exist:

Ask a **single compound question**:

> **One-time setup: Organization Profile**
>
> I'll save this so you won't be asked again for future assessments.
>
> 1. **Jurisdictions** where your organization operates (select all that apply):
>    - United States
>    - European Union
>    - United Kingdom
>    - Canada
>    - Asia-Pacific
>    - Other (specify)
>
> 2. **Industry sectors** (select all that apply):
>    - Financial Services (banking, insurance, fintech)
>    - Healthcare
>    - Technology / SaaS
>    - Government / Public Sector
>    - Critical Infrastructure (energy, utilities, transport)
>    - Retail / E-commerce
>    - Manufacturing
>    - Education
>    - Other (specify)
>
> 3. **Compliance frameworks** that apply to your organization:
>    - SOC 2
>    - ISO 27001
>    - HIPAA
>    - PCI DSS
>    - SOX
>    - GDPR
>    - DORA
>    - NIS2
>    - FedRAMP
>    - Other (specify)
>    - Not sure

Save the response to `assessments/.org-profile.json`:

```json
{
  "jurisdictions": ["..."],
  "industry_sectors": ["..."],
  "compliance_frameworks": ["..."],
  "created": "YYYY-MM-DD",
  "last_updated": "YYYY-MM-DD"
}
```

Create the `assessments/` directory first if it doesn't exist: `Bash(mkdir -p assessments)`

### If the file DOES exist:

Read the file and use the saved values. **Skip this round entirely** — do not ask the user anything. Mention in Round 4 that organization profile was loaded from the saved profile.

---

## Round 4: Tier Confirmation

Calculate scores for all 5 factors and present the tier determination.

### Score Calculation

1. **Data Sensitivity (1-4):** Based on highest-sensitivity data type selected
   - 4: PHI, PCI, or Credentials selected
   - 3: PII, Financial, or Business Confidential selected
   - 2: Internal only
   - 1: Public only

2. **Business Criticality (1-4):** From inference table above

3. **Replaceability (1-4):** From inference table above

4. **Integration Depth (1-4):**
   - Deep = 4, Moderate = 3, Light = 2, Standalone = 1

5. **Regulatory Exposure (1-4):** Based on organization profile + data types
   - 4: Directly regulated data (PHI → HIPAA, PCI → PCI DSS, EU + PII → GDPR)
   - 3: Indirectly supports compliance (SOX environment, financial data)
   - 2: Limited regulatory relevance
   - 1: No regulatory impact

### Present the Tier Table

Ask:
> ## Vendor Tier Assessment: [Vendor Name]
>
> **Calculated Tier: [Critical/High/Medium/Low]**
> **Score: [X/20]**
>
> | Factor | Rating | Score | Source | Justification |
> |--------|--------|:-----:|--------|---------------|
> | Data Sensitivity | [Level] | [1-4] | User input | [Why] |
> | Business Criticality | [Level] | [1-4] | Inferred | [Why — from data types + integration] |
> | Replaceability | [Level] | [1-4] | Inferred | [Why — from integration + deployment] |
> | Integration Depth | [Level] | [1-4] | User input | [Why] |
> | Regulatory Exposure | [Level] | [1-4] | Auto-detected | [Why — from org profile + data types] |
>
> **Tier thresholds:** Critical ≥ 16 · High ≥ 12 · Medium ≥ 8 · Low < 8
>
> *Inferred scores are derived from your inputs. Override any value by telling me (e.g., "Business Criticality should be 4").*
>
> **Does this tier look right, or would you like to adjust any scores?**

If the user overrides any scores, recalculate the tier.

---

## Step 5: Identify Applicable Regulations

Based on jurisdiction, sector, and data types (from org profile + this assessment), auto-identify applicable regulations:

- **EU + Financial Services** → DORA, NIS2, GDPR
- **US + Public Company** → SEC Cyber Disclosure, SOX
- **US + Healthcare** → HIPAA
- **EU + AI vendor** → EU AI Act
- **Payment processing** → PCI DSS 4.0
- **EU + Digital products** → EU CRA (upcoming)
- **Critical Infrastructure** → NIS2

Present the list and confirm with the user (this is part of the Round 4 response, not a separate interaction round).

---

## Step 6: Scaffold Assessment Workspace

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

---

## Step 7: Summary and Next Steps

Present a summary of everything set up and recommend the next actions:

1. **Start research** — Run `/vendor-risk-assessment:team-research` for parallel OSINT research
2. **Request evidence** — List specific documents to request from the vendor based on tier
3. **Timeline** — Suggest assessment completion timeline based on tier

---

## Interaction Summary

| Scenario | Rounds | Details |
|----------|:------:|---------|
| **First assessment** | 4 | Vendor identity → AI research → Assessment context → Org profile → Tier confirmation |
| **Subsequent assessments** | 3 | Vendor identity → AI research → Assessment context → Tier confirmation |
| **Previous wizard** | 13 | One question per field |
