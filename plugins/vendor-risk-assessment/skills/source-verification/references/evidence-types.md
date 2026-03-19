# Evidence Types Reference

This document provides a detailed breakdown of each evidence type used in vendor risk assessment source verification, including what to look for and how to interpret findings.

---

## Evidence Hierarchy

Evidence types are ranked by reliability and independence:

1. **Third-party audit reports** (SOC 2, ISO 27001 certification) -- highest assurance
2. **Technical assessments** (penetration test reports, vulnerability scans)
3. **Standardized questionnaires** (SIG, CAIQ)
4. **Vendor self-attestations** (policies, whitepapers, marketing materials) -- lowest assurance

Always prefer higher-ranked evidence when available. Lower-ranked evidence is supplementary, not a substitute.

---

## SOC 2 Reports

### Type I vs Type II

| Attribute | Type I | Type II |
|---|---|---|
| **Scope** | Design of controls at a point in time | Design and operating effectiveness over a period |
| **Audit period** | Single date (e.g., "as of March 31, 2026") | Range (e.g., "October 1, 2025 through March 31, 2026") |
| **Assurance level** | Lower -- controls existed on that date | Higher -- controls operated effectively over time |
| **Typical use** | First-time audits, new organizations | Ongoing assurance, mature organizations |

A Type I report is not a red flag on its own, but a vendor that has been operating for several years and only has a Type I should prompt questions about why they have not progressed to Type II.

### Trust Service Criteria (TSC)

SOC 2 reports cover one or more of the following criteria. The report's scope section lists which are included.

- **Security (Common Criteria)** -- Always included. Covers logical and physical access, system operations, change management, and risk mitigation. This is the baseline.
- **Availability** -- System uptime, disaster recovery, business continuity. Important for infrastructure and SaaS vendors.
- **Confidentiality** -- Protection of information designated as confidential. Important when sharing sensitive business data.
- **Processing Integrity** -- Accuracy, completeness, and timeliness of system processing. Critical for financial, data pipeline, and transaction-processing vendors.
- **Privacy** -- Collection, use, retention, disclosure, and disposal of personal information aligned with the entity's privacy notice. Important when the vendor handles PII.

### What to Look For in a SOC 2 Report

1. **Auditor's opinion** -- Unqualified (clean) vs qualified. A qualified opinion means the auditor found material issues.
2. **Scope of services** -- Confirm the report covers the specific service or product your organization uses. A vendor may have a SOC 2 for Product A but not Product B.
3. **Period covered** -- Ensure the report is current. Reports older than 12 months provide limited assurance.
4. **Exceptions and deviations** -- Section IV or V typically lists control exceptions. Review each for severity and whether the vendor has remediated.
5. **Complementary User Entity Controls (CUECs)** -- Controls the vendor expects your organization to implement. These are your responsibilities.
6. **Subservice organizations** -- Other vendors the audited entity depends on (e.g., AWS, Azure). Check whether they are included in scope (inclusive method) or excluded (carve-out method).
7. **Auditor identity** -- Confirm the auditor is a licensed CPA firm. The AICPA does not accredit SOC 2 auditors, but the firm must hold a valid CPA license.

---

## ISO 27001

### Certification Cycle

- **Initial certification audit** -- Two stages. Stage 1 is a documentation review. Stage 2 is the on-site (or remote) assessment of control implementation.
- **Certificate validity** -- Three years from the date of issuance.
- **Surveillance audits** -- Conducted annually (years 1 and 2 after initial certification) to confirm the ISMS remains effective. These are partial audits, not full recertifications.
- **Recertification audit** -- Full audit in year 3 to renew the certificate for another three-year cycle.

### Statement of Applicability (SoA)

The SoA is the most important document tied to an ISO 27001 certificate. It lists all controls from Annex A and indicates which are applicable, which are implemented, and which are excluded (with justification). Request the SoA alongside the certificate -- the certificate alone tells you very little about what is actually controlled.

### Version: ISO 27001:2022 vs ISO 27001:2013

- **ISO 27001:2022** -- Current version. Annex A restructured from 14 domains to 4 themes (Organizational, People, Physical, Technological). Reduced from 114 controls to 93. Added 11 new controls including threat intelligence, cloud security, and data masking.
- **ISO 27001:2013** -- Previous version. Transition deadline was October 31, 2025. Certificates issued under 2013 after that date are invalid. Existing 2013 certificates should have been transitioned.

If a vendor presents an ISO 27001:2013 certificate dated after October 2025, this is a significant finding.

### What to Look For

1. **Certificate validity dates** -- Must be within the three-year cycle and not expired.
2. **Scope statement** -- Printed on the certificate. Confirm it covers the relevant service, location, and business unit.
3. **Accreditation body** -- The certification body (e.g., BSI, Schellman, A-LIGN) should itself be accredited by a recognized national accreditation body (e.g., UKAS, ANAB, DAkkS). Check the IAF MLA member list.
4. **Registry verification** -- Most certification bodies maintain a public registry of valid certificates. Look up the vendor's certificate to confirm it has not been suspended or withdrawn.

---

## Penetration Test Reports

### Scope Types

- **External network** -- Tests internet-facing infrastructure (firewalls, VPNs, public IPs). Minimum expected scope for any vendor.
- **Internal network** -- Tests internal network segmentation and lateral movement. Assumes attacker has breached the perimeter.
- **Web application** -- Tests the application layer (authentication, authorization, injection, session management). Essential for SaaS vendors.
- **API** -- Tests API endpoints for authentication, authorization, input validation, rate limiting, and data exposure. Critical for integration-heavy vendors.
- **Mobile application** -- Tests iOS/Android apps for local storage, transport security, and platform-specific vulnerabilities.

