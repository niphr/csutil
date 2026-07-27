test_that("apply_fn_via_hash_table maps results back onto repeated values", {
  expect_identical(
    apply_fn_via_hash_table(c(1, 1, 2), function(x) x * 10),
    c(10, 10, 20)
  )
  expect_identical(
    apply_fn_via_hash_table(c("a", "b", "a", "c", "b", "a"), toupper),
    c("A", "B", "A", "C", "B", "A")
  )
})

test_that("apply_fn_via_hash_table preserves input order and length", {
  x <- c(3, 1, 3, 2, 1, 1)
  expect_identical(apply_fn_via_hash_table(x, function(y) y + 100), x + 100)
})

test_that("apply_fn_via_hash_table calls fn once per unique value", {
  seen <- 0L
  fn <- function(y) {
    seen <<- seen + length(y)
    y * 2
  }

  expect_identical(
    apply_fn_via_hash_table(c(5, 5, 5, 7), fn),
    c(10, 10, 10, 14)
  )
  expect_identical(seen, 2L)
})

test_that("apply_fn_via_hash_table passes ... through to fn", {
  expect_identical(
    apply_fn_via_hash_table(c(1.1, 2.2, 1.1, 3.3), round, digits = 0),
    c(1, 2, 1, 3)
  )
})
