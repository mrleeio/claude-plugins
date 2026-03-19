# Concentration Risk Assessment

## Definition and Types

Concentration risk in vendor management is the risk that arises when an organization is overly dependent on a single vendor, technology, geographic region, or fourth party across its vendor portfolio. A failure, breach, or disruption at the point of concentration would simultaneously impact multiple vendor relationships or business processes.

### Types of Concentration Risk

#### 1. Cloud Provider Concentration

Over-reliance on a single cloud infrastructure provider across the vendor portfolio. If multiple SaaS vendors all run on the same cloud platform, an outage at that platform disrupts multiple business functions simultaneously.

**Example:** Organization uses 15 SaaS vendors, 12 of which are hosted on AWS. An AWS regional outage impacts 80% of the organization's SaaS services simultaneously.

#### 2. Technology Concentration

Dependence on a single technology, library, or platform component across multiple vendors.

**Example:** Multiple vendors rely on the same open-source library (e.g., Log4j). A vulnerability in that library simultaneously exposes multiple vendor relationships.

#### 3. Geographic Concentration

Multiple vendors (or their sub-processors) processing or storing data in the same geographic region, data center, or availability zone.

**Example:** Five critical vendors all operate primary data centers in the same metropolitan area. A natural disaster affecting that area simultaneously disrupts all five vendor services.

#### 4. Fourth-Party (Sub-Processor) Concentration

Multiple vendors in your portfolio sharing the same sub-processor. The sub-processor becomes a common point of failure or risk amplification.

**Example:** Three of your vendors use the same payment processing sub-processor. A breach at that sub-processor simultaneously affects all three vendor relationships and potentially triples the data exposure.

#### 5. Talent and Expertise Concentration

Multiple vendors depending on the same limited pool of specialized talent or expertise.

**Example:** Several vendors rely on the same niche consulting firm for security compliance work. That firm's quality issues or unavailability affects multiple vendor security programs.

#### 6. Regulatory Concentration

Multiple vendors subject to the same regulatory changes or enforcement actions, creating simultaneous compliance risk.

**Example:** Multiple vendors operate under the same regulatory framework. A regulatory change simultaneously affects their ability to deliver services.

---

## Identification Methodology

### Step 1: Build the Dependency Map

Create a comprehensive map of shared dependencies across your vendor portfolio.

**Data Collection:**

For each vendor in the portfolio, collect:
- Cloud infrastructure provider(s) and regions
- Key technology platforms and frameworks
- Sub-processor list (from DPA, trust center, SOC 2 report)
- Primary data processing locations (country, region, city)
- Data center providers (if not cloud-native)
- Key technology dependencies (databases, CDNs, DNS, identity providers)
- Critical personnel or consulting relationships

**Mapping Process:**

1. Create a matrix with vendors as rows and dependencies as columns
2. Mark each vendor's dependencies
3. Identify columns with high vendor counts -- these are concentration points
4. Weight by vendor tier (Tier 1 vendor concentrations are more critical)
5. Weight by data classification (concentrations involving Restricted data are more critical)

### Step 2: Identify Concentration Points

A concentration point exists when:

| Condition | Threshold |
|---|---|
| Multiple Tier 1 vendors share the same dependency | 2 or more Tier 1 vendors |
| Multiple vendors across tiers share the same dependency | 30% or more of total vendors |
| A single sub-processor appears across multiple vendor relationships | 3 or more vendor relationships |
| A single geographic location hosts multiple critical vendor services | 3 or more critical services in same city/region |
| A single cloud provider hosts multiple critical vendor services | 50% or more of Tier 1/2 vendor workloads |

### Step 3: Assess Impact

For each identified concentration point, assess:

1. **Blast radius** - How many vendor relationships would be affected by a failure at this concentration point?
2. **Data exposure** - What is the combined data exposure if this concentration point is compromised?
3. **Business process impact** - Which business processes would be disrupted?
4. **Recovery complexity** - How difficult would it be to recover or failover?
5. **Likelihood** - What is the probability of a disruption at this concentration point?

---

## Assessment Framework

### Concentration Risk Scoring

Score each concentration point on two dimensions:

**Impact Score (1-5):**

| Score | Description | Criteria |
|---|---|---|
| 5 | Severe | Multiple Tier 1 vendors affected; Restricted data exposure; core business process disruption; no alternative available |
| 4 | Major | Tier 1 + Tier 2 vendors affected; Confidential data exposure; significant business process disruption; limited alternatives |
| 3 | Moderate | Multiple Tier 2 vendors affected; Internal data exposure; moderate business disruption; alternatives available but not immediate |
| 2 | Minor | Tier 3/4 vendors affected; minimal data exposure; limited business disruption; alternatives readily available |
| 1 | Negligible | Single low-tier vendor affected; no sensitive data; no meaningful business disruption |

