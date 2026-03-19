# SaaS vs. Self-Hosted vs. Hybrid Assessment Guide

This reference provides guidance on how to tailor vendor risk assessments based on the deployment model of the product or service being evaluated.

---

## SaaS-Specific Assessment Considerations

When the vendor hosts and operates the solution as a multi-tenant or single-tenant SaaS offering, the following considerations apply.

### Shared Responsibility Model

The shared responsibility model defines which security controls are the vendor's obligation versus the customer's. For SaaS, the vendor owns the majority of the stack.

**Vendor responsibilities (typically):**
- Physical infrastructure and data center security
- Network security, segmentation, and DDoS protection
- Operating system and platform patching
- Application security and code integrity
- Data encryption at rest and in transit
- Availability, backup, and disaster recovery
- Identity provider infrastructure and authentication mechanisms
- Logging infrastructure and security monitoring

**Customer responsibilities (typically):**
- User account management and access provisioning
- SSO/MFA configuration for their tenant
- Data classification of content uploaded to the platform
- API key and integration credential management
- Configuration of tenant-level security settings
- Compliance with their own regulatory obligations

**Assessment focus:** Verify that the vendor clearly documents the shared responsibility model. Ask for a responsibility matrix (RACI) that maps controls to responsible parties. Flag any ambiguity about who owns what.

### Tenant Isolation

Multi-tenant SaaS introduces unique risks around data leakage between tenants.

**Questions to ask:**
- Is tenant isolation enforced at the application layer, database layer, or infrastructure layer?
- Are tenant databases logically separated (separate schemas) or physically separated (separate database instances)?
- Has tenant isolation been validated through penetration testing with tenant-boundary testing in scope?
- Are there controls preventing cross-tenant data access through shared services (caching, queuing, search indexes)?
- Can tenant administrators see other tenants' metadata (e.g., user counts, company names)?

**Red flags:**
- Shared database tables with tenant ID column as the only isolation mechanism
- No specific mention of tenant isolation in penetration test scope
- Shared caching layers (Redis, Memcached) without namespace isolation

### Data Residency

SaaS deployments may process and store data across multiple geographic regions.

**Questions to ask:**
- In which regions is customer data stored at rest?
- Can the customer choose their data residency region?
- Does data transit through other regions during processing (even temporarily)?
- Are backups stored in the same region as primary data?
- Do support staff in other regions/countries have access to customer data?
- What sub-processors process data, and where are they located?

**Assessment focus:** Map all locations where data is stored, processed, or accessed. Verify alignment with the customer's regulatory requirements (GDPR, data sovereignty laws, sectoral regulations).

### SOC 2 Scope Relevance

Not all SOC 2 reports cover the product being evaluated.

**Verification steps:**
1. Confirm the SOC 2 report covers the specific product or service being assessed (not just the corporate entity)
2. Check which Trust Service Criteria are included (Security is baseline; Availability, Processing Integrity, Confidentiality, and Privacy may be relevant)
3. Review the "System Description" section to verify scope boundaries
4. Check the report period and whether it is current (Type II reports typically cover 6-12 months)
5. Review any complementary user entity controls (CUECs) that shift responsibility to the customer
6. Note any qualified opinions, exceptions, or deviations

**Common issue:** Vendor provides a SOC 2 report for their parent company or a different product line. The report scope section is the definitive check.

### SaaS-Specific Risks to Flag

- **Forced upgrade risk:** SaaS vendors control the release cycle; customers cannot defer updates. Assess change management and rollback capabilities.
- **Data portability risk:** Evaluate data export capabilities. Can the customer extract all their data in a standard format?
- **Vendor lock-in:** Assess the feasibility of migrating away from the platform. Are APIs proprietary? Is data stored in proprietary formats?
- **Account termination risk:** What happens to customer data when the contract ends? What is the data retrieval window?
- **Co-tenancy risk:** In regulated industries, verify that co-tenancy with entities from sanctioned countries or competitors is addressed.

---

## Self-Hosted / On-Premises Assessment Considerations

When the vendor provides software that the customer deploys and operates in their own infrastructure, the risk profile shifts significantly.

### Deployment Hardening

The customer is responsible for hardening the deployment environment, but the vendor must provide adequate guidance.

**Questions to ask:**
- Does the vendor provide a hardening guide for production deployments?
- Are CIS Benchmarks or equivalent hardening standards referenced?
- Does the vendor provide pre-hardened container images or VM images?
- What are the minimum and recommended infrastructure requirements?
- Does the vendor support deployment on hardened operating systems (e.g., RHEL with STIG applied)?
- Are default credentials eliminated or forced to be changed at installation?
- Does the installer disable unnecessary services and ports by default?

**Assessment focus:** Review the vendor's deployment documentation for security posture. Flag vendors that provide no hardening guidance or ship with insecure defaults.

### Patch Management

For self-hosted software, the customer must apply patches, but the vendor must provide them in a timely manner.

