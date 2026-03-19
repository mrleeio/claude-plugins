# SEC Cybersecurity Disclosure Rules

## Overview

The SEC adopted final rules on cybersecurity risk management, strategy, governance, and incident disclosure on July 26, 2023, effective September 5, 2023. These rules require public companies (registrants) to disclose material cybersecurity incidents and provide annual disclosures on cybersecurity risk management, strategy, and governance -- including third-party risk management programs.

**Applicable Regulations:**
- Final Rule: Cybersecurity Risk Management, Strategy, Governance, and Incident Disclosure (Release No. 33-11216)
- Amendments to Form 8-K (Item 1.05)
- Amendments to Form 10-K (Item 1C of Regulation S-K)
- Amendments to Form 20-F (for foreign private issuers)

---

## Form 8-K Item 1.05 - Material Cybersecurity Incident Disclosure

### Four Business Day Requirement

**Trigger:** Determination that a cybersecurity incident is material.

**Timeline:**
- Clock starts when the registrant **determines** the incident is material (not when the incident occurs or is discovered)
- Filing required within **4 business days** of materiality determination
- Registrants must not unreasonably delay making a materiality determination

**Required Disclosures:**
1. Nature, scope, and timing of the incident
2. Material impact or reasonably likely material impact on the registrant, including financial condition and results of operations

**Vendor Incident Implications:**
- Incidents at third-party vendors that materially impact the registrant trigger the same disclosure obligation
- The registrant (not the vendor) is responsible for timely disclosure
- Vendor contracts should include notification timelines that allow the registrant sufficient time to assess materiality and file within 4 business days

### Materiality Determination Framework for Vendor Incidents

**Standard:** Information is material if there is a substantial likelihood that a reasonable investor would consider it important in making an investment decision.

**Quantitative Factors:**

| Factor | Assessment Criteria |
|---|---|
| Financial impact | Direct costs, remediation expenses, lost revenue |
| Business disruption | Duration and scope of operational impact |
| Data exposure | Volume and sensitivity of data compromised |
| Contractual liability | Indemnification obligations, SLA penalties |
| Regulatory fines | Anticipated enforcement actions and penalties |
| Litigation exposure | Potential class action or regulatory suits |

**Qualitative Factors:**

| Factor | Assessment Criteria |
|---|---|
| Reputational harm | Customer trust, market perception, media coverage |
| Customer impact | Number and type of affected customers |
| Competitive position | Loss of proprietary information or advantage |
| Strategic impact | Effect on planned initiatives, M&A, partnerships |
| Systemic risk | Broader market or industry implications |
| Recurring nature | Pattern indicating systemic control weakness |

**Vendor-Specific Materiality Considerations:**
1. Is the vendor's service critical to core business operations?
2. Does the incident affect data the registrant is obligated to protect?
3. Could the incident cascade to other systems or vendors?
4. Is the vendor a sole-source or difficult-to-replace provider?
5. Does the incident reveal a systemic weakness in the vendor risk program?
6. Are other registrants affected by the same vendor incident?

### National Security Delay Exception

- Disclosure may be delayed if the U.S. Attorney General determines that disclosure poses a substantial risk to national security or public safety
- Initial delay: up to 30 days (can be extended up to 60 days total, with an additional 60-day extension in extraordinary circumstances)
- This exception is narrowly construed and rarely applicable

---

## Form 10-K Item 1C - Cybersecurity Risk Management Disclosure

### Annual Disclosure Requirements

#### Risk Management and Strategy (Item 106(b))

Registrants must describe their processes for assessing, identifying, and managing material risks from cybersecurity threats, including:

| Disclosure Element | Third-Party Risk Relevance |
|---|---|
| Whether and how the process integrates into overall risk management | How vendor risk fits within enterprise risk framework |
| Whether the registrant engages assessors, consultants, or auditors | Use of third-party assessment services |
| Whether the registrant has processes to oversee and identify risks from third-party service providers | Direct description of vendor risk program |
| Whether any cybersecurity incidents have materially affected the registrant | Including vendor-originated incidents |
| Risks from cybersecurity threats that are reasonably likely to materially affect the registrant | Including supply chain and concentration risks |

#### Governance (Item 106(c))

| Disclosure Element | VRA Domain Mapping |
|---|---|
| Board oversight of cybersecurity risks | Governance |
| How the board is informed about cyber risks | Reporting & Communication |
| Management's role in assessing and managing cyber risks | Governance, Risk Management |
| Relevant expertise of management | Personnel & Competency |
| Management's role in implementing cybersecurity policies and procedures | Policy Management |

