# Intro to csutil

## Splitting

[`easy_split()`](https://niphr.github.io/csutil/reference/easy_split.md)
divides a vector into groups either by specifying the target size of
each group or the total number of groups.

``` r
csutil::easy_split(letters[1:20], size_of_each_group = 3)
#> $`1`
#> [1] "a" "b" "c"
#> 
#> $`2`
#> [1] "d" "e" "f"
#> 
#> $`3`
#> [1] "g" "h" "i"
#> 
#> $`4`
#> [1] "j" "k" "l"
#> 
#> $`5`
#> [1] "m" "n" "o"
#> 
#> $`6`
#> [1] "p" "q" "r"
#> 
#> $`7`
#> [1] "s" "t"
csutil::easy_split(letters[1:20], number_of_groups = 3)
#> $`1`
#> [1] "a" "b" "c" "d" "e" "f" "g"
#> 
#> $`2`
#> [1] "h" "i" "j" "k" "l" "m" "n"
#> 
#> $`3`
#> [1] "o" "p" "q" "r" "s" "t"
```

## Unnesting data frames within a list

[`unnest_dfs_within_list_of_fully_named_lists()`](https://niphr.github.io/csutil/reference/unnest_dfs_within_list_of_fully_named_lists.md)
collapses a list of named lists, each containing data frames, into a
single flat list. Elements that share a name across the outer lists are
row-bound together.

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
  )
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
```

## Describing lists

These predicates test structural properties of a list: whether every
element is named, and whether every element is `NULL` or a particular
type.

``` r
csutil::is_fully_named_list(list(1))
#> [1] FALSE
csutil::is_fully_named_list(list("a"=1))
#> [1] TRUE

csutil::is_all_list_elements_null_or_df(list(data.frame()))
#> [1] TRUE
csutil::is_all_list_elements_null_or_df(list(1, NULL))
#> [1] FALSE

csutil::is_all_list_elements_null_or_list(list(1, NULL))
#> [1] FALSE
csutil::is_all_list_elements_null_or_list(list(list(), NULL))
#> [1] TRUE

csutil::is_all_list_elements_null_or_fully_named_list(list(list(), NULL))
#> [1] FALSE
csutil::is_all_list_elements_null_or_fully_named_list(list(list("a" = 1), NULL))
#> [1] TRUE
```

## Applying a function via hash table

[`apply_fn_via_hash_table()`](https://niphr.github.io/csutil/reference/apply_fn_via_hash_table.md)
extracts the unique values from the input, applies the given function
once per unique value to build a lookup table, then maps the results
back to the original input. When there are many repeated values, this
avoids redundant computation and can be substantially faster than
applying the function element-wise.

``` r
input <- rep(seq(as.Date("2000-01-01"), as.Date("2020-01-01"), 1), 1000)
a1 <- Sys.time()
z <- format(input, "%Y")
a2 <- Sys.time()
a2 - a1
#> Time difference of 2.314204 secs

b1 <- Sys.time()
z <- csutil::apply_fn_via_hash_table(
  input,
  format,
  "%Y"
)
b2 <- Sys.time()
b2 - b1
#> Time difference of 0.3949087 secs
```
