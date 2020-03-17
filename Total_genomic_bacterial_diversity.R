##########################################
## Total Genomic Diversity Calculations ##
##########################################

## Load all necessary libraries
library(vegan)
library(tidyverse)
library(data.table)
library(gdata)
library(ggsignif)

## Set seed for reproducibility

set.seed(123)

## Import datasets

# Presence/absence gene data from pan-genome analysis
cgMatrix <- fread("~/core_genome_total.csv")

# File with samples Ids and origin tag for each sample (WWTP/river)
mapping <-  fread("~/Mapping.csv")

## Calculate jaccard similarity matrix
dist.jac <- vegdist(cgMatrix, method="jaccard", header=FALSE, binary=TRUE, diag=FALSE, upper=FALSE, lower=TRUE)

## Create NMDS
dist.jac.nmds <- metaMDS(dist.jac, try=1000)

## Quickly visualize data
plot(dist.jac.nmds)

## For ggplot it is necessary to retrieve the NMDS scores for x and y coordinates
NMDS_JAC <- as.data.frame(scores(dist.jac.nmds))

## Adding the origin variable
NMDS_JAC$sample_type <- mapping$Origin

## Create a scatter plot colored by origin of the sample
ggplot(NMDS_JAC, aes(NMDS1, NMDS2, color=sample_type)) + geom_point() +
    scale_color_manual(values=c("#9fe8fa", "#fdb87d")) +
    theme_classic() +
    labs(color = "Source")

## Identify the centroid by sample and calculate the mean by origin type
NMDS_JAC_means <- merge(NMDS_JAC,aggregate(cbind(mean.x=NMDS1,mean.y=NMDS2) ~ sample_type, NMDS_JAC, mean), by= "sample_type")

jac_plot<- ggplot(NMDS_JAC_means, aes(NMDS1,NMDS2, color=sample_type)) + geom_point() + # the scatter plot
    geom_segment(aes(x=mean.x, y=mean.y, xend=NMDS1, yend=NMDS2), alpha=0.3) + # the segment from centroid of sample type to points of the same sample type
    geom_point(aes(x=mean.x,y=mean.y),size=3) +
    geom_point(aes(x=mean.x,y=mean.y),size=3, colour="grey45", shape=21) +
    theme_classic() +
    stat_ellipse() +
    labs(color = "Source") +
    scale_color_manual(values=c("#9fe8fa", "#fdb87d"))

jac_plot

## PERMANOVA
adonis(dist.jac ~ Origin, data = mapping)

## Retrieve the Ids to subset distance matrix
river_ids <- filter(mapping,
                    Origin == "river") %>%
  pull(ID)

wwtp_ids <- filter(mapping, 
                   Origin == "WWTP") %>%
  pull(ID)

## Transform to distance matrix and add the Ids as row and column names
dist.jac.matrix <- as.matrix(dist.jac)
colnames(dist.jac.matrix) <- mapping$ID
rownames(dist.jac.matrix) <- mapping$ID

## Since the matrix is simetric, we only need the upper triangle for each of the sources
dist_rivers <- dist.jac.matrix[river_ids, river_ids]
dist_rivers <- upperTriangle(dist_rivers, diag=FALSE)

dist_wwtp <- dist.jac.matrix[wwtp_ids, wwtp_ids]
dist_wwtp <- upperTriangle(dist_wwtp, diag=FALSE)

## Create a data frame with all the distances per each origin type
distance_data_frame <- data.frame(sample_type = c(rep("river", times = length(dist_rivers)),
                  rep("WWTP", times = length(dist_wwtp))),
  distance = c(dist_rivers, dist_wwtp))

## Violine plot with distances
bacteria_violin <- ggplot(distance_data_frame, aes(x = sample_type, y = distance, fill = sample_type)) +
  geom_violin() +
  scale_x_discrete(limits=c("WWTP", "river")) +
  scale_fill_manual(values=c("#9fe8fa", "#fdb87d")) +
  geom_signif(comparisons = list(c("WWTP", "river")),
              map_signif_level = TRUE, textsize=6) +
  geom_boxplot(width=0.05, show.legend = F) +
  scale_x_discrete(limits = c("WWTP", "river"), labels = NULL) +
  xlab("") +
  labs(fill = "Source") +
  theme_classic()
  
bacteria_violin 

## Student t test to compare differences between sample origins
t_test <- t.test(distance ~ sample_type, data = distance_data_frame)
t_test
