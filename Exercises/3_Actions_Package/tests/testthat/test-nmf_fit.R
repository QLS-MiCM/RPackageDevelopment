test_that("run_nmf returns correct dimensions", {
  V <- load_expression_matrix(expression_matrix_path())
  rank <- 3L
  fit <- run_nmf(V, rank = rank, max_iter = 30L, seed = 1L)
  expect_equal(dim(fit$W), c(nrow(V), rank))
  expect_equal(dim(fit$H), c(rank, ncol(V)))
  expect_length(fit$error_history, fit$iterations)
})

test_that("run_nmf error decreases initially", {
  V <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  fit <- run_nmf(V, rank = 2L, max_iter = 20L, seed = 99L)
  expect_lt(tail(fit$error_history, 1), fit$error_history[1])
})

test_that("run_nmf rejects invalid rank", {
  V <- matrix(1:4, nrow = 2)
  expect_error(run_nmf(V, rank = 0L), "rank")
  expect_error(run_nmf(V, rank = 10L), "rank")
})
