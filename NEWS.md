# Version 2026.7.27

- `.Rbuildignore` now excludes the rendered pkgdown site (`docs/`, `pkgdown/`) so it is not included in the source tarball.
- The four `is_*` list predicates now cross-reference each other via `@family list predicates`.
- Added a `testthat` (edition 3) test suite covering all seven exported functions. The suite pins the shipped behaviour, including the deliberate asymmetry where `is_fully_named_list(list())` returns `FALSE` while the three `is_all_list_elements_null_or_*()` predicates return `TRUE`.

# Version 2023.4.25

- `apply_fn_via_hash_table` extracts the unique input values, applies the given function to it to create a hash table (containing unique input/output combinations), and then matches the original input to the hash table to obtain the desired output. This can dramatically speed up computation if there is a lot of data and a limited amount of unique values.
- Submitted to CRAN

# Version 2022.6.20

- Submitted to CRAN
- Added additional documentation.

# Version 2022.6.8

- Submitted to CRAN
- all_list_elements_null_or_df renamed to is_all_list_elements_null_or_df
- all_list_elements_null_or_list renamed to is_all_list_elements_null_or_list
- all_list_elements_null_or_fully_named_list renamed to is_all_list_elements_null_or_fully_named_list
- split_equal renamed to easy_split

# Version 2022.4.28

- split_equal (Split a vector into a list with equal sized elements)
- is_fully_named_list (Is this a fully named list?)
- all_list_elements_null_or_df (Are all elements in a list null or data.frames?)
- all_list_elements_null_or_list (Are all elements in a list null or lists?)
- all_list_elements_null_or_fully_named_list (Are all elements in a list null or fully named lists?)
- unnest_dfs_within_fully_named_list (Unnest data.frames within fully named list)
