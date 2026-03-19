# DORA and NIS2 Regulatory Mapping

## DORA (Digital Operational Resilience Act) - Regulation (EU) 2022/2554

### Overview

DORA establishes a comprehensive framework for digital operational resilience in the EU financial sector. It directly impacts vendor risk assessment through its extensive ICT third-party risk management requirements.

**Effective Date:** January 17, 2025
**Applies To:** Financial entities (credit institutions, investment firms, insurance undertakings, payment institutions, crypto-asset service providers) and their ICT third-party service providers.

---

### Articles 28-44: ICT Third-Party Risk Management

#### Article 28 - General Principles

| DORA Requirement | VRA Domain Mapping |
|---|---|
| Sound management of ICT third-party risk | Governance, Risk Management |
| Proportionality based on criticality | Vendor Tiering |
| Board-level responsibility for ICT risk strategy | Governance |
| Register of all ICT third-party arrangements | Asset Management, Vendor Inventory |
| Assessment before entering into contractual arrangements | Due Diligence |

**Assessment Questions:**
- Does the organization maintain a complete register of all ICT third-party contractual arrangements?
- Is there a documented strategy for ICT third-party risk approved at board level?
- Are contractual arrangements classified by criticality and importance?

#### Article 29 - Preliminary Assessment of ICT Concentration Risk

| DORA Requirement | VRA Domain Mapping |
|---|---|
| Identify and assess concentration risk before contracting | Concentration Risk |
| Consider substitutability of ICT services | Business Continuity |
| Evaluate benefits and costs of alternative solutions | Strategic Risk |
| Report concentration risks to competent authorities | Regulatory Reporting |

#### Article 30 - Key Contractual Provisions

Contracts with ICT third-party service providers **must** include:

| Contractual Provision | Details | VRA Checkpoint |
|---|---|---|
| **Service description** | Clear, complete description of all functions and services | Contract Review |
| **Subcontracting conditions** | Full chain of subcontracting with approval rights | Fourth-Party Risk |
| **Data location** | Processing and storage locations specified | Data Protection |
| **Data protection** | Availability, authenticity, integrity, confidentiality provisions | Information Security |
| **Service levels** | Quantitative and qualitative performance targets | Performance Management |
| **Incident reporting** | Notification obligations and response times | Incident Management |
| **Business continuity** | BCM plans, testing, and recovery commitments | Business Continuity |
| **Termination rights** | Termination for cause, transition periods, data return | Exit Strategy |
| **Audit rights** | Unrestricted access for audits and inspections | Audit & Assurance |
| **Exit strategies** | Transition plans with adequate timelines | Exit Planning |
| **Cooperation with authorities** | Full cooperation with competent and resolution authorities | Regulatory Compliance |

**Critical Contract Clauses to Verify:**
1. Right to audit and inspect the ICT third-party provider
2. Obligation to participate in threat-led penetration testing (TLPT)
3. Data location restrictions and notification of changes
4. Full subcontracting chain visibility and approval rights
5. Defined exit strategy with mandatory transition period
6. Incident notification within contractually specified timelines

#### Article 31 - Designation of Critical ICT Third-Party Providers

**Designation Criteria (assessed by ESAs):**

| Criterion | Assessment Factors |
|---|---|
| Systemic impact | Degree to which a disruption would affect financial stability |
| Substitutability | Availability of alternatives, switching costs, migration complexity |
| Concentration | Number and significance of financial entities relying on the provider |
| Interconnectedness | Interdependencies with other providers and financial entities |

**Implications of Critical Designation:**
- Subject to direct oversight by Lead Overseer (ESA)
- Must comply with additional transparency and reporting requirements
- Subject to on-site inspections and information requests
- Required to provide detailed risk assessments and BCM documentation
- May face recommendations that carry comply-or-explain obligations

#### Articles 33-35 - Oversight Framework for Critical Providers

| Oversight Power | VRA Impact |
|---|---|
| General investigations | Vendor must cooperate with regulatory inquiries |
| On-site inspections | Vendor premises and systems subject to inspection |
| Recommendations | Vendor must address identified risks or explain non-compliance |
| Information requests | Vendor must provide data on services to financial entities |

#### Articles 36-44 - Cooperation and Enforcement

- Cross-border cooperation between competent authorities
- Information sharing on ICT third-party risk
- Penalties for non-compliance (member state level)

---

### Concentration Risk Requirements

**Assessment Framework:**

```
Concentration Risk Evaluation Matrix
-------------------------------------
Factor              | Low | Medium | High | Critical
--------------------|-----|--------|------|----------
Provider market     |     |        |      |
  share             | <5% | 5-15%  |15-30%| >30%
Financial entities  |     |        |      |
  dependent         | <10 | 10-50  |50-200| >200
Substitutability    | Easy| Moderate|Diff. | No viable
  assessment        |     |        |      | alternative
Service criticality | Non-| Import-| Crit-| Systemically
                    |crit.| ant    | ical | important
Geographic          |     |        |      |
  concentration     |Multi|  3+    |  2   | Single
  (data centers)    |region|regions|region| location
```

**Mitigation Strategies to Assess:**
1. Multi-provider strategy documentation
2. Interoperability and portability provisions
3. Regular substitutability testing
4. Documented exit and transition plans
5. Data portability assurance

---

### Exit Strategy Requirements

**Mandatory Components:**

1. **Transition Plan**
   - Detailed migration roadmap
   - Resource allocation and timeline
   - Minimum transition period (proportionate to service complexity)

2. **Data Management**
   - Data return procedures and formats
   - Data deletion confirmation from provider
   - Intellectual property ownership clarity

