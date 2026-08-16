# The Four Layers

Every Nextflow pipeline mixes together four distinct kinds of thinking. Session 5 exists because these get blended together in normal conversation — this document keeps them separate.

---

## 1. Biology Layer

**What it covers:** The research question, the samples, the reference data, and what the output actually means scientifically.

**Key question:** *What are we trying to learn about biology?*

**Vocabulary:** research question, sample, reference genome/database, biological output, interpretation.

This layer exists independently of Nextflow. You could ask the same biological question using a completely different pipeline, or by hand — the biology doesn't change.

---

## 2. Workflow Layer

**What it covers:** The Nextflow/nf-core vocabulary itself — the building blocks used to express a computational procedure.

**Key question:** *How is the computation structured?*

**Vocabulary:** Nextflow, nf-core, pipeline, workflow, process, module, task, channel.

A common confusion: using "task" and "process" interchangeably. A **process** is the definition (the code you write once). A **task** is one specific execution of that process on one specific input — a single process can spawn many tasks.

---

## 3. Execution Layer

**What it covers:** The environment the workflow actually runs in — what executes it, where, and with what.

**Key question:** *What is actually running this, and where?*

**Vocabulary:** executor, container, profile, configuration, work directory, cache, `-resume`.

This is where reproducibility problems usually hide — not in the biology, and not in the workflow logic, but in execution details like an unpinned container tag or a shared cache masking a real change.

---

## 4. Evidence Layer

**What it covers:** How you prove any of the above actually happened correctly — tests, CI, reports, provenance.

**Key question:** *How do we know this is trustworthy?*

**Vocabulary:** tests, CI, reports, provenance, determinism, reproducibility.

This layer doesn't tell you the biology is right, or that the workflow is elegant — it tells you whether you can trust that the same inputs will reliably produce the same outputs, and that you can prove what actually ran.

---

## Why separate them?

Most confusion in Sessions 1–4 came from collapsing two layers into one sentence without noticing. "The pipeline worked" quietly mixes Workflow (it executed) with Evidence (therefore it's correct) — but those are different claims. Session 5's whole purpose is training you to notice the seam between layers before Session 6 asks you to build something independently.