
<!-- README.md is generated from README.Rmd. Please edit that file -->
Coursera Assignment for Building an R Package
=============================================

My build is passing on AppVeyor and Travis!

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/VirenDias/farsfunctions?branch=master&svg=true)](https://ci.appveyor.com/project/VirenDias/farsfunctions)

[![Travis-CI Build Status](https://travis-ci.org/VirenDias/farsfunctions.svg?branch=master)](https://travis-ci.org/VirenDias/farsfunctions)

Installation
------------

You can install farsfunctions from github with:

``` r
# install.packages("devtools")
devtools::install_github("VirenDias/farsfunctions")
```

Reading a CSV File
------------------

To read a CSV file and return a data frame table of the data, you should use the *fars\_read* function. To make things easier, use it in conjunction with the *make\_filename* function and specify the year of data you would like to read.

``` r
fars_read(make_filename(2015))
#> # A tibble: 32,166 x 52
#>    STATE ST_CASE VE_TOTAL VE_FORMS PVH_INVL  PEDS PERNOTMVIT PERMVIT
#>    <int>   <int>    <int>    <int>    <int> <int>      <int>   <int>
#>  1     1   10001        1        1        0     0          0       1
#>  2     1   10002        1        1        0     0          0       1
#>  3     1   10003        1        1        0     0          0       2
#>  4     1   10004        1        1        0     0          0       1
#>  5     1   10005        2        2        0     0          0       2
#>  6     1   10006        1        1        0     0          0       2
#>  7     1   10007        1        1        0     0          0       2
#>  8     1   10008        1        1        0     1          1       1
#>  9     1   10009        1        1        0     0          0       1
#> 10     1   10010        2        2        0     0          0       2
#> # ... with 32,156 more rows, and 44 more variables: PERSONS <int>,
#> #   COUNTY <int>, CITY <int>, DAY <int>, MONTH <int>, YEAR <int>,
#> #   DAY_WEEK <int>, HOUR <int>, MINUTE <int>, NHS <int>, RUR_URB <int>,
#> #   FUNC_SYS <int>, RD_OWNER <int>, ROUTE <int>, TWAY_ID <chr>,
#> #   TWAY_ID2 <chr>, MILEPT <int>, LATITUDE <dbl>, LONGITUD <dbl>,
#> #   SP_JUR <int>, HARM_EV <int>, MAN_COLL <int>, RELJCT1 <int>,
#> #   RELJCT2 <int>, TYP_INT <int>, WRK_ZONE <int>, REL_ROAD <int>,
#> #   LGT_COND <int>, WEATHER1 <int>, WEATHER2 <int>, WEATHER <int>,
#> #   SCH_BUS <int>, RAIL <chr>, NOT_HOUR <int>, NOT_MIN <int>,
#> #   ARR_HOUR <int>, ARR_MIN <int>, HOSP_HR <int>, HOSP_MN <int>,
#> #   CF1 <int>, CF2 <int>, CF3 <int>, FATALS <int>, DRUNK_DR <int>
```

Reading Accident Data Across Multiple Years
-------------------------------------------

To read accident data across multiple years, you should use the *fars\_read\_years* function and specify the years of data you would like to read.

``` r
fars_read_years(c(2013, 2014, 2015))
#> [[1]]
#> # A tibble: 30,202 x 2
#>    MONTH  year
#>    <int> <dbl>
#>  1     1 2013.
#>  2     1 2013.
#>  3     1 2013.
#>  4     1 2013.
#>  5     1 2013.
#>  6     1 2013.
#>  7     1 2013.
#>  8     1 2013.
#>  9     1 2013.
#> 10     1 2013.
#> # ... with 30,192 more rows
#> 
#> [[2]]
#> # A tibble: 30,056 x 2
#>    MONTH  year
#>    <int> <dbl>
#>  1     1 2014.
#>  2     1 2014.
#>  3     1 2014.
#>  4     1 2014.
#>  5     1 2014.
#>  6     1 2014.
#>  7     1 2014.
#>  8     1 2014.
#>  9     1 2014.
#> 10     1 2014.
#> # ... with 30,046 more rows
#> 
#> [[3]]
#> # A tibble: 32,166 x 2
#>    MONTH  year
#>    <int> <dbl>
#>  1     1 2015.
#>  2     1 2015.
#>  3     1 2015.
#>  4     1 2015.
#>  5     1 2015.
#>  6     1 2015.
#>  7     1 2015.
#>  8     1 2015.
#>  9     1 2015.
#> 10     1 2015.
#> # ... with 32,156 more rows
```

Summarizing Accident Data Across Multiple Years
-----------------------------------------------

To summarize accident data across multiple years, you should use the *fars\_summarize\_years* function and specify the years of data you would like to summarize.

``` r
fars_summarize_years(c(2013, 2014, 2015))
#> # A tibble: 12 x 4
#>    MONTH `2013` `2014` `2015`
#>    <int>  <int>  <int>  <int>
#>  1     1   2230   2168   2368
#>  2     2   1952   1893   1968
#>  3     3   2356   2245   2385
#>  4     4   2300   2308   2430
#>  5     5   2532   2596   2847
#>  6     6   2692   2583   2765
#>  7     7   2660   2696   2998
#>  8     8   2899   2800   3016
#>  9     9   2741   2618   2865
#> 10    10   2768   2831   3019
#> 11    11   2615   2714   2724
#> 12    12   2457   2604   2781
```

Plotting Accident Data
----------------------

To plot accident data on a geographical map, you should use the *fars\_map\_state function*, and specify the state number and year of accident data to plot.

``` r
fars_map_state(1, 2015)
```

![](README-unnamed-chunk-5-1.png)
