test_that("easy_split splits by size_of_each_group", {
  retval <- easy_split(letters[1:7], size_of_each_group = 3)

  expect_type(retval, "list")
  expect_length(retval, 3)
  expect_identical(names(retval), c("1", "2", "3"))
  expect_identical(lengths(retval, use.names = FALSE), c(3L, 3L, 1L))
  expect_identical(retval[["1"]], c("a", "b", "c"))
  expect_identical(retval[["2"]], c("d", "e", "f"))
  expect_identical(retval[["3"]], "g")
  expect_identical(unname(unlist(retval)), letters[1:7])
})

test_that("easy_split splits by number_of_groups", {
  retval <- easy_split(letters[1:7], number_of_groups = 3)

  expect_type(retval, "list")
  expect_length(retval, 3)
  expect_identical(names(retval), c("1", "2", "3"))
  expect_identical(lengths(retval, use.names = FALSE), c(3L, 3L, 1L))
  expect_identical(retval[["1"]], c("a", "b", "c"))
  expect_identical(retval[["2"]], c("d", "e", "f"))
  expect_identical(retval[["3"]], "g")
  expect_identical(unname(unlist(retval)), letters[1:7])
})

test_that("both easy_split parameterisations agree for this input", {
  expect_identical(
    easy_split(letters[1:7], size_of_each_group = 3),
    easy_split(letters[1:7], number_of_groups = 3)
  )
})

test_that("easy_split demands exactly one of the two arguments", {
  # neither argument given
  expect_error(easy_split(letters[1:7]), "you must specify ONE")
  # both arguments given
  expect_error(
    easy_split(letters[1:7], size_of_each_group = 3, number_of_groups = 3),
    "you must specify ONE"
  )
})