**Questions to ask:**
- What is the vendor's patching cadence for security vulnerabilities?
- What is the SLA for releasing patches for critical vulnerabilities (e.g., CVSS 9.0+)?
- Are security patches released independently of feature releases, or must the customer upgrade to a new major version?
- Does the vendor provide security advisories or a CVE notification mechanism?
- How long are previous versions supported with security patches (N-1, N-2 support)?
- Does the vendor provide a software bill of materials (SBOM) for dependency tracking?

**Red flags:**
- Security patches bundled with feature releases only (forces full upgrades for security fixes)
- No defined SLA for critical vulnerability patches
- End-of-life versions with known unpatched vulnerabilities
- No SBOM or dependency transparency

### Configuration Security

Self-hosted deployments rely heavily on correct configuration by the customer, guided by vendor documentation.

**Questions to ask:**
- Does the vendor provide a configuration security baseline?
- Are configuration options documented with security implications noted?
- Does the vendor provide configuration validation tools or scripts?
- Are there known insecure configurations that the vendor warns against?
- Does the vendor support configuration-as-code for reproducible secure deployments?
- Are encryption settings (TLS versions, cipher suites, key management) configurable and documented?

**Assessment focus:** Evaluate the quality and completeness of configuration documentation. Test whether default configurations are secure-by-default or require hardening.

### Integration Security

Self-hosted software often integrates with the customer's existing infrastructure, creating additional attack surface.

**Questions to ask:**
- What protocols and ports does the software use for communication?
- Does the software support mutual TLS (mTLS) for service-to-service communication?
- How does the software integrate with the customer's identity provider (LDAP, AD, SAML, OIDC)?
- Does the software require outbound internet access? If so, to which endpoints and for what purpose?
- Are integration APIs authenticated and authorized with standard mechanisms (OAuth 2.0, API keys)?
- Does the software support network policy enforcement (e.g., Kubernetes NetworkPolicies)?

**Self-Hosted-Specific Risks to Flag:**
- **Telemetry and phone-home:** Does the software send data back to the vendor? Can this be disabled? What data is transmitted?
- **License verification:** Does the software require periodic outbound connections for license validation?
- **Update mechanism security:** How are updates delivered? Are they signed? Can the update mechanism be used as an attack vector?
- **Dependency sprawl:** Does the software require installing additional third-party components (databases, message queues, caches) that the customer must also patch and maintain?
- **End-of-support risk:** Self-hosted deployments may run unsupported versions longer than SaaS. Assess the vendor's support lifecycle policy.

---

## Hybrid Model Assessment

Hybrid deployments combine SaaS and self-hosted components, or involve data flowing between customer-controlled and vendor-controlled environments.

### Scope Boundary Definition

The most critical step in assessing hybrid deployments is clearly defining where vendor responsibility ends and customer responsibility begins.

**Questions to ask:**
- Which components are vendor-managed and which are customer-managed?
- Is there a documented architecture diagram showing the boundary between vendor and customer environments?
- How is data synchronized between vendor-managed and customer-managed components?
- Which security controls are provided by the vendor versus expected from the customer?
- Are SLAs different for vendor-managed versus customer-managed components?

### Data Flow Mapping

Hybrid models create complex data flows that must be thoroughly mapped.

**Assessment approach:**
1. Identify all data types processed by the system
2. Map where each data type is stored (vendor cloud, customer infrastructure, or both)
3. Document all data movement between environments (direction, protocol, frequency, encryption)
4. Identify any data transformation or processing that occurs during transit
5. Verify that data flows comply with residency and sovereignty requirements
6. Assess whether the data flow introduces any single points of failure

**Key questions:**
- Does customer data leave the customer's environment? Under what circumstances?
- Is metadata (usage analytics, performance metrics) sent to the vendor even if primary data stays on-prem?
- Are encryption keys managed by the vendor or the customer for data in transit between environments?
- What happens if the connection between vendor and customer environments is disrupted?

### Split Responsibility Assessment

For each assessment domain, determine which entity (vendor, customer, or shared) bears responsibility.

**Create a responsibility matrix covering:**
- Infrastructure security (likely split)
- Application security (likely vendor)
- Data protection (likely split based on where data resides)
- Access management (likely customer for on-prem components, vendor for SaaS components)
- Monitoring and logging (likely split)
- Incident response (shared, with coordination requirements)
- Backup and recovery (likely split)
- Patch management (split based on component ownership)

**Hybrid-Specific Risks to Flag:**
- **Responsibility gaps:** Areas where neither party clearly owns a control
- **Coordination complexity:** Incident response requiring coordination between vendor and customer SOCs
- **Inconsistent security posture:** SaaS components may have stronger controls than self-hosted components (or vice versa)
- **Network trust boundaries:** Connections between vendor and customer environments may introduce trust boundary violations
- **Operational complexity:** More moving parts increase the likelihood of misconfiguration

---

## Decision Framework: Domain Emphasis by Deployment Model

Use this framework to determine which assessment domains deserve the most scrutiny based on deployment model.

### Priority Matrix

