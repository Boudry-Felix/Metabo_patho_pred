# Informations ------------------------------------------------------------
# Title: functions.R
# Author: Félix Boudry
# Contact: <felix.boudry@univ-perp.fr>
# License: GPLv3
# Description: File containing all functions used in this repo.

# Plots -------------------------------------------------------------------
## Clusters ---------------------------------------------------------------
hclust_plot <- function(clust_data, target) {
  clust_data <- as.dendrogram(clust_data)
  clust_color <- ifelse(target == 1, "skyblue", "orange")
  par(mar = c(8, 2, 2, 2))

  clust_data %>%
    dendextend::set("labels_col",
                    value = c("skyblue", "orange"),
                    k = 2) %>%
    dendextend::set("branches_k_color",
                    value = c("skyblue", "orange"),
                    k = 2) %>%
    dendextend::set("leaves_pch", 15)  %>%
    dendextend::set("nodes_cex", 0.4) %>%
    dendextend::set("labels_cex", 0.6) %>%
    plot(axes = FALSE)

  dendextend::colored_bars(
    colors = clust_color,
    dend = clust_data,
    rowLabels = "Patho",
    text_shift = 1
  )
  grDevices::recordPlot()
}

## Tables -----------------------------------------------------------------
draw_confusion_matrix <- function(cm) {
  # https://stackoverflow.com/a/42940553/20203361
  layout(matrix(c(1, 1, 2)))
  par(mar = c(2, 2, 2, 2))
  plot(
    c(100, 345),
    c(300, 450),
    type = "n",
    xlab = "",
    ylab = "",
    xaxt = 'n',
    yaxt = 'n'
  )
  title('CONFUSION MATRIX', cex.main = 2)

  # create the matrix
  rect(150, 430, 240, 370, col = '#3F97D0')
  text(195, 435, 'Class1', cex = 1.2)
  rect(250, 430, 340, 370, col = '#F7AD50')
  text(295, 435, 'Class2', cex = 1.2)
  text(125,
       370,
       'Predicted',
       cex = 1.3,
       srt = 90,
       font = 2)
  text(245, 450, 'Actual', cex = 1.3, font = 2)
  rect(150, 305, 240, 365, col = '#F7AD50')
  rect(250, 305, 340, 365, col = '#3F97D0')
  text(140, 400, 'Class1', cex = 1.2, srt = 90)
  text(140, 335, 'Class2', cex = 1.2, srt = 90)

  # add in the cm results
  res <- as.numeric(cm$table)
  text(195,
       400,
       res[1],
       cex = 1.6,
       font = 2,
       col = 'white')
  text(195,
       335,
       res[2],
       cex = 1.6,
       font = 2,
       col = 'white')
  text(295,
       400,
       res[3],
       cex = 1.6,
       font = 2,
       col = 'white')
  text(295,
       335,
       res[4],
       cex = 1.6,
       font = 2,
       col = 'white')

  # add in the specifics
  plot(
    c(100, 0),
    c(100, 0),
    type = "n",
    xlab = "",
    ylab = "",
    main = "DETAILS",
    xaxt = 'n',
    yaxt = 'n'
  )
  text(10, 85, names(cm$byClass[1]), cex = 1.2, font = 2)
  text(10, 70, round(as.numeric(cm$byClass[1]), 3), cex = 1.2)
  text(30, 85, names(cm$byClass[2]), cex = 1.2, font = 2)
  text(30, 70, round(as.numeric(cm$byClass[2]), 3), cex = 1.2)
  text(50, 85, names(cm$byClass[5]), cex = 1.2, font = 2)
  text(50, 70, round(as.numeric(cm$byClass[5]), 3), cex = 1.2)
  text(70, 85, names(cm$byClass[6]), cex = 1.2, font = 2)
  text(70, 70, round(as.numeric(cm$byClass[6]), 3), cex = 1.2)
  text(90, 85, names(cm$byClass[7]), cex = 1.2, font = 2)
  text(90, 70, round(as.numeric(cm$byClass[7]), 3), cex = 1.2)

  # add in the accuracy information
  text(30, 35, names(cm$overall[1]), cex = 1.5, font = 2)
  text(30, 20, round(as.numeric(cm$overall[1]), 3), cex = 1.4)
  text(70, 35, names(cm$overall[2]), cex = 1.5, font = 2)
  text(70, 20, round(as.numeric(cm$overall[2]), 3), cex = 1.4)
}

.replace.by.lod <- function(x) {
  # MetaboAnalyst: https://github.com/xia-lab/MetaboAnalystR/blob/d2272aa77cfd292f07c00d6baecc59880c4b3ed1/R/general_misc_utils.R#L8C1-L23C2
  lod <- min(x[x > 0], na.rm = T) / 5
  x[x == 0 | is.na(x)] <- lod
  return(x)
}

ReplaceMissingByLoD <- function(int.mat) {
  # MetaboAnalyst: https://github.com/xia-lab/MetaboAnalystR/blob/d2272aa77cfd292f07c00d6baecc59880c4b3ed1/R/general_misc_utils.R#L8C1-L23C2
  int.mat <- as.matrix(int.mat)
  rowNms <- rownames(int.mat)
  colNms <- colnames(int.mat)
  int.mat <- apply(int.mat, 2, .replace.by.lod)
  rownames(int.mat) <- rowNms
  colnames(int.mat) <- colNms
  return(as.data.frame(int.mat))
}
