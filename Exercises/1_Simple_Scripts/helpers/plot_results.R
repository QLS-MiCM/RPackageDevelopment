# Base R plots for NMF results.

plot_error_history <- function(error_history, file = NULL, width = 7, height = 5) {
  if (!is.null(file)) {
    grDevices::png(file, width = width, height = height, units = "in", res = 120)
    on.exit(grDevices::dev.off(), add = TRUE)
  }

  iter <- seq_along(error_history)
  plot(
    iter, error_history,
    type = "l", lwd = 2,
    xlab = "Iteration",
    ylab = "Frobenius reconstruction error",
    main = "NMF convergence"
  )
  invisible(NULL)
}

plot_nmf_heatmaps <- function(W, H, file = NULL, width = 10, height = 5) {
  if (!is.null(file)) {
    grDevices::png(file, width = width, height = height, units = "in", res = 120)
    on.exit(grDevices::dev.off(), add = TRUE)
  }

  op <- par(mfrow = c(1, 2), mar = c(5, 4, 3, 2))
  on.exit(par(op), add = TRUE)

  heatmap(
    W,
    Rowv = NA, Colv = NA,
    scale = "none",
    main = "W (gene programs)",
    xlab = "Factor",
    ylab = "Gene"
  )
  heatmap(
    H,
    Rowv = NA, Colv = NA,
    scale = "none",
    main = "H (sample loadings)",
    xlab = "Sample",
    ylab = "Factor"
  )
  invisible(NULL)
}
