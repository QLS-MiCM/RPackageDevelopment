#' Plot NMF reconstruction error over iterations
#'
#' @param error_history Numeric vector of Frobenius errors.
#' @param file Optional path to save a PNG; when `NULL`, plots to the active device.
#' @param width Plot width in inches when saving to `file`.
#' @param height Plot height in inches when saving to `file`.
#' @return Invisibly `NULL`.
#' @export
plot_error_history <- function(error_history, file = NULL, width = 7, height = 5) {
  if (!is.null(file)) {
    grDevices::png(file, width = width, height = height, units = "in", res = 120)
    on.exit(grDevices::dev.off(), add = TRUE)
  }

  iter <- seq_along(error_history)
  graphics::plot(
    iter, error_history,
    type = "l", lwd = 2,
    xlab = "Iteration",
    ylab = "Frobenius reconstruction error",
    main = "NMF convergence"
  )
  invisible(NULL)
}

#' Heatmaps of NMF factor matrices
#'
#' @param W Gene loading matrix (`nrow(W)` genes x `ncol(W)` factors).
#' @param H Sample loading matrix (`nrow(H)` factors x `ncol(H)` samples).
#' @param file Optional path to save a PNG.
#' @param width Plot width in inches when saving to `file`.
#' @param height Plot height in inches when saving to `file`.
#' @return Invisibly `NULL`.
#' @export
plot_nmf_heatmaps <- function(W, H, file = NULL, width = 10, height = 5) {
  if (!is.null(file)) {
    grDevices::png(file, width = width, height = height, units = "in", res = 120)
    on.exit(grDevices::dev.off(), add = TRUE)
  }

  op <- graphics::par(mfrow = c(1, 2), mar = c(5, 4, 3, 2))
  on.exit(graphics::par(op), add = TRUE)

  stats::heatmap(
    W,
    Rowv = NA, Colv = NA,
    scale = "none",
    main = "W (gene programs)",
    xlab = "Factor",
    ylab = "Gene"
  )
  stats::heatmap(
    H,
    Rowv = NA, Colv = NA,
    scale = "none",
    main = "H (sample loadings)",
    xlab = "Sample",
    ylab = "Factor"
  )
  invisible(NULL)
}
