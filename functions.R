# Informations ------------------------------------------------------------
# Title: functions.R
# Author: Félix Boudry
# Contact: <felix.boudry@univ-perp.fr>
# License: GPLv3
# Description: File containing all functions used in this repo.

# Plots -------------------------------------------------------------------
## Clusters ---------------------------------------------------------------
hclust_ggplot <- function(clust_data, dataset) {
  plot_df <- clust_data |>
    dendextend::cutree(k = 2L) |>
    subtract(e1 = 1) |>
    as.data.frame() |>
    `colnames<-`("cluster") |> 
    merge(dataset, by = 0) |> 
    dplyr::arrange(factor(Row.names, levels = clust_data$order.lab))

  # Convert hclust to dendrogram
  dend_data <- as.dendrogram(clust_data) |> 
    as.hclust() |> 
    ggdendro::dendro_data()

  # Create a color palette dynamically based on the number of unique values in target
  color_palette <- unique(plot_df$cluster) |> 
    length() |> 
    scales::hue_pal()() # Generate distinct colors
  target_colors <- color_palette[as.numeric(factor(plot_df$cluster))] # Map target to colors

  # Create ggplot dendrogram
  p <- ggplot2::ggplot() +
    ggplot2::geom_segment(
      data = dend_data$segments,
      ggplot2::aes(x = x, y = y, xend = xend, yend = yend),
      linewidth = 0.8, color = "black"
    ) +
      ggplot2::geom_text( #color based on status
      data = dend_data$labels,
      ggplot2::aes(x = x, y = y - 1.5, label = label, color = plot_df$patho),
      size = 3
    ) +
      ggplot2::labs(x = "Clusters", y = NULL) +
      ggplot2::theme(
      axis.text = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      panel.grid = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank()
    ) +
    labs(color = "Patho")

  # Add colored bars
  # Order bar elements to match dendrogramm order (i.e, MC7 and JR10 are last.)
  bar_data <- data.frame(x = 1:length(plot_df$cluster), color = target_colors)
  p <- p + ggplot2::geom_tile(
    data = bar_data,
    ggplot2::aes(x = x, y = -5, fill = color),
    height = 2.5, width = 1
  ) +
    ggplot2::scale_fill_identity()

  return(p)
}
