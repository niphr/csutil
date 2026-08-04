# csutil <a href="https://niphr.github.io/csutil/"><img src="man/figures/logo.png" align="right" width="120" /></a>

[![CRAN status](https://www.r-pkg.org/badges/version/csutil)](https://cran.r-project.org/package=csutil)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/csutil)](https://cran.r-project.org/package=csutil)

## Overview 

[csutil](https://niphr.github.io/csutil/) contains helpful functions to help with common base-R problems.

Base-R lists are flexible, and that flexibility makes them awkward to check. csutil supplies seven functions: four that answer a yes/no question about the shape of a list, and three that transform a vector or a list. The package defines no S3 classes and keeps no state between calls.

## Installation

```r
install.packages("csutil")

# development version
remotes::install_github("niphr/csutil")
```

## Quick start

```r
library(csutil)

# compute on the distinct values only, then map the answers back
x <- c("oslo", "bergen", "oslo", "tromso", "oslo")
apply_fn_via_hash_table(x, toupper)
#> [1] "OSLO"   "BERGEN" "OSLO"   "TROMSO" "OSLO"

# chop a vector into runs of three
easy_split(1:7, size_of_each_group = 3)
#> $`1`
#> [1] 1 2 3
#>
#> $`2`
#> [1] 4 5 6
#>
#> $`3`
#> [1] 7
```

## Which function do I want?

| Question or task | Function |
| --- | --- |
| Is every element of this list named? | `is_fully_named_list()` |
| Is every element either `NULL` or a data frame? | `is_all_list_elements_null_or_df()` |
| Is every element either `NULL` or a list? | `is_all_list_elements_null_or_list()` |
| Is every element either `NULL` or a fully named list? | `is_all_list_elements_null_or_fully_named_list()` |
| Chop a vector into groups of a fixed size, or into a requested number of groups | `easy_split()` |
| Gather repeated results into one `data.table` per name | `unnest_dfs_within_list_of_fully_named_lists()` |
| Skip repeated work when a long vector holds few distinct values | `apply_fn_via_hash_table()` |

Each of the four questions is answered with `TRUE` or `FALSE`, never `NA`. All four use `inherits(x, "list")` as their entry test, so an object that fails that test answers `FALSE`.

## Documentation

Full reference and articles live at <https://niphr.github.io/csutil/>.

Read the introduction vignette [here](https://niphr.github.io/csutil/articles/csutil.html) or run `help(package="csutil")`.
