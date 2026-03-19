# Vendor Monitoring Tiers - Detailed Procedures

## Overview

Continuous monitoring intensity should be proportionate to the risk tier assigned during vendor assessment. This reference defines monitoring procedures, checklists, alert configurations, tool requirements, reporting cadences, and escalation procedures for each tier.

---

## Tier 1: Critical Vendors

**Definition:** Vendors whose failure or compromise would cause severe business disruption, significant financial loss, regulatory non-compliance, or material harm to customers. Typically includes core infrastructure, primary cloud providers, critical data processors, and systemically important service providers.

### Monitoring Cadence

| Activity | Frequency | Owner |
|---|---|---|
| Security ratings check | Daily | Automated / Analyst |
| Threat intelligence review | Daily | Threat Intel Team |
| Service availability monitoring | Continuous (real-time) | NOC / Automated |
| Dark web monitoring for vendor exposure | Daily | Threat Intel / MSSP |
| News and media monitoring | Daily | Automated / Analyst |
| Financial health indicators | Weekly | Analyst |
| Regulatory action monitoring | Weekly | Compliance |
| SLA performance review | Weekly | Vendor Manager |
| Vulnerability scan correlation | Weekly | Security Operations |
| Contractual compliance review | Monthly | Vendor Manager |
| Comprehensive risk reassessment | Quarterly | Risk Team |
| On-site or detailed remote assessment | Annually | Assessment Team |
| Tabletop exercise (vendor scenario) | Annually | BC/DR Team |

### Daily Checklist

- [ ] Review security rating score and any score changes exceeding threshold (5+ points)
- [ ] Check threat intelligence feeds for vendor-related indicators of compromise
- [ ] Verify service availability and performance against SLA baselines
- [ ] Review dark web monitoring alerts for vendor data exposure or credential leaks
- [ ] Scan news sources for vendor security incidents, leadership changes, or financial distress
- [ ] Review any vendor-initiated notifications or communications

### Weekly Checklist

- [ ] Analyze aggregated security rating trends for the week
- [ ] Review vendor financial health indicators (stock price, credit rating changes, analyst reports)
- [ ] Check for new regulatory actions, lawsuits, or enforcement against the vendor
- [ ] Review SLA performance metrics and flag any breaches
- [ ] Correlate vulnerability scan data with vendor-hosted assets
- [ ] Review and action any open vendor risk items or remediation tracking entries
- [ ] Update vendor risk dashboard

### Monthly Checklist

- [ ] Compile monthly vendor risk report for critical vendors
- [ ] Review contractual compliance across all critical vendor agreements
- [ ] Assess any changes to vendor's subcontractor or fourth-party landscape
- [ ] Review and update vendor contact information and escalation paths
- [ ] Validate vendor insurance coverage and certificate currency
- [ ] Review vendor patch management and vulnerability remediation status

### Quarterly Checklist

- [ ] Conduct comprehensive risk reassessment using full assessment questionnaire
- [ ] Review and update vendor risk rating based on all monitoring inputs
- [ ] Assess concentration risk across critical vendor portfolio
- [ ] Review vendor business continuity and disaster recovery test results
- [ ] Validate vendor compliance certifications (SOC 2, ISO 27001, etc.) are current
- [ ] Present critical vendor risk summary to risk committee or board
- [ ] Review and update exit strategy and transition plans

### Alert Configuration

| Alert Type | Threshold | Priority | Response Time |
|---|---|---|---|
| Security rating drop | >= 5 points in 24h | Critical | 4 hours |
| Service outage | Any unplanned downtime > 15 min | Critical | Immediate |
| Data breach notification | Any vendor notification | Critical | 1 hour |
| Dark web exposure | Vendor data or credentials found | High | 4 hours |
| Financial distress signal | Credit downgrade, stock drop > 10% | High | 24 hours |
| Regulatory action | Enforcement action or investigation | High | 24 hours |
| Certificate expiration | Within 30 days of expiry | Medium | 5 business days |
| Subcontractor change | New critical subcontractor added | Medium | 5 business days |
| News alert | Negative security/privacy coverage | Medium | 24 hours |

