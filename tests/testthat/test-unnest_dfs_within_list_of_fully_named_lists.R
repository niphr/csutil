test_that("unnest_dfs_within_list_of_fully_named_lists row-binds same-named frames", {
  x <- list(
    list(
      "a" = data.frame("v1" = 1),
      "b" = data.frame("v2" = 3)
    ),
    list(
      "a" = data.frame("v1" = 10),
      "b" = data.frame("v2" = 30),
      "d" = data.frame("v3" = 50)
    ),
    list(
      "a" = NULL
    ),
    NULL
  )

  retval <- unnest_dfs_within_list_of_fully_named_lists(x)

  expect_type(retval, "list")
  expect_length(retval, 3)
  # names are the sorted union of the inner names
  expect_identical(names(retval), c("a", "b", "d"))

  # each element is a data.table, NOT a plain data.frame
  expect_s3_class(retval[["a"]], "data.table")
  expect_s3_class(retval[["b"]], "data.table")
  expect_s3_class(retval[["d"]], "data.table")

  # same-named frames are row-bound across the outer lists
  expect_identical(nrow(retval[["a"]]), 2L)
  expect_identical(retval[["a"]]$v1, c(1, 10))
  expect_identical(retval[["b"]]$v2, c(3, 30))
  expect_identical(retval[["d"]]$v3, 50)
})

test_that("unnest_dfs_within_list_of_fully_named_lists handles an unnested list of data.frames", {
  x <- list(
    data.frame("v1" = 1),
    data.frame("v3" = 50)
  )

  retval <- unnest_dfs_within_list_of_fully_named_lists(
    x,
    returned_name_when_dfs_are_not_nested = "NAME",
    fill = TRUE
  )

  expect_identical(names(retval), "NAME")
  expect_s3_class(retval[["NAME"]], "data.table")
  expect_identical(retval[["NAME"]]$v1, c(1, NA))
  expect_identical(retval[["NAME"]]$v3, c(NA, 50))
})

test_that("unnest_dfs_within_list_of_fully_named_lists rejects unsupported input", {
  expect_null(unnest_dfs_within_list_of_fully_named_lists(NULL))
  expect_null(unnest_dfs_within_list_of_fully_named_lists(1:3))
  expect_error(
    unnest_dfs_within_list_of_fully_named_lists(list(list(1))),
    "All list elements must be either null or a fully named list"
  )
})
