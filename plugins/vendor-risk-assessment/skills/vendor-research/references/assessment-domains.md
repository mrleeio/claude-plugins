# Vendor Risk Assessment Domains

This reference defines 15 assessment domains. Each domain includes a description, specific assessment questions, key evidence to look for, and common gaps to flag.

---

## 1. Organizational Security & Governance

**Description:** Evaluates the vendor's security program maturity, leadership commitment, and governance structure. This domain assesses whether security is embedded in the organization's culture and decision-making.

**Assessment Questions:**
1. Does the vendor have a dedicated CISO or equivalent security leader who reports to executive leadership?
2. Is there a documented information security policy that is reviewed and updated at least annually?
3. Does the vendor maintain a security steering committee or equivalent governance body?
4. Are security roles and responsibilities clearly defined across the organization?
5. Does the vendor conduct regular risk assessments (at least annually) with documented methodology?
6. Is there a security awareness training program for all employees, with completion tracking?
7. Does the vendor have a documented exception/risk acceptance process with executive sign-off?
8. Are security metrics reported to the board or executive leadership on a regular cadence?

**Key Evidence:**
- Information security policy document with review date
- Organizational chart showing CISO reporting line
- Security awareness training completion records
- Risk assessment methodology and recent results
- Board/executive security reporting cadence

**Common Gaps:**
- CISO reports into IT rather than executive leadership
- Security policies exist but have not been reviewed in 12+ months
- No formal risk acceptance process -- risks are accepted informally
- Security awareness training is one-time at onboarding with no annual refresh
- No security metrics or KPIs tracked

---

## 2. Access Control & Identity Management

**Description:** Assesses how the vendor manages user identities, authentication, and authorization to ensure least-privilege access to systems and data.

**Assessment Questions:**
1. Does the vendor enforce multi-factor authentication (MFA) for all user accounts, including administrative access?
2. Is role-based access control (RBAC) implemented with documented role definitions?
3. Are access reviews conducted at least quarterly for privileged accounts and semi-annually for standard accounts?
4. Does the vendor have a documented joiner/mover/leaver process with SLAs for access provisioning and deprovisioning?
5. Are service accounts and API keys inventoried, rotated on a defined schedule, and scoped to minimum required permissions?
6. Does the vendor support SSO integration (SAML 2.0, OIDC) for customer-facing applications?
7. Are privileged access management (PAM) controls in place for administrative access to production systems?
8. Is there a process for emergency/break-glass access with logging and post-use review?

**Key Evidence:**
- MFA enforcement policy and implementation evidence
- RBAC role matrix documentation
- Access review records with remediation tracking
- Joiner/mover/leaver SLA documentation
- PAM tool deployment evidence
- SSO integration documentation

**Common Gaps:**
- MFA not enforced for all accounts (e.g., service accounts exempted)
- Access reviews are performed but remediation of findings is not tracked
- No formal process for revoking access on employee termination -- relies on manual steps
- Shared accounts or credentials in use for production systems
- API keys with overly broad permissions or no rotation schedule

---

## 3. Data Protection & Privacy

**Description:** Evaluates how the vendor protects data throughout its lifecycle, including collection, processing, storage, transmission, and disposal, with attention to privacy obligations.

**Assessment Questions:**
1. Does the vendor encrypt data at rest using AES-256 or equivalent, with customer-managed key (CMK) options?
2. Is data encrypted in transit using TLS 1.2 or higher for all communications?
3. Does the vendor maintain a data classification scheme and apply controls based on classification level?
4. Is there a documented data retention and disposal policy with evidence of enforcement?
5. Does the vendor provide a Data Processing Agreement (DPA) that meets GDPR Article 28 requirements?
6. Where is customer data stored and processed geographically? Can data residency requirements be met?
7. Does the vendor have a documented process for responding to data subject access requests (DSARs)?
8. Are there technical controls preventing unauthorized data exfiltration (DLP)?

**Key Evidence:**
- Encryption standards documentation (algorithms, key management)
- Data classification policy
- DPA with standard contractual clauses
- Data flow diagrams showing geographic locations
- Data retention schedule with disposal evidence
- DSAR response process documentation

**Common Gaps:**
- Encryption at rest uses vendor-managed keys only with no CMK option
- No formal data classification beyond "confidential" and "public"
- Data retention policy exists but no automated enforcement
- Data residency is vaguely described without specific region commitments
- No DLP controls in place
- Sub-processor data flows not documented

