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
