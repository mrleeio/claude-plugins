# OSINT Sources for Vendor Research

## Source Categories

### 1. Vendor Trust & Security Pages

Vendors increasingly publish dedicated trust centers and security documentation. These are the highest-fidelity primary sources.

**Where to look:**
- `trust.vendor.com` or `vendor.com/trust`
- `security.vendor.com` or `vendor.com/security`
- `vendor.com/compliance`
- `vendor.com/privacy`
- `vendor.com/legal/subprocessors` or `vendor.com/sub-processors`
- `status.vendor.com` (operational status and incident history)

**Search query templates:**
- `[vendor] site:vendor.com security`
- `[vendor] site:vendor.com trust center`
- `[vendor] site:vendor.com SOC 2`
- `[vendor] site:vendor.com compliance certifications`
- `[vendor] site:vendor.com sub-processors`
- `[vendor] site:vendor.com data processing agreement`
- `[vendor] site:vendor.com incident response`
- `[vendor] site:vendor.com privacy policy`

---

### 2. Certification Registries

Authoritative registries that confirm whether a vendor actually holds claimed certifications.

**Registry URLs:**

| Certification | Registry URL | Notes |
|---|---|---|
| SOC 2 / SOC 1 | https://us.aicpa.org/forthepublic/socsuiteofreports | AICPA SOC reports directory; note that SOC reports themselves are restricted-distribution |
| ISO 27001 | National accreditation body directories (e.g., UKAS, ANAB, DAkkS) | No single global registry; check the accreditation body for the cert issuer |
| ISO 27701 | Same accreditation body directories | Extension to ISO 27001 for privacy |
| ISO 42001 | Same accreditation body directories | AI management system standard |
| FedRAMP | https://marketplace.fedramp.gov/ | Authoritative list of FedRAMP-authorized products |
| CSA STAR | https://cloudsecurityalliance.org/star/registry/ | Self-assessment (Level 1) and third-party audit (Level 2) |
| PCI DSS | https://www.visa.com/splisting/ | Visa's Global Registry of Service Providers |
| HITRUST | https://hitrustalliance.net/certified-assessed-organizations/ | HITRUST CSF certified organizations |
| StateRAMP | https://stateramp.org/authorized-products/ | State-level FedRAMP equivalent |
| TX-RAMP | https://dir.texas.gov/tx-ramp | Texas Risk and Authorization Management Program |

**Search query templates:**
- `[vendor] SOC 2 Type II report`
- `[vendor] ISO 27001 certificate`
- `[vendor] FedRAMP authorized`
- `[vendor] CSA STAR registry`
- `[vendor] HITRUST certified`
- `site:marketplace.fedramp.gov [vendor]`
- `site:cloudsecurityalliance.org [vendor]`

---

### 3. Breach Databases & Disclosure Tracking

Sources for identifying past security incidents involving the vendor.

