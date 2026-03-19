# Verification Methods Reference

This document provides step-by-step procedures for verifying vendor security evidence, identifying red flags, analyzing gaps, and documenting findings.

---

## Certificate Authenticity Verification

### ISO 27001 Certificate Verification

1. **Identify the certification body** -- The name appears on the certificate (e.g., BSI, Schellman, A-LIGN, Bureau Veritas).
2. **Confirm accreditation** -- The certification body must be accredited by a national accreditation body that is a member of the IAF Multilateral Recognition Arrangement (MLA).
   - UKAS (United Kingdom)
   - ANAB (United States)
   - DAkkS (Germany)
   - JAS-ANZ (Australia/New Zealand)
   - Search the IAF CertSearch database at iafcertsearch.org for the certificate.
3. **Registry lookup** -- Visit the certification body's public registry and search for the vendor by name or certificate number. Confirm:
   - The certificate is listed and active (not suspended or withdrawn).
   - The scope matches what the vendor claims.
   - The validity dates are current.
4. **Check version** -- Confirm the certificate references ISO/IEC 27001:2022. Certificates referencing ISO 27001:2013 should have been transitioned by October 31, 2025.
5. **Request the Statement of Applicability** -- The certificate alone does not show which controls are implemented. The SoA provides that detail.

### HITRUST Verification

1. Confirm the assessor is listed in the HITRUST Assessor Directory.
2. Request the validated assessment letter and confirm the certification level (e1, i1, or r2).
3. Check the assessment date and expiration.

### PCI DSS Verification

1. Request the Attestation of Compliance (AOC).
2. Verify the QSA firm on the PCI Security Standards Council website (pcisecuritystandards.org).
3. Confirm the AOC covers the specific services relevant to your engagement.
4. Check that the AOC references PCI DSS v4.0 or v4.0.1.

### FedRAMP Verification

1. Search the FedRAMP Marketplace (marketplace.fedramp.gov) for the vendor.
2. Confirm the authorization status is "Authorized" (not "In Process" or "Ready").
3. Note the impact level (Low, Moderate, High) and confirm it meets your requirements.
4. Review the authorization date and sponsoring agency.

---

## SOC 2 Report Analysis

### Step 1: Read the Auditor's Opinion (Section I)

The opinion is the single most important element. It appears in the independent service auditor's report, typically in the first few pages.

- **Unqualified opinion** -- The auditor found no material issues. The controls are suitably designed (Type I) or suitably designed and operating effectively (Type II). This is what you want to see.
- **Qualified opinion** -- The auditor found one or more material issues. Read the basis for qualification carefully. A qualified opinion is a significant finding.
- **Adverse opinion** -- The controls are materially misstated. This is rare and is a deal-breaker.
- **Disclaimer of opinion** -- The auditor could not obtain sufficient evidence. Treat this the same as an adverse opinion.

### Step 2: Confirm Scope (Section II -- Management Assertion)

1. Read the system description. Identify the specific products, services, and infrastructure covered.
2. Confirm that the service your organization uses (or plans to use) is explicitly within scope.
3. Note the Trust Service Criteria included (Security, Availability, Confidentiality, Processing Integrity, Privacy). If a criterion you need is absent, document it as a gap.
4. Identify subservice organizations. If the vendor carves out a subservice organization (e.g., AWS), you need to separately assess that provider or confirm your organization already has assurance over it.

### Step 3: Review Exceptions (Section IV or V)

1. Read each exception listed in the description of tests and results.
2. For each exception, assess:
   - **Severity** -- Does the exception relate to a critical control (e.g., access management, encryption, incident response)?
   - **Frequency** -- Was it a one-time lapse or a recurring issue across the audit period?
   - **Remediation** -- Has the vendor addressed the exception? Is there a management response indicating corrective action?
3. A small number of minor exceptions in a Type II report is common and not necessarily disqualifying. Multiple exceptions in critical control areas is a red flag.

### Step 4: Review CUECs (Complementary User Entity Controls)

1. Locate the CUECs section (typically in the system description or a dedicated section).
2. Document each CUEC.
3. Assign internal ownership for each CUEC. These are controls your organization is responsible for implementing.
4. If your organization cannot implement a required CUEC, document the resulting risk.

### Step 5: Assess Currency

1. Check the report date and the period covered.
2. A Type II report with a period ending more than 12 months ago provides reduced assurance. Request an updated report or a bridge letter covering the gap.
3. If the vendor is transitioning from Type I to Type II, request a timeline for the Type II report.

---

## Cross-Referencing Vendor Claims Against Independent Sources

### Procedure

1. **Collect vendor claims** -- Gather all security-related claims from the vendor's website, sales materials, security page, trust center, and any completed questionnaires.
2. **Map claims to evidence** -- For each claim, identify the supporting evidence:
   - "SOC 2 Type II certified" --> Request the SOC 2 Type II report.
   - "ISO 27001 certified" --> Request the certificate and verify via registry.
   - "Annual penetration testing" --> Request the most recent penetration test report.
   - "Data encrypted at rest and in transit" --> Check SOC 2 report control descriptions or request technical documentation.
3. **Verify specifics** -- General claims require specific evidence:
   - "Enterprise-grade security" is a marketing term, not a verifiable claim.
   - "256-bit AES encryption at rest" can be verified against SOC 2 control descriptions or architecture documentation.
4. **Check for contradictions** -- Compare evidence sources against each other:
   - Does the SOC 2 scope match what the vendor told you is covered?
   - Does the penetration test scope include the systems the vendor says were tested?
   - Do questionnaire responses align with what the SOC 2 report describes?
