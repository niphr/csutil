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

Boolean.

## See also

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
