# Intro to csutil

## Splitting

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

## Unnesting data.frames

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

## Apply a function via hash table

This function extracts the unique input values, applies the given
function to it to create a hash table (containing unique input/output
combinations), and then matches the original input to the hash table to
obtain the desired output.

This can dramatically speed up computation if there is a lot of data and
a limited amount of unique values.

``` r
input <- rep(seq(as.Date("2000-01-01"), as.Date("2020-01-01"), 1), 1000)
a1 <- Sys.time()
z <- format(input, "%Y")
a2 <- Sys.time()
a2 - a1
#> Time difference of 2.287873 secs

b1 <- Sys.time()
z <- csutil::apply_fn_via_hash_table(
  input,
  format,
  "%Y"
)
b2 <- Sys.time()
b2 - b1
#> Time difference of 0.3994842 secs
```
