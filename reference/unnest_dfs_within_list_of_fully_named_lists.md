# Unnest data.frames within fully named list

Consider the situation where a function returns a list containing two
data.frames. If this function is called repeatedly and the return values
are stored in a list, we will have a list of fully named lists (each of
which contains a data.frame). Typically, we want to extract the two
data.frames from this nested list structure (and rbindlist them).

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

  When x is a single list of data.frames, what name should be returned?

- ...:

  parameters passed to data.table::rbindlist

## Value

Fully named list, each element containing a data.table.

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