### Tool Requirements

- Real-time service availability monitoring (e.g., synthetic monitoring, API health checks)
- Security ratings platform with daily refresh and API integration
- Threat intelligence platform with vendor-specific watch lists
- Dark web monitoring service
- Automated news and media monitoring
- Financial health monitoring service or feed
- GRC platform for risk tracking and workflow
- SIEM integration for vendor-related security event correlation

### Reporting

| Report | Audience | Frequency | Format |
|---|---|---|---|
| Critical vendor dashboard | CISO, CRO | Weekly | Dashboard / Executive summary |
| Critical vendor risk report | Risk Committee | Monthly | Detailed report with trends |
| Board risk summary | Board / Audit Committee | Quarterly | Executive presentation |
| Annual assessment report | Exec Leadership | Annually | Comprehensive assessment report |

---

## Tier 2: High-Risk Vendors

**Definition:** Vendors with significant data access, meaningful business impact if disrupted, or elevated regulatory exposure. Includes secondary service providers, significant SaaS platforms, and vendors processing sensitive data.

### Monitoring Cadence

| Activity | Frequency | Owner |
|---|---|---|
| Security ratings check | Weekly | Automated / Analyst |
| Threat intelligence review | Weekly | Threat Intel Team |
| Service availability monitoring | Continuous or hourly | NOC / Automated |
| News and media monitoring | Weekly | Automated / Analyst |
| Financial health indicators | Monthly | Analyst |
| Regulatory action monitoring | Monthly | Compliance |
| SLA performance review | Monthly | Vendor Manager |
| Contractual compliance review | Quarterly | Vendor Manager |
| Comprehensive risk reassessment | Semi-annually | Risk Team |
| Detailed assessment | Annually | Assessment Team |

### Weekly Checklist

- [ ] Review security rating score and investigate any significant changes
- [ ] Check threat intelligence feeds for vendor-related alerts
- [ ] Verify service availability metrics meet SLA requirements
- [ ] Scan news sources for vendor-related incidents or material changes
- [ ] Review any vendor-initiated communications or notifications

### Monthly Checklist

- [ ] Compile monthly summary of high-risk vendor monitoring results
- [ ] Review vendor financial health indicators
- [ ] Check for regulatory actions or enforcement affecting the vendor
- [ ] Review SLA performance metrics and flag breaches
- [ ] Update vendor risk tracking items and remediation status

### Quarterly Checklist

- [ ] Review contractual compliance across high-risk vendor agreements
- [ ] Assess changes to vendor subcontractor landscape
- [ ] Validate vendor insurance and certification currency
- [ ] Update vendor risk dashboard entries

### Semi-Annual Checklist

- [ ] Conduct comprehensive risk reassessment
- [ ] Review and update vendor risk rating
- [ ] Assess concentration risk contributions
- [ ] Review vendor BC/DR capabilities and test results
- [ ] Update exit strategy considerations

### Alert Configuration

| Alert Type | Threshold | Priority | Response Time |
|---|---|---|---|
| Security rating drop | >= 8 points in 7 days | High | 24 hours |
| Service outage | Unplanned downtime > 1 hour | High | 4 hours |
| Data breach notification | Any vendor notification | Critical | 2 hours |
| Financial distress signal | Credit downgrade, significant stock drop | Medium | 48 hours |
| Regulatory action | Enforcement action or investigation | Medium | 48 hours |
| Certificate expiration | Within 30 days of expiry | Low | 10 business days |

### Tool Requirements

- Service availability monitoring (can be less granular than critical tier)
- Security ratings platform with weekly refresh
- Threat intelligence feed (can be shared with critical tier tooling)
- Automated news monitoring
- GRC platform for risk tracking

### Reporting

| Report | Audience | Frequency | Format |
|---|---|---|---|
| High-risk vendor summary | CISO, Vendor Risk Lead | Monthly | Summary report |
| Combined vendor risk report | Risk Committee | Quarterly | Combined with critical vendor report |
| Assessment results | Vendor Risk Lead | Semi-annually | Assessment report |

