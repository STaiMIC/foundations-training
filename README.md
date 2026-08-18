# foundations-training

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/STaiMIC/foundations-training)
[![nf-core](https://img.shields.io/badge/nf--core-sarek%2Fampliseq-brightgreen)](https://nf-co.re) [![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A526.04-blue)](https://www.nextflow.io/) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**A conceptual and practical checkpoint for the STaiMIC Training Program Using Nextflow**
*From Biological Question to Nextflow Execution: Foundations for Independent Workflow Building*
## Independent training and affiliation notice

This educational programme was independently designed and delivered by STaiMIC. Its curriculum is informed by open Nextflow and nf-core community practices and uses the open-source Nextflow workflow system and selected nf-core resources for teaching and demonstration.

This is **not** an official Seqera, Nextflow, or nf-core course, training session, certification, or product. It is not sponsored, endorsed, reviewed, or certified by Seqera or the nf-core community.

Any instructor’s status as a Nextflow Ambassador is an individual community role and does not imply that Seqera, Nextflow, or nf-core delivers or endorses this STaiMIC programme. Third-party names and marks are used solely for identification and attribution.

## Licensing and third-party material

Original STaiMIC material and code in this repository is released under the [MIT License](LICENSE). Nextflow is separate open-source software released under the Apache License 2.0. Reused or adapted nf-core material remains subject to its original MIT licence and copyright notices. The STaiMIC licence does not replace or relicense third-party material.

---

## What is this?

This repository is the Session 5 practical component of the STaiMIC Nextflow Bioinformatics Training Program (Wednesday 19 August 2026). Unlike Sessions 1–4, this session does not run a new pipeline. It corrects terminology and reproducibility misconceptions surfaced across Sessions 1–4, so students can separate the biology, workflow logic, execution environment, and validation evidence before building independently in Session 6.

## Quick Start

Click the badge above, or navigate to `Code → Codespaces → Create codespace on main`. Wait ~2 minutes for the environment to set up automatically. Then open [`GETTING_STARTED.md`](GETTING_STARTED.md) for the full step-by-step guide.

## What you'll examine

A deliberately simplified fragment from ampliseq or sarek, followed by one minimal two-process DSL2 workflow. You will trace: biological input → channel → process/task → output → published result → test.

## Synthetic Dataset

This session reuses the real samplesheet formats from Session 1 (sarek) and Session 2 (ampliseq), so students recognise the schemas — but the read files themselves are illustrative only, not real FASTQ data.

**`data/microbiome_samplesheet.csv`** — mirrors the Session 2 ampliseq format:

| sampleID | forwardReads | reverseReads |
|----------|--------------|--------------|
| gut_1 | fastq/gut_1_1.fastq.gz | fastq/gut_1_2.fastq.gz |
| gut_2 | fastq/gut_2_1.fastq.gz | fastq/gut_2_2.fastq.gz |

**`data/microbiome_metadata.tsv`** — mirrors the Session 2 Metadata.tsv:

| ID | condition | status |
|----|-----------|--------|
| gut_1 | healthy | 0 |
| gut_2 | healthy | 0 |

**`data/cancer_samplesheet.csv`** — mirrors the Session 1 sarek format, included for comparison only (not run in this session's workflow):

| patient | sex | status | sample | lane | fastq_1 | fastq_2 |
|---------|-----|--------|--------|------|---------|---------|
| patientX | XX | 0 | normal_sample | L001 | fastq/normal_1.fastq.gz | fastq/normal_2.fastq.gz |
| patientX | XX | 1 | tumor_sample | L001 | fastq/tumor_1.fastq.gz | fastq/tumor_2.fastq.gz |

> **Why compare both formats?**
> Sarek requires `patient` and `sample`, which link multiple samples back to one individual. `lane` is required for FASTQ input and carries the technical read group, so reads from different lanes are tracked and merged correctly. `sex` and `status` are optional: `sex` informs sex chromosome handling, and `status` marks normal (0) or tumour (1), defaulting to 0. Sarek is not restricted to paired somatic analysis, so these columns exist to support tumour/normal pairing when the question needs it, not because pairing is mandatory. Ampliseq needs only `sampleID` and read paths because 16S profiling has no such relationships to track. Different biological questions require different metadata. That is the Biology layer in practice.

## What you'll learn

Biology layer — research question, samples, reference data, biological output and interpretation.

Workflow layer — Nextflow, nf-core, pipeline, workflow, process, module, task, channel.

Execution layer — executor, container, profile, configuration, work directory, cache, -resume.

Evidence layer — tests, CI, reports, provenance, determinism, reproducibility.

## Mandatory Session 6 Entry Gate

- [ ] Label a DSL2 workflow correctly
- [ ] Explain the biology separately from the computation
- [ ] Connect two processes using a channel
- [ ] Define typed inputs and named outputs
- [ ] Pin software and record provenance correctly
- [ ] Run once normally and once as a clean, uncached reproduction
- [ ] Explain what a passing test proves — and what it does not

---

Built for the STaiMIC Nextflow Training Program
by [Nkiruka Cynthia Efenji](https://github.com/Nkiruka-Cynthia) · Nextflow Ambassador · [@Seqera](https://seqera.io)
