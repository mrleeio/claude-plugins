# VRA Writing Standards

Standards for tone, formatting, citations, and audience-appropriate language in Vendor Risk Assessment reports.

---

## Professional Tone Guidelines

### Core Principles
- **Objective:** Present findings based on evidence, not opinion. Use "the assessment identified" rather than "we believe" or "it seems."
- **Evidence-based:** Every claim must be supported by a cited evidence source. If evidence is insufficient, state that explicitly.
- **Precise:** Use specific, measurable language. "MFA is not enforced for 3 of 12 admin accounts" rather than "MFA coverage is incomplete."
- **Balanced:** Acknowledge strengths alongside weaknesses. A report that only lists problems lacks credibility.
- **Neutral:** Avoid language that conveys vendor bias, positive or negative. The report states facts and assesses risk.

### Language to Use

| Instead of... | Write... |
|---------------|----------|
| "The vendor seems to have good security" | "The vendor's SOC 2 Type II report demonstrates effective controls for [specific area]" |
| "This is a major concern" | "This gap presents a high inherent risk of [impact] due to [cause]" |
| "They should fix this" | "Remediation requires [specific action] within [timeframe]" |
| "Security is adequate" | "Controls in [domain] meet baseline requirements as evidenced by [source]" |
| "The vendor claims..." | "The vendor attests that... (Evidence Tier 5: self-attestation without supporting documentation)" |

### Language to Avoid
- Marketing language: "best-in-class," "cutting-edge," "industry-leading," "world-class"
- Emotional language: "alarming," "impressive," "disappointing," "shocking"
- Hedge words without purpose: "somewhat," "arguably," "relatively," "fairly"
- Absolute claims without evidence: "always," "never," "guarantees," "ensures"
- Informal language: contractions, colloquialisms, jargon without definition

---

## Formatting Standards

### Headers
- **H1:** Report title only (one per document)
- **H2:** Major sections (Executive Summary, Vendor Profile, etc.)
- **H3:** Subsections and individual domain findings
- **H4:** Detail-level headers within subsections
- Maintain consistent header hierarchy; never skip levels

### Tables
- Use tables for structured comparisons, scoring matrices, and remediation items
- Always include a header row
- Align numeric columns to the center
- Use consistent column ordering across similar tables
- Caption tables if meaning is not immediately obvious from context

### Rating Scales
- Use the same 1-5 scale throughout the entire report
- Always pair the numeric rating with its label: "3 — Partial Implementation"
- Apply the same scale definitions in every section; never redefine mid-report
- When presenting ratings in tables, include the scale legend at least once per section

### Lists
- Use bullet points for unordered items (findings, gaps, strengths)
- Use numbered lists for sequential or prioritized items (remediation steps, conditions)
- Limit nesting to 2 levels maximum
- Start each bullet with a capital letter; end with a period if it is a complete sentence

### Dates and Numbers
- Use ISO 8601 format for dates: YYYY-MM-DD
- Spell out numbers one through nine; use digits for 10 and above
- Use consistent units throughout (days, not a mix of days and business days, unless distinguished)
- Include currency codes for financial figures (e.g., USD 1.2M)

---

## Citation Format

### Evidence References
Every finding must include a citation to its evidence source. Use the following format:

```
[Source Type: Document Name (Date), Section/Control Reference]
```

#### Examples
- `[SOC 2 Type II: Acme Corp Annual Report (2025-06-15), CC6.1]`
- `[ISO 27001 Certificate: Bureau Veritas (2025-03-01), Clause A.9.4]`
- `[Penetration Test: SecureFirm Report (2025-09-20), Finding #7]`
- `[SIG Core Response: Question I.4.2 (2025-11-01)]`
- `[Vendor Interview: CISO Meeting (2025-08-14), Topic: Incident Response]`
- `[Public Source: Company Security Page, accessed 2025-10-01]`

### Evidence Tier Notation
After the citation, note the evidence tier in parentheses:

```
"Annual penetration testing is performed by an independent firm."
[Penetration Test: SecureFirm Report (2025-09-20), Finding Summary] (Tier 2)
```

### Multiple Sources
When a finding is supported by multiple sources, list them:

```
"Encryption at rest uses AES-256 for all customer data stores."
[SOC 2 Type II (2025), CC6.1] (Tier 1); [SIG Core Response, D.2.1] (Tier 4)
```

---

## Risk Statement Format

All identified risks and gaps must follow the standardized format:

```
Risk of [IMPACT] due to [CAUSE].
```

### Components

| Component | Description | Example |
|-----------|-------------|---------|
| **Impact** | The negative outcome to YOUR organization | "unauthorized access to customer PII" |
| **Cause** | The control gap or deficiency creating the risk | "lack of MFA enforcement on privileged accounts" |

