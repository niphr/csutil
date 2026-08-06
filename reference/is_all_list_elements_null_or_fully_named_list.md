# Are all elements in a list null or fully named lists?

Checks two things: that \`x\` is a list, and that all elements in \`x\`
are \`NULL\` or fully named lists.

## Usage

``` r
is_all_list_elements_null_or_fully_named_list(x)
```

## Arguments

- x:

  An object

## Value

`TRUE` or `FALSE`.

## Details

A fully named list is a list in which every element has a name.

## See also

[`vignette("csutil", package = "csutil")`](https://niphr.github.io/csutil/articles/csutil.md),
which runs all four predicates on small example lists.

Other list predicates:
[`is_all_list_elements_null_or_df()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_df.md),
[`is_all_list_elements_null_or_list()`](https://niphr.github.io/csutil/reference/is_all_list_elements_null_or_list.md),
[`is_fully_named_list()`](https://niphr.github.io/csutil/reference/is_fully_named_list.md)

## Examples

``` r
is_all_list_elements_null_or_fully_named_list(data.frame())
#> [1] FALSE
is_all_list_elements_null_or_fully_named_list(list(data.frame()))
#> [1] FALSE
is_all_list_elements_null_or_fully_named_list(list(1, NULL))
#> [1] FALSE
is_all_list_elements_null_or_fully_named_list(list(list(), NULL))
#> [1] FALSE
is_all_list_elements_null_or_fully_named_list(list(list("a" = 1), NULL))
#> [1] TRUE
is_all_list_elements_null_or_fully_named_list(list("a"=1, 2))
#> [1] FALSE
```
