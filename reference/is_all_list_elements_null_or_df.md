# Are all elements in a list null or data.frames?

Checks if A) \`x\` is a list, B) All elements in \`x\` are either null
or data.frame.

## Usage

``` r
is_all_list_elements_null_or_df(x)
```

## Arguments

- x:

  An object

## Value

Boolean.

## Examples

``` r
is_all_list_elements_null_or_df(data.frame())
#> [1] FALSE
is_all_list_elements_null_or_df(list(data.frame()))
#> [1] TRUE
is_all_list_elements_null_or_df(list(1, NULL))
#> [1] FALSE
is_all_list_elements_null_or_df(list(data.frame(), NULL))
#> [1] TRUE
is_all_list_elements_null_or_df(list("a"=1, 2))
#> [1] FALSE
```