| Assessment Domain | SaaS | Self-Hosted | Hybrid |
|---|---|---|---|
| 1. Organizational Security & Governance | High | Medium | High |
| 2. Access Control & Identity Management | High | Medium | High |
| 3. Data Protection & Privacy | Critical | High | Critical |
| 4. Network Security | High | Medium* | High |
| 5. Application Security | High | High | High |
| 6. Infrastructure & Cloud Security | Critical | Low** | High |
| 7. Incident Response & Management | Critical | Medium | Critical |
| 8. Business Continuity & Disaster Recovery | Critical | Medium | Critical |
| 9. Vendor & Third-Party Risk Management | High | Medium | High |
| 10. Compliance & Audit | Critical | Medium | High |
| 11. Physical Security | High | Low** | Medium |
| 12. Human Resources Security | Medium | Medium | Medium |
| 13. Logging, Monitoring & Detection | High | Medium | High |
| 14. Contractual & Legal | High | High | Critical |
| 15. AI Risk & Governance | High | High | High |

*\* For self-hosted, network security is primarily the customer's responsibility, but the vendor's software must support secure network configurations.*

*\*\* For self-hosted, infrastructure and physical security are the customer's responsibility. Assess only the vendor's deployment requirements and hardening guidance.*

### Guidance by Deployment Model

**SaaS-first emphasis:**
- Focus most heavily on domains 3 (Data Protection), 6 (Infrastructure), 7 (Incident Response), 8 (BC/DR), and 10 (Compliance) because the customer has limited visibility and control over these areas.
- Tenant isolation and data residency are SaaS-specific priorities.
- Compliance certifications (SOC 2, ISO 27001) serve as primary assurance mechanisms since the customer cannot independently verify controls.

**Self-hosted-first emphasis:**
- Focus on domains 5 (Application Security) and 14 (Contractual/Legal) because the vendor's code runs in the customer's environment.
- Patch management, hardening guidance, and SBOM availability are critical.
- The vendor's own infrastructure security is less relevant, but their development practices directly impact the customer.

**Hybrid emphasis:**
- Focus on domains 3 (Data Protection), 7 (Incident Response), and 14 (Contractual/Legal) because split responsibilities increase complexity.
- Data flow mapping across environments is essential.
- The responsibility matrix must be explicitly documented with no gaps.

---

## Common Pitfalls by Deployment Type

### SaaS Pitfalls

1. **Accepting marketing claims as evidence.** "Enterprise-grade security" and "bank-level encryption" are not controls. Require specific evidence (certifications, audit reports, penetration test summaries).
2. **Ignoring SOC 2 scope.** Verifying the vendor has a SOC 2 report is insufficient. The report must cover the specific product and relevant trust service criteria.
3. **Overlooking sub-processor risk.** The vendor's SaaS may be built on other SaaS products. A breach at a sub-processor affects the vendor's customers.
4. **Assuming data stays in one region.** Even with data residency commitments, backups, CDN caches, support access, and analytics may cross borders.
5. **Not assessing vendor viability.** SaaS creates hard dependencies. If the vendor goes out of business, access to data may be lost. Assess financial health and data portability.
6. **Ignoring CUECs.** Complementary User Entity Controls in SOC 2 reports describe what the customer must do. If the customer does not implement CUECs, the vendor's control environment has gaps.

### Self-Hosted Pitfalls

1. **Assuming the vendor is not a risk.** Even self-hosted software introduces risk through code vulnerabilities, insecure defaults, supply chain dependencies, and update mechanisms.
2. **Not verifying the update mechanism.** Software update channels can be compromised (supply chain attacks). Verify that updates are signed and the verification process is documented.
3. **Ignoring telemetry.** Many self-hosted products phone home with usage data, license verification, or crash reports. This data exfiltration may violate the customer's security policies.
4. **Skipping SBOM review.** Self-hosted software bundles dependencies that become the customer's responsibility to monitor for vulnerabilities.
5. **Overlooking end-of-life timelines.** Self-hosted deployments often run older versions longer. Verify the vendor's support lifecycle and plan for upgrades.
6. **Treating hardening as optional.** If the vendor provides a hardening guide, treat it as a minimum requirement. If they do not provide one, flag it as a significant gap.

### Hybrid Pitfalls

1. **Unclear responsibility boundaries.** The most common and dangerous pitfall. If the responsibility matrix is not explicit, security gaps will exist at the boundary.
2. **Inconsistent assessment depth.** Applying SaaS assessment rigor to the cloud components while neglecting the self-hosted components (or vice versa) leaves blind spots.
3. **Ignoring the connection.** The link between vendor-managed and customer-managed environments is often the weakest point. Assess the security of this connection specifically.
4. **Assuming vendor certifications cover everything.** The vendor's SOC 2 or ISO 27001 likely covers only their managed components. The customer-managed components are out of scope.
5. **Not testing failover.** When vendor-managed and customer-managed components depend on each other, a failure in one may cascade to the other. Assess resilience of the integration.
6. **Metadata leakage.** Even when primary data stays on-prem, metadata, telemetry, and diagnostic data flowing to the vendor's cloud may contain sensitive information.