**Likelihood Score (1-5):**

| Score | Description | Criteria |
|---|---|---|
| 5 | Almost Certain | Concentration point has experienced disruptions in the past 12 months; systemic risks identified |
| 4 | Likely | Concentration point has experienced disruptions in the past 3 years; known vulnerabilities or stability concerns |
| 3 | Possible | Concentration point has some history of disruptions; moderate risk factors present |
| 2 | Unlikely | Concentration point is generally stable; minor risk factors only |
| 1 | Rare | Concentration point has strong track record; robust redundancy in place |

**Risk Rating = Impact x Likelihood**

| Risk Score | Rating | Action Required |
|---|---|---|
| 20-25 | Critical | Immediate mitigation plan required; executive visibility; board reporting |
| 12-19 | High | Mitigation plan required within 90 days; leadership visibility |
| 6-11 | Medium | Mitigation plan required within 180 days; standard risk management |
| 1-5 | Low | Monitor; address at next strategic review cycle |

### Critical Thresholds

The following conditions automatically trigger a Critical concentration risk rating regardless of scoring:

- **Single cloud provider** hosts more than 75% of Tier 1 and Tier 2 vendor workloads
- **Single sub-processor** has access to Restricted data across 3 or more vendor relationships
- **Single geographic location** (city or metropolitan area) hosts primary infrastructure for more than 50% of critical vendor services with no geographic failover
- **Single technology dependency** (e.g., specific open-source library) is present across more than 60% of vendor stack with no patching/update coordination process

---

## Mitigation Strategies

### Multi-Cloud Diversification

**Strategy:** Distribute vendor workloads across multiple cloud infrastructure providers to reduce single-cloud dependency.

**Implementation:**
- Identify which vendors offer multi-cloud or alternative cloud hosting options
- For new vendor selections, prefer vendors with multi-cloud capability or hosting on underrepresented cloud platforms
- For critical business functions, require vendors to demonstrate geographic and infrastructure redundancy
- Negotiate contractual options for cloud portability

**Considerations:**
- Multi-cloud adds complexity and potentially cost
- Not all vendors can easily switch cloud providers
- Focus on the most critical concentration points rather than attempting full diversification
- Consider the cloud provider's own redundancy (multi-region, multi-AZ) as partial mitigation

### Geographic Diversification

**Strategy:** Ensure vendor services are distributed across multiple geographic regions to reduce single-location risk.

**Implementation:**
- Map all vendor processing locations and identify geographic clusters
- For Tier 1 vendors, require multi-region or multi-data-center architecture
- Ensure DR sites are in different geographic risk zones (not same earthquake zone, flood plain, etc.)
- Consider regulatory implications of geographic diversification (data residency requirements)

**Considerations:**
- Data sovereignty requirements may limit geographic options
- Latency considerations for certain applications
- Cost implications of multi-region deployment
- Verify that "multi-region" claims represent true geographic separation

### Alternative Provider Identification

**Strategy:** Maintain a registry of alternative providers for each critical vendor and shared dependency.

**Implementation:**
- For each Tier 1 vendor, identify at least one alternative provider
- For each critical concentration point, identify at least one alternative technology or platform
- Periodically validate that alternatives remain viable (pricing, capability, compatibility)
- For the most critical concentration points, maintain a tested migration/failover plan

**Considerations:**
- Alternative identification is different from alternative readiness
- Some concentration points have limited alternatives (e.g., dominant cloud providers)
- Migration costs and complexity may make alternatives impractical for non-critical scenarios
- Focus on alternatives for the highest-risk concentration points

### Contractual Mitigation

**Strategy:** Use contractual terms to reduce concentration risk impact.

**Implementation:**
- Require vendors to disclose infrastructure dependencies and changes
- Include notification requirements for material infrastructure changes
- Negotiate SLAs that account for shared infrastructure risks
- Include termination assistance provisions that facilitate migration
- Require vendors to maintain business continuity plans that address their own concentration risks

### Monitoring and Early Warning

**Strategy:** Establish monitoring to detect concentration risk changes and emerging threats.

**Implementation:**
- Monitor vendor infrastructure changes and announcements
- Track cloud provider status pages and incident history
- Subscribe to vendor trust center updates for sub-processor changes
- Monitor industry news for shared technology vulnerabilities
- Review concentration risk map quarterly

---

## DORA Concentration Risk Requirements

The Digital Operational Resilience Act (DORA), applicable to EU financial entities, includes specific requirements for ICT concentration risk.

