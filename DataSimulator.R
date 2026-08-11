# Simulation script for gene expression data used in all exercises.
# Generates a non-negative gene x sample matrix as W_true %*% H_true + noise,
# with 50 genes, 100 samples, and 3 distinct expression patterns (rank = 3).

set.seed(42)

n_genes <- 50L
n_samples <- 100L
rank <- 3L
noise_sd <- 0.5

gene_names <- sprintf("Gene%04d", seq_len(n_genes))
sample_names <- sprintf("Sample%d", seq_len(n_samples))

# W_true: gene loadings for each of 3 patterns (genes x rank)
W_true <- matrix(0, nrow = n_genes, ncol = rank)
gene_blocks <- split(seq_len(n_genes), cut(seq_len(n_genes), rank, labels = FALSE))

for (k in seq_len(rank)) {
  W_true[gene_blocks[[k]], k] <- runif(length(gene_blocks[[k]]), 2, 4)
  background <- setdiff(seq_len(n_genes), gene_blocks[[k]])
  W_true[background, k] <- runif(length(background), 0, 0.3)
}

# H_true: sample usage of each pattern (rank x samples)
H_true <- matrix(0, nrow = rank, ncol = n_samples)
samples_per_pattern <- floor(n_samples / rank)
sample_blocks <- split(
  seq_len(n_samples),
  cut(seq_len(n_samples), rank, labels = FALSE)
)

for (k in seq_len(rank)) {
  H_true[k, sample_blocks[[k]]] <- runif(length(sample_blocks[[k]]), 2, 5)
  H_true[-k, sample_blocks[[k]]] <- runif(length(sample_blocks[[k]]), 0, 0.4)
}

X <- W_true %*% H_true
X <- X + abs(matrix(rnorm(n_genes * n_samples, sd = noise_sd), nrow = n_genes))
X <- pmax(X, 0)

rownames(X) <- gene_names
colnames(X) <- sample_names

output_paths <- c(
  file.path("Exercises", "1_Simple_Scripts", "data", "expression_matrix.csv"),
  file.path("Exercises", "2_Simple_Package", "inst", "extdata", "expression_matrix.csv"),
  file.path("Exercises", "3_Actions_Package", "inst", "extdata", "expression_matrix.csv")
)

for (path in output_paths) {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  write.csv(X, file = path, row.names = TRUE)
  message("Saved ", nrow(X), " genes x ", ncol(X), " samples to ", path)
}
