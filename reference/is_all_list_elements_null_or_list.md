# Are all elements in a list null or lists?

Checks if A) \`x\` is a list, B) All elements in \`x\` are either null
or list.

## Usage

``` r
is_all_list_elements_null_or_list(x)
```

## Arguments

- x:

  An object

## Value

Boolean.

## Examples

``` r
is_all_list_elements_null_or_list(data.frame())
#> [1] FALSE
is_all_list_elements_null_or_list(list(data.frame()))
#> [1] FALSE
is_all_list_elements_null_or_list(list(1, NULL))
#> [1] FALSE
is_all_list_elements_null_or_list(list(list(), NULL))
#> [1] TRUE
is_all_list_elements_null_or_list(list("a"=1, 2))
#> [1] FALSE
```
