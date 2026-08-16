# Pre-Session Glossary

Complete this before Session 5. These are short definitions only — the "why it matters" discussion happens in class and in `docs/misconceptions.md`.

---

## Biology Layer

**Research question** — the specific thing you're trying to find out biologically (e.g. "which mutations are unique to the tumor?").

**Sample** — a single biological specimen being analysed.

**Reference data** — the genome, database, or index a sample is compared against.

**Biological output** — the scientifically meaningful result (e.g. a list of variants), as distinct from raw computational output.

**Interpretation** — the step of turning a biological output into a scientific conclusion.

---

## Workflow Layer

**Nextflow** — the workflow language and execution engine used to write and run pipelines.

**nf-core** — a community project providing peer-reviewed, standardised Nextflow pipelines.

**Pipeline** — a complete, runnable workflow made of one or more connected processes.

**Workflow** — the block of Nextflow code (`workflow { }`) that defines how processes connect together.

**Process** — a reusable definition of a single computational step (written once).

**Module** — a process (or group of processes) saved in its own file for reuse across pipelines.

**Task** — one specific execution of a process on one specific input. One process can produce many tasks.

**Channel** — the data structure that carries values between processes.

---

## Execution Layer

**Executor** — the system responsible for actually running tasks (e.g. local machine, AWS Batch, SLURM).

**Container** — a packaged, isolated environment (e.g. Docker/Singularity image) containing the software a process needs.

**Profile** — a named configuration preset (e.g. `-profile docker`) that sets execution options.

**Configuration** — settings controlling how a pipeline runs (resources, paths, executor, etc.), usually in `nextflow.config`.

**Work directory** — the folder where Nextflow stores intermediate files for each task.

**Cache** — Nextflow's record of previously completed tasks, used to skip unchanged work.

**`-resume`** — a flag that restarts a pipeline using the cache, re-running only what changed.

---

## Evidence Layer

**Test** — an automated check that a specific piece of code or output behaves as expected.

**CI (Continuous Integration)** — automatically running tests whenever code changes, to catch problems early.

**CD (Continuous Deployment/Delivery)** — automatically releasing or deploying code once it passes CI.

**Report** — a generated summary of what happened during a run (e.g. MultiQC report, execution report).

**Provenance** — a record of exactly what produced a given result (software versions, parameters, commit hash).

**Determinism** — a process that, given the same input, always produces the same output.

**Reproducibility** — the ability for the same inputs and software versions to reliably produce the same scientific conclusion, run after run.

---

## Before you arrive

- [ ] Read every definition above once
- [ ] Complete one nf-core run (from Sessions 1–4)
- [ ] No Seqera Platform account required