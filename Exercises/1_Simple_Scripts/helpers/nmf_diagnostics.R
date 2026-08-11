# Diagnostics for NMF reconstruction quality.

reconstruction_error <- function(V, W, H) {
  sqrt(sum((V - W %*% H)^2))
}

explain_variance <- function(V, W, H) {
  ss_res <- sum((V - W %*% H)^2)
  ss_tot <- sum((V - mean(V))^2)
  if (ss_tot <= 0) {
    return(NA_real_)
  }
  1 - ss_res / ss_tot
}
