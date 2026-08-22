# Intro to csutil

## What csutil is for

Lists in base R are very flexible. That flexibility makes them awkward
to check and awkward to take apart. csutil is a small set of helpers for
four of those awkward jobs:

- splitting a vector into groups;
- pulling data frames out of a nested named list;
- checking what a list actually holds;
- running a function on the unique values of a vector instead of on
  every element.

The package is deliberately tiny. It has seven exported functions and
nothing else.

## The seven functions

**What is in this list?** Four functions answer that question:

- [`is_fully_named_list()`](https://niphr.github.io/csutil/reference/is_fully_named_list.md)
- [`is_all_list_elements_null_or_df()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_df.md)
- [`is_all_list_elements_null_or_list()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_list.md)
- [`is_all_list_elements_null_or_fully_named_list()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_fully_named_list.md)

**Three functions change the data:**

- [`easy_split()`](https://niphr.github.io/csutil/reference/easy_split.md)
  cuts a vector into consecutive groups.
- [`unnest_dfs_within_list_of_fully_named_lists()`](https://niphr.github.io/csutil/reference/unnest_dfs_within_list_of_fully_named_lists.md)
  flattens a list of named lists that hold data frames. Elements that
  share a name are row-bound together.
- [`apply_fn_via_hash_table()`](https://niphr.github.io/csutil/reference/apply_fn_via_hash_table.md)
  computes a result for the unique values of a vector, then maps it back
  to the original vector.

## Two things that surprise people

**[`apply_fn_via_hash_table()`](https://niphr.github.io/csutil/reference/apply_fn_via_hash_table.md)
calls your function once, not once per value.** It hands the whole
vector of unique values over in a single call. Your function MUST
therefore be vectorised. Here is a counter that proves it:

``` r
counter <- new.env()
counter$calls <- 0
counted_toupper <- function(v) {
  counter$calls <- counter$calls + 1
  toupper(v)
}

x <- c("oslo", "bergen", "oslo", "tromso", "oslo")
csutil::apply_fn_via_hash_table(x, counted_toupper)
#> [1] "OSLO"   "BERGEN" "OSLO"   "TROMSO" "OSLO"

length(x)
#> [1] 5
length(unique(x))
#> [1] 3
counter$calls
#> [1] 1
```

Five elements, three unique values, one call.

A function that only handles one value at a time will fail:

``` r
scalar_only <- function(v) {
  if (length(v) != 1) stop("this function handles one value at a time")
  toupper(v)
}

tryCatch(
  csutil::apply_fn_via_hash_table(x, scalar_only),
  error = function(e) conditionMessage(e)
)
#> [1] "this function handles one value at a time"
```

**[`easy_split()`](https://niphr.github.io/csutil/reference/easy_split.md)
can return fewer groups than you asked for.** `number_of_groups` is a
request, not a guarantee. The function works out the group size first,
as `ceiling(length(x) / number_of_groups)`. The number of groups falls
out of that. Ask for three groups from a four-element vector and you get
two:

``` r
csutil::easy_split(1:4, number_of_groups = 3)
#> $`1`
#> [1] 1 2
#> 
#> $`2`
#> [1] 3 4
```

Every group has the same length except the last, which may be shorter.

## Where csutil sits

csdb imports csutil. csutil imports no cs\* package, only data.table and
ggplot2.

## Splitting

[`easy_split()`](https://niphr.github.io/csutil/reference/easy_split.md)
divides a vector into groups. Give it either the target size of each
group or the total number of groups.

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
collapses a list of named lists, each of which holds data frames, into a
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
extracts the unique values from the input. It calls the given function
ONCE, on that whole vector of unique values, to build a lookup table. It
then maps the results back to the original input. Your function MUST
therefore be vectorised, as the counter above shows. When many values
repeat, this avoids redundant computation and can be much faster than
applying the function element by element.

``` r
input <- rep(seq(as.Date("2000-01-01"), as.Date("2020-01-01"), 1), 1000)
a1 <- Sys.time()
z <- format(input, "%Y")
a2 <- Sys.time()
a2 - a1
#> Time difference of 2.329592 secs

b1 <- Sys.time()
z <- csutil::apply_fn_via_hash_table(
  input,
  format,
  "%Y"
)
b2 <- Sys.time()
b2 - b1
#> Time difference of 0.38814 secs
```
