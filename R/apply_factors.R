apply_factors <- function(tables) {

    market_levels <- sort(unique(tables$Orders$market))
    region_levels <- sort(unique(tables$Orders$region))

    tables$Orders <- tables$Orders |>
        mutate(
            ship_mode      = factor(ship_mode, levels = c("First Class", "Standard Class", "Second Class", "Same Day")),
            segment        = factor(segment),
            order_priority = factor(order_priority,levels = c("Low", "Medium", "High", "Critical"), ordered = TRUE),
            category       = factor(category),
            sub_category   = factor(sub_category),
            market         = factor(market, levels = market_levels),
            region         = factor(region, levels = region_levels),
            country        = factor(country),
            state          = factor(state)
        )

    tables$Returns <- tables$Returns |>
        mutate(
            returned = as.integer(returned == "TRUE"),
            market   = factor(market, levels = market_levels)
        )

    tables$People <- tables$People |>
        mutate(
            region = factor(region, levels = region_levels)
        )

    tables
}


# source("R/apply_factors.R")

# tables <- list(
#   Orders   = readr::read_csv("data/processed/Orders.csv"),
#   Returns  = readr::read_csv("data/processed/Returns.csv"),
#   People   = readr::read_csv("data/processed/People.csv")
# )

# tables <- apply_factors(tables)
