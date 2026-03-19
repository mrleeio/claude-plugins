# Data Classification Framework

## Classification Levels

### Level 1: Restricted

The highest sensitivity level. Unauthorized disclosure would cause severe harm to the organization, its customers, or its regulatory standing.

**Characteristics:**
- Regulated by specific laws with breach notification requirements
- Requires explicit authorization for each access grant
- Must be encrypted at rest and in transit without exception
- Access logged and audited continuously

### Level 2: Confidential

Sensitive business or personal data whose disclosure would cause significant harm. Access limited to those with a demonstrated business need.

**Characteristics:**
- May be subject to contractual confidentiality obligations
- Requires role-based access controls
- Must be encrypted at rest and in transit
- Access logged and reviewed periodically

### Level 3: Internal

Data intended for internal use that is not sensitive but should not be publicly available. Disclosure would cause minor or negligible harm.

**Characteristics:**
- Available to authenticated employees/contractors by default
- Standard access controls sufficient
- Encryption in transit required; at rest recommended
- Standard audit logging

### Level 4: Public

Data explicitly approved for public disclosure. No harm from disclosure.

**Characteristics:**
- No access restrictions required
- Integrity controls to prevent unauthorized modification
- No encryption requirements beyond transport security
- Minimal logging requirements

---

## Data Types and Classification

| Data Type | Classification | Regulatory Drivers | Examples |
|---|---|---|---|
| Protected Health Information (PHI) | Restricted | HIPAA, HITECH | Medical records, diagnoses, treatment plans, insurance IDs, lab results |
| Payment Card Data (PCI) | Restricted | PCI DSS | Primary account numbers (PAN), CVV, cardholder names with card data, PINs |
| Personally Identifiable Information (PII) - Sensitive | Restricted | GDPR, CCPA, state privacy laws | SSN, government IDs, biometric data, financial account numbers, immigration status |
| Authentication Credentials | Restricted | Multiple | Passwords, API keys, tokens, certificates, MFA seeds, SSH keys |
| PII - Standard | Confidential | GDPR, CCPA | Names, email addresses, phone numbers, mailing addresses, dates of birth |
| Financial Data | Confidential | SOX, SEC regulations | Revenue figures, forecasts, M&A plans, pricing strategies, audit findings |
| Intellectual Property | Confidential | Trade secret law, patent law | Source code, algorithms, product roadmaps, research data, trade secrets |
| Employee Records | Confidential | Employment law, GDPR | Performance reviews, compensation data, disciplinary records, background checks |
| Customer Communications | Confidential | Industry-specific | Support tickets with PII, account details, service configurations |
| Internal Communications | Internal | N/A | Meeting notes, internal announcements, process documentation, project plans |
| Operational Data | Internal | N/A | Non-sensitive system logs, capacity metrics, vendor lists, org charts |
| Marketing Materials | Public | N/A | Published blog posts, press releases, product brochures, public pricing |
| Public Documentation | Public | N/A | Published API docs, public knowledge base articles, open-source code |

---

## Handling Requirements by Classification Level

### Encryption

| Requirement | Restricted | Confidential | Internal | Public |
|---|---|---|---|---|
| Encryption in transit | Required (TLS 1.2+) | Required (TLS 1.2+) | Required (TLS 1.2+) | Recommended |
| Encryption at rest | Required (AES-256) | Required (AES-256) | Recommended | Not required |
| Key management | HSM or dedicated KMS | KMS acceptable | Standard key management | N/A |
| Field-level encryption | Required for PCI/credentials | Recommended for sensitive fields | Not required | N/A |
| End-to-end encryption | Required where feasible | Recommended | Not required | N/A |

### Access Control

| Requirement | Restricted | Confidential | Internal | Public |
|---|---|---|---|---|
| Access approval | Explicit per-individual approval | Role-based with manager approval | Role-based, default for employees | Open access |
| MFA | Required | Required | Required for remote access | Not required |
| Privileged access management | Required with session recording | Required | Recommended | Not required |
| Access reviews | Quarterly | Semi-annually | Annually | Not required |
| Separation of duties | Required | Required for financial data | Recommended | Not required |
| Least privilege | Strictly enforced | Enforced | Enforced | N/A |

### Data Loss Prevention (DLP)

