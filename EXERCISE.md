# Exercise — In-Class Walkthrough

Follow these steps in order during Session 5. Each step maps to one part of the trace: biological input → channel → process/task → output → published result → test.

---

## Step 1 — Confirm prerequisites (5 min)

Confirm you've completed `GLOSSARY.md` before class. If not, skim it now — we'll move fast, but the vocabulary won't be re-explained from scratch.

---

## Step 2 — Read Fragment 1 (10 min)

Open `fragment/excerpt.nf`. This file is for reading only — it is not meant to be run as-is.

For each line, decide out loud (or write down) which layer it belongs to: Biology, Workflow, Execution, or Evidence. Use `fragment/README.md` as a guide, but try before checking.

**Discussion:** Why does this fragment have no Evidence layer? What would you add to give it one?

---

## Step 3 — Read Fragment 2 (10 min)

In the same file, scroll to `process BWA_MEM`. This is a real, complete process from `nf-core/sarek` — but note it has no `workflow { }` block calling it here, so it cannot run on its own in this file either. It is included purely to examine its structure.

Identify:
- The typed input/output contract (Workflow layer)
- The container and resource declarations (Execution layer)
- The `topic: versions` line (Evidence layer)
- Where the biology is implied but not explicitly labelled (Biology layer)

**Discussion:** Is it a problem that the biological purpose isn't written in a comment anywhere? Why or why not?

---

## Step 4 — Examine the synthetic samplesheets (5 min)

Open `minimal-workflow/data/microbiome_samplesheet.csv`, `minimal-workflow/data/microbiome_metadata.tsv`, and `minimal-workflow/data/cancer_samplesheet.csv`.

Before running anything, answer: what does each column represent? Why does the cancer samplesheet need `patient`, `sex`, `status`, and `lane`, while the microbiome one only needs `sampleID` and read paths?

---

## Step 5 — Run the minimal workflow (5 min)

```bash
nextflow run minimal-workflow/main.nf
```

Watch the process names as they execute: `READ_SAMPLE`, then `COUNT_CHARACTERS`. Confirm both show `2 of 2 ✔`.

---

## Step 6 — Inspect the output (5 min)

```bash
cat results/gut_1.count.txt
cat results/gut_2.count.txt
```

**Discussion:** This number is a real, correctly-computed result. Is it biologically meaningful? Why or why not? (Connects to Misconception #2.)

---

## Step 7 — Check consistency across cached and clean runs (10 min)

```bash
nextflow run minimal-workflow/main.nf -resume
```

Then force a clean, uncached run:

```bash
rm -rf work/
nextflow run minimal-workflow/main.nf
```

**Discussion:** Does re-running the same workflow give a consistent result, whether cached or clean? This is about caching and determinism on a single machine — not the same claim as reproducibility across different machines (Misconception #3), which is a separate, stronger guarantee.

---

## Step 8 — Explain what a test would and wouldn't prove (10 min)

No automated test exists in this repo. As a group: if you wrote one test for `COUNT_CHARACTERS`, what would a passing result actually prove? What would it not prove?

---

## Step 9 — Self-check against the Entry Gate (10 min)

Open `ENTRY_GATE.md`. Individually, go through each item and honestly mark whether you can currently do it. Be ready to demonstrate any item if asked.

---

## Wrap-up

Session 6 assumes every item in `ENTRY_GATE.md` is checked. If anything is unclear, ask now — Session 6 builds forward from here without revisiting these terms.
