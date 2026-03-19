# EU AI Act - Vendor Risk Assessment Reference

## Overview

Regulation (EU) 2024/1689 (the EU AI Act) establishes a comprehensive regulatory framework for artificial intelligence systems based on a risk classification approach. For vendor risk assessment, the Act creates new obligations for organizations that procure, deploy, or integrate AI systems from third-party providers.

**Publication:** Official Journal of the EU, July 12, 2024
**Entry into Force:** August 1, 2024

---

## Risk Classification System

### Tier 1: Unacceptable Risk (Article 5 - Prohibited Practices)

**Effective: February 2, 2025**

The following AI practices are **prohibited** outright. Vendors offering these capabilities must be immediately flagged and excluded.

| Prohibited Practice | Description | VRA Action |
|---|---|---|
| **Social scoring** | AI systems that evaluate or classify persons based on social behavior or personality characteristics leading to detrimental treatment | Reject vendor; no procurement |
| **Exploitation of vulnerabilities** | AI systems that exploit vulnerabilities of specific groups (age, disability, social/economic situation) to materially distort behavior | Reject vendor; no procurement |
| **Real-time remote biometric identification** | In publicly accessible spaces for law enforcement (with narrow exceptions) | Assess legal basis; generally reject |
| **Emotion recognition** | In workplace and educational institutions | Reject for these use cases |
| **Biometric categorization** | Inferring sensitive attributes (race, political opinions, religion, sexual orientation) | Reject vendor; no procurement |
| **Untargeted facial image scraping** | From internet or CCTV for facial recognition databases | Reject vendor; no procurement |
| **Predictive policing** | Based solely on profiling or personality traits | Reject vendor; no procurement |
| **Subliminal manipulation** | AI techniques that materially distort behavior causing significant harm | Reject vendor; no procurement |

**Assessment Questions for Prohibited Practices:**
1. Does the AI system perform any form of social scoring or behavioral classification?
2. Could the system be used to exploit vulnerable populations?
3. Does the system involve biometric identification or categorization of sensitive attributes?
4. Does the system use subliminal or manipulative techniques?
5. Has the vendor confirmed in writing that the system does not fall under Article 5?

---

### Tier 2: High-Risk AI Systems (Annex III Categories)

**Effective: August 2, 2026** (general), with some provisions earlier

**Annex III High-Risk Categories:**

| Category | Examples | Key Assessment Areas |
|---|---|---|
| **1. Biometrics** | Remote biometric identification (non-prohibited), emotion recognition, biometric categorization | Accuracy, bias, data protection |
| **2. Critical infrastructure** | AI for safety components in management/operation of roads, water, gas, heating, electricity | Safety, reliability, resilience |
| **3. Education and vocational training** | Determining access, admission, assignment, assessment of students | Fairness, bias, transparency |
| **4. Employment and workers management** | Recruitment, selection, HR decisions, task allocation, monitoring, evaluation | Non-discrimination, transparency |
| **5. Access to essential services** | Credit scoring, insurance pricing, emergency services dispatch | Fairness, accuracy, explainability |
| **6. Law enforcement** | Risk assessment, polygraphs, evidence evaluation, profiling | Fundamental rights, accuracy |
| **7. Migration, asylum, and border control** | Risk assessment, document authentication, application processing | Fundamental rights, non-discrimination |
| **8. Administration of justice** | Researching and interpreting facts and law, dispute resolution | Due process, transparency |

**High-Risk Assessment Requirements:**

| Requirement | Details | VRA Checkpoint |
|---|---|---|
| Risk management system | Continuous, iterative process throughout lifecycle | Documented risk management |
| Data governance | Training, validation, and testing data requirements | Data quality and bias assessment |
| Technical documentation | Before placing on market or putting into service | Documentation completeness |
| Record-keeping | Automatic logging of events during operation | Audit trail capability |
| Transparency | Clear instructions for use provided to deployers | User documentation quality |
| Human oversight | Designed to allow effective human oversight | Human-in-the-loop design |
| Accuracy, robustness, cybersecurity | Appropriate levels throughout lifecycle | Technical performance testing |

---

### Tier 3: Limited Risk (Transparency Obligations)

**Effective: August 2, 2025**

