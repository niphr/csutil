test_that("is_fully_named_list characterizes lists", {
  expect_true(is_fully_named_list(list("a" = 1)))
  expect_true(is_fully_named_list(list("a" = 1, "b" = 2)))

  # partially named and unnamed lists are NOT fully named
  expect_false(is_fully_named_list(list("a" = 1, 2)))
  expect_false(is_fully_named_list(list(1)))

  # non-lists are never fully named lists
  expect_false(is_fully_named_list(NULL))
  expect_false(is_fully_named_list(data.frame()))
  expect_false(is_fully_named_list(c("a" = 1)))
})

test_that("is_fully_named_list(list()) is FALSE while the three siblings are TRUE", {
  # DELIBERATE ASYMMETRY, ASSERTED ON PURPOSE, NOT AN OVERSIGHT.
  # is_fully_named_list(list()) returns FALSE, but the three
  # is_all_list_elements_null_or_*() predicates return TRUE for the same empty
  # list. That inconsistency is the shipped contract of a package already on
  # CRAN. Changing it would be a silent API break, so it is pinned here.
  # Do not "fix" the implementation or these expectations to make them agree.
  expect_false(is_fully_named_list(list()))
  expect_true(is_all_list_elements_null_or_df(list()))
  expect_true(is_all_list_elements_null_or_list(list()))
  expect_true(is_all_list_elements_null_or_fully_named_list(list()))
})

test_that("the three is_all_list_elements_null_or_* predicates accept list(NULL)", {
  expect_true(is_all_list_elements_null_or_df(list(NULL)))
  expect_true(is_all_list_elements_null_or_list(list(NULL)))
  expect_true(is_all_list_elements_null_or_fully_named_list(list(NULL)))
})

test_that("the three is_all_list_elements_null_or_* predicates reject non-lists", {
  expect_false(is_all_list_elements_null_or_df(NULL))
  expect_false(is_all_list_elements_null_or_list(NULL))
  expect_false(is_all_list_elements_null_or_fully_named_list(NULL))

  expect_false(is_all_list_elements_null_or_df(data.frame()))
  expect_false(is_all_list_elements_null_or_list(data.frame()))
  expect_false(is_all_list_elements_null_or_fully_named_list(data.frame()))
})

test_that("is_all_list_elements_null_or_df discriminates data.frame elements", {
  expect_true(is_all_list_elements_null_or_df(list(data.frame())))
  expect_true(is_all_list_elements_null_or_df(list(data.frame(), NULL)))
  expect_false(is_all_list_elements_null_or_df(list(1, NULL)))
  expect_false(is_all_list_elements_null_or_df(list("a" = 1, 2)))
})

test_that("is_all_list_elements_null_or_list discriminates list elements", {
  expect_true(is_all_list_elements_null_or_list(list(list(), NULL)))
  expect_true(is_all_list_elements_null_or_list(list(list("a" = 1))))
  # inherits() looks only at the class attribute, so a data.frame is NOT a "list"
  expect_false(is_all_list_elements_null_or_list(list(data.frame())))
  expect_false(is_all_list_elements_null_or_list(list(1, NULL)))
  expect_false(is_all_list_elements_null_or_list(list("a" = 1, 2)))
})

test_that("is_all_list_elements_null_or_fully_named_list requires named inner lists", {
  expect_true(is_all_list_elements_null_or_fully_named_list(list(
    list("a" = 1),
    NULL
  )))
  expect_false(is_all_list_elements_null_or_fully_named_list(list(
    list(1),
    NULL
  )))
  expect_false(is_all_list_elements_null_or_fully_named_list(list(list(
    "a" = 1,
    2
  ))))
  expect_false(is_all_list_elements_null_or_fully_named_list(list(1, NULL)))
  expect_false(is_all_list_elements_null_or_fully_named_list(list("a" = 1, 2)))

  # an inner empty list is not fully named (see the asymmetry note above), so
  # the outer predicate is FALSE here
  expect_false(is_all_list_elements_null_or_fully_named_list(list(
    list(),
    NULL
  )))
})
