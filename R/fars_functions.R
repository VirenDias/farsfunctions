#' Read CSV File
#'
#' This function first checks if the specified comma separated values filename exists,
#' reads it, and finally returns a data frame table.
#'
#' @param filename A character string. The name of the CSV file to be read.
#'
#' @return If the \code{filename} exists, this function will return a dataframe of the
#'    data contained in the CSV file. If the \code{filename} does not exist, the
#'    function will stop executing and return an error message.
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @examples
#' \dontrun{fars_read("accident_2015.csv.bz2")}
#'
#' @export
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}

#' Make CSV Filename
#'
#' This function generates an appropriate accident data CSV filename according to the
#' specified year.
#'
#' @param year A numeric. The year of the accident data.
#'
#' @return This function returns a character vector of the accident data CSV filename
#'    with the specified \code{year}.
#'
#' @examples
#' \dontrun{make_filename(2015)}
#'
#' @export
make_filename <- function(year) {
        year <- as.integer(year)
        file <- sprintf("accident_%d.csv.bz2", year)
        system.file("extdata", file, package="farsfunctions")
}

#' Read Accident Data
#'
#' This function reads accident data for each of the years specified. It then selects
#' just the month and year of each accident and returns a list of data frames for
#' each corresponding year.
#'
#' @param years A numeric vector. The years of accident data to be read.
#'
#' @return This function returns a list of data frames, with each data frame
#'    corresponding to each of the \code{years} specified. The data frames only
#'    contain information about the month and year of each accident that occured. If
#'    the file for any of the specified \code{years} cannot be read, that index will
#'    be returned as null along with an appropriate warning message.
#'
#' @importFrom dplyr mutate select
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{fars_read_years(c(2013, 2014, 2015))}
#'
#' @export
fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select(MONTH, year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#' Summarize Accident Data
#'
#' This function summarizes accident data for the specified years. It returns a data
#' frame table with information about the number of accidents that occurred in each
#' month of each year.
#'
#' @param years A numeric vector. The years of accident data to be summarized.
#'
#' @return This function returns a single data frame. Each year from the \code{years}
#'    specified is allocated a separate column and each month is allocated a separate
#'    row, and each data point represents the total number of accidents that occured
#'    in that corresponding month and year.
#'
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{fars_summarize_years(c(2013, 2014, 2015))}
#'
#' @export
fars_summarize_years <- function(years) {
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(year, MONTH) %>%
                dplyr::summarize(n = n()) %>%
                tidyr::spread(year, n)
}

#' Plot Accident Data
#'
#' This function plots a geographical map of the accidents that occurred in a
#' specified state and a specified year.
#'
#' @param state.num A numeric. The number of the state for accident data to be
#'    plotted.
#' @param year A numeric. The year of the accident data to be plotted.
#'
#' @return This function returns a geographical plot of the specified state, defined
#'    by the \code{state.num}. Accidents are plotted as dots on the map according to
#'    data from the specified \code{year}. Each dot on the map represents one
#'    accident. If the specified \code{state.num} does not exist in the data, the
#'    function will stop executing and return an error message. If there are no
#'    accidents to plot for the specified \code{state.num} and \code{year}, this
#'    function will return a message informing the user of such a case.
#'
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @examples
#' \dontrun{fars_map_state(1, 2015)}
#'
#' @export
fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
