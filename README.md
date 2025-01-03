# geom_variance

A new **ggplot2** extension to visually compare group differences and variability in a way that people can intuitively understand.

Many people struggle to interpret probability density functions (PDFs). While PDFs can accurately communicate statistical information, they often fail to resonate with real-world experiences. By contrast, **geom_variance** mirrors what one would actually “see on the ground.” For instance, a teacher testing a new teaching tool immediately notices how individual students differ in their responses—some respond positively, some less so, and others show minimal difference. The distribution of these individual responses is precisely what **geom_variance** aims to show.

## Overview

- **Present effect sizes in a straightforward manner**: Instead of relying on density curves or boxplots, **geom_variance** plots each observation (or a controlled subset) along an index axis, visually highlighting how groups differ and overlap.  
- **Group-by-group indexing**: Each group is assigned its own x-index from 1 to *n* (the number of observations), letting the viewer see the raw spread of values.  
- **Sampling for large datasets**: By default, **geom_variance** randomly samples 100 points per group to avoid clutter. You can override this and plot all data if needed.  
- **Custom ordering**: Optionally reorder observations in ascending, descending, or random order, or keep the original data order intact.

## Key Features

1. **Intuitive Visual Representation**  
   - Helps audiences grasp variability at a glance.  
   - Ideal when your goal is to show real “data points” rather than stylized summaries.

2. **Sampling Behavior**  
   - **plot_all = FALSE** (default): Plots up to 100 points per group to keep the display manageable.  
   - **plot_all = TRUE**: Plots all data points, useful for smaller datasets or when full transparency is needed.

3. **Reordering Options**  
   - **"asis"**: Keeps the original order of data.  
   - **"randomized"**: Randomly shuffles points within each group.  
   - **"hightolow"**: Sorts observations from largest to smallest.  
   - **"lowtohigh"**: Sorts from smallest to largest.

4. **Integration with the ggplot2 Ecosystem**  
   - Designed as a **stat** + **geom** layer for seamless use in **ggplot2** pipelines.  
   - Supports **color**, **fill**, and other ggplot2 aesthetics.  
   - Facet your data across multiple effect sizes, subgroups, or conditions.
