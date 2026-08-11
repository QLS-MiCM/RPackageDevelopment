test_that("expression_matrix_path points to bundled data", {
  path <- expression_matrix_path()
  expect_true(nzchar(path))
  expect_true(file.exists(path))
})

test_that("load_expression_matrix reads bundled CSV", {
  V <- load_expression_matrix(expression_matrix_path())
  expect_true(is.matrix(V))
  expect_type(V, "double")
  expect_gt(nrow(V), 1L)
  expect_gt(ncol(V), 1L)
  expect_true(all(V >= 0))
})

test_that("load_expression_matrix validates input", {
  f <- tempfile(fileext = ".csv")
  on.exit(unlink(f), add = TRUE)
  writeLines(c("gene,s1", "g1,-1"), f)
  expect_error(load_expression_matrix(f), "non-negative")
})