### Key DORA Articles on Concentration Risk

**Article 29: Preliminary Assessment of ICT Concentration Risk**

Before entering into a contractual arrangement for ICT services, financial entities must:
- Identify and assess whether the arrangement would lead to increased ICT concentration risk
- Consider whether the ICT services are provided by a single provider or by a limited number of providers
- Assess the degree of substitutability

**Article 28(4): Further Harmonization of ICT Risk Management Tools**

The European Supervisory Authorities (ESAs) shall develop standards addressing:
- Criteria for identifying ICT concentration risk
- Methodologies for assessing ICT concentration risk at entity and sectoral level

### DORA Compliance Considerations

| Requirement | Implementation |
|---|---|
| ICT concentration risk identification | Maintain dependency mapping as described above; include in vendor risk assessment |
| Assessment before new arrangements | Include concentration risk analysis in Phase 1 (Pre-Engagement) of vendor lifecycle |
| Multi-vendor strategy | Document rationale for single-provider relationships where concentration risk exists |
| Exit strategy requirements | Mandatory exit plans for all critical ICT service providers |
| Register of information | Maintain register of all ICT third-party arrangements including sub-contractors |
| Reporting to competent authority | Be prepared to report concentration risk assessments to national competent authority |

### DORA Critical ICT Third-Party Provider Oversight

- ESAs may designate ICT third-party service providers as "critical" at EU level
- Critical providers will be subject to direct oversight by Lead Overseers
- Financial entities using critical providers face heightened concentration risk scrutiny
- Organizations should monitor ESA designations and assess impact on their vendor portfolio

---

## Portfolio-Level Concentration Risk Dashboard

### Dashboard Concept

A portfolio-level concentration risk dashboard provides executive visibility into the organization's concentration risk exposure across all vendor relationships.

### Key Dashboard Views

#### 1. Infrastructure Dependency Heat Map

A visual matrix showing:
- **Rows:** Vendor names (sorted by tier)
- **Columns:** Infrastructure dependencies (cloud providers, key technologies, sub-processors)
- **Cell color:** Risk contribution (red = Restricted data, orange = Confidential, yellow = Internal, green = Public)
- **Column header indicators:** Concentration level (number of vendors sharing this dependency)

#### 2. Geographic Risk Map

An interactive map displaying:
- Vendor data processing locations (pins colored by data classification)
- Cluster indicators where multiple vendors co-locate
- Natural disaster risk zones overlaid
- Political/regulatory risk indicators by country

#### 3. Concentration Risk Summary Metrics

| Metric | Target | Current |
|---|---|---|
| Cloud provider concentration (% of Tier 1/2 on single provider) | < 60% | [Actual] |
| Sub-processor overlap (max vendors sharing single sub-processor) | < 3 Tier 1 vendors | [Actual] |
| Geographic concentration (% of critical services in single region) | < 50% | [Actual] |
| Single points of technology failure identified | 0 for Tier 1 | [Actual] |
| Concentration risk points rated Critical or High | 0 Critical, < 3 High | [Actual] |
| Vendors with no documented alternative provider | 0 for Tier 1 | [Actual] |

#### 4. Concentration Risk Trend

Track concentration risk over time:
- Number and severity of concentration risk points per quarter
- Trend direction (improving, stable, deteriorating)
- Mitigation actions completed vs. planned
- New concentration risks identified

#### 5. Scenario Impact Analysis

Model the impact of specific concentration risk scenarios:
- "What if AWS us-east-1 goes down for 24 hours?" -- List all affected vendors, business processes, and estimated impact
- "What if sub-processor X suffers a data breach?" -- List all affected vendor relationships and data exposure
- "What if a vulnerability is discovered in technology Y?" -- List all affected vendors and remediation coordination needs

### Dashboard Data Sources

| Data Source | Update Frequency | Owner |
|---|---|---|
| Vendor register/inventory | Real-time (as changes occur) | Vendor management |
| Sub-processor inventories | Quarterly or upon notification | Security assessors |
| Cloud infrastructure mapping | Quarterly | Security assessors + IT |
| Security rating scores | Continuous (daily sync) | Security operations |
| Geographic location data | Semi-annually | Security assessors |
| Alternative provider registry | Annually | Vendor management + IT |

### Reporting Cadence

| Report | Audience | Frequency |
|---|---|---|
| Dashboard review | Security leadership | Monthly |
| Concentration risk summary | Executive team / Risk committee | Quarterly |
| Full portfolio concentration analysis | CISO, CRO | Semi-annually |
| Regulatory reporting (DORA, etc.) | Competent authority | As required |
