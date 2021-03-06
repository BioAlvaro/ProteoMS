#' Principal Component Analysis of the Intensity values.
#'
#' @param MQCombined Object list containing all the files from the MaxQuant
#' output. It is the result from using \code{make_MQCombined}.
#' @param intensity_type The type of intensity. Values: 'Intensity' or 'LFQ'.
#' @param palette The palette from the Package RColorBrewer. By default is
#' 'Set2'.
#'  Default is Intensity.
#'
#' @return A PCA plot of the Intesities of all the samples.
#' @export
#'
#' @examples
#' MQPathCombined <- system.file("extdata/combined/", package = "MQmetrics")
#' MQCombined <- make_MQCombined(MQPathCombined)
#' PlotPCA(MQCombined)
PlotPCA <- function(MQCombined,
                    intensity_type = "Intensity",
                    palette = "Set2") {
    proteinGroups <- MQCombined$proteinGroups.txt

    PC1 <- PC2 <- Modifications <- variable <- value <- Freq <- NULL

    if (intensity_type == "Intensity") {
        intensities <- proteinGroups %>%
            select(contains("Intensity ") & -contains("LFQ"))
        title <- "PCA of Protein Intensity"
        colnames(intensities) <- gsub(
            pattern = "Intensity",
            "",
            colnames(intensities)
        )
    }

    if (intensity_type == "LFQ") {
        intensities <- proteinGroups %>% select(contains("LFQ intensity "))
        title <- "PCA of Protein LFQ intensities"
        colnames(intensities) <- gsub(
            pattern = "LFQ intensity",
            "",
            colnames(intensities)
        )
        # Error if LFQ Intensity not found.

        if (length(intensities) == 1) {
            print("LFQ intensities not found,
                    changing automatically to Intensity.")

            intensities <- proteinGroups %>%
                select(contains("Intensity ") & -contains("LFQ"))
            colnames(intensities) <- gsub(
                pattern = "Intensity",
                "",
                colnames(intensities)
            )
            title <- "PCA of Protein Intensity"
        }
    }

    if (length(intensities) < 2) {
        cat("Only one sample was analyzed, PCA can not be applied")
    } else if (nrow(proteinGroups) < 2) {
        cat(paste0(
            "PCA can not be performed with only ",
            nrow(proteinGroups),
            " proteins."
        ))
    }

    else {
        intensities_t <- t(intensities)
        # Remove columns with 0 in all the column
        intensities_t <- intensities_t[, colSums(intensities_t != 0) > 0]

        pca <- stats::prcomp(intensities_t, scale = TRUE)

        df_out <- as.data.frame(pca$x)

        df_out$sample <- rownames(df_out)
        rownames(df_out) <- NULL


        colourCount <- length(rownames(df_out))

        getPalette <- colorRampPalette(brewer.pal(8, palette))


        ggplot(df_out, aes(PC1, PC2 ,fill = sample)) +
            geom_point(size = 4.0, color = 'black', shape = 21) +
            geom_text_repel(aes(label = sample))+
            ggtitle(title) +
            theme_bw() +
            theme(legend.position = "none") +
            guides(color = guide_legend(ncol = 3)) +
            scale_fill_manual(values = getPalette(colourCount))
    }
}
