---
name: fourth-party-risk
description: Assess sub-processor and fourth-party risks including SBOMs, concentration risk, and cascading dependencies. Trigger phrases include "fourth party", "sub-processor", "subprocessor", "SBOM", "concentration risk", "supply chain risk", "fourth-party". (user)
---

# Fourth-Party Risk

Assess risks from vendor sub-processors, software supply chain dependencies, concentration risk, and cascading fourth-party relationships.

## Quick Reference

### Fourth-Party Risk Categories

| Category | Description | Key Concerns |
|----------|-------------|-------------|
| **Sub-processor Risk** | Third parties used by your vendor to process your data | Data flows beyond your vendor, contractual flow-down |
| **Software Supply Chain** | Open-source and commercial components in vendor products | Vulnerable dependencies, supply chain attacks |
| **Concentration Risk** | Over-reliance on shared infrastructure/providers | Single points of failure, systemic risk |
| **Cascading Risk** | Fourth parties that themselves depend on fifth parties | Exponential risk propagation |

### Sub-Processor Assessment Checklist

| Area | Questions |
|------|-----------|
| **Inventory** | Does the vendor maintain a current sub-processor list? Is it publicly available? |
| **Notification** | Does the vendor notify customers of sub-processor changes? What is the notice period? |
| **Due Diligence** | How does the vendor assess sub-processor security? What standards are required? |
| **Contractual** | Do vendor contracts flow down security requirements to sub-processors? |
| **Data Flows** | What data is shared with each sub-processor? In what jurisdictions? |
| **Right to Audit** | Do you have right-to-audit clauses that extend to sub-processors? |
| **Termination** | Can you object to a sub-processor? What is the dispute resolution process? |

### SBOM Requirements (CISA 2025 Minimum Elements)

| Element | Description | Required? |
|---------|-------------|:-:|
| **Supplier Name** | Entity that creates/maintains the component | Yes |
| **Component Name** | Name of the software component | Yes |
| **Component Version** | Version identifier | Yes |
| **Unique Identifier** | CPE, PURL, or SWID tag | Yes |
| **Dependency Relationship** | Upstream/downstream relationships | Yes |
| **Author of SBOM** | Entity that created the SBOM | Yes |
| **Timestamp** | When the SBOM was generated | Yes |
| **Hash** | Cryptographic hash of the component | Recommended |
| **License** | License information | Recommended |
| **Known Vulnerabilities** | CVE references | Recommended |

### Concentration Risk Assessment

| Risk Factor | Critical Threshold | Example |
|-------------|-------------------|---------|
| **Cloud Provider** | >60% of critical vendors on same cloud | 8 of 10 critical vendors use AWS |
| **Shared Fourth Party** | Same sub-processor serves >3 of your vendors | Twilio used by 5 of your vendors |
| **Geographic** | >50% of data processing in single jurisdiction | All vendors host in us-east-1 |
| **Technology** | Single technology dependency across vendors | All vendors use same auth provider |

## Sub-Processor Risk Assessment

### Step 1: Obtain Sub-Processor List

- Request current sub-processor list from vendor
- Search vendor website: `[vendor] sub-processors` or `[vendor] subprocessors`
- Review DPA for sub-processor disclosure requirements
- Check GDPR Article 28 compliance for EU data

### Step 2: Classify Sub-Processors

| Category | Criteria | Assessment Depth |
|----------|----------|-----------------|
| **Material** | Processes your data directly, critical to service delivery | Full sub-processor assessment |
| **Infrastructure** | Provides underlying infrastructure (cloud, CDN, DNS) | Concentration risk review |
| **Ancillary** | Support services (analytics, monitoring, support tools) | Light review, data flow check |

### Step 3: Assess Cascading Risk

Map the dependency chain:
```
Your Org → Vendor → Sub-processor → Sub-sub-processor
```

For each link, assess:
- What data flows downstream?
- What controls attenuate at each level?
- What contractual protections exist?
- What is the blast radius of a breach at each level?

## SBOM Assessment

### For Vendor Software Components

1. **Request SBOM** — Ask vendor for SBOM in CycloneDX or SPDX format
2. **Assess completeness** — Does it cover the CISA minimum elements?
3. **Vulnerability analysis** — Cross-reference components against NVD/CVE databases
4. **Update cadence** — How frequently is the SBOM updated?
5. **Dependency freshness** — Are dependencies current or significantly outdated?
6. **License compliance** — Any restrictive licenses that affect your usage?

### Red Flags in SBOMs

| Red Flag | Risk |
|----------|------|
| Components with known critical CVEs unpatched > 30 days | Active vulnerability exposure |
| Dependencies not updated in > 2 years | Unmaintained components |
| No SBOM available | Lack of supply chain visibility |
| Single maintainer for critical dependencies | Bus factor risk |
| Components from sanctioned entities | Legal/compliance risk |

## Do

- Map your complete fourth-party landscape (vendor → sub-processor → their vendors)
- Assess concentration risk across your entire vendor portfolio
- Require sub-processor change notification in contracts
- Request SBOMs for software products, especially for self-hosted deployments
- Evaluate cascading risk for Critical and High tier vendors

## Don't

- Stop assessment at the vendor boundary — fourth parties are in scope
- Ignore shared fourth parties across your vendor portfolio
- Accept "we don't have sub-processors" without verification
- Treat infrastructure providers (AWS, Azure, GCP) as zero-risk fourth parties
- Skip SBOM review for vendor software deployed in your environment

## Common Mistakes

1. **Ignoring the sub-processor list** — This is often the easiest fourth-party risk to assess and the most commonly skipped
2. **Not mapping concentration** — You may not realize 80% of your critical vendors depend on the same cloud provider
3. **Assuming contractual flow-down** — Just because YOUR contract has security requirements doesn't mean sub-processor contracts do
4. **Treating SBOMs as one-time** — SBOMs must be updated with each release

## See Also

- [Sub-Processor Management](references/sub-processor-management.md) — Detailed sub-processor assessment guide
- [Concentration Risk](references/concentration-risk.md) — Concentration risk identification and mitigation
