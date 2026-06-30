# Apply a function via hash table

Extracts the unique values of `x`, applies `fn` to those unique values,
and maps the results back to the original vector. This avoids redundant
computation when `x` contains many repeated values.

## Usage

``` r
apply_fn_via_hash_table(x, fn, ...)
```

## Arguments

- x:

  A vector whose values need a function applied.

- fn:

  A function to apply to the unique values of `x`.

- ...:

  Additional arguments passed to `fn`.

## Value

A vector of the same length as `x`, containing the result of applying
`fn` to each element (computed via unique-value lookup).

## Details

This can dramatically speed up computation if there is a lot of data and
a limited number of unique values: `fn` is called once per unique value
rather than once per element.

## Examples

``` r
x <- c("a", "b", "a", "c", "b", "a")
apply_fn_via_hash_table(x, toupper)
#> [1] "A" "B" "A" "C" "B" "A"

# passing extra arguments to fn
nums <- c(1.1, 2.2, 1.1, 3.3)
apply_fn_via_hash_table(nums, round, digits = 0)
#> [1] 1 2 1 3
```
