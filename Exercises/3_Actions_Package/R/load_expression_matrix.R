#' Path to the bundled example expression matrix
#'
#' Returns the path to `expression_matrix.csv` shipped with the package
#' (same simulated gene-by-sample data as in exercise `1_Simple_Scripts`).
#'
#' @return Character scalar, absolute path when the file is present.
#' @export
#'
#' @examples
#' path <- expression_matrix_path()
#' if (nzchar(path)) {
#'   X <- load_expression_matrix(path)
#'   dim(X)
#' }
expression_matrix_path <- function() {
  system.file("extdata", "expression_matrix.csv", package = "bionmf")
}

#' Load a gene-by-sample expression matrix from CSV
#'
#' Reads a CSV with gene IDs in the first column (row names) and non-negative
#' numeric expression values for each sample.
#'
#' @param path Path to a CSV file.
#' @return Numeric matrix with genes as rows and samples as columns.
#' @export
#'
#' @examples
#' path <- expression_matrix_path()
#' if (nzchar(path)) {
#'   X <- load_expression_matrix(path)
#' }
load_expression_matrix <- function(path) {
  if (!file.exists(path)) {
    stop("Expression matrix file not found: ", path)
  }

  dat <- utils::read.csv(path, row.names = 1, check.names = FALSE)
  V <- as.matrix(dat)
  storage.mode(V) <- "double"

  if (any(is.na(V))) {
    stop("Expression matrix contains NA values; impute or filter before NMF.")
  }
  if (any(V < 0)) {
    stop("NMF requires a non-negative matrix; found negative values.")
  }
  if (nrow(V) < 2L || ncol(V) < 2L) {
    stop("Matrix must have at least 2 genes and 2 samples.")
  }

  V
}