**Primary sources:**
- **Have I Been Pwned** (https://haveibeenpwned.com/) -- Check if vendor appears in known breaches
- **HHS Breach Portal** (https://ocrportal.hhs.gov/ocr/breach/breach_report.jsf) -- HIPAA breach reports (healthcare data)
- **Privacy Rights Clearinghouse** (https://privacyrights.org/data-breaches) -- Historical breach database
- **State AG breach notifications** -- Many states publish breach notification letters (e.g., Maine, California, Montana)
- **SEC EDGAR** (https://www.sec.gov/cgi-bin/browse-edgar) -- Publicly traded companies must disclose material cyber incidents in 8-K filings
- **CISA Known Exploited Vulnerabilities** (https://www.cisa.gov/known-exploited-vulnerabilities-catalog) -- Check if vendor products appear

**Search query templates:**
- `[vendor] data breach`
- `[vendor] security incident`
- `[vendor] breach notification`
- `[vendor] CVE vulnerability`
- `[vendor] ransomware`
- `[vendor] data leak`
- `site:ocrportal.hhs.gov [vendor]`
- `[vendor] site:sec.gov 8-K cybersecurity`

---

### 4. Regulatory Filings & Legal Records

Public filings that reveal governance, financial health, and regulatory actions.

**Sources:**
- **SEC EDGAR** -- 10-K (annual reports), 10-Q (quarterly), 8-K (material events), DEF 14A (proxy/governance)
- **State business registries** -- Incorporation status, registered agents, good standing
- **FTC enforcement actions** (https://www.ftc.gov/legal-library/browse/cases-proceedings)
- **GDPR enforcement tracker** (https://enforcementtracker.com/) -- EU DPA enforcement actions
- **Court records** (PACER for federal courts) -- Lawsuits, settlements

**Search query templates:**
- `[vendor] site:sec.gov 10-K`
- `[vendor] FTC consent order`
- `[vendor] GDPR fine`
- `[vendor] class action lawsuit data`
- `[vendor] regulatory action`

---

### 5. Job Postings

Job listings reveal a vendor's actual security posture, team maturity, and technology stack.

**What to look for:**
- Security team size and structure (CISO, security engineers, GRC analysts)
- Technologies mentioned (SIEM, EDR, CSPM, container security)
- Compliance programs referenced (SOC 2, ISO 27001, FedRAMP)
- Incident response staffing
- Absence of security hiring can indicate immature program

**Search query templates:**
- `[vendor] site:linkedin.com/jobs security engineer`
- `[vendor] site:greenhouse.io security`
- `[vendor] site:lever.co security`
- `[vendor] CISO site:linkedin.com`
- `[vendor] security team hiring`

---

### 6. Code Repositories

Public code repositories reveal development practices, dependency management, and security hygiene.

**Sources:**
- **GitHub** (https://github.com/) -- Public repos, security advisories, dependency graphs
- **GitLab** (https://gitlab.com/) -- Public projects
- **NPM / PyPI / Maven Central** -- Published packages, dependency trees

**What to look for:**
- Security policy (SECURITY.md) and vulnerability disclosure process
- Dependency update frequency and use of automated tooling (Dependabot, Renovate)
- CI/CD pipeline configuration (security scanning stages)
- Code quality signals (test coverage, linting, static analysis)
- Open security issues or unpatched vulnerabilities
- License compliance

**Search query templates:**
- `[vendor] site:github.com security`
- `[vendor] github security advisory`
- `[vendor] open source vulnerability`
- `site:github.com [vendor] SECURITY.md`

---

### 7. Dark Web & Threat Intelligence

Monitoring for vendor exposure in underground forums and marketplaces. These sources require specialized tooling and are noted here for awareness.

**Indicators to search for:**
- Vendor credentials for sale on paste sites or dark web markets
- Vendor data dumps or samples posted on forums
- Mentions in ransomware group leak sites
- Employee credentials in stealer log aggregators

**Search query templates (surface web proxies):**
- `[vendor] credentials leaked`
- `[vendor] dark web`
- `[vendor] ransomware leak site`
- `[vendor] infostealer logs`
- `site:reddit.com [vendor] breach`

> **Note:** Direct dark web access is out of scope. Use surface-web threat intelligence aggregators and breach notification services to approximate this category.

---

## Source Reliability Tiers

When synthesizing findings from multiple sources, weight them according to reliability.

### Tier 1 -- Authoritative (High Confidence)
- Vendor-published certifications with verifiable certificate numbers
- Official certification registries (FedRAMP Marketplace, CSA STAR)
- Regulatory filings (SEC EDGAR, state AG breach notifications)
- Vendor trust center documentation with audit report availability

### Tier 2 -- Credible (Moderate Confidence)
- Vendor marketing pages and blog posts (may overstate; verify claims)
- Reputable news outlets covering incidents (cross-reference multiple sources)
- Job postings (reveal actual practices but represent a point in time)
- Court records and legal filings

### Tier 3 -- Indicative (Low Confidence, Useful for Leads)
- Social media posts and forum discussions
- Glassdoor and employee reviews mentioning security culture
- Unverified breach claims on paste sites
- Analyst reports behind paywalls (may be outdated)

### Tier 4 -- Unverified (Corroborate Before Citing)
- Anonymous forum posts
- Dark web mentions without confirmation
- Rumored incidents without public disclosure
- AI-generated summaries from other tools

**Rule:** Never cite a Tier 3 or Tier 4 source as a finding without flagging it as unverified. Always attempt to corroborate with a Tier 1 or Tier 2 source.

---

## Tips for Using WebSearch and WebFetch

### WebSearch Best Practices

1. **Start broad, then narrow.** Begin with `[vendor] security` to see what surfaces, then drill into specific domains.
2. **Use site-scoped searches** to target authoritative sources: `site:vendor.com`, `site:sec.gov`, `site:marketplace.fedramp.gov`.
3. **Run multiple searches per domain.** A single query rarely captures the full picture. Plan 3-5 queries per assessment domain.
4. **Search for negative signals too.** Queries like `[vendor] breach`, `[vendor] vulnerability`, and `[vendor] lawsuit` surface risk indicators that the vendor will not volunteer.
5. **Check recency.** Certifications expire, incidents get resolved, and teams change. Note the date of every source.
6. **Use Boolean-style narrowing** when results are noisy: add terms like `SOC 2`, `ISO 27001`, `GDPR`, `incident`, `breach` to focus results.

### WebFetch Best Practices

1. **Fetch vendor trust pages directly** when you know the URL pattern (e.g., `trust.vendor.com`).
2. **Fetch certification registry pages** to verify claims rather than relying on vendor self-attestation.
3. **Fetch status pages** (`status.vendor.com`) for uptime history and recent incident timelines.
4. **Fetch sub-processor lists** to map the vendor's own supply chain risk.
5. **Be prepared for gated content.** Many trust centers require NDA or customer login for actual audit reports. Note when content is gated and flag it as a gap.
6. **Rate-limit fetches.** Space out requests to avoid triggering bot protection on vendor sites.
7. **Save key quotes.** When a page contains a specific claim (e.g., "SOC 2 Type II audited annually"), capture the exact text and URL for citation.

---

## Sub-Processor List Discovery Strategies

Vendor sub-processor lists are critical for understanding fourth-party risk. They are often buried.

**Discovery approaches:**
1. Search `[vendor] sub-processors` or `[vendor] subprocessors`
2. Search `site:vendor.com sub-processors`
3. Check the vendor's DPA (Data Processing Agreement) -- sub-processor lists are often an appendix or linked exhibit
4. Look for a dedicated page: `vendor.com/legal/sub-processors`, `vendor.com/privacy/sub-processors`
5. Check the vendor's Trust Center for a downloadable sub-processor list
6. Search `[vendor] data processing addendum` -- the DPA often references or links to the sub-processor list
7. If the vendor is a SaaS product, check their help/docs site: `site:docs.vendor.com sub-processors`

**What to capture from sub-processor lists:**
- Sub-processor name and purpose
- Data processed by each sub-processor
- Geographic location of processing
- Whether the list includes infrastructure providers (AWS, GCP, Azure)
- Update frequency and notification mechanism for sub-processor changes
- Whether customers can object to new sub-processors