### Methodology Standards

- **OWASP Testing Guide / ASVS** -- Industry standard for web application and API testing. Look for references to OWASP Top 10 categories.
- **PTES (Penetration Testing Execution Standard)** -- Covers pre-engagement through reporting. Provides a structured methodology for network and application testing.
- **NIST SP 800-115** -- Technical Guide to Information Security Testing and Assessment. Common in government and regulated environments.
- **CREST / CHECK** -- UK-based accreditation for penetration testing firms. Indicates tester competency.

### Reporting Elements to Review

1. **Scope and methodology** -- What was tested, what was excluded, and what methodology was followed.
2. **Testing dates** -- Reports older than 12 months have limited value. Annual testing is standard practice.
3. **Findings severity** -- Look for critical and high findings. Confirm remediation status.
4. **Remediation verification** -- Did the tester re-test after fixes were applied? A report with open critical findings and no re-test is a concern.
5. **Tester qualifications** -- OSCP, CREST, GPEN, or similar certifications indicate competency.
6. **Limitations** -- Was testing time-boxed? Were certain systems excluded? Limitations reduce the assurance provided.

---

## SIG and CAIQ Questionnaires

### SIG (Standardized Information Gathering)

The SIG questionnaire (managed by Shared Assessments) is a standardized vendor risk assessment tool.

- **SIG Core** -- Full version with approximately 850+ questions across 19 risk domains (IT, privacy, physical security, business continuity, etc.).
- **SIG Lite** -- Abbreviated version with approximately 150+ questions for lower-risk vendors.
- **Structure** -- Each question has a yes/no/N/A response with space for additional detail and evidence references.

#### Assessment Criteria

- **Completeness** -- Questionnaires with many blank or N/A responses without justification are unreliable.
- **Consistency** -- Cross-check answers against other evidence. If the SIG says "yes" to annual penetration testing, request the report.
- **Detail quality** -- Responses that only say "yes" without explanation provide less assurance than those referencing specific policies, tools, or processes.

### CAIQ (Consensus Assessments Initiative Questionnaire)

The CAIQ (managed by the Cloud Security Alliance) is specific to cloud service providers.

- **Structure** -- Questions mapped to the Cloud Controls Matrix (CCM) domains (e.g., Application & Interface Security, Data Security, Identity & Access Management).
- **Format** -- Yes/no responses with implementation details.
- **Version** -- CAIQ v4 aligns with CCM v4. Older versions may not cover current cloud security concerns.

#### Assessment Criteria

- Same completeness and consistency checks as SIG.
- Cross-reference CAIQ responses against the vendor's CSA STAR registry entry if available.

---

## Other Evidence Types

### HITRUST CSF Certification

- **Scope** -- Healthcare and organizations handling protected health information (PHI).
- **Certification levels** -- e1 (1-year), i1 (1-year), r2 (2-year). The r2 is the most rigorous and maps to multiple frameworks (HIPAA, NIST, ISO 27001).
- **Verification** -- Check the HITRUST CSF Assessor directory and request the validated assessment report.

### FedRAMP Authorization

- **Scope** -- Cloud service providers serving US federal agencies.
- **Authorization levels** -- Low, Moderate, High (based on FIPS 199 impact levels).
- **Verification** -- Check the FedRAMP Marketplace for the vendor's authorization status, level, and sponsoring agency.
- **Note** -- FedRAMP authorization is one of the most rigorous assessments available. A FedRAMP Moderate or High authorization provides substantial assurance.

### PCI DSS

- **Scope** -- Organizations that store, process, or transmit cardholder data.
- **Versions** -- PCI DSS v4.0.1 is current. v3.2.1 expired March 31, 2024.
- **Validation levels** -- Level 1 merchants require a Report on Compliance (ROC) by a Qualified Security Assessor (QSA). Lower levels may self-assess with a Self-Assessment Questionnaire (SAQ).
- **Verification** -- Request the Attestation of Compliance (AOC), which is the shareable summary. The full ROC is typically confidential. Verify the QSA firm on the PCI SSC website.

### SOC 1 (SSAE 18 / ISAE 3402)

- **Scope** -- Controls relevant to user entities' financial reporting. Not a security audit.
- **Use case** -- Relevant for vendors that process financial transactions or handle data that affects your financial statements (payroll processors, payment platforms).
- **Note** -- SOC 1 does not replace SOC 2. A vendor with only a SOC 1 has not been independently assessed for security controls.

### CSA STAR

- **Levels** -- Level 1 (self-assessment via CAIQ), Level 2 (third-party certification based on ISO 27001 + CCM), Level 3 (continuous monitoring -- rarely used).
- **Verification** -- Search the CSA STAR Registry at cloudsecurityalliance.org.

---

## Evidence Handling

### NDA Requirements

- **SOC 2 reports** -- Almost always shared under NDA. The report is the property of the service organization, and distribution is restricted.
- **Penetration test reports** -- Typically shared under NDA. Some vendors provide an executive summary without NDA and the full report under NDA.
- **ISO 27001 certificates** -- Generally public. The Statement of Applicability may require NDA.
- **Questionnaires** -- May or may not require NDA depending on the vendor's policy.

### Storage and Retention

- Store all vendor evidence in a secure, access-controlled repository.
- Label evidence with the vendor name, evidence type, date received, and expiration/review date.
- Retain evidence for the duration of the vendor relationship plus any regulatory retention period (typically 3-7 years depending on industry).
- Establish a review cadence: request updated evidence annually or when a vendor's certification expires, whichever comes first.
- Dispose of evidence securely when the retention period ends, in accordance with any NDA terms.
