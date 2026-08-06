# Is this a fully named list?

Checks if \`x\` is a list with each element named.

## Usage

``` r
is_fully_named_list(x)
```

## Arguments

- x:

  An object

## Value

`TRUE` or `FALSE`.

## Details

The empty list is a special case. `is_fully_named_list(list())` returns
`FALSE`, because a fully named list must have at least one element. The
other three predicates in this family return `TRUE` for
[`list()`](https://rdrr.io/r/base/list.html).

## See also

[`vignette("csutil", package = "csutil")`](https://niphr.github.io/csutil/articles/csutil.md),
which runs all four predicates on small example lists.

Other list predicates:
[`is_all_list_elements_null_or_df()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_df.md),
[`is_all_list_elements_null_or_fully_named_list()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_fully_named_list.md),
[`is_all_list_elements_null_or_list()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_list.md)

## Examples

``` r
is_fully_named_list(list())
#> [1] FALSE
is_fully_named_list(list(1))
#> [1] FALSE
is_fully_named_list(list("a"=1))
#> [1] TRUE
is_fully_named_list(list("a"=1, 2))
#> [1] FALSE
```
