# Simple scripts: NMF for gene expression

This exercise is **step 1** in the workshop sequence ([Exercises overview](../README.md)). You have a working non-negative matrix factorization (NMF) pipeline split across a main script and helper files—the kind of layout that often appears right after a first successful prototype.

## Goal

Decompose a **gene × sample** expression matrix `X` into non-negative factors `W` and `H` such that `X ≈ W %*% H`:

-   **Rows of `X`**: genes (features)
-   **Columns of `X`**: samples
-   **`W`**: gene loadings for each latent factor (often interpreted as gene programs or pathways)
-   **`H`**: how much each sample uses each factor

The algorithm is **Lee–Seung multiplicative updates** (Frobenius loss), implemented from scratch in base R—no NMF packages required.

## Data

[`data/expression_matrix.csv`](data/expression_matrix.csv) is a teaching matrix (50 genes × 100 samples). Values are non-negative pseudo-expression. The table was **simulated once** as `W_true %*% H_true` plus noise (then floored at zero), with 3 distinct expression patterns, so latent structure exists but need not match your fitted rank exactly.

## How to run

Open this folder as your working directory (RStudio: *Session → Set Working Directory → To Source File Location* after opening `run_nmf_analysis.R`, or set wd manually).

From the **`1_Simple_Scripts`** directory:

``` r
source("run_nmf_analysis.R")
```

Or from a shell:

``` bash
cd Exercises/1_Simple_Scripts
Rscript run_nmf_analysis.R
```

Hyperparameters (`rank`, `max_iter`, `tol`, `seed`) are set at the top of [`run_nmf_analysis.R`](run_nmf_analysis.R).

## Outputs

After a successful run, see [`output/`](output/):

| File | Description |
|----|----|
| `nmf_fit.rds` | List with `W`, `H`, error history, iteration count, and summary metrics |
| `error_history.csv` | Frobenius error by iteration |
| `error_history.png` | Convergence curve |
| `nmf_heatmaps.png` | Heatmaps of `W` and `H` |

Generated PNG/CSV/RDS files are artifacts of the analysis; only `output/.gitkeep` is tracked so the folder exists in git.

## Script layout

```         
run_nmf_analysis.R          # entry point: settings, source(), save results
helpers/
  load_expression_data.R    # load_expression_matrix()
  nmf_fit.R                 # run_nmf(), Lee–Seung updates
  nmf_diagnostics.R         # reconstruction_error(), explain_variance()
  plot_results.R            # plot_error_history(), plot_nmf_heatmaps()
data/
  expression_matrix.csv
output/                     # written by the main script
```

## Why move to a package? (discussion checklist)

This layout **works** for a single analyst on one machine. Part 1 of the workshop asks what breaks as code is shared, reused, and maintained. Use this checklist while browsing the scripts:

1.  **`source()` order and coupling** — Helpers must be sourced before use; dependencies between files are implicit, not declared.
2.  **Working directory and paths** — Relative paths like `data/...` and `helpers/...` assume you started in the right folder; scripts fail silently or confusingly when reused from another project.
3.  **No automated tests** — A small change (e.g. transposing `X`) can give plausible-looking plots with wrong biology; nothing fails in CI.
4.  **Global environment** — All functions live in `.GlobalEnv`; names can clash with other scripts or packages; there is no stable **exported API**.
5.  **No `R CMD check`** — Namespace, dependencies, and cross-platform issues are unchecked until someone else runs your code.
6.  **Documentation in comments only** — Collaborators cannot run `?run_nmf` or browse help HTML; vignettes are absent.
7.  **Hard to reuse one piece** — To call `run_nmf()` elsewhere you still `source()` multiple files or copy-paste; installing one version for a team is awkward.

In **`2_Simple_Package`**, the same logic moves into the **`bionmf`** R package (`R/`, **`testthat`**, **roxygen2**). See [2_Simple_Package/README.md](../2_Simple_Package/README.md).