---

### Board Oversight Requirements and Governance Domain Mapping

**Board-Level Expectations:**

| Expectation | VRA Governance Assessment |
|---|---|
| Regular briefings on cybersecurity risk posture | Does VRA program report to the board? |
| Understanding of third-party risk landscape | Is vendor risk included in board risk reporting? |
| Oversight of risk management framework | Is vendor risk framework board-approved? |
| Incident escalation procedures to board | Are vendor incidents escalated per defined thresholds? |
| Approval of risk appetite and tolerance | Are vendor risk thresholds board-endorsed? |

**Management-Level Expectations:**

| Expectation | VRA Governance Assessment |
|---|---|
| Designated responsibility for third-party risk | Is there a named vendor risk owner/function? |
| Defined processes and procedures | Are vendor risk processes documented and followed? |
| Regular risk assessment cadence | Is the assessment schedule maintained? |
| Incident response coordination | Is vendor incident response integrated with IR plan? |
| Reporting to board/committee | Are vendor risk reports prepared and delivered? |

---

## Third-Party Risk Management Program Disclosure Expectations

### What the SEC Expects to See

Based on the final rule and SEC staff guidance, registrants should be prepared to disclose:

1. **Program Structure**
   - Organizational placement of third-party risk function
   - Reporting lines and governance structure
   - Integration with enterprise risk management

2. **Assessment Processes**
   - How third-party cybersecurity risks are identified and assessed
   - Vendor due diligence procedures
   - Ongoing monitoring practices
   - Criteria for vendor risk tiering

3. **Oversight Mechanisms**
   - Contractual security requirements
   - Right-to-audit provisions
   - Continuous monitoring tools and methods
   - Incident notification requirements

4. **Risk Mitigation**
   - Controls and safeguards in place
   - Concentration risk management
   - Exit and transition planning
   - Insurance coverage considerations

---

## Example Language for Risk Management Disclosures

### Third-Party Risk Management Description

> We maintain a comprehensive third-party risk management program designed to identify, assess, and manage cybersecurity risks arising from our use of third-party service providers. Our program includes:
>
> - A risk-based tiering methodology that categorizes vendors based on data access, service criticality, and regulatory requirements
> - Pre-engagement due diligence assessments covering information security controls, business continuity capabilities, and regulatory compliance
> - Ongoing monitoring of vendor security posture through a combination of periodic reassessments, security ratings services, and contractual audit rights
> - Contractual provisions requiring our vendors to maintain defined security standards, notify us promptly of security incidents, and cooperate with our audit and assessment activities
> - Regular reporting to our [Board Committee] on the state of our third-party risk landscape, including concentration risks and any material vendor incidents

### Board Oversight Description

> Our [Audit Committee / Risk Committee / Board] oversees our cybersecurity risk management program, including risks arising from third-party service providers. [Committee/Board] receives [quarterly/regular] reports from our [CISO/CRO/CIO] covering the current threat landscape, vendor risk posture, results of vendor assessments, and any significant cybersecurity incidents involving our third-party providers. Our management team, led by [title], is responsible for implementing and maintaining our cybersecurity risk management policies and procedures, including our vendor risk management program.

### Incident History Description (if applicable)

> [During the reporting period / In [year]], we experienced [a cybersecurity incident / cybersecurity incidents] involving [a third-party service provider / our supply chain] that [describe impact]. We assessed the materiality of [this incident / these incidents] in accordance with our established framework and [determined it was not material / disclosed the incident pursuant to Item 1.05 of Form 8-K on [date]].

---

## VRA Program Alignment Checklist

Use the following checklist to ensure the VRA program supports SEC disclosure requirements:

- [ ] Vendor risk management is integrated into the enterprise risk management framework
- [ ] Board or committee receives regular reports on third-party cybersecurity risks
- [ ] Management roles and responsibilities for vendor risk are clearly defined
- [ ] Pre-engagement due diligence process is documented and consistently followed
- [ ] Vendor tiering methodology is documented and risk-based
- [ ] Continuous monitoring program is in place for critical vendors
- [ ] Incident notification timelines in vendor contracts support 4-business-day 8-K filing
- [ ] Materiality determination framework includes vendor incident scenarios
- [ ] Concentration risk across vendors is assessed and reported
- [ ] Annual disclosure language is reviewed and updated for accuracy
- [ ] Third-party assessors, consultants, or auditors are engaged as appropriate
- [ ] Vendor-related cybersecurity risks are included in risk factor disclosures
