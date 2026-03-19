# Risk Scoring Matrix

## 5x5 Likelihood x Impact Matrix

The risk score for any identified risk is calculated as **Likelihood x Impact**, producing a value from 1 to 25. The matrix below maps every combination to a risk level.

|                     | Negligible (1) | Minor (2) | Moderate (3) | Major (4) | Severe (5) |
|---------------------|:--------------:|:---------:|:------------:|:---------:|:----------:|
| **Almost Certain (5)** | 5 (Medium)     | 10 (High) | 15 (Critical)| 20 (Critical)| 25 (Critical)|
| **Likely (4)**          | 4 (Low)        | 8 (Medium)| 12 (High)    | 16 (Critical)| 20 (Critical)|
| **Possible (3)**        | 3 (Low)        | 6 (Medium)| 9 (High)     | 12 (High)    | 15 (Critical)|
| **Unlikely (2)**        | 2 (Low)        | 4 (Low)   | 6 (Medium)   | 8 (Medium)   | 10 (High)    |
| **Rare (1)**            | 1 (Low)        | 2 (Low)   | 3 (Low)      | 4 (Low)      | 5 (Medium)   |

### Risk Level Thresholds

| Score Range | Risk Level | Action Required |
|:-----------:|:----------:|:----------------|
| 1-4         | Low        | Accept risk; monitor during periodic reviews |
| 5-9         | Medium     | Mitigate with standard controls; review quarterly |
| 10-15       | High       | Require remediation plan within 30 days; escalate to risk owner |
| 16-25       | Critical   | Immediate action required; escalate to senior leadership; consider relationship termination |

---

## Likelihood Scale

| Level | Label | Probability | Criteria |
|:-----:|:------|:-----------:|:---------|
| 1 | **Rare** | < 5% | Event may occur only in exceptional circumstances. No history of occurrence at this vendor or comparable vendors. Strong preventive controls are in place. |
| 2 | **Unlikely** | 5-20% | Event could occur but is not expected. Isolated incidents have been observed at comparable vendors. Adequate preventive controls exist with minor gaps. |
| 3 | **Possible** | 20-50% | Event might occur at some point. Similar events have occurred at comparable vendors within the past 3 years. Some preventive controls exist but with notable gaps. |
| 4 | **Likely** | 50-80% | Event will probably occur in most circumstances. The vendor or comparable vendors have experienced this event within the past 12 months. Preventive controls are weak or inconsistently applied. |
| 5 | **Almost Certain** | > 80% | Event is expected to occur. The vendor has a documented history of this event. Preventive controls are absent or ineffective. |

---

## Impact Scale

Each impact level is defined across four dimensions. The **highest applicable dimension** determines the overall impact score.

### Level 1 -- Negligible

| Dimension | Criteria |
|:----------|:---------|
| Financial | Loss < $10,000 or < 0.01% of annual revenue |
| Operational | Disruption < 1 hour; no measurable effect on service delivery |
| Regulatory | No regulatory attention; internal policy deviation only |
| Reputational | No external awareness; contained within operational team |

### Level 2 -- Minor

| Dimension | Criteria |
|:----------|:---------|
| Financial | Loss $10,000-$100,000 or 0.01-0.1% of annual revenue |
| Operational | Disruption 1-8 hours; minor degradation in non-critical services |
| Regulatory | Potential for regulatory inquiry; no formal investigation |
| Reputational | Limited external awareness; localized customer complaints |

### Level 3 -- Moderate

| Dimension | Criteria |
|:----------|:---------|
| Financial | Loss $100,000-$1,000,000 or 0.1-1% of annual revenue |
| Operational | Disruption 8-72 hours; degradation in critical services with workarounds available |
| Regulatory | Formal regulatory inquiry or audit finding; potential for minor penalties |
| Reputational | Regional media coverage; notable customer dissatisfaction; social media attention |

### Level 4 -- Major

| Dimension | Criteria |
|:----------|:---------|
| Financial | Loss $1,000,000-$10,000,000 or 1-5% of annual revenue |
| Operational | Disruption 3-14 days; critical services unavailable; manual workarounds required |
| Regulatory | Regulatory enforcement action; material fines; consent order or corrective action plan |
| Reputational | National media coverage; significant customer attrition; executive-level public response required |

### Level 5 -- Severe

