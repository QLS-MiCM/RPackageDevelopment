# bionmf

Workshop exercise **2_Simple_Package**: a standard R package port of the NMF scripts in [`1_Simple_Scripts`](../1_Simple_Scripts/).

## Package contents

| Script helper (step 1) | Package location |
|----|----|
| `helpers/load_expression_data.R` | `R/load_expression_matrix.R` |
| `helpers/nmf_fit.R` | `R/nmf_fit.R` |
| `helpers/nmf_diagnostics.R` | `R/nmf_diagnostics.R` |
| `helpers/plot_results.R` | `R/plot_results.R` |
| `data/expression_matrix.csv` | `inst/extdata/expression_matrix.csv` |
| `run_nmf_analysis.R` | `examples/nmf_analysis.R`, `vignettes/bionmf.Rmd` |

Exported API (stable names carried over from the scripts):

-   `expression_matrix_path()`, `load_expression_matrix()`
-   `run_nmf()`
-   `reconstruction_error()`, `explain_variance()`
-   `plot_error_history()`, `plot_nmf_heatmaps()`

Internal helpers (`initialize_nmf`, `nmf_multiplicative_step`) live in `R/nmf_fit.R` and are not exported.

## Setup

From this directory (`Exercises/2_Simple_Package`):

``` r
# install.packages("devtools")  # if needed
devtools::load_all()
devtools::test()
?run_nmf
browseVignettes("bionmf")
```

After `devtools::install(build_vignettes = TRUE)` (or `R CMD build`), open the HTML vignette with `vignette("bionmf")`. During development you can also knit `vignettes/bionmf.Rmd` directly.

Or build and check from the shell:

``` bash
cd Exercises/2_Simple_Package
Rscript -e "roxygen2::roxygenise()"
R CMD build .
R CMD check bionmf_*.tar.gz --no-manual
```

## Run the example analysis

``` r
devtools::load_all()
source("examples/nmf_analysis.R", local = TRUE)
```

Compare with step 1: no `source()` chain, functions are namespaced, help pages exist, and `tests/testthat/` guards behavior.

## What changed vs scripts?

1.  **Layout** — `DESCRIPTION`, `NAMESPACE`, `R/`, `man/`, `tests/`, `inst/extdata/`.
2.  **Documentation** — roxygen2 comments generate `?function` help; `vignettes/bionmf.Rmd` is a long-form walkthrough of the example analysis.
3.  **Tests** — `testthat` covers loading, factorization dimensions, and diagnostics.
4.  **Data access** — `system.file()` via `expression_matrix_path()` instead of a hard-coded `data/` path.
5.  **Reuse** — `library(bionmf)` or `devtools::load_all()` loads one version of each function.

## Next step

Continue to [**3_Actions_Package**](../3_Actions_Package/) to add GitHub Actions for automated install, tests, and PR/issue messaging.
