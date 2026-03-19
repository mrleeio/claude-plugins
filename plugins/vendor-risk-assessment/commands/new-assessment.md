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

## Round 1: Vendor Identity (1 question)

Use AskUserQuestion to collect a single input:

Ask:
> **What vendor would you like to assess?**
> Provide a company name (e.g., "Zulip") or website URL (e.g., https://zulip.com).

Parse the response:
- If a URL is provided, extract the vendor name from the domain and use the URL for research.
- If only a name is provided, use it for web searches to find the vendor's website.

---

## AI Research Phase (no user interaction)

After Round 1, research the vendor using WebSearch and WebFetch. Do NOT ask the user anything during this phase — work silently and present findings in Round 2.

### Research Steps

1. **Find the vendor's website** (if not provided): WebSearch for `"[vendor name]" official site` and identify the primary domain.
2. **WebFetch** the vendor's homepage to extract:
   - **Product/service name** — the specific product(s) offered
   - **Business purpose** — the product's core value proposition
   - **Deployment model** — look for terms like "cloud-hosted", "SaaS", "self-hosted", "on-premises", "hybrid"
3. **WebSearch** for `"[vendor name]" site:trust OR security OR compliance` to find their trust/security page.
4. **WebFetch** the trust/security page (if found) to extract:
   - **Certifications** — SOC 2, ISO 27001, HIPAA, PCI DSS, FedRAMP, etc.
5. **WebSearch** for `"[vendor name]" SOC 2 OR "ISO 27001" OR HIPAA OR "PCI DSS"` to find certification mentions.
6. **WebSearch** for `"[vendor name]" sub-processors OR subprocessors` to check for a sub-processor list (indicates SaaS model).
7. **WebFetch** the vendor's integrations/API documentation page (if found) to determine:
   - **Integration depth** — does the product offer APIs, SSO/SAML, data sync, webhooks, or is it standalone?

### Infer Data Types from Product Category

Based on what the product does, infer the **likely data types** it will process:

| Product Category | Inferred Data Types |
|-----------------|-------------------|
| HR / People management | PII, Financial |
| Payment / Billing | PCI, PII, Financial |
| Healthcare / EHR | PHI, PII |
| Identity / SSO provider | Credentials, PII |
| CRM / Sales | PII, Business Confidential |
| Email / Messaging | PII, Internal |
| Analytics / Monitoring | Internal |
| Project management | Internal |
| CI/CD / Developer tools | Credentials, Internal |
| Marketing (no PII) | Public |
| Documentation / Wiki | Internal |

If the product doesn't clearly fit a category, default to Internal.

### Infer Integration Depth from Product Capabilities

Based on the vendor's documentation and product type:

| Signal | Inferred Integration Depth |
|--------|---------------------------|
| Extensive API docs, webhooks, data sync, shared infrastructure | **Deep** (4) |
| SSO/SAML support, some API endpoints, OAuth | **Moderate** (3) |
| SSO only, browser-based access, no API | **Light** (2) |
| No integrations, standalone product | **Standalone** (1) |

### Infer Data Volume from Product Type

Based on the product category and typical usage:

| Product Category | Inferred Volume |
|-----------------|----------------|
| Infrastructure, payment processing, analytics, CRM at scale | 100K+ records |
| HR, project management, collaboration, mid-market SaaS | 1K–100K records |
| Niche tools, consulting, standalone utilities | < 1K records |

### Research Output (internal — not shown to user yet)

Compile findings into these variables for use in Round 2:
- `detected_vendor_name`: confirmed company name
- `detected_website`: vendor's primary URL
- `detected_product`: product/service name or Unknown
- `detected_deployment_model`: SaaS / Self-hosted / Hybrid / Unknown
- `detected_business_purpose`: one-line description or Unknown
- `detected_certifications`: list of found certifications or empty
- `inferred_data_types`: list of likely data types based on product category
- `inferred_data_volume`: < 1K / 1K–100K / 100K+
- `inferred_integration_depth`: Deep / Moderate / Light / Standalone
- `research_confidence`: High (multiple sources confirm) / Medium (single source) / Low (inferred) / None

If research yields nothing useful (all Unknown), fall back to asking in Round 2.

---

## Round 2: Review Findings (confirmation only)

Present **all** research findings — both auto-detected and inferred — for the user to confirm or correct. Do NOT ask the user to fill in blanks; every field should already have a value.

### If research found results:

Ask:
> **Here's what I found about [Vendor Name]:**
>
> | Detail | Value | How determined |
> |--------|-------|----------------|
> | Website | [detected_website] | Auto-detected |
> | Product/Service | [detected_product] | Auto-detected |
> | Business Purpose | [detected_business_purpose] | Auto-detected |
> | Deployment Model | [detected_deployment_model] | Auto-detected |
> | Certifications | [detected_certifications] | Auto-detected |
> | Data Types | [inferred_data_types] | Inferred from product category |
> | Data Volume | [inferred_data_volume] | Inferred from product type |
> | Integration Depth | [inferred_integration_depth] | Inferred from product capabilities |
>
> **Does this look right?** Let me know if anything needs correcting (e.g., "data types should include PCI" or "integration is actually standalone").

### If research found nothing:

If the vendor cannot be found online at all, fall back to asking the user to provide the missing details:
> I wasn't able to find information about [Vendor Name] online. I'll need you to fill in the basics:
>
> 1. **Website URL**
> 2. **Product/Service** — what specific product are you assessing?
> 3. **Deployment model** — SaaS, Self-hosted, or Hybrid?
> 4. **Business purpose** — what business function does this support?
> 5. **Data types** — what data will this vendor access? (PHI, PCI, PII, Financial, Credentials, Business Confidential, Internal, Public)
> 6. **Integration depth** — Deep, Moderate, Light, or Standalone?

This fallback should be rare — most commercial vendors have a web presence.

Apply any corrections the user provides to the auto-detected/inferred values.

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
| **First assessment** | 4 | Vendor name/URL → AI research → Review findings → Org profile → Tier confirmation |
| **Subsequent assessments** | 3 | Vendor name/URL → AI research → Review findings → Tier confirmation |
| **Previous wizard** | 13 | One question per field |
