# `bionmf`  **Example GitHub Actions-Enabled package**

Workshop exercise **3_Actions_Package**: the **`bionmf`** package from [`2_Simple_Package`](../2_Simple_Package/), extended with GitHub Actions for collaboration and CI.

## GitHub Actions Workflows for `bionmf`

Four workflows live in [`.github/workflows/`](.github/workflows/):

| Workflow | Trigger | Purpose |
|--------------------------|-----------------------|-----------------------|
| [`issue-message.yml`](.github/workflows/issue-message.yml) | Issue opened | Posts a welcome message and bug-report checklist |
| [`pull-request-message.yml`](.github/workflows/pull-request-message.yml) | PR opened / reopened | Posts a contributor checklist on the PR |
| [`install-package.yml`](.github/workflows/install-package.yml) | Push / PR to `main` | Builds and installs the package on Ubuntu |
| [`run-tests.yml`](.github/workflows/run-tests.yml) | Push / PR to `main` | Runs `testthat` via [r-lib/actions](https://github.com/r-lib/actions) |

Together they cover **communication** (issues & PRs) and **continuous integration** (install + test).

## Package contents

Same as step 2 — see the mapping in [`2_Simple_Package/README.md`](../2_Simple_Package/README.md). All R code, tests, and bundled data are unchanged unless you modify them during the Actions exercise.

## Local development

From this directory (`Exercises/3_Actions_Package`):

``` r
devtools::load_all()
devtools::test()
vignette("bionmf")  # after install with vignettes built
```

``` bash
R CMD build .
R CMD check bionmf_*.tar.gz --no-manual
```

## Using the workflows

### Standalone package repository

When **`bionmf` is the root of your GitHub repository**, copy `.github/workflows/` to the repository root. GitHub only runs workflows from `<repo>/.github/workflows/`.

### This workshop monorepo

This repository also includes mirrored workflows at the **repository root**:

-   [`.github/workflows/bionmf-issue-message.yml`](../../.github/workflows/bionmf-issue-message.yml)
-   [`.github/workflows/bionmf-pull-request-message.yml`](../../.github/workflows/bionmf-pull-request-message.yml)
-   [`.github/workflows/bionmf-install-package.yml`](../../.github/workflows/bionmf-install-package.yml)
-   [`.github/workflows/bionmf-run-tests.yml`](../../.github/workflows/bionmf-run-tests.yml)

The install, test, and PR-message workflows set `working-directory: Exercises/3_Actions_Package` where needed and use `paths` filters so they run only when this exercise changes. The issue-message workflow cannot use `paths` (GitHub does not support that filter on `issues` events); it posts only when the issue title or body mentions `bionmf` or `3_Actions_Package`.

## Try the automation

1.  Open a **new issue** whose title or body mentions `bionmf` or `3_Actions_Package` — the issue workflow posts a template comment.
2.  Open a **pull request** that touches `Exercises/3_Actions_Package/` — the PR workflow posts a checklist comment.
3.  Push a change under `Exercises/3_Actions_Package/` — install and test workflows run on GitHub's Ubuntu runners.

Check the **Actions** tab on GitHub for workflow run logs.

## Workshop discussion points

-   **Permissions** — issue/PR workflows need `issues: write` or `pull-requests: write`.
-   **Path filters** — limit CI to the package folder in monorepos.
-   **r-lib/actions** — standard R setup (`setup-r`, `setup-r-dependencies`) plus `testthat::test_local()` for the test job.
-   **Separation of concerns** — install verifies the tarball; tests verify behavior.

## Prior steps

-   [`1_Simple_Scripts`](../1_Simple_Scripts/) — script-based prototype
-   [`2_Simple_Package`](../2_Simple_Package/) — package structure, roxygen2, testthat
