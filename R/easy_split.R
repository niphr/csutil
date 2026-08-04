#' Split a vector into a list of vectors
#'
#' Splits \code{x} into a list of consecutive groups. Specify exactly one of
#' \code{size_of_each_group} or \code{number_of_groups}; supplying neither, or
#' supplying both, is an error.
#'
#' @details
#' Every group has the same length except the last, which may be shorter. The
#' original order of \code{x} is preserved, and the list elements are named
#' \code{"1"}, \code{"2"} and so on.
#'
#' \code{number_of_groups} is a request, not a guarantee. The group size is
#' computed as \code{ceiling(length(x) / number_of_groups)}, so the number of
#' groups actually returned is
#' \code{ceiling(length(x) / ceiling(length(x) / number_of_groups))}, which can
#' be smaller than \code{number_of_groups}. For example,
#' \code{easy_split(1:4, number_of_groups = 3)} returns two groups of two.
#' @param x The vector to be split.
#' @param size_of_each_group The number of elements in each group. The last
#'   group may hold fewer.
#' @param number_of_groups The number of groups requested. Fewer groups than
#'   requested can be returned; see Details.
#' @examples
#' easy_split(letters[1:20], size_of_each_group = 3)
#' easy_split(letters[1:20], number_of_groups = 3)
#'
#' # number_of_groups is a request: this asks for 3 groups and returns 2
#' easy_split(1:4, number_of_groups = 3)
#' @return A list of vectors, holding the elements of \code{x} in their original
#'   order. Every element has the same length except the last, which may be
#'   shorter.
#' @seealso \code{vignette("csutil", package = "csutil")}, which splits
#'   \code{letters[1:20]} both ways.
#' @export
easy_split <- function(x, size_of_each_group = NULL, number_of_groups = NULL) {
  if (is.null(size_of_each_group) & is.null(number_of_groups)) {
    stop("you must specify ONE of size_of_each_group OR number_of_groups")
  }
  if (!is.null(size_of_each_group) & !is.null(number_of_groups)) {
    stop("you must specify ONE of size_of_each_group OR number_of_groups")
  }

  if (!is.null(size_of_each_group)) {
    return(split(x, ceiling(seq_along(x) / size_of_each_group)))
  }

  if (!is.null(number_of_groups)) {
    splitting_index <- rep(
      1:number_of_groups,
      each = ceiling(length(x) / number_of_groups)
    )[1:length(x)]
    return(split(x, splitting_index))
  }
}
