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

  A vectorised function, called once on the vector of unique values of
  `x`.

- ...:

  Additional arguments passed to `fn`.

## Value

A vector of the same length as `x`, holding the value of `fn` for each
element (computed via unique-value lookup). The result takes its class
from the value `fn` returns.

## Details

`fn` is called exactly once, on the vector of unique values of `x`. It
is not called once per element, and it is not called once per unique
value either. `fn` must therefore be vectorised: it receives the whole
vector of unique values in a single call.

This can dramatically speed up computation if there is a lot of data and
a limited number of unique values, because the work `fn` does scales
with the number of unique values rather than with the length of `x`.

## See also

[`vignette("csutil", package = "csutil")`](https://niphr.github.io/csutil/articles/csutil.md),
which times this function against a direct call to
[`format()`](https://rdrr.io/r/base/format.html).

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
