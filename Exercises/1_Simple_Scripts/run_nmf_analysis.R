# Non-negative matrix factorization on gene expression data.
# Run from the 1_Simple_Scripts directory (see README.md).

# ---- Analysis settings ----
rank <- 3L
max_iter <- 200L
tol <- 1e-4
seed <- 42L

data_path <- file.path("data", "expression_matrix.csv")
output_dir <- "output"

# ---- Load helper scripts (order matters if functions depend on each other) ----
source("helpers/load_expression_data.R")
source("helpers/nmf_fit.R")
source("helpers/nmf_diagnostics.R")
source("helpers/plot_results.R")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

message("Loading expression matrix...")
X <- load_expression_matrix(data_path)
message("Matrix dimensions: ", nrow(X), " genes x ", ncol(X), " samples")

message("Running NMF (rank = ", rank, ")...")
fit <- run_nmf(X, rank = rank, max_iter = max_iter, tol = tol, seed = seed)

final_error <- reconstruction_error(X, fit$W, fit$H)
r2 <- explain_variance(X, fit$W, fit$H)
message(
  "Finished in ", fit$iterations, " iteration(s). ",
  "Final error = ", signif(final_error, 4),
  "; variance explained = ", signif(r2, 4)
)

saveRDS(
  list(
    W = fit$W,
    H = fit$H,
    error_history = fit$error_history,
    iterations = fit$iterations,
    rank = rank,
    final_error = final_error,
    variance_explained = r2
  ),
  file = file.path(output_dir, "nmf_fit.rds")
)

write.csv(
  data.frame(iteration = seq_along(fit$error_history), error = fit$error_history),
  file = file.path(output_dir, "error_history.csv"),
  row.names = FALSE
)

plot_error_history(
  fit$error_history,
  file = file.path(output_dir, "error_history.png")
)
plot_nmf_heatmaps(
  fit$W,
  fit$H,
  file = file.path(output_dir, "nmf_heatmaps.png")
)

message("Results written to ", normalizePath(output_dir, mustWork = FALSE))