| Dimension | Criteria |
|:----------|:---------|
| Financial | Loss > $10,000,000 or > 5% of annual revenue |
| Operational | Disruption > 14 days; complete loss of critical business function; no viable workaround |
| Regulatory | License revocation threat; class-action litigation; multi-jurisdictional enforcement |
| Reputational | Sustained international media coverage; existential threat to brand; board-level crisis management |

---

## Per-Domain Scoring Guidance

The following criteria define what constitutes **Strong**, **Adequate**, and **Weak** for each of the 15 assessment domains. Score each domain on the 1-5 scale using these benchmarks.

### 1. Data Security

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Encryption at rest and in transit using current standards (AES-256, TLS 1.2+). Robust key management with HSM. DLP controls deployed and monitored. Regular penetration testing by qualified third party. |
| **Adequate (3)** | Encryption implemented but with some gaps (e.g., legacy systems). Key management procedures documented but manual. DLP partially deployed. Annual penetration testing. |
| **Weak (1-2)** | Encryption absent or using deprecated algorithms. No formal key management. No DLP. Penetration testing not performed or findings unaddressed. |

### 2. Access Control

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Role-based access control enforced. Least-privilege principle applied and audited. MFA required for all privileged and remote access. Access reviews performed quarterly. Automated provisioning/deprovisioning. |
| **Adequate (3)** | RBAC defined but not consistently enforced. MFA for privileged access only. Access reviews performed annually. Manual provisioning with documented process. |
| **Weak (1-2)** | Shared accounts used. No MFA. No regular access reviews. Ad-hoc provisioning with no formal process. |

### 3. Network Security

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Network segmentation with micro-segmentation for sensitive zones. Next-gen firewall with IDS/IPS. 24/7 SOC monitoring. Zero-trust architecture principles applied. |
| **Adequate (3)** | Basic network segmentation. Standard firewall with IDS. Monitoring during business hours. VPN for remote access. |
| **Weak (1-2)** | Flat network with no segmentation. Basic firewall only. No intrusion detection. Minimal or no network monitoring. |

### 4. Incident Response

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Documented IR plan tested via tabletop exercises at least annually. Defined notification timelines (< 24 hours). Dedicated IR team or retainer with qualified firm. Post-incident review process with lessons learned. |
| **Adequate (3)** | Documented IR plan but tested infrequently. Notification within 72 hours. IR responsibilities assigned but not dedicated. Basic post-incident review. |
| **Weak (1-2)** | No documented IR plan or plan is outdated. No defined notification process. No designated IR personnel. No post-incident analysis. |

### 5. Business Continuity

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | BCP and DR plan tested annually. RTO/RPO defined and met in testing. Geographic redundancy for critical systems. Documented and tested failover procedures. |
| **Adequate (3)** | BCP exists but testing is infrequent or limited in scope. RTO/RPO defined but not validated. Single-region redundancy. Basic failover documented. |
| **Weak (1-2)** | No BCP or DR plan. RTO/RPO not defined. No redundancy. No failover capability. |

### 6. Compliance

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Current SOC 2 Type II (or equivalent) with clean opinion. ISO 27001 certified. All relevant regulatory requirements mapped and evidenced. Compliance monitoring automated where possible. |
| **Adequate (3)** | SOC 2 Type I or Type II with noted exceptions under remediation. Pursuing ISO 27001. Most regulatory requirements addressed with some gaps. Manual compliance monitoring. |
| **Weak (1-2)** | No independent audit reports. No security certifications. Significant compliance gaps. No compliance monitoring program. |

### 7. Privacy

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Privacy program with designated DPO/CPO. DPIA performed for all processing activities. Data subject rights processes automated. Data processing agreements current and comprehensive. Privacy by design embedded in SDLC. |
| **Adequate (3)** | Privacy policy exists. DPIAs performed for high-risk processing. Manual data subject rights process. DPAs in place but may need updates. |
| **Weak (1-2)** | No formal privacy program. No DPIAs. No process for data subject rights. Missing or inadequate DPAs. |

### 8. Vulnerability Management

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Continuous vulnerability scanning. Critical/high findings remediated within 7/30 days. Patch management SLA defined and tracked. Vulnerability disclosure program in place. |
| **Adequate (3)** | Monthly vulnerability scanning. Critical/high findings remediated within 30/90 days. Patch management process documented. |
| **Weak (1-2)** | Infrequent or no vulnerability scanning. No defined remediation timelines. Ad-hoc patching. Known vulnerabilities remain unaddressed. |

### 9. Change Management

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Formal change advisory board. All changes documented, tested, and approved before deployment. Automated CI/CD with security gates. Rollback procedures tested. |
| **Adequate (3)** | Change management process documented. Most changes follow process. Manual testing before deployment. Rollback procedures documented but not regularly tested. |
| **Weak (1-2)** | No formal change management. Changes deployed without testing or approval. No rollback procedures. |

### 10. Physical Security

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Multi-layer physical access controls (badge, biometric, mantrap). 24/7 security personnel. CCTV with 90+ day retention. Visitor management system. Environmental controls (fire suppression, HVAC, UPS). |
| **Adequate (3)** | Badge access to facilities. CCTV at entry points. Visitor sign-in process. Basic environmental controls. |
| **Weak (1-2)** | Minimal physical access controls. No CCTV or limited coverage. No visitor management. Inadequate environmental controls. |

### 11. Human Resources Security

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Background checks for all employees. Annual security awareness training with phishing simulations. Acceptable use policy signed. Clear disciplinary process for violations. Secure offboarding with same-day access revocation. |
| **Adequate (3)** | Background checks for roles with data access. Annual security awareness training. Acceptable use policy exists. Offboarding process documented. |
| **Weak (1-2)** | No background checks. No security awareness training. No acceptable use policy. Ad-hoc offboarding. |

### 12. Third-Party Management

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Comprehensive third-party risk management program. Vendors assessed before onboarding and periodically. Contractual security requirements enforced. Right-to-audit clauses exercised. Nth-party risk tracked. |
| **Adequate (3)** | Third-party assessment performed at onboarding. Contractual security clauses included. Periodic reassessment for critical vendors. |
| **Weak (1-2)** | No third-party risk program. No security requirements in contracts. No ongoing monitoring of vendor risk. |

### 13. Security Governance

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | CISO or equivalent role reporting to executive leadership. Information security policy framework aligned to recognized standard (NIST, ISO). Risk appetite defined by board. Regular security metrics reported to leadership. |
| **Adequate (3)** | Designated security leader. Security policies exist but may not cover all areas. Risk assessment performed annually. Periodic reporting to management. |
| **Weak (1-2)** | No designated security leader. Policies outdated or missing. No formal risk assessment. No security reporting to leadership. |

### 14. Application Security

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Secure SDLC with security requirements, threat modeling, SAST/DAST, and code review. OWASP Top 10 addressed. Bug bounty program. Security champions embedded in development teams. |
| **Adequate (3)** | Security included in SDLC but not at every stage. SAST or DAST performed. OWASP Top 10 awareness. Periodic application security assessments. |
| **Weak (1-2)** | No secure SDLC. No application security testing. OWASP Top 10 not addressed. No security involvement in development. |

### 15. Data Lifecycle Management

| Rating | Criteria |
|:-------|:---------|
| **Strong (4-5)** | Data classification scheme implemented and enforced. Retention and disposal policies defined and automated. Secure data destruction with certificates. Data inventory maintained. Data lineage tracked. |
| **Adequate (3)** | Data classification defined but inconsistently applied. Retention policies exist. Manual data disposal with documentation. Basic data inventory. |
| **Weak (1-2)** | No data classification. No retention or disposal policies. Data hoarded indefinitely. No data inventory. |

---

## Control Effectiveness Rating

When assessing the effectiveness of controls within any domain, use the following scale.

| Rating | Score Range | Description |
|:-------|:----------:|:------------|
| **Strong** | 80-100% | Controls are well-designed, consistently implemented, and regularly validated. Evidence of continuous improvement. Gaps are minor and actively managed. |
| **Adequate** | 50-79% | Controls are designed and implemented but with notable gaps. Evidence of periodic review. Some controls may be manual or inconsistently applied. |
| **Weak** | 20-49% | Controls exist in limited form. Significant design or implementation gaps. Infrequent review. Reliance on ad-hoc or reactive measures. |
| **Absent** | 0-19% | Controls are not implemented or are entirely ineffective. No evidence of design, monitoring, or improvement. |

### Mapping Control Effectiveness to Domain Score

| Control Effectiveness | Domain Score |
|:----------------------|:------------|
| Strong (80-100%)      | 4 or 5 (use 5 if effectiveness > 90% with evidence of continuous improvement) |
| Adequate (50-79%)     | 3 (use 2 if effectiveness is at the lower end, 50-59%) |
| Weak (20-49%)         | 2 (use 1 if effectiveness < 30%) |
| Absent (0-19%)        | 1 |