---

## 4. Network Security

**Description:** Assesses the vendor's network architecture, segmentation, and defense-in-depth controls protecting systems and data from network-based threats.

**Assessment Questions:**
1. Does the vendor implement network segmentation to isolate production, staging, and corporate environments?
2. Are web application firewalls (WAF) deployed in front of customer-facing applications?
3. Does the vendor use intrusion detection/prevention systems (IDS/IPS)?
4. Is there a documented network architecture diagram that is reviewed and updated regularly?
5. Are all network access points inventoried and protected with firewall rules following deny-by-default?
6. Does the vendor conduct regular network penetration testing (at least annually) by a qualified third party?
7. Is DDoS protection implemented for customer-facing services?
8. Are VPN or zero-trust network access (ZTNA) controls in place for remote access to internal systems?

**Key Evidence:**
- Network architecture diagrams
- Firewall rule review records
- Penetration test reports (executive summary at minimum)
- WAF and DDoS protection configuration evidence
- IDS/IPS deployment documentation
- Network segmentation validation results

**Common Gaps:**
- Flat network architecture with no segmentation between environments
- Penetration testing is performed but findings are not remediated within defined SLAs
- Network diagrams are outdated or do not reflect current architecture
- No DDoS protection for customer-facing services
- Remote access does not require MFA

---

## 5. Application Security

**Description:** Evaluates the vendor's secure software development lifecycle (SSDLC) and application-layer security controls.

**Assessment Questions:**
1. Does the vendor follow a documented secure development lifecycle (SDLC) with security gates?
2. Are static application security testing (SAST) and dynamic application security testing (DAST) integrated into CI/CD pipelines?
3. Does the vendor conduct code reviews with security considerations for all production changes?
4. Is there a software composition analysis (SCA) tool in use to track and remediate open-source vulnerabilities?
5. Does the vendor maintain a vulnerability disclosure or bug bounty program?
6. Are OWASP Top 10 risks explicitly addressed in development standards?
7. Does the vendor perform threat modeling for new features and significant changes?
8. What is the SLA for remediating critical and high-severity application vulnerabilities?

**Key Evidence:**
- SDLC documentation with security integration points
- SAST/DAST tool configuration and scan frequency
- SCA tool with dependency inventory
- Vulnerability remediation SLAs and compliance metrics
- Bug bounty program scope and results summary
- Threat modeling artifacts

**Common Gaps:**
- Security testing is performed manually and not integrated into CI/CD
- No SCA tool; open-source dependencies are not tracked
- No vulnerability disclosure or bug bounty program
- Threat modeling is ad hoc or not performed
- Vulnerability remediation SLAs are not defined or not enforced

---

## 6. Infrastructure & Cloud Security

**Description:** Assesses the security of the vendor's infrastructure, including cloud environments, container orchestration, and configuration management.

**Assessment Questions:**
1. Which cloud providers and regions does the vendor use for production workloads?
2. Does the vendor use infrastructure-as-code (IaC) with security scanning for misconfigurations?
3. Are cloud security posture management (CSPM) tools deployed to detect configuration drift?
4. Does the vendor implement container security controls (image scanning, runtime protection, least-privilege pods)?
5. Are production systems hardened according to CIS Benchmarks or equivalent standards?
6. Is there an asset inventory of all production infrastructure components?
7. Does the vendor have a defined patching cadence with SLAs for critical vulnerabilities?
8. Are secrets management solutions (e.g., HashiCorp Vault, AWS Secrets Manager) in use rather than hardcoded credentials?

**Key Evidence:**
- Cloud provider and region documentation
- IaC repository with security scanning evidence
- CSPM tool deployment and alerting configuration
- CIS Benchmark compliance reports
- Asset inventory
- Patch management policy and compliance metrics
- Secrets management tool deployment

**Common Gaps:**
- No CSPM tooling; cloud misconfigurations discovered reactively
- IaC is used but security scanning is not integrated
- Container images are not scanned before deployment
- Patching cadence is inconsistent with no SLAs for critical vulnerabilities
- Secrets are stored in environment variables or config files rather than a vault

---

## 7. Incident Response & Management

**Description:** Evaluates the vendor's preparedness and capability to detect, respond to, and recover from security incidents, including customer notification processes.