5. **Verify dates and currency** -- Confirm that certifications and reports referenced in marketing materials are still valid.

---

## Red Flag Identification Checklist

### Certification and Report Red Flags

- [ ] ISO 27001 certificate references the 2013 standard with an issue date after October 2025.
- [ ] ISO 27001 certificate issued by a certification body not accredited by an IAF MLA member.
- [ ] ISO 27001 certificate cannot be found in the certification body's public registry.
- [ ] SOC 2 report has a qualified, adverse, or disclaimed opinion.
- [ ] SOC 2 report is Type I from a vendor that has been operating for more than three years.
- [ ] SOC 2 report period ended more than 12 months ago with no bridge letter.
- [ ] SOC 2 report scope does not cover the service being evaluated.
- [ ] SOC 2 report has multiple exceptions in critical control areas (access management, encryption, incident response, change management).

### Penetration Test Red Flags

- [ ] Penetration test is older than 12 months.
- [ ] Penetration test scope excludes the application or infrastructure your organization will use.
- [ ] Critical or high-severity findings remain open without a documented remediation plan.
- [ ] No re-test was performed after remediation of critical findings.
- [ ] Testing firm or individual has no recognized certifications (OSCP, CREST, GPEN).
- [ ] Report lacks a methodology section or references no recognized testing standard.
- [ ] Testing was heavily time-boxed (e.g., two days for a large application) suggesting insufficient coverage.

### Questionnaire Red Flags

- [ ] Large number of "N/A" responses without justification.
- [ ] Responses contradict evidence from other sources (e.g., claims annual pen testing but no report available).
- [ ] Generic or copy-pasted responses that do not address the specific question.
- [ ] Vendor refuses to complete industry-standard questionnaires (SIG, CAIQ) without providing equivalent evidence.
- [ ] Questionnaire completed by sales or marketing rather than security or compliance personnel.

### General Red Flags

- [ ] Vendor is unwilling to share evidence under NDA.
- [ ] Vendor provides only marketing materials or trust center pages as evidence.
- [ ] Vendor claims certifications that cannot be independently verified.
- [ ] Vendor's security page references certifications that are expired or not yet obtained.
- [ ] Significant delay (more than 30 days) in providing requested evidence.

---

## Evidence Gap Analysis Methodology

### Step 1: Define Required Evidence

Based on the vendor's risk tier and the data/systems involved, define the minimum evidence requirements:

| Risk Tier | Minimum Evidence |
|---|---|
| Critical | SOC 2 Type II + penetration test + SIG Core + ISO 27001 (if applicable) |
| High | SOC 2 Type II + penetration test + SIG Core or Lite |
| Medium | SOC 2 Type II or ISO 27001 + SIG Lite |
| Low | SIG Lite or vendor security documentation |

### Step 2: Inventory Available Evidence

List all evidence received from the vendor with the following attributes:
- Evidence type
- Date of issuance or report period
- Scope covered
- Current or expired

### Step 3: Identify Gaps

Compare required evidence against available evidence. A gap exists when:
- A required evidence type is entirely missing.
- Evidence is available but expired or older than the acceptable threshold.
- Evidence scope does not cover the service or system in question.
- Evidence quality is insufficient (e.g., Type I when Type II is required; SIG Lite when SIG Core is required).

### Step 4: Assess Gap Impact

For each gap, determine:
- **Risk impact** -- What risk does the missing evidence leave unaddressed?
- **Compensating evidence** -- Is there alternative evidence that partially addresses the gap?
- **Remediation path** -- Can the vendor provide the missing evidence within a reasonable timeframe?

### Step 5: Document and Communicate

Record all gaps, their impact, and recommended actions. Present findings to the risk owner for a risk acceptance, mitigation, or avoidance decision.

---

## Verification Documentation Template

Use the following structure to document verification findings for each vendor.

```
Vendor Name: [Name]
Assessment Date: [Date]
Assessor: [Name]
Risk Tier: [Critical / High / Medium / Low]

## Evidence Inventory

| # | Evidence Type | Date Received | Document Date / Period | Scope | Status |
|---|---|---|---|---|---|
| 1 | SOC 2 Type II | [Date] | [Period] | [Scope] | [Current / Expired] |
| 2 | ISO 27001 Certificate | [Date] | [Valid until] | [Scope] | [Verified / Unverified] |
| 3 | Penetration Test Report | [Date] | [Test dates] | [Scope] | [Current / Expired] |
| 4 | SIG Questionnaire | [Date] | [Completion date] | [Full / Partial] | [Complete / Incomplete] |

## Verification Results

### [Evidence Type 1]
- Authenticity verified: [Yes / No] -- [Method used]
- Scope covers required services: [Yes / No / Partial]
- Currency: [Current / Expired / Expiring within 90 days]
- Findings: [Description of any exceptions, qualifications, or concerns]
- CUECs identified: [List or "None"]

### [Evidence Type 2]
- [Same structure as above]

## Red Flags Identified

- [List each red flag with a brief description and reference to the evidence source]

## Evidence Gaps

| # | Required Evidence | Gap Description | Risk Impact | Compensating Evidence | Recommended Action |
|---|---|---|---|---|---|
| 1 | [Type] | [Description] | [Impact] | [Alternative evidence, if any] | [Action] |

## Overall Assessment

- Evidence sufficiency: [Sufficient / Insufficient / Partially sufficient]
- Recommended risk decision: [Accept / Accept with conditions / Mitigate / Reject]
- Conditions or follow-up actions: [List]

## Approval

- Risk owner: [Name]
- Decision: [Accept / Reject / Conditional]
- Date: [Date]
- Notes: [Any additional notes]
```
