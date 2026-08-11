# Load a gene x sample expression matrix from CSV.
# Expects row names in the first column and non-negative numeric values.

load_expression_matrix <- function(path) {
  if (!file.exists(path)) {
    stop("Expression matrix file not found: ", path)
  }

  dat <- read.csv(path, row.names = 1, check.names = FALSE)
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