**Assessment Questions:**
1. Does the vendor have a documented incident response plan that is tested at least annually?
2. What are the customer notification timelines for security incidents affecting customer data?
3. Does the vendor conduct tabletop exercises or incident simulations?
4. Is there a 24/7 security operations center (SOC) or equivalent monitoring capability?
5. Does the vendor maintain an incident classification and severity framework?
6. What forensic and investigation capabilities does the vendor have (internal team, retainer with third-party firm)?
7. Does the vendor track mean time to detect (MTTD) and mean time to respond (MTTR) metrics?
8. Is there a post-incident review process with lessons learned and control improvements?

**Key Evidence:**
- Incident response plan document
- Tabletop exercise records and findings
- Customer notification SLA documentation
- SOC operational model documentation
- Incident metrics (MTTD, MTTR)
- Post-incident review reports (redacted)

**Common Gaps:**
- Incident response plan exists but has never been tested
- No defined customer notification timeline (or timeline exceeds 72 hours)
- No 24/7 monitoring capability; incidents detected only during business hours
- No post-incident review process
- MTTD and MTTR metrics are not tracked

---

## 8. Business Continuity & Disaster Recovery

**Description:** Assesses the vendor's ability to maintain service availability and recover from disruptions, including documented RTOs, RPOs, and backup strategies.

**Assessment Questions:**
1. Does the vendor have documented RTO (Recovery Time Objective) and RPO (Recovery Point Objective) targets?
2. Are disaster recovery plans tested at least annually with documented results?
3. Does the vendor maintain geographically redundant infrastructure for production workloads?
4. Are backups performed regularly, encrypted, and stored in a separate location from production?
5. Has the vendor experienced any significant outages in the past 24 months? What were the root causes and resolutions?
6. Does the vendor have a business continuity plan covering key-person dependencies and operational resilience?
7. What is the vendor's contractual SLA for uptime, and what has actual uptime been over the past 12 months?

**Key Evidence:**
- BCP and DR plan documents
- DR test results and findings
- RTO/RPO targets with validation evidence
- Backup configuration and recovery test results
- Status page history showing uptime metrics
- Contractual SLA documentation

**Common Gaps:**
- DR plan exists but has not been tested or test results show gaps
- RTO/RPO targets are not documented or are not aligned with customer needs
- Backups are not tested for recoverability
- No geographic redundancy; single-region deployment
- Contractual SLA does not match actual uptime performance

---

## 9. Vendor & Third-Party Risk Management

**Description:** Evaluates how the vendor manages its own supply chain risk, including sub-processors, fourth-party dependencies, and concentration risk.

**Assessment Questions:**
1. Does the vendor maintain a current list of sub-processors that is publicly accessible?
2. Is there a vendor risk management program for evaluating the vendor's own third parties?
3. Does the vendor notify customers of sub-processor changes with advance notice?
4. Are sub-processors subject to contractual security requirements and periodic assessments?
5. Does the vendor have concentration risk controls (e.g., avoiding single points of failure in critical sub-processors)?
6. Can customers object to new sub-processors with a defined resolution process?
7. Does the vendor assess the security posture of open-source dependencies as part of supply chain risk?

**Key Evidence:**
- Sub-processor list with purpose and data processed
- Vendor risk management policy and program documentation
- Sub-processor change notification process
- Contractual security requirements for sub-processors
- Fourth-party assessment records

**Common Gaps:**
- Sub-processor list is outdated or not publicly accessible
- No formal vendor risk management program for the vendor's own third parties
- Sub-processor changes are made without customer notification
- No contractual right for customers to object to new sub-processors
- Open-source supply chain risk is not assessed

---

## 10. Compliance & Audit

**Description:** Assesses the vendor's compliance posture, audit history, and ability to demonstrate adherence to regulatory and contractual requirements.

**Assessment Questions:**
1. What compliance certifications and attestations does the vendor currently hold (SOC 2, ISO 27001, HITRUST, etc.)?
2. Are SOC 2 Type II reports available, and do they cover the trust service criteria relevant to the engagement?
3. Has the vendor had any qualified opinions or exceptions in recent audit reports?
4. Does the vendor support customer audit rights, including on-site assessments?
5. How does the vendor track and maintain compliance with applicable regulations (GDPR, CCPA, HIPAA, etc.)?
6. Does the vendor have a dedicated compliance team or function?
7. Are compliance obligations mapped to specific controls with evidence of implementation?

