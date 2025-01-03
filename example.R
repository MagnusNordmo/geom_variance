# Plot with geom_variance
library(tidyverse)


# -------------------------------------------------------------------------
# 2) A helper function to simulate two-group data with Cohen's d
# -------------------------------------------------------------------------
make_cohens_d_data <- function(d, n = 100) {
  # Group A: mean=0, sd=1
  grpA <- rnorm(n, mean = 0, sd = 1)
  # Group B: mean=d, sd=1 (so difference in means is d)
  grpB <- rnorm(n, mean = d, sd = 1)
  
  tibble(
    value = c(grpA, grpB),
    group = rep(c("A", "B"), each = n),
    d_label = paste0("Cohen's d = ", d)  # for facet label
  )
}

# -------------------------------------------------------------------------
# 3) Generate data for multiple Cohen's d values
# -------------------------------------------------------------------------
d_values <- c(0.3, 0.6, 0.8, 1.1)
df_all <- lapply(d_values, make_cohens_d_data) |> 
  bind_rows()

# -------------------------------------------------------------------------
# 4) Plot using geom_variance with a professional theme
# -------------------------------------------------------------------------
ggplot(df_all, aes(y = value, color = group)) +
  geom_variance(
    arrangement = "asis",
    size = 2.5,      # Increase point size
    alpha = 0.7,     # Slight transparency helps overlapping points
    stroke = 0.5
  ) +
  facet_wrap(~ d_label, nrow = 2) +
  scale_color_brewer(palette = "Dark2", name = "Group") +
  labs(
    title = "Comparing Two Groups for Various Cohen's d",
    subtitle = "Groups A and B differ by d standard deviations",
    x = "Index",
    y = "Observed Value"
  ) +
  theme_classic(base_size = 14) +
  theme(
    plot.title       = element_text(face = "bold", size = 16),
    plot.subtitle    = element_text(size = 12, margin = margin(b = 10)),
    axis.title.x     = element_text(face = "bold", size = 14),
    axis.title.y     = element_text(face = "bold", size = 14),
    axis.text        = element_text(size = 12),
    axis.line        = element_line(linewidth = 0.5),
    axis.ticks       = element_blank(),   # Hide axis ticks
    legend.position  = "top",             # Move legend on top
    legend.justification = "center",
    panel.spacing    = unit(1, "lines")   # Increase spacing between facets
  )