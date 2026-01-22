library(dplyr)
library(ggplot2)
library(skimr)
library(purrr)
library(lubridate)

#' Add a time period column to a data frame based on a date column
#' 
#' @param df A data frame
#' @param date_col A string specifying the date column name
#' @param period A string specifying the time period to aggregate by: "month", "quarter", "year"
#'
#' @return Data frame with an additional 'period' column
#' 
#' @examples
#' add_time_period(orders, "order_date", period = "month")
add_time_period <- function(df, date_col, period = "month") {
    df |>
        mutate(
            period = dplyr::case_when(
                period == "month" ~ floor_date(.data[[date_col]], unit = "month"),
                period == "quarter" ~ floor_date(.data[[date_col]], unit = "quarter"),
                period == "year" ~ floor_date(.data[[date_col]], unit = "year"),
            )
        )
}

#' Summarize numeric column over time periods
#' 
#' @param df A data frame with a 'period' column
#' @param numeric_col A string specifying the numeric column name
#' 
#' @return A data frame summarized by time period
#' 
#' @examples
#' summarize_over_time(orders_with_period, "sales")
summarize_over_time <- function(df, numeric_col) {
    df |>
        group_by(period) |>
        summarise(
            mean = mean(.data[[numeric_col]], na.rm = TRUE),
            median = median(.data[[numeric_col]], na.rm = TRUE),
            sd = sd(.data[[numeric_col]], na.rm = TRUE),
            min = min(.data[[numeric_col]], na.rm = TRUE),
            max = max(.data[[numeric_col]], na.rm = TRUE),
            n = n()
        )
}


#' Filter data frame by date range
#' 
#' @param df A data frame
#' @param date_col A string specifying the date column name
#' @param start_date A string or Date object specifying the start date (inclusive)
#' @param end_date A string or Date object specifying the end date (inclusive)
#' 
#' @return Filtered data frame
#' 
#' @examples
#' filter_by_date_range(orders, "order_date", "2020-01-01", "2020-12-31")
filter_by_date_range <- function(df, date_col, start_date = NULL, end_date = NULL) {
    if (!is.null(start_date)) {
        df <- df |> filter(.data[[date_col]] >= as.Date(start_date))
    }
    if (!is.null(end_date)) {
        df <- df |> filter(.data[[date_col]] <= as.Date(end_date))
    }
    df
}


#' Plot time trend of a numeric variable
#' 
#' @param df A data frame with a 'period' column
#' @param y_col A string specifying the numeric column name to plot
#' 
#' @return A ggplot object showing the time trend
#' 
#' @examples
#' plot_time_trend(orders_summary, "mean_sales")
plot_time_trend <- function(df, y_col) {
    ggplot(df, aes(x = period, y = .data[[y_col]])) +
        geom_line() +
        geom_point() +
        labs(
            title = paste("Time Trend of", y_col),
            x = "Time Period",
            y = y_col
        ) +
        theme_minimal()
}