3. **Service Continuity**
   - Continued service delivery during transition
   - Performance maintenance commitments
   - Parallel running period provisions

4. **Testing**
   - Exit plan testing schedule
   - Simulation exercises
   - Documentation of test results

---

## NIS2 Directive - Directive (EU) 2022/2555

### Overview

NIS2 significantly expands the scope of EU cybersecurity regulation, with direct implications for supply chain security and vendor risk management.

**Transposition Deadline:** October 17, 2024
**Applies To:** Essential and Important entities across 18 sectors.

---

### Article 21 - Supply Chain Security Requirements

**Cybersecurity Risk Management Measures:**

| NIS2 Requirement | VRA Domain Mapping |
|---|---|
| Supply chain security policies | Governance, Third-Party Risk Policy |
| Supplier relationship security aspects | Vendor Assessment |
| Vulnerability handling and disclosure | Vulnerability Management |
| Security in network and information system acquisition | Procurement Security |
| Assessment of overall supply chain quality | Continuous Monitoring |
| Coordinated vulnerability disclosure | Incident Management |
| Cybersecurity-related aspects in relationships with direct suppliers | Contract Management |

**Supply Chain Security Assessment Areas:**
1. Direct supplier cybersecurity capabilities
2. Product development practices (secure SDLC)
3. Vulnerability handling procedures
4. Security certifications and audit results
5. Quality of security products and practices of suppliers
6. Risk assessments of critical supply chain dependencies

---

### Incident Reporting Requirements

| Timeline | Obligation | Details |
|---|---|---|
| **24 hours** | Early warning | Initial notification to CSIRT/competent authority |
| **72 hours** | Incident notification | Updated assessment including severity and impact |
| **1 month** | Final report | Root cause analysis, mitigation measures, cross-border impact |

**Vendor-Related Incident Reporting Considerations:**
- Incidents originating from vendor/supply chain must still be reported within required timelines
- Contractual provisions should ensure vendor cooperation in incident investigation
- Vendor SLAs for incident notification should align with or be shorter than NIS2 timelines
- Cross-border incident reporting may be required when vendor serves multiple EU jurisdictions

---

### Essential vs Important Entity Obligations

| Aspect | Essential Entities | Important Entities |
|---|---|---|
| **Sectors** | Energy, transport, banking, health, digital infrastructure, water, space, public admin, ICT service management (B2B) | Postal, waste, chemicals, food, manufacturing, digital providers, research |
| **Supervision** | Ex-ante (proactive) | Ex-post (reactive, after incident) |
| **Penalties** | Up to 10M EUR or 2% global turnover | Up to 7M EUR or 1.4% global turnover |
| **Risk management** | Full Article 21 compliance | Full Article 21 compliance |
| **Reporting** | Mandatory incident reporting | Mandatory incident reporting |
| **Management liability** | Personal liability for management | Personal liability for management |

**VRA Implication:** Vendor classification should consider whether the vendor qualifies as an Essential or Important entity under NIS2, as this affects the regulatory baseline they must meet.

---

### Security Measures Mapping to VRA Domains

| NIS2 Security Measure (Art. 21.2) | VRA Assessment Domain |
|---|---|
| (a) Policies on risk analysis and information system security | Information Security Policy |
| (b) Incident handling | Incident Management |
| (c) Business continuity and crisis management | Business Continuity |
| (d) Supply chain security | Third-Party Risk Management |
| (e) Security in acquisition, development, and maintenance | Secure Development |
| (f) Vulnerability handling and disclosure | Vulnerability Management |
| (g) Cybersecurity risk assessment practices | Risk Management |
| (h) Cryptography and encryption policies | Data Protection |
| (i) Human resources security and access control | Access Management |
| (j) Multi-factor authentication and secure communications | Authentication & Communications |

---

### Member State Implementation Variations

**Key Differences to Monitor:**

| Variation Area | Impact on VRA |
|---|---|
| **Sector-specific requirements** | Some member states may impose stricter requirements for specific sectors |
| **Certification schemes** | Member states may mandate specific cybersecurity certifications |
| **Penalty frameworks** | Actual penalty amounts may vary within NIS2 maximums |
| **Registration requirements** | Some member states require entity registration |
| **National CSIRT procedures** | Reporting mechanisms and formats may differ |
| **Additional security measures** | Member states may add to the baseline in Article 21 |

**VRA Best Practices for Multi-Jurisdiction Compliance:**
1. Map vendor operations to all applicable member state implementations
2. Apply the most stringent requirement where variations exist
3. Monitor transposition progress in all relevant jurisdictions
4. Include jurisdiction-specific contractual provisions
5. Ensure vendor incident reporting can meet the shortest applicable timeline
6. Maintain awareness of national cybersecurity certification schemes

---

### Cross-Reference: DORA and NIS2 Alignment

| Topic | DORA | NIS2 | VRA Consideration |
|---|---|---|---|
| Scope | Financial sector | Cross-sector (18 sectors) | DORA is lex specialis for financial entities |
| Incident reporting | Per RTS specifications | 24h/72h/1 month | Financial entities follow DORA timelines |
| Supply chain | ICT third-party focus | Broad supply chain | DORA is more prescriptive on ICT providers |
| Oversight | Direct oversight of critical providers | National authority supervision | Different oversight mechanisms apply |
| Penalties | Member state defined | Defined maximums | Cumulative exposure if entity falls under both |
| Risk management | Detailed ICT risk framework | General cybersecurity measures | DORA requires more granular ICT controls |

**Note:** Financial entities subject to DORA are generally exempt from NIS2 for the areas covered by DORA, but NIS2 may still apply to aspects not specifically addressed by DORA. VRA programs should assess compliance with both frameworks where applicable.