### Examples
- "Risk of **data breach affecting 50,000 customer records** due to **lack of encryption at rest for database backups**."
- "Risk of **extended service outage exceeding RTO** due to **absence of documented and tested disaster recovery procedures**."
- "Risk of **regulatory non-compliance with GDPR Article 28** due to **missing data processing agreement with sub-processor**."
- "Risk of **lateral movement from compromised vendor account** due to **overly permissive API access scoping**."

### Severity Qualification
Optionally qualify the risk with severity context:

```
Risk of [IMPACT] due to [CAUSE]. [SEVERITY CONTEXT].
```

Example: "Risk of unauthorized access to financial data due to shared service accounts. This affects 4 production databases containing SOX-regulated data."

---

## Audience-Appropriate Language

### CISO / Security Leadership
- Use technical security terminology freely
- Reference frameworks and control numbers (e.g., NIST CSF PR.AC-1)
- Focus on risk levels, control gaps, and remediation priorities
- Include scoring methodology details

### Procurement
- Emphasize contractual implications and vendor obligations
- Translate security findings into contract requirements (SLAs, right-to-audit, termination clauses)
- Focus on conditions and timelines
- Minimize technical jargon; define terms when unavoidable

### Legal
- Highlight regulatory and compliance implications
- Reference specific regulations and clauses (e.g., GDPR Article 28, HIPAA 164.314)
- Note data residency and cross-border transfer concerns
- Emphasize liability and indemnification considerations

### Business Owners
- Lead with business impact, not technical details
- Use analogies and plain language for technical concepts
- Focus on the recommendation and what it means for their operations
- Quantify risk in business terms (downtime hours, revenue impact, customer impact)

### Board / Executive Committee
- Executive summary only; 1-page maximum
- Traffic light (Red/Yellow/Green) risk indicators
- Trend comparisons with prior assessments
- Financial exposure estimates where available

---

## Common Writing Mistakes in VRA Reports

### 1. Burying the Recommendation
The recommendation must appear in the first sentence of the Executive Summary. Readers should never have to hunt for the bottom line.

### 2. Findings Without Evidence
Every finding must cite its source and evidence tier. "The vendor uses MFA" is incomplete. "The vendor enforces MFA for all user accounts [SOC 2 Type II (2025), CC6.1] (Tier 1)" is complete.

### 3. Vague Remediation Items
"Improve incident response" is not actionable. "Document and test incident response runbooks for the top 5 threat scenarios, validated through tabletop exercise, within 60 days" is actionable.

### 4. Inconsistent Rating Scales
Using different scales in different sections (1-3 in one place, 1-5 in another, High/Medium/Low labels with different thresholds) destroys report credibility. Pick one scale and use it everywhere.

### 5. Mixing Inherent and Residual Risk
Never present a risk score without clearly labeling whether it is inherent or residual. Mixing the two in the same table or discussion misleads the reader.

### 6. Copy-Paste from Questionnaire Responses
Reports should synthesize and analyze vendor responses, not reproduce them verbatim. Raw questionnaire data belongs in appendices.

### 7. Omitting Strengths
A report that only lists weaknesses appears biased. Acknowledge areas where the vendor demonstrates strong controls; this builds credibility for the identified gaps.

### 8. Passive Voice Overuse
Prefer active voice. "The vendor has not implemented MFA" is clearer than "MFA has not been implemented by the vendor."

### 9. Missing Regulatory Mapping
For vendors handling regulated data, every relevant finding must be mapped to applicable regulatory requirements. Omitting this mapping is a significant gap.

### 10. No Follow-Up Questions
When evidence is insufficient (Tier 5-7), the report must include specific follow-up questions for the vendor rather than simply noting the gap.

---

## Accessibility and Readability Standards

### Readability
- Target a Flesch-Kincaid Grade Level of 12-14 (professional but accessible)
- Keep sentences under 30 words on average
- Limit paragraphs to 4-5 sentences
- Use active voice for at least 80% of sentences
- Define acronyms on first use; include an acronym glossary in appendices

### Document Structure
- Use a table of contents for reports exceeding 10 pages
- Number all pages
- Include document metadata: title, version, date, classification, author
- Use consistent page layout (margins, fonts, spacing)

### Tables and Visual Elements
- Ensure tables have descriptive header rows
- Use color as a supplement, not as the sole indicator (pair with text labels)
- Provide alt-text descriptions for charts and diagrams
- Keep tables to 7 columns or fewer for readability

### Document Classification
- Mark the document classification on every page (e.g., "CONFIDENTIAL")
- Include distribution restrictions in the document header
- Note data retention requirements for the report itself
