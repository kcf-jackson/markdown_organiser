calendar_dates <- function(year, month) {
    num_days <- function(m) {
        c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)[m]
    }

    s <- seq(num_days(month))
    new_date <- function(day) {
        date <- as.Date(glue::glue("{year}-{month}-{day}"))
        format(date, "%b %d (%a)")
    }
    unlist(Map(new_date, s))
}

calendar_table <- function(year, month) {
    tr <- function(date) glue::glue("| {date} | \t |")
    res <- c("\n### ", "| Date | Plan |", "| --- | --- |",
             unlist(Map(tr, calendar_dates(year, month))))
    paste(res, collapse = "\n")
}

this_year <- function() {
    as.numeric(format(Sys.Date(), "%Y"))
}

this_month <- function() {
    as.numeric(format(Sys.Date(), "%m"))
}

# Example
# cat(calendar_table(2021, 5))
