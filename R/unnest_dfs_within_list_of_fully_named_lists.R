#' Unnest data.frames within fully named list
#'
#' Consider a function that returns a list of two data.frames. Call that
#' function repeatedly and store each return value in a list. You then hold a
#' list of fully named lists, and each inner list holds a data.frame.
#' Typically you want the two data.frames out of that nested structure, row-bound
#' with \code{data.table::rbindlist()}.
#'
#' @details
#' When every element of \code{x} is \code{NULL} or a \code{data.frame}, the
#' function row-binds those elements into a single \code{data.table}. It
#' returns that table in a length-1 list, named by
#' \code{returned_name_when_dfs_are_not_nested}.
#'
#' Otherwise every element of \code{x} MUST be \code{NULL} or a fully named
#' list. The function stops with an error if one element is not. The function
#' names the returned list by the sorted union of the inner names. Each element
#' is the \code{data.table::rbindlist()} of the inner elements that carry that
#' name.
#' @param x A list of fully named lists (which then contain data.frames)
#' @param returned_name_when_dfs_are_not_nested The name to give the returned
#'   element when \code{x} is a single list of data.frames.
#' @param ... Parameters passed to \code{data.table::rbindlist()}.
#' @examples
#' x <- list(
#'   list(
#'     "a" = data.frame("v1"=1),
#'     "b" = data.frame("v2"=3)
#'   ),
#'   list(
#'     "a" = data.frame("v1"=10),
#'     "b" = data.frame("v2"=30),
#'     "d" = data.frame("v3"=50)
#'   ),
#'   list(
#'     "a" = NULL
#'   ),
#'   NULL
#' )
#' print(x)
#' csutil::unnest_dfs_within_list_of_fully_named_lists(x)
#'
#' x <- list(
#'   data.frame("v1"=1),
#'   data.frame("v3"=50)
#' )
#' print(x)
#' csutil::unnest_dfs_within_list_of_fully_named_lists(
#'   x,
#'   returned_name_when_dfs_are_not_nested = "NAME",
#'   fill = TRUE
#' )
#' @return A fully named list, each element a \code{data.table}. \code{NULL} if
#'   \code{x} is not a list.
#' @seealso \code{vignette("csutil", package = "csutil")}, which unnests a
#'   two-element list of fully named lists.
#' @export
unnest_dfs_within_list_of_fully_named_lists <- function(
  x,
  returned_name_when_dfs_are_not_nested = "data",
  ...
) {
  if (!inherits(x, "list")) {
    return(NULL)
  }
  if (is_all_list_elements_null_or_df(x)) {
    retval <- list(rbindlist(x, ...))
    names(retval) <- returned_name_when_dfs_are_not_nested
    return(retval)
  }
  if (!is_all_list_elements_null_or_fully_named_list(x)) {
    stop("All list elements must be either null or a fully named list")
  }

  list_names <- lapply(x, function(y) names(y))
  list_names <- sort(unique(unlist(list_names)))

  if (length(list_names) == 0) {
    return(NULL)
  }

  retval <- vector("list", length = length(list_names))
  for (i in seq_along(retval)) {
    retval[[i]] <- vector("list", length = length(x))
    for (j in seq_along(x)) {
      retval[[i]][[j]] <- x[[j]][[list_names[i]]]
    }
    retval[[i]] <- rbindlist(retval[[i]], ...)
  }
  names(retval) <- list_names

  return(retval)
}
