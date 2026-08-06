#' Apply a function via hash table
#'
#' Extracts the unique values of \code{x}, applies \code{fn} to those unique
#' values, and maps the results back to the original vector. This avoids
#' redundant computation when \code{x} contains many repeated values.
#'
#' @details
#' The function calls \code{fn} exactly once, on the vector of unique values of
#' \code{x}. It does not call \code{fn} once per element. It does not call
#' \code{fn} once per unique value either. \code{fn} MUST therefore be
#' vectorised. It receives the whole vector of unique values in a single call.
#'
#' This can dramatically speed up computation when there is a lot of data and
#' a limited number of unique values. The work \code{fn} does scales with the
#' number of unique values, not with the length of \code{x}.
#' @param x A vector whose values need a function applied.
#' @param fn A vectorised function, called once on the vector of unique values
#'   of \code{x}.
#' @param ... Additional arguments passed to \code{fn}.
#' @return A vector of the same length as \code{x}, holding the value of
#'   \code{fn} for each element (computed via unique-value lookup). The result
#'   takes its class from the value \code{fn} returns.
#' @seealso \code{vignette("csutil", package = "csutil")}, which times this
#'   function against a direct call to \code{format()}.
#' @examples
#' x <- c("a", "b", "a", "c", "b", "a")
#' apply_fn_via_hash_table(x, toupper)
#'
#' # passing extra arguments to fn
#' nums <- c(1.1, 2.2, 1.1, 3.3)
#' apply_fn_via_hash_table(nums, round, digits = 0)
#' @export
apply_fn_via_hash_table <- function(x, fn, ...) {
  . <- NULL
  input <- NULL
  output <- NULL

  match <- data.table(input = unique(x))
  match[, output := fn(input, ...)]
  setkey(match, "input")

  return(match[.(x)]$output)
}
