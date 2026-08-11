#' Frobenius reconstruction error
#'
#' @param V Observed data matrix `X`.
#' @param W Gene loading matrix.
#' @param H Sample loading matrix.
#' @return Scalar Frobenius norm `||X - WH||_F`.
#' @export
reconstruction_error <- function(V, W, H) {
  sqrt(sum((V - W %*% H)^2))
}

#' Fraction of variance explained by the reconstruction
#'
#' Computes `1 - SS_res / SS_tot` over all entries of `X`.
#'
#' @param V Observed data matrix `X`.
#' @param W Gene loading matrix.
#' @param H Sample loading matrix.
#' @return Scalar in `[0, 1]` when defined; `NA` if total variance is zero.
#' @export
explain_variance <- function(V, W, H) {
  ss_res <- sum((V - W %*% H)^2)
  ss_tot <- sum((V - mean(V))^2)
  if (ss_tot <= 0) {
    return(NA_real_)
  }
  1 - ss_res / ss_tot
}