---

## Tier 3: Medium-Risk Vendors

**Definition:** Vendors with limited data access, moderate business impact if disrupted, and standard regulatory exposure. Includes general business SaaS, consulting firms with data access, and non-critical IT service providers.

### Monitoring Cadence

| Activity | Frequency | Owner |
|---|---|---|
| Security ratings check | Monthly | Automated / Analyst |
| News and media monitoring | Monthly | Automated |
| Financial health indicators | Quarterly | Analyst |
| SLA performance review | Quarterly | Vendor Manager |
| Contractual compliance review | Semi-annually | Vendor Manager |
| Comprehensive risk reassessment | Annually | Risk Team |
| Questionnaire-based assessment | Annually | Assessment Team |

### Monthly Checklist

- [ ] Review security rating score and note any significant changes
- [ ] Scan news for vendor-related incidents or material changes
- [ ] Review any vendor-initiated communications

### Quarterly Checklist

- [ ] Review vendor financial stability indicators
- [ ] Review SLA performance for the quarter
- [ ] Update vendor risk tracking items
- [ ] Check for regulatory actions affecting the vendor

### Annual Checklist

- [ ] Conduct full risk reassessment via questionnaire
- [ ] Review and update vendor risk rating
- [ ] Verify contractual compliance
- [ ] Validate vendor certifications and insurance
- [ ] Update vendor inventory records
- [ ] Review continued business justification for the vendor relationship

### Alert Configuration

| Alert Type | Threshold | Priority | Response Time |
|---|---|---|---|
| Security rating drop | >= 10 points in 30 days | Medium | 5 business days |
| Data breach notification | Vendor notification received | High | 24 hours |
| Significant news event | Major negative coverage | Medium | 5 business days |
| Certificate expiration | Within 30 days of expiry | Low | 15 business days |

### Tool Requirements

- Security ratings platform (monthly refresh sufficient)
- Automated news monitoring (can use lightweight tools)
- GRC platform for risk tracking

### Reporting

| Report | Audience | Frequency | Format |
|---|---|---|---|
| Medium-risk vendor summary | Vendor Risk Lead | Quarterly | Summary dashboard |
| Assessment results | Vendor Risk Lead | Annually | Assessment report |

---

## Tier 4: Low-Risk Vendors

**Definition:** Vendors with no access to sensitive data, minimal business impact if disrupted, and no significant regulatory exposure. Includes general office supplies, non-IT services with no data access, and commoditized services with easy substitution.

### Monitoring Cadence

| Activity | Frequency | Owner |
|---|---|---|
| Security ratings check | Quarterly | Automated |
| News monitoring | Quarterly | Automated |
| Contractual compliance review | Annually | Vendor Manager |
| Risk reassessment | Every 2 years or upon trigger | Risk Team |

### Quarterly Checklist

- [ ] Review security rating score for any dramatic changes
- [ ] Scan news for major vendor incidents

### Annual Checklist

- [ ] Verify contractual compliance and agreement currency
- [ ] Confirm vendor is still active and relationship is needed
- [ ] Update vendor inventory records

### Biennial Checklist

- [ ] Conduct simplified risk reassessment
- [ ] Confirm vendor risk tier is still appropriate
- [ ] Review vendor against current policy requirements

### Alert Configuration

| Alert Type | Threshold | Priority | Response Time |
|---|---|---|---|
| Data breach notification | Vendor notification received | Medium | 48 hours |
| Major news event | Major negative coverage | Low | 10 business days |
| Security rating drop | >= 15 points in 90 days | Low | 10 business days |

### Tool Requirements

- Security ratings platform (quarterly refresh sufficient)
- Basic news monitoring (automated alerts)
- GRC platform for inventory tracking

### Reporting

| Report | Audience | Frequency | Format |
|---|---|---|---|
| Low-risk vendor summary | Vendor Risk Lead | Annually | Summary list |
| Exception report | Vendor Risk Lead | As needed | Exception report |

---

## Escalation Procedures

