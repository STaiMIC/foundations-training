# Misconceptions — Session 5

Thirteen common misconceptions surfaced across Sessions 1–4 and general Nextflow/nf-core practice, corrected here before Session 6.

---

## 1. "It ran" vs. computational correctness

**Misconception:** If a Nextflow run finishes without an error and prints `✔`, the pipeline "worked."

**Correction:** A green checkmark only means each process executed to completion — it says nothing about whether the logic inside that process was correct. A script with a bug in its math can still exit successfully and produce a checkmark, as long as it doesn't crash.

**Example:** A process that accidentally divides read counts by the wrong denominator will still show `✔` — the shell command ran, exited 0, and Nextflow reports success. The number is wrong, but nothing failed.

---

## 2. Computational correctness vs. biological validity

**Misconception:** If the math/code in a process is correct, the biological conclusion is correct too.

**Correction:** Even a perfectly correct computation can produce a biologically meaningless or misleading result if the input, reference, or experimental design was wrong to begin with.

**Example:** Correctly counting reads aligned to the wrong reference genome gives you a mathematically accurate — but biologically useless — number.

---

## 3. Reproducibility vs. identical files

**Misconception:** "Reproducible" means running the pipeline twice produces byte-identical output files.

**Correction:** Reproducibility means the same inputs and same software versions produce the same scientific conclusions — not necessarily identical bytes. Timestamps, file ordering, or compression metadata can differ between runs while the actual result is unchanged.

**Example:** Two runs of the same alignment can produce BAM files with different internal timestamps but identical read placements — both are reproducible, even though `diff` shows a difference.

---

## 4. Version capture vs. version pinning

**Misconception:** If a pipeline report shows which software version ran (e.g. in a MultiQC report or `pipeline_info/`), that means the version was pinned.

**Correction:** Capturing a version after the fact tells you what happened to run — it doesn't guarantee that version will run next time. Pinning means explicitly locking the version before execution, so it can't silently change between runs.

**Example:** A container tagged `samtools:latest` will report whatever version happened to be `latest` on that day in the MultiQC output — that's capture. It's not pinning, because next month `latest` may point to a different build entirely.

---

## 5. CI vs. CD

**Misconception:** "We have CI/CD" means the same thing regardless of which half is actually implemented.

**Correction:** CI (Continuous Integration) means automated tests run on every change to catch breakage early. CD (Continuous Deployment/Delivery) means passing changes are automatically released or deployed. A repo can have thorough CI and zero CD, or vice versa — they are separate guarantees.

**Example:** A GitHub Actions workflow that runs `nf-test` on every pull request is CI. It becomes CD only if a passing test automatically triggers a new tagged release or publishes to a registry.

---

## 6. Why `python:latest` and `python:3.11-slim` are both mutable

**Misconception:** Naming a specific version tag like `python:3.11-slim` (instead of `python:latest`) means the container image is pinned and immutable.

**Correction:** Version tags are mutable pointers — the maintainer can rebuild and re-push a new image under the exact same tag at any time (e.g. patching a security fix). Only a digest (a SHA256 hash of the image content) is truly immutable, because the hash changes if the underlying bytes change.

**Example:** `python:3.11-slim` pulled today and `python:3.11-slim` pulled six months from now can be genuinely different images. `python@sha256:abcd1234...` will always resolve to the exact same bytes, forever.

---

## 7. Why dependencies must not be installed at runtime

**Misconception:** Installing a package inside a process (e.g. `pip install jsonschema` at the top of a script) is fine, since it "gets installed either way."

**Correction:** Runtime installation means the exact package version depends on whatever is available from the package index at the moment the pipeline happens to run — not a fixed, recorded version. If the package index changes (a new release, a yanked version, a network outage), the same pipeline code can behave differently or fail entirely on a later run.

**Example:** A process that runs `pip install jsonschema` today might install v4.19. Run the identical pipeline code again in a year, and it could silently pull v4.25 with different validation behavior — nothing in the pipeline code changed, but the result can.

---

## 8. Why nf-core does not guarantee byte-identical results across every machine

**Misconception:** Because nf-core pipelines are "reproducible," running the same pipeline on two different machines (or two different HPC clusters) will always produce identical output files.

