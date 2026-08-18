#' Initialize non-negative factor matrices
#'
#' @param V Data matrix (genes x samples), non-negative.
#' @param k Factorization rank.
#' @param seed Optional random seed for reproducibility.
#' @return List with components `W` and `H`.
#' @keywords internal
initialize_nmfx <- function(V, k, seed = NULL) {
  if (!is.null(seed)) {
    set.seed(seed)
  }
  m <- nrow(V)
  n <- ncol(V)
  W <- matrix(stats::runif(m * k, min = 0.1, max = 1), nrow = m, ncol = k)
  H <- matrix(stats::runif(k * n, min = 0.1, max = 1), nrow = k, ncol = n)
  list(W = W, H = H)
}

#' One Lee-Seung multiplicative update step
#'
#' @param V Data matrix.
#' @param W Current W matrix.
#' @param H Current H matrix.
#' @param eps Small constant to avoid division by zero.
#' @return List with updated `W` and `H`.
#' @keywords internal
nmf_multiplicative_step <- function(V, W, H, eps = 1e-9) {
  H <- H * (crossprod(W, V) / (crossprod(W, W %*% H) + eps))
  W <- W * ((V %*% t(H)) / (W %*% H %*% t(H) + eps))
  list(W = W, H = H)
}

#' Run non-negative matrix factorization
#'
#' Fits `X \approx W H` with `W, H \ge 0` using Lee-Seung multiplicative
#' updates under the Frobenius loss.
#'
#' @param V Numeric matrix `X`, genes as rows and samples as columns; non-negative.
#' @param rank Integer factorization rank (number of latent programs).
#' @param max_iter Maximum number of multiplicative update iterations.
#' @param tol Stop when relative change in Frobenius error falls below this value.
#' @param seed Optional random seed passed to [initialize_nmf()].
#' @param eps Small constant for numerical stability in updates.
#' @return A list with `W`, `H`, `error_history`, and `iterations`.
#' @export
#'
#' @examples
#' path <- expression_matrix_path()
#' if (nzchar(path)) {
#'   X <- load_expression_matrix(path)
#'   fit <- run_nmf(X, rank = 3L, max_iter = 50L, seed = 42L)
#'   fit$iterations
#' }
run_nmf <- function(V, rank, max_iter = 200L, tol = 1e-4, seed = NULL, eps = 1e-9) {
  rank <- as.integer(rank)
  if (rank < 1L || rank > min(nrow(V), ncol(V))) {
    stop("rank must be between 1 and min(nrow(V), ncol(V)).")
  }

  init <- initialize_nmf(V, rank, seed = seed)
  W <- init$W
  H <- init$H

  error_history <- numeric(max_iter)
  prev_error <- Inf

  for (iter in seq_len(max_iter)) {
    step <- nmf_multiplicative_step(V, W, H, eps = eps)
    W <- step$W
    H <- step$H

    err <- reconstruction_error(V, W, H)
    error_history[iter] <- err

    if (iter > 1L) {
      rel_change <- abs(prev_error - err) / (prev_error + eps)
      if (rel_change < tol) {
        error_history <- error_history[seq_len(iter)]
        break
      }
    }
    prev_error <- err
  }

  list(
    W = W,
    H = H,
    error_history = error_history,
    iterations = length(error_history)
  )
}
