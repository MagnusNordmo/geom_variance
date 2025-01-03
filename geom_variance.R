library(tidyverse)

# -------------------------------------------------------------------------
# 1) Define the custom Stat: StatVariance with sampling logic
# -------------------------------------------------------------------------
StatVariance <- ggproto(
  "StatVariance", 
  Stat,
  
  required_aes = c("y"),
  default_aes = aes(x = ..x..),
  
  compute_group = function(data, scales, arrangement, plot_all, n_sample) {
    
    # 1) Optional sampling of up to n_sample points per group
    if (!plot_all) {
      n_obs <- nrow(data)
      if (n_obs > n_sample) {
        data <- data[sample(seq_len(n_obs), n_sample), ]
      }
    }
    
    # 2) Reorder or shuffle 'data' based on arrangement
    if (arrangement == "asis") {
      # Keep data "as-is"
      index <- seq_len(nrow(data))
    } else if (arrangement == "randomized") {
      data <- data[sample(seq_len(nrow(data))), ]
      index <- seq_len(nrow(data))
    } else if (arrangement == "hightolow") {
      data <- data[order(-data$y), ]
      index <- seq_len(nrow(data))
    } else if (arrangement == "lowtohigh") {
      data <- data[order(data$y), ]
      index <- seq_len(nrow(data))
    }
    
    # 3) Return a modified data frame with a new 'x' column
    data$x <- index
    data
  }
)

# -------------------------------------------------------------------------
# 2) Define the geom_variance function
# -------------------------------------------------------------------------
geom_variance <- function(
    mapping = NULL, 
    data = NULL, 
    arrangement = c("asis", "randomized", "hightolow", "lowtohigh"),
    plot_all = FALSE,        # New argument: by default, only sample up to 100
    n_sample = 100,          # New argument: the sampling cap
    position = "identity", 
    na.rm = FALSE, 
    show.legend = NA,
    inherit.aes = TRUE, 
    ...
) {
  
  arrangement <- match.arg(arrangement)
  
  layer(
    stat = StatVariance,
    geom = GeomPoint,     
    mapping = mapping,
    data = data,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      arrangement = arrangement,
      plot_all = plot_all,
      n_sample = n_sample,
      na.rm = na.rm,
      ...
    )
  )
}