**Correction:** nf-core guarantees the same software versions and logic run via containers/conda — but floating-point arithmetic, thread scheduling, and hardware-specific optimizations (e.g. different CPU instruction sets) can produce tiny numerical differences in some tools, even with identical inputs and versions. The scientific conclusion should be stable; individual bytes may not be.

**Example:** A variant caller using multi-threaded floating-point math can order intermediate results differently depending on CPU thread count, producing VCF files that differ in row order or minor rounding — while the same variants are still detected.

---

## 9. Why cloud execution still needs credentials, storage, executor and resource configuration

**Misconception:** Once a pipeline is written with Nextflow, running it "in the cloud" is just a matter of changing `-profile` — everything else is handled automatically.

**Correction:** Nextflow abstracts the workflow logic, not the infrastructure. Cloud execution still requires you to explicitly configure which executor to use (e.g. AWS Batch, Google Life Sciences), authentication credentials for that cloud account, a storage bucket for work/output files, and resource limits (CPU/memory) appropriate to that environment — none of this is inferred automatically.

**Example:** Switching `-profile docker` to `-profile awsbatch` without also setting `aws.region`, `process.executor`, and a valid `workDir` pointing to an S3 bucket will simply fail to launch — the profile alone doesn't supply missing infrastructure detail.

---

## 10. Why timestamps, unordered collections, random seeds, and shared work directories can create false reproducibility

**Misconception:** If a pipeline "passes" the same test twice, it must be genuinely reproducible.

**Correction:** Several common patterns can make a pipeline look reproducible by coincidence while actually being fragile: embedding the current timestamp in output, collecting files in whatever order the filesystem returns them, not fixing a random seed, or reusing a shared `work/` directory across runs (Nextflow's cache can mask a real change by resuming from stale results).

**Example:** A process that writes `Analysis run on: $(date)` into its output will "pass" a test that doesn't check that line — but two runs are not actually identical, and a test that does check full-file equality will fail intermittently depending on when it's run.

---

## 11. Why low variant quality does not mean clinically safe to ignore

**Misconception:** A variant with a low quality score (e.g. low `QUAL` in a VCF) can simply be filtered out and treated as if it doesn't exist.

**Correction:** A low quality score reflects the caller's statistical confidence given the available sequencing depth and evidence — not the clinical importance of that position. A real pathogenic variant sitting in a low-coverage region can receive a low quality score purely due to insufficient reads, not because the variant itself is unreal. Filtering by quality threshold is a computational convenience, not a clinical judgment.

**Example:** A clinically actionable BRCA1 variant sitting in a region with only 8x sequencing depth may be flagged as low quality by the caller — discarding it automatically could mean missing a real finding, rather than correctly identifying noise.

---

## 12. Why an nf-core pipeline's default parameters are not automatically correct for your data

**Misconception:** Because a pipeline carries the nf-core badge (meaning it passed community review, linting, and has documentation), running it with default parameters is guaranteed to be scientifically appropriate for any dataset.

**Correction:** The nf-core badge certifies engineering quality — consistent structure, tested code, reproducible execution, documentation standards. It does not certify that the default parameter values (e.g. quality thresholds, reference genome, adapter sequences, minimum read length) are correct for your specific organism, sequencing platform, or experimental design. Defaults are usually tuned to a common use case or the pipeline's test dataset, not your data.

**Example:** Running `nf-core/ampliseq` with default trimming parameters tuned for standard Illumina adapters will silently under-trim or over-trim reads generated on a different sequencing platform with different adapter sequences — the pipeline still runs cleanly and reports success, but the biological output is compromised.

---

## 13. Why Sarek analyses sequencing data — it does not sequence DNA

**Misconception:** Running `nf-core/sarek` is "sequencing" a sample.

**Correction:** Sequencing is a wet-lab process that happens on physical instruments (e.g. Illumina machines) before any pipeline runs — it converts DNA into digital reads (FASTQ files). Sarek is a downstream computational pipeline that takes those already-sequenced reads and performs alignment, variant calling, and annotation. It never touches physical DNA.

**Example:** Saying "we sequenced the tumor sample with Sarek" is like saying you "photographed" a picture by opening it in an image editor — the pipeline processes data that sequencing already produced.