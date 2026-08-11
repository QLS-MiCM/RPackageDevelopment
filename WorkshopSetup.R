# Checking and installing packages

packages <- c(
  "knitr", "rmarkdown", "testthat",
  "devtools", "roxygen2", "usethis",
  "covr", "pkgdown", "rcmdcheck","covr"
)

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
    library(pkg, character.only = TRUE)
  }
}
