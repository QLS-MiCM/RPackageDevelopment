test_that("reconstruction_error is zero for exact factorization", {
  W <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  H <- matrix(c(1, 0, 0, 1), nrow = 2, ncol = 2)
  V <- W %*% H
  expect_equal(reconstruction_error(V, W, H), 0)
})

test_that("explain_variance is 1 for exact reconstruction", {
  W <- matrix(c(1, 2), ncol = 1)
  H <- matrix(c(3, 4), nrow = 1)
  V <- W %*% H
  expect_equal(explain_variance(V, W, H), 1)
})
