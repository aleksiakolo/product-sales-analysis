library(dplyr)
library(ggplot2)
library(skimr)
library(purrr)

#' Join two data frames with specified join type
#'
#' @param df_left Left data frame
#' @param df_right Right data frame
#' @param by A character vector of variables to join by
#' @param type Type of join: "left", "inner", "right", "full"
#' 
#' @return Joined data frame
#' 
#' @examples
#' join_tables(orders, returns, by = "order_id", type = "inner")
join_tables <- function(df_left, df_right, by, type = "left") {
    switch(type,
        left  = left_join(df_left, df_right, by = by),
        inner = inner_join(df_left, df_right, by = by),
        right = right_join(df_left, df_right, by = by),
        full  = full_join(df_left, df_right, by = by)
    )
}

#' Filter a data frame by categorical values. Each filter is applied using `%in%`, allowing multiple values per column.
#'
#' @param df A data frame or tibble to be filtered.
#' @param filters A named list where:
#'   - names correspond to column names in `df`
#'   - values are vectors of allowed values for that column
#'
#' @return A filtered data frame.
#'
#' @examples
#' filter_by_categories(
#'   orders,
#'   list(region = c("West", "East"), segment = "Consumer")
#' )
filter_by_categories <- function(df, filters = list()){
    for (col in names(filters)) {
        df <- df %>% filter(.data[[col]]) %in% filters[[col]]
    }
    df
}

#' Compute summary statistics for a single numeric column
#'
#' Calculates mean, median, standard deviation, minimum, maximum,
#' and number of observations for a numeric variable.
#'
#' @param df A data frame containing the numeric column.
#' @param numeric_col A string specifying the numeric column name.
#'
#' @return A tibble with summary statistics.
#'
#' @examples
#' numeric_summary_single(orders, "sales")
numeric_summary_single <- function(df, numeric_col) {
    df %>%
        summarise(
            mean   = mean(.data[[numeric_col]], na.rm = TRUE),
            median = median(.data[[numeric_col]], na.rm = TRUE),
            sd     = sd(.data[[numeric_col]], na.rm = TRUE),
            min    = min(.data[[numeric_col]], na.rm = TRUE),
            max    = max(.data[[numeric_col]], na.rm = TRUE),
            n      = n()
        )
}

#' Compute summary statistics for multiple numeric columns
#'
#' Calculates mean, median, standard deviation, minimum, maximum,
#' and number of observations for each numeric variable in the list.
#'      
#' @param df A data frame containing the numeric columns.
#' @param numeric_cols A character vector specifying the numeric column names.
#'
#' @return A tibble with summary statistics for each numeric column.
#' 
#' @examples
#' numeric_summary_multiple(orders, c("sales", "profit"))
numeric_summary_multiple <- function(df, numeric_cols) {
    bind_rows(
        lapply(numeric_cols, function(col) {
            numeric_summary_single(df, col) %>%
                mutate(variable = col)
        })
    ) %>%
        relocate(variable)
}

#' Create a boxplot for a numeric variable grouped by a categorical variable
#'  
#' @param df A data frame containing the data to plot.
#' @param x_cat A string specifying the categorical variable for the x-axis.
#' @param y_num A string specifying the numeric variable for the y-axis.
#' 
#' @return A ggplot2 boxplot object.
#' 
#' @examples
#' boxplot_numeric(orders, "region", "sales")
boxplot_numeric <- function(df, x_cat, y_num) {
    ggplot(df, aes(x = .data[[x_cat]], y = .data[[y_num]])) +
        geom_boxplot() +
        labs(x = x_cat, y = y_num) +
        theme_minimal()
}

#' Plot distribution of a numeric variable using histogram
#' 
#' @param df A data frame containing the data to plot.
#' @param numeric_col A string specifying the numeric variable to plot.
#' @param bins Number of bins for the histogram (default is 30).
#' 
#' @return A ggplot2 histogram object.
#' 
#' @examples
#' plot_distribution_hist(orders, "sales", bins = 20)
plot_distribution_hist <- function(df, numeric_col, bins=30) {
    ggplot(df, aes(x = .data[[numeric_col]])) +
        geom_histogram(bins = bins, fill = "blue", color = "black", alpha = 0.7) +
        labs(x = numeric_col, y = "Count") +
        theme_minimal()
}


#' Plot distribution of a numeric variable using density plot
#' 
#' @param df A data frame containing the data to plot.
#' @param numeric_col A string specifying the numeric variable to plot.
#' 
#' @return A ggplot2 density plot object.
#' 
#' @examples
#' plot_distributiopn_density(orders, "sales")
plot_distribution_density <- function(df, numeric_col) {
    ggplot(df, aes(x = .data[[numeric_col]])) +
        geom_density(fill = "green", alpha = 0.5) +
        labs(x = numeric_col, y = "Density") +
        theme_minimal()
}