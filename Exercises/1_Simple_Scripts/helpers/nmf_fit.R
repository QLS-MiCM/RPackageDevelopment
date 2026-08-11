# Lee-Seung multiplicative updates for non-negative matrix factorization (Frobenius norm).

initialize_nmf <- function(V, k, seed = NULL) {
  if (!is.null(seed)) {
    set.seed(seed)
  }
  m <- nrow(V)
  n <- ncol(V)
  W <- matrix(stats::runif(m * k, min = 0.1, max = 1), nrow = m, ncol = k)
  H <- matrix(stats::runif(k * n, min = 0.1, max = 1), nrow = k, ncol = n)
  list(W = W, H = H)
}

nmf_multiplicative_step <- function(V, W, H, eps = 1e-9) {
  # Update H then W (Lee & Seung, 2001).
  H <- H * (crossprod(W, V) / (crossprod(W, W %*% H) + eps))
  W <- W * ((V %*% t(H)) / (W %*% H %*% t(H) + eps))
  list(W = W, H = H)
}

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

    err <- sqrt(sum((V - W %*% H)^2))
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
