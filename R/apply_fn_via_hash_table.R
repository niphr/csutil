#' Apply a function via hash table
#'
#' Extracts the unique values of \code{x}, applies \code{fn} to those unique
#' values, and maps the results back to the original vector. This avoids
#' redundant computation when \code{x} contains many repeated values.
#'
#' @details
#' This can dramatically speed up computation if there is a lot of data and
#' a limited number of unique values: \code{fn} is called once per unique value
#' rather than once per element.
#' @param x A vector whose values need a function applied.
#' @param fn A function to apply to the unique values of \code{x}.
#' @param ... Additional arguments passed to \code{fn}.
#' @return A vector of the same length as \code{x}, containing the result of
#'   applying \code{fn} to each element (computed via unique-value lookup).
#' @examples
#' x <- c("a", "b", "a", "c", "b", "a")
#' apply_fn_via_hash_table(x, toupper)
#'
#' # passing extra arguments to fn
#' nums <- c(1.1, 2.2, 1.1, 3.3)
#' apply_fn_via_hash_table(nums, round, digits = 0)
#' @export
apply_fn_via_hash_table <- function(x, fn, ...){
  . <- NULL
  input <- NULL
  output <- NULL

  match <- data.table(input = unique(x))
  match[, output := fn(input, ...)]
  setkey(match, "input")

  return(match[.(x)]$output)
}