**Key Evidence:**
- Current SOC 2 Type II report (or bridge letter if report is in progress)
- ISO 27001 certificate with scope and validity dates
- Audit exception remediation tracking
- Compliance framework mapping documentation
- Customer audit rights clause in contract
- Regulatory compliance documentation

**Common Gaps:**
- SOC 2 report scope does not cover the specific product or service being evaluated
- ISO 27001 certificate scope is limited and does not cover relevant operations
- Audit exceptions from prior reports have not been remediated
- No customer audit rights in the contract
- Compliance is self-assessed without independent verification

---

## 11. Physical Security

**Description:** Evaluates physical access controls for facilities where customer data is processed or stored, including data centers and office locations.

**Assessment Questions:**
1. Where are the vendor's data centers located, and are they owned or operated by third parties?
2. What physical access controls are in place (badge access, biometric, mantraps, visitor logging)?
3. Are data center facilities SOC 2 or ISO 27001 certified?
4. Is there 24/7 physical security monitoring (guards, CCTV) at data center facilities?
5. Does the vendor have environmental controls (fire suppression, climate control, redundant power)?
6. How is media (drives, tapes) sanitized and disposed of when decommissioned?
7. Are physical access logs reviewed regularly?

**Key Evidence:**
- Data center location documentation
- Physical access control descriptions
- Data center certifications (SOC 2, ISO 27001)
- Media sanitization and disposal policy
- Environmental control specifications
- Physical access log review records

**Common Gaps:**
- Reliance on cloud provider physical security without validating provider certifications
- No documented media sanitization process
- Physical access logs are maintained but not reviewed
- Office locations where data is accessed lack adequate physical controls
- No visitor management process

---

## 12. Human Resources Security

**Description:** Assesses personnel security controls including background checks, security training, and controls for employee lifecycle events.

**Assessment Questions:**
1. Does the vendor conduct background checks for employees with access to customer data?
2. Are employees required to sign confidentiality/NDA agreements?
3. Is security awareness training mandatory for all employees with at least annual refreshers?
4. Does the vendor have an acceptable use policy for information systems?
5. Is there a disciplinary process for security policy violations?
6. Are background checks conducted for contractors and temporary staff?
7. Does the vendor have a process for revoking all access within defined SLAs upon termination?
8. Is there role-specific security training for developers, administrators, and other technical staff?

**Key Evidence:**
- Background check policy and scope
- Confidentiality agreement template
- Security awareness training program with completion metrics
- Acceptable use policy
- Termination access revocation SLA and compliance evidence
- Role-specific training documentation

**Common Gaps:**
- Background checks limited to criminal records without verification of employment and education
- Contractors not subject to the same background check requirements as employees
- Security training is generic and not tailored to roles
- No defined SLA for access revocation upon termination
- Training completion rates are not tracked

---

## 13. Logging, Monitoring & Detection

**Description:** Evaluates the vendor's ability to collect, analyze, and retain security-relevant logs and detect anomalous or malicious activity.

**Assessment Questions:**
1. Does the vendor centralize logs from all production systems, applications, and security controls?
2. What is the log retention period, and does it meet regulatory and contractual requirements?
3. Is a SIEM or equivalent security analytics platform deployed with active alerting rules?
4. Does the vendor monitor for indicators of compromise (IOCs) and anomalous behavior?
5. Are audit logs tamper-protected and stored separately from production systems?
6. Does the vendor provide customers with access to audit logs for their tenant?
7. Are log review and alert triage processes documented with SLAs?
8. Does the vendor correlate events across multiple data sources for threat detection?

**Key Evidence:**
- Log management architecture documentation
- Log retention policy
- SIEM deployment and alerting rule documentation
- Audit log access capabilities for customers
- Log review and triage SLA documentation
- Tamper-protection controls for logs

**Common Gaps:**
- Logs are collected but not centralized or correlated
- Log retention period is insufficient (less than 90 days)
- No SIEM or security analytics platform; log review is manual
- Customer audit logs are not available
- Alerts are generated but triage process is undocumented with no SLAs
- Logs are stored on the same systems they monitor (no tamper protection)

---

## 14. Contractual & Legal

**Description:** Assesses the contractual protections, legal terms, and commercial arrangements that govern the vendor relationship and allocate risk.

