# Split a vector into a list of vectors

Easily split a list into a list of equally sized vectors.

## Usage

``` r
easy_split(x, size_of_each_group = NULL, number_of_groups = NULL)
```

## Arguments

- x:

  The vector to be split

- size_of_each_group:

  If you want to split \`x\` into a number of groups, each of
  \`size_of_each_group\` size

- number_of_groups:

  How many equally sized groups do you want?

## Value

A list containing equally sized vectors.

## Details

You can either specify the length of the list (via \`number_of_groups\`)
or the length of the equally sized vectors within each list element (via
\`size_of_each_group\`). The last element of the list can be shorter
than the other elements.

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
```
