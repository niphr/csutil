# Unnest data.frames within fully named list

Consider a function that returns a list of two data.frames. Call that
function repeatedly and store each return value in a list. You then hold
a list of fully named lists, and each inner list holds a data.frame.
Typically you want the two data.frames out of that nested structure,
row-bound with
[`data.table::rbindlist()`](https://rdrr.io/pkg/data.table/man/rbindlist.html).

## Usage

``` r
unnest_dfs_within_list_of_fully_named_lists(
  x,
  returned_name_when_dfs_are_not_nested = "data",
  ...
)
```

## Arguments

- x:

  A list of fully named lists (which then contain data.frames)

- returned_name_when_dfs_are_not_nested:

  The name to give the returned element when `x` is a single list of
  data.frames.

- ...:

  Parameters passed to
  [`data.table::rbindlist()`](https://rdrr.io/pkg/data.table/man/rbindlist.html).

## Value

A fully named list, each element a `data.table`. `NULL` if `x` is not a
list.

## Details

When every element of `x` is `NULL` or a `data.frame`, the function
row-binds those elements into a single `data.table`. It returns that
table in a length-1 list, named by
`returned_name_when_dfs_are_not_nested`.

Otherwise every element of `x` MUST be `NULL` or a fully named list. The
function stops with an error if one element is not. The function names
the returned list by the sorted union of the inner names. Each element
is the
[`data.table::rbindlist()`](https://rdrr.io/pkg/data.table/man/rbindlist.html)
of the inner elements that carry that name.

## See also

[`vignette("csutil", package = "csutil")`](https://niphr.github.io/csutil/articles/csutil.md),
which unnests a two-element list of fully named lists.

## Examples

``` r
x <- list(
  list(
    "a" = data.frame("v1"=1),
    "b" = data.frame("v2"=3)
  ),
  list(
    "a" = data.frame("v1"=10),
    "b" = data.frame("v2"=30),
    "d" = data.frame("v3"=50)
  ),
  list(
    "a" = NULL
  ),
  NULL
)
print(x)
#> [[1]]
#> [[1]]$a
#>   v1
#> 1  1
#> 
#> [[1]]$b
#>   v2
#> 1  3
#> 
#> 
#> [[2]]
#> [[2]]$a
#>   v1
#> 1 10
#> 
#> [[2]]$b
#>   v2
#> 1 30
#> 
#> [[2]]$d
#>   v3
#> 1 50
#> 
#> 
#> [[3]]
#> [[3]]$a
#> NULL
#> 
#> 
#> [[4]]
#> NULL
#> 
csutil::unnest_dfs_within_list_of_fully_named_lists(x)
#> $a
#>       v1
#>    <num>
#> 1:     1
#> 2:    10
#> 
#> $b
#>       v2
#>    <num>
#> 1:     3
#> 2:    30
#> 
#> $d
#>       v3
#>    <num>
#> 1:    50
#> 

x <- list(
  data.frame("v1"=1),
  data.frame("v3"=50)
)
print(x)
#> [[1]]
#>   v1
#> 1  1
#> 
#> [[2]]
#>   v3
#> 1 50
#> 
csutil::unnest_dfs_within_list_of_fully_named_lists(
  x,
  returned_name_when_dfs_are_not_nested = "NAME",
  fill = TRUE
)
#> $NAME
#>       v1    v3
#>    <num> <num>
#> 1:     1    NA
#> 2:    NA    50
#> 
```
