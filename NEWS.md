# Version 2026.8.6

- The `csutil` vignette now opens with a get-started overview. pkgdown promotes `vignettes/csutil.Rmd` to "Get started", and that page previously began at `## Splitting` with no statement of what the package is for.
- The overview states what csutil is for, groups all seven exports by the question they answer, and records where csutil sits: `csdb` imports `csutil`, and `csutil` imports no cs* package.
- The overview demonstrates two behaviours that surprise people, both with executed output. `apply_fn_via_hash_table()` calls `fn` once on the whole vector of unique values, so a scalar-only `fn` errors. `easy_split()` can return fewer groups than requested — `easy_split(1:4, number_of_groups = 3)` returns two.
- No existing vignette section was changed or reordered.

# Version 2026.8.4

- `.Rbuildignore` now excludes `index.md` and `Rplots.pdf`, so the pkgdown home page body no longer ships in the source tarball and no longer raises a top-level-file `NOTE`.
- Expanded `README.md` with installation, a quick start, and a table naming which function to reach for.
- Every exported function now carries an `@seealso` pointing at the `csutil` vignette. All seven appear in a vignette code chunk.
- Corrected `apply_fn_via_hash_table()`: the documentation said `fn` was called once per unique value. It is called exactly once, on the whole vector of unique values, so `fn` must be vectorised.
- Corrected `easy_split()`: the documentation promised "equally sized vectors". Every group has the same length except the last, which may be shorter. `number_of_groups` is also a request rather than a guarantee — `easy_split(1:4, number_of_groups = 3)` returns two groups, not three.
- Corrected `unnest_dfs_within_list_of_fully_named_lists()`: it returns `NULL` when `x` is not a list, which the `@return` section did not say. Documented both branches and the sorted-union naming of the result.
- Documented that `is_fully_named_list(list())` returns `FALSE`.

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