| AI System Type | Transparency Obligation | VRA Checkpoint |
|---|---|---|
| **Chatbots / conversational AI** | Inform users they are interacting with AI | Disclosure mechanism verification |
| **Emotion recognition systems** | Inform exposed persons of the system's operation | Notice and consent process |
| **Biometric categorization** | Inform exposed persons of the system's operation | Notice and consent process |
| **Deep fakes / synthetic content** | Label content as artificially generated or manipulated | Content labeling mechanism |
| **AI-generated text** | Published to inform on matters of public interest must be labeled | Labeling compliance |

---

### Tier 4: Minimal Risk

AI systems that do not fall into the above categories (e.g., AI-enabled spam filters, AI in video games) have **no additional regulatory requirements** under the AI Act. Voluntary codes of conduct are encouraged.

**VRA Note:** Even minimal-risk AI should be assessed for general cybersecurity, data protection, and contractual compliance. The AI Act's risk classification does not replace standard vendor security assessment.

---

## Provider vs Deployer Obligations

### Provider Obligations (Article 16)

The **provider** is the entity that develops or has an AI system developed and places it on the market or puts it into service under its own name or trademark.

| Obligation | Description |
|---|---|
| Conformity assessment | Ensure the AI system undergoes appropriate conformity assessment before market placement |
| Quality management system | Implement and maintain a QMS covering the AI system lifecycle |
| Technical documentation | Draw up and maintain technical documentation |
| Record-keeping | Ensure automatic logging capabilities |
| Registration | Register the AI system in the EU database |
| Corrective actions | Take corrective action and inform when the system is non-conforming |
| Cooperation with authorities | Cooperate with competent authorities on request |
| Post-market monitoring | Establish and document a post-market monitoring system |
| Serious incident reporting | Report serious incidents to market surveillance authorities |

### Deployer Obligations (Article 26)

