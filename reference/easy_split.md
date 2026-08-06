# Split a vector into a list of vectors

Splits `x` into a list of consecutive groups. You MUST specify exactly
one of `size_of_each_group` or `number_of_groups`. Neither argument, or
both arguments, is an error.

## Usage

``` r
easy_split(x, size_of_each_group = NULL, number_of_groups = NULL)
```

## Arguments

- x:

  The vector to split.

- size_of_each_group:

  The number of elements in each group. The last group may hold fewer.

- number_of_groups:

  The number of groups you request. The function can return fewer groups
  than you request. See Details.

## Value

A list of vectors, holding the elements of `x` in their original order.
Every element has the same length except the last, which may be shorter.

## Details

Every group has the same length except the last, which may be shorter.
The function preserves the original order of `x`. It names the list
elements `"1"`, `"2"` and so on.

`number_of_groups` is a request, not a guarantee. The function computes
the group size as `ceiling(length(x) / number_of_groups)`. The number of
groups it returns is then
`ceiling(length(x) / ceiling(length(x) / number_of_groups))`. That count
can be smaller than `number_of_groups`. For example,
`easy_split(1:4, number_of_groups = 3)` returns two groups of two.

## See also

[`vignette("csutil", package = "csutil")`](https://niphr.github.io/csutil/articles/csutil.md),
which splits `letters[1:20]` both ways.

## Examples

``` r
easy_split(letters[1:20], size_of_each_group = 3)
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
#> 
easy_split(letters[1:20], number_of_groups = 3)
#> $`1`
#> [1] "a" "b" "c" "d" "e" "f" "g"
#> 
#> $`2`
#> [1] "h" "i" "j" "k" "l" "m" "n"
#> 
#> $`3`
#> [1] "o" "p" "q" "r" "s" "t"
#> 

# number_of_groups is a request: this asks for 3 groups and returns 2
easy_split(1:4, number_of_groups = 3)
#> $`1`
#> [1] 1 2
#> 
#> $`2`
#> [1] 3 4
#> 
```
