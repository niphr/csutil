# Apply a function via hash table

This function extracts the unique input values, applies the given
function to it to create a hash table (containing unique input/output
combinations), and then matches the original input to the hash table to
obtain the desired output.

## Usage

``` r
apply_fn_via_hash_table(x, fn, ...)
```

## Arguments

- x:

  A vector data that needs a function applied to it.

- fn:

  A function that will be applied to x.

- ...:

  Arguments that will be passed to \`fn\`.

## Details

This can dramatically speed up computation if there is a lot of data and
a limited amount of unique values.
