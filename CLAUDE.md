# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Licensing

This package is `MIT + file LICENSE`. Two files carry the licence and
they MUST agree with each other:

- `LICENSE` holds exactly two lines, `YEAR:` and `COPYRIGHT HOLDER:`.
  CRAN requires that shape for `MIT + file LICENSE`. Do not put the
  licence text there.
- `DESCRIPTION` `Authors@R` MUST name the same holder, with
  `role = "cph"`.

The copyright holder for this package is **Folkehelseinstituttet**.

**Check the year at the start of each calendar year, and whenever you
edit `DESCRIPTION`.** Nothing in `R CMD check` tests the copyright year,
so a stale one goes unnoticed indefinitely. A fleet sweep on 2026-08-06
found years of 2021, 2023 and 2025 still in place across 15 packages,
and not one package declared a `cph` role at all.

Check both in one step:

``` r
readLines("LICENSE")
a <- unclass(eval(parse(text = read.dcf("DESCRIPTION")[1, "Authors@R"])))
Filter(function(p) "cph" %in% p$role, a)
```
