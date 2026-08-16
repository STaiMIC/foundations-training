# Fragment — Real Pipeline Excerpts

Two real excerpts, both from pipelines used earlier in this training series. Read each before running anything. For each, decide which layer (Biology / Workflow / Execution / Evidence) each part belongs to.

## Fragment 1 — Samplesheet structure

From `STaiMIC/sarek-wes-training`, Lesson 1 (`course/01_samplesheet.nf`), Session 2.

- Biology — `patient`, `sex`, `status`, `sample`
- Workflow — `channel`, `.splitCsv()`, `.map()`, `.view()`
- Execution — `params.input`, `projectDir`, `checkIfExists`
- Evidence — none present. Discuss: why not, and what would it look like here?

Note: this fragment has no `process` block — only a `workflow { }`. A workflow block alone is not a complete pipeline; it needs at least one `process` to compute something.

## Fragment 2 — A complete process (BWA_MEM)

From the actual `nf-core/sarek` pipeline module (`modules/nf-core/bwa/mem/main.nf`) — the real alignment step run when you executed Session 2's pipeline.

Trace through it and identify:

- Workflow layer — `input:`, `output:`, `tuple val(meta)` — the typed contract this process expects and returns
- Execution layer — `container`, `task.cpus`, `task.ext.prefix` — what environment and resources this runs with
- Evidence layer — the `topic: versions` output line — this is provenance capture in action, recording the exact `bwa` version used
- Biology layer — discuss: where is the biology in this fragment? (Hint: it's implicit — alignment against a reference — not explicitly labelled anywhere in the code itself. This is worth discussing directly: code rarely states its biological purpose in comments.)

## Original sources

- STaiMIC/sarek-wes-training/course/01_samplesheet.nf
- nf-core/sarek/modules/nf-core/bwa/mem/main.nf