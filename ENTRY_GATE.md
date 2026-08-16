# Session 6 Entry Gate

Before Session 6, each student must independently demonstrate all seven items below. This is self-assessed, but be honest — Session 6 builds forward assuming these are solid.

---

## Checklist

- [ ] **Label a DSL2 workflow correctly** — given a workflow file, correctly identify and name its process(es), channel(s), and the workflow block itself.

- [ ] **Explain the biology separately from the computation** — for any given process, state what biological question it serves, and separately, what computation it performs, without conflating the two.

- [ ] **Connect two processes using a channel** — demonstrate (verbally or in code) how the output of one process becomes the input of another via a channel.

- [ ] **Define typed inputs and named outputs** — write or identify a process with clearly typed `input:` and `output:` blocks, including named emissions (e.g. `emit: bam`).

- [ ] **Pin software and record provenance correctly** — explain the difference between a mutable tag and an immutable digest, and identify what provenance information (version, commit, parameters) should be captured for a given run.

- [ ] **Run once normally and once as a clean, uncached reproduction** — actually execute a workflow twice: once normally, once after clearing the `work/` directory, and compare.

- [ ] **Explain what a passing test proves — and what it does not** — for a given test, state precisely what condition it verifies, and name at least one thing it does *not* guarantee.

---

## If you're not confident on any item

Review the relevant section:

| Item | Review |
|------|--------|
| Labeling a workflow | [`docs/four-layers.md`](docs/four-layers.md) — Workflow layer |
| Biology vs. computation | [`docs/misconceptions.md`](docs/misconceptions.md) — #2 |
| Channels | [`fragment/excerpt.nf`](fragment/excerpt.nf) — Fragment 1 |
| Typed inputs/outputs | [`fragment/excerpt.nf`](fragment/excerpt.nf) — Fragment 2 |
| Pinning and provenance | [`docs/misconceptions.md`](docs/misconceptions.md) — #4, #6 |
| Clean reproduction | [`EXERCISE.md`](EXERCISE.md) — Step 7 |
| What tests prove | [`docs/misconceptions.md`](docs/misconceptions.md) — #1 |