### Escalation Matrix

| Severity | Definition | Initial Responder | Escalation Path | Response Time SLA |
|---|---|---|---|---|
| **P1 - Critical** | Active breach, service outage affecting critical operations, regulatory notification required | Vendor Risk Lead + CISO | CISO -> CRO -> CEO/Board within 2 hours | 1 hour initial response |
| **P2 - High** | Confirmed security incident, significant SLA breach, financial distress confirmed | Vendor Risk Lead | CISO within 4 hours; CRO within 24 hours | 4 hours initial response |
| **P3 - Medium** | Security rating degradation, minor SLA breach, potential compliance gap | Vendor Risk Analyst | Vendor Risk Lead within 24 hours | 24 hours initial response |
| **P4 - Low** | Informational alerts, minor contract issues, routine monitoring findings | Vendor Risk Analyst | Vendor Risk Lead in next regular meeting | 5 business days |

### Escalation Communication Requirements

| Severity | Communication Method | Required Information |
|---|---|---|
| P1 | Phone + email + incident management system | Vendor name, nature of event, immediate impact, actions taken, next steps |
| P2 | Email + incident management system | Vendor name, nature of event, assessed impact, recommended actions |
| P3 | Email + GRC platform update | Vendor name, finding details, risk assessment, proposed remediation |
| P4 | GRC platform update | Vendor name, finding details, proposed action |

### Response Time SLAs by Action Type

| Action | Critical Vendor | High-Risk Vendor | Medium-Risk Vendor | Low-Risk Vendor |
|---|---|---|---|---|
| Initial acknowledgment | 1 hour | 4 hours | 24 hours | 5 business days |
| Impact assessment | 4 hours | 24 hours | 5 business days | 10 business days |
| Remediation plan | 24 hours | 5 business days | 15 business days | 30 business days |
| Remediation completion | Risk-based | Risk-based | Risk-based | Risk-based |
| Stakeholder notification | 2 hours | 24 hours | 5 business days | Next reporting cycle |

---

## Annual Monitoring Program Review

### Review Process

Conduct an annual review of the entire vendor monitoring program to ensure effectiveness, efficiency, and alignment with organizational risk appetite.

### Review Checklist

**Program Effectiveness:**
- [ ] Review monitoring coverage: Are all vendors monitored at the appropriate tier?
- [ ] Analyze alert effectiveness: What percentage of alerts were actionable?
- [ ] Review escalation timeliness: Were response time SLAs met?
- [ ] Assess risk identification: Were risks identified before they materialized?
- [ ] Review vendor incidents: Were any incidents missed by the monitoring program?
- [ ] Evaluate vendor risk rating accuracy: Did vendor tiers appropriately reflect actual risk?

**Program Efficiency:**
- [ ] Assess resource utilization: Is staffing adequate for monitoring workload?
- [ ] Review tool effectiveness: Are monitoring tools providing value?
- [ ] Identify automation opportunities: Can any manual processes be automated?
- [ ] Evaluate false positive rates: Are thresholds appropriately calibrated?
- [ ] Review cost-effectiveness: Is the monitoring spend proportionate to risk reduction?

**Program Alignment:**
- [ ] Validate alignment with organizational risk appetite and tolerance
- [ ] Review regulatory changes that may require monitoring adjustments
- [ ] Assess alignment with industry standards and peer practices
- [ ] Review and update monitoring policies and procedures
- [ ] Validate integration with enterprise risk management framework
- [ ] Confirm board and management reporting meets stakeholder expectations

**Continuous Improvement:**
- [ ] Document lessons learned from the past year
- [ ] Identify gaps and develop remediation plans
- [ ] Update tier definitions and thresholds as needed
- [ ] Plan tool upgrades or replacements
- [ ] Update training requirements for monitoring staff
- [ ] Set improvement objectives for the coming year

### Review Deliverables

1. Annual monitoring program effectiveness report
2. Updated monitoring procedures and thresholds
3. Tool and resource requirements for the coming year
4. Improvement roadmap with milestones
5. Updated risk appetite alignment documentation