The **deployer** is the entity that uses an AI system under its authority (the organization procuring the AI vendor's system).

| Obligation | Description | VRA Action |
|---|---|---|
| Use in accordance with instructions | Follow provider's instructions for use | Verify instructions are clear and complete |
| Human oversight | Assign competent individuals for human oversight | Assess feasibility of oversight design |
| Input data quality | Ensure input data is relevant and representative | Data governance assessment |
| Monitoring | Monitor operation for risks and report incidents | Continuous monitoring plan |
| Record retention | Keep logs generated by the system for at least 6 months | Log management verification |
| Transparency to affected persons | Inform individuals subject to AI decisions | Notification process assessment |
| DPIA requirement | Conduct data protection impact assessment where required | DPIA documentation |
| Fundamental rights impact assessment | Required for certain deployers of high-risk AI | FRIA documentation |

---

## Conformity Assessment Requirements for High-Risk AI

### Assessment Pathways

| Pathway | Applicable To | Process |
|---|---|---|
| **Internal control** (Annex VI) | Most high-risk AI systems | Provider self-assessment against requirements |
| **Notified body assessment** (Annex VII) | Biometric identification systems and certain critical infrastructure AI | Independent third-party assessment |

### Internal Control Assessment (Annex VI)

The provider must verify:
1. Quality management system compliance
2. Technical documentation completeness
3. Conformity with all Chapter 2 requirements (Articles 8-15)
4. EU Declaration of Conformity issued
5. CE marking affixed

### Notified Body Assessment (Annex VII)

Required for:
- Remote biometric identification systems
- Safety components of critical infrastructure (in certain cases)

Process includes:
1. Application to notified body
2. Quality management system audit
3. Technical documentation assessment
4. Testing and evaluation
5. Conformity certificate issuance
6. Ongoing surveillance

---

## Technical Documentation Requirements (Annex IV)

Vendors of high-risk AI systems must provide:

| Documentation Element | What to Verify |
|---|---|
| General description | System purpose, intended use, versions |
| Detailed description of elements | Algorithms, data, training, testing methodologies |
| Development process | Design choices, assumptions, key decisions |
| Monitoring, functioning, and control | Human oversight measures, control mechanisms |
| Risk management | Risk identification, estimation, evaluation, mitigation |
| Changes and updates | Lifecycle management, version control |
| Performance metrics | Accuracy, robustness, cybersecurity metrics |
| Data governance | Training data, validation data, testing data procedures |
| Post-market monitoring plan | Ongoing monitoring approach and commitments |

---

## AI Vendor Assessment Questions Mapped to Act Requirements

### Pre-Engagement Assessment

| # | Question | Maps To |
|---|---|---|
| 1 | What is the intended purpose and use case of the AI system? | Risk classification (Art. 6) |
| 2 | Has the vendor classified the AI system's risk level under the EU AI Act? | Risk classification |
| 3 | Does the AI system fall under any prohibited practices (Article 5)? | Prohibited practices screen |
| 4 | If high-risk, has the vendor completed a conformity assessment? | Conformity (Art. 43) |
| 5 | Can the vendor provide the EU Declaration of Conformity? | Declaration (Art. 47) |
| 6 | Is the AI system registered in the EU database? | Registration (Art. 49) |
| 7 | What technical documentation is available for review? | Documentation (Annex IV) |
| 8 | What training, validation, and testing data was used? | Data governance (Art. 10) |
| 9 | What measures are in place for bias detection and mitigation? | Non-discrimination |
| 10 | How does the system support human oversight? | Human oversight (Art. 14) |
| 11 | What logging and record-keeping capabilities exist? | Record-keeping (Art. 12) |
| 12 | What accuracy, robustness, and cybersecurity measures are implemented? | Technical requirements (Art. 15) |
| 13 | What is the vendor's post-market monitoring plan? | Post-market (Art. 72) |
| 14 | How does the vendor handle serious incident reporting? | Incident reporting (Art. 73) |
| 15 | What is the vendor's approach to transparency and explainability? | Transparency (Art. 13) |

### Ongoing Monitoring Questions

| # | Question | Maps To |
|---|---|---|
| 16 | Have there been any changes to the AI system that could alter its risk classification? | Substantial modification (Art. 6) |
| 17 | Have any new biases or performance issues been identified? | Accuracy/robustness (Art. 15) |
| 18 | Has the vendor reported any serious incidents? | Incident reporting (Art. 73) |
| 19 | Is the system's performance consistent with documented metrics? | Performance monitoring |
| 20 | Have regulatory guidance or standards been updated? | Compliance monitoring |

---

## Implementation Timeline

| Date | Milestone | VRA Action Required |
|---|---|---|
| **August 1, 2024** | AI Act enters into force | Begin impact assessment; inventory AI vendors |
| **February 2, 2025** | Prohibited practices apply; AI literacy obligations | Screen all AI vendors against Article 5; begin training |
| **August 2, 2025** | GPAI model obligations apply; transparency obligations for limited-risk AI; governance structures operational | Assess GPAI vendors; verify transparency compliance |
| **August 2, 2026** | High-risk AI system obligations apply (Annex III); conformity assessment requirements | Full high-risk AI vendor assessment; verify conformity |
| **August 2, 2027** | Obligations for high-risk AI in Annex I (regulated products) | Assess AI components in regulated products |

**Recommended VRA Program Timeline:**

| Phase | Timing | Activities |
|---|---|---|
| **Discovery** | Now | Inventory all AI vendors and systems; classify by risk tier |
| **Gap Analysis** | Q1 each year | Assess current vendor contracts and controls against requirements |
| **Remediation** | Ongoing | Update contracts, assessments, and monitoring for each compliance milestone |
| **Steady State** | Post-Aug 2027 | Full AI Act compliance integrated into standard VRA processes |

---

## General-Purpose AI (GPAI) Models - Additional Considerations

**Effective: August 2, 2025**

| GPAI Classification | Obligations | VRA Assessment |
|---|---|---|
| **All GPAI models** | Technical documentation, transparency to downstream providers, copyright compliance, publish training content summary | Verify documentation availability |
| **GPAI with systemic risk** | Model evaluation, adversarial testing, incident tracking and reporting, adequate cybersecurity | Enhanced security assessment; verify testing protocols |

**Systemic Risk Threshold:** GPAI models trained with total computing power exceeding 10^25 FLOPs, or designated by the Commission based on other criteria.

**VRA Note:** Organizations deploying GPAI-based vendor solutions (e.g., large language models, foundation models) should assess whether the underlying model has been classified as having systemic risk and ensure the provider meets the corresponding obligations.