| Requirement | Restricted | Confidential | Internal | Public |
|---|---|---|---|---|
| DLP monitoring | Required (block mode) | Required (alert mode minimum) | Recommended | Not required |
| Email DLP | Required with blocking | Required with alerting | Recommended | Not required |
| Endpoint DLP | Required | Recommended | Optional | Not required |
| Cloud DLP (CASB) | Required | Required | Recommended | Not required |
| USB/removable media | Blocked | Restricted with logging | Allowed with logging | Allowed |
| Print controls | Restricted with watermarking | Logging recommended | Standard | Standard |

### Retention and Disposal

| Requirement | Restricted | Confidential | Internal | Public |
|---|---|---|---|---|
| Retention policy | Defined per regulation | Defined per business need | Standard retention schedule | No specific requirement |
| Disposal method | Cryptographic erasure or physical destruction with certificate | Secure deletion with verification | Standard secure deletion | Standard deletion |
| Disposal documentation | Certificate of destruction required | Disposal log entry | Standard logging | Not required |
| Backup retention | Per regulatory requirement | Per business requirement | Standard backup schedule | Standard backup schedule |

---

## Data Flow Mapping Guidance

When assessing a vendor, document the following data flows:

### Data Flow Inventory

For each data element shared with the vendor, document:

1. **Data element name** - Specific field or data type
2. **Classification level** - Per the framework above
3. **Source system** - Where the data originates
4. **Transfer method** - API, SFTP, manual upload, email, etc.
5. **Transfer frequency** - Real-time, batch (daily/weekly/monthly), ad-hoc
6. **Encryption in transit** - Protocol and version
7. **Vendor storage location** - Geographic region, specific data center if known
8. **Encryption at rest** - Algorithm and key management
9. **Vendor access scope** - Which vendor personnel/systems can access
10. **Data return/destruction** - How data is returned or destroyed at end of relationship
11. **Retention period** - How long the vendor retains the data
12. **Onward sharing** - Whether vendor shares data with sub-processors

### Data Flow Diagram Requirements

- Show all entry and exit points for data
- Identify encryption boundaries
- Mark geographic/jurisdictional boundaries
- Identify all parties with access (including sub-processors)
- Document backup and disaster recovery data flows
- Note any data transformation or aggregation

---

## Cross-Border Data Transfer Considerations

### GDPR Adequacy Decisions

Data can flow freely to countries with an EU adequacy decision. As of the current framework:

- Countries with adequacy decisions include: Andorra, Argentina, Canada (commercial), Faroe Islands, Guernsey, Israel, Isle of Man, Japan, Jersey, New Zealand, Republic of Korea, Switzerland, United Kingdom, Uruguay, United States (via EU-US Data Privacy Framework)
- Adequacy decisions can be revoked (as with Privacy Shield/Schrems II)
- Always verify current adequacy status before relying on this mechanism

### Schrems II Implications

Following the Schrems II ruling (Case C-311/18):

- **Transfer Impact Assessments (TIAs)** are required when relying on Standard Contractual Clauses for transfers to countries without adequacy decisions
- Assess whether the destination country's surveillance laws undermine the protection provided by SCCs
- Document supplementary measures if surveillance risk is identified
- Consider data localization as an alternative if adequate protection cannot be ensured

### Standard Contractual Clauses (SCCs)

When SCCs are the transfer mechanism:

- Use the current EU Commission-approved SCCs (June 2021 version with modular approach)
- Select the appropriate module:
  - **Module 1:** Controller to Controller
  - **Module 2:** Controller to Processor
  - **Module 3:** Processor to Processor
  - **Module 4:** Processor to Controller
- Complete the appendices with specific data processing details
- Implement supplementary technical measures where required by TIA
- Include SCCs in or annex them to the vendor contract

### Additional Transfer Mechanisms

- **Binding Corporate Rules (BCRs):** For intra-group transfers within multinational organizations
- **Derogations (Article 49):** Limited exceptions for occasional transfers (explicit consent, contract performance, legal claims)
- **Approved codes of conduct or certification mechanisms:** Emerging options under GDPR

### Vendor Assessment Questions for Cross-Border Transfers

1. In which countries/regions does the vendor process and store data?
2. Does the vendor use sub-processors in different jurisdictions?
3. What transfer mechanism does the vendor rely on for international transfers?
4. Has the vendor conducted Transfer Impact Assessments?
5. What supplementary measures has the vendor implemented?
6. Can the vendor provide data residency guarantees if required?
7. Does the vendor have experience with government data access requests?
8. What is the vendor's process if a transfer mechanism is invalidated?