**Assessment Questions:**
1. Does the contract include security and privacy requirements as enforceable obligations?
2. Are there defined SLAs for availability, performance, and incident notification with remedies for non-compliance?
3. Does the contract include a right to audit clause?
4. Are data processing terms compliant with applicable privacy regulations (GDPR, CCPA)?
5. What are the contract termination and data return/destruction provisions?
6. Does the vendor carry cyber liability insurance with adequate coverage limits?
7. Are limitation of liability and indemnification terms appropriate for the risk level?
8. Does the contract address data ownership and intellectual property rights clearly?

**Key Evidence:**
- Master service agreement or equivalent contract
- Data processing agreement
- SLA documentation with remedy provisions
- Right to audit clause
- Insurance certificate (cyber liability)
- Data return/destruction provisions
- Indemnification and limitation of liability terms

**Common Gaps:**
- No right to audit clause
- Incident notification timeline is undefined or exceeds regulatory requirements
- Data return/destruction provisions are vague with no certification of destruction
- No cyber liability insurance or inadequate coverage limits
- Limitation of liability caps are disproportionately low relative to data risk
- Contract does not address sub-processor obligations

---

## 15. AI Risk & Governance

**Description:** Evaluates risks specific to vendors that develop, deploy, or integrate artificial intelligence and machine learning systems. This domain covers AI governance frameworks, model risk management, data practices, bias monitoring, and regulatory compliance.

**Assessment Questions:**
1. Does the vendor have a documented AI governance framework or policy covering the development and deployment of AI systems?
2. Has the vendor classified its AI systems under the EU AI Act risk categories (unacceptable, high, limited, minimal risk)? What classification applies to the product or service being assessed?
3. Does the vendor align with the NIST AI Risk Management Framework (AI RMF) or equivalent framework for AI risk identification and mitigation?
4. Is the vendor pursuing or has it achieved ISO 42001 (AI Management System) certification?
5. Does the vendor have a model governance process covering model development, validation, deployment, monitoring, and retirement?
6. What training data practices does the vendor follow? Specifically:
   - Is training data sourced ethically and with appropriate rights/licenses?
   - Is customer data used for model training? If so, is there an opt-out mechanism?
   - How is training data quality assessed and maintained?
   - Are there controls for PII/sensitive data in training datasets?
7. Does the vendor monitor for and mitigate algorithmic bias, including:
   - Pre-deployment bias testing across protected categories?
   - Ongoing production monitoring for disparate impact?
   - Documented bias incident response and remediation process?
8. How does the vendor ensure AI output quality, accuracy, and safety?
   - Are there guardrails against harmful or inappropriate outputs?
   - Is there human oversight for high-stakes AI decisions?
   - Does the vendor measure and report hallucination rates or accuracy metrics?

**Additional AI-Specific Questions:**
- Does the vendor maintain an AI system inventory/registry with risk classifications?
- Are AI model decisions explainable and interpretable where required?
- Does the vendor have a process for AI impact assessments (similar to DPIAs for privacy)?
- How does the vendor handle AI model versioning, rollback, and deprecation?
- Are there controls for prompt injection, adversarial inputs, and other AI-specific attack vectors?
- Does the vendor disclose when AI is being used to process customer data or make decisions?
- What transparency measures are in place (model cards, data sheets, system documentation)?
- Does the vendor have policies on the use of generative AI by its own employees when handling customer data?

**Key Evidence:**
- AI governance framework or policy document
- EU AI Act risk classification documentation
- NIST AI RMF alignment mapping
- ISO 42001 certification or roadmap
- Model governance lifecycle documentation
- Training data provenance and rights documentation
- Bias testing reports and monitoring dashboards
- AI impact assessment templates and completed assessments
- Model cards or system documentation
- AI incident response procedures
- Customer opt-out mechanism documentation for model training

**Common Gaps:**
- No formal AI governance framework; AI development follows ad hoc processes
- No EU AI Act risk classification despite operating in EU markets
- Customer data is used for model training without clear disclosure or opt-out
- No bias testing or monitoring is performed
- AI models are deployed without explainability requirements for high-risk decisions
- No AI-specific incident response procedures
- Model governance does not include monitoring for drift or degradation
- No guardrails against harmful outputs or prompt injection attacks
- Transparency is limited; users cannot determine when AI is making or influencing decisions
- No AI impact assessments are performed before deploying new AI features
- Generative AI usage by vendor employees is uncontrolled, creating data leakage risk
