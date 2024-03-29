library(readr)

chocolates <- 
  read_csv(
    "https://dqlab-dataset.s3-ap-southeast-1.amazonaws.com/chocolates.csv",
    col_types = cols(
      panelist = col_factor(),
      session = col_factor(),
      rank = col_factor(),
      product = col_factor(levels = paste0("choc", 1:6)),
      .default = col_integer()
    )
  )
chocolates


# [Mengenal Data - Part 2: Eksplorasi Struktur Data](https://academy.dqlab.id/main/livecode/281/513/2520)


install.packages("skimr",repos = "http://cran.us.r-project.org")
library(skimr)

skim(chocolates)


# [Mengenal Data - Part 3](https://academy.dqlab.id/main/livecode/281/513/2521)


library(dplyr)

chocolates %>% 
  summarise(
    sample = toString(levels(product)),
    n_sample = n_distinct(product),
    n_panelist = n_distinct(panelist)
  )

n_sample <- 6
n_panelist <- 29


# [Mengenal Data - Part 4](https://academy.dqlab.id/main/livecode/281/513/2522)


ncol(chocolates) - 4
atribut_sensoris <- colnames(chocolates[-c(1, 2, 3, 4)])
atribut_sensoris


# [Mengenal Data - Part 5](https://academy.dqlab.id/main/livecode/281/513/2523)


install.packages("skimr",repos = "http://cran.us.r-project.org")
library(skimr)
library(dplyr)

chocolates %>%
  select(atribut_sensoris) %>%
  skim_without_charts()

batas_bawah <- 0
batas_atas <- 10


# [Dari Satu Sisi - Part 1](https://academy.dqlab.id/main/livecode/281/513/2525)


model_bitterness <- aov(bitterness ~ product + panelist + 
                          session + panelist:product + panelist:session + 
                          product:session + rank, data = chocolates)

model_bitterness


# [Dari Satu Sisi - Part 2](https://academy.dqlab.id/main/livecode/281/513/2526)


anova(model_bitterness)


# [Dari Satu Sisi - Part 3](https://academy.dqlab.id/main/livecode/281/513/2527)


summary.lm(model_bitterness)
-1.74 # dua digit di belakang koma/titik


# [Dari Satu Sisi - Part 6](https://academy.dqlab.id/main/livecode/281/513/2530)


library(FactoMineR)

res_bitterness <- AovSum(model_bitterness)

anova(model_bitterness)

res_bitterness$Ftest


# [Dari Satu sisi - Part 7](https://academy.dqlab.id/main/livecode/281/513/2531)


res_bitterness$Ttest[1:7, 1:2]
c("choc1", "choc4", "choc2", "choc5", "choc6", "choc3")


# [Dari Satu Sisi - Part 8](https://academy.dqlab.id/main/livecode/281/513/2532)


install.packages('agricolae ', repos="http://cran.rstudio.com/")
library(agricolae )

posthoc_bitterness  <- HSD.test(model_bitterness, trt = "product")
posthoc_bitterness$groups


# [Dari Satu Sisi - Part 9](https://academy.dqlab.id/main/livecode/281/513/2533)


install.packages('agricolae', repos="http://cran.rstudio.com/")
library(agricolae)

posthoc_bitterness$groups

plot.group(posthoc_bitterness, variation = "SE")


# [Tak Cukup Satu Sisi - Part 2](https://academy.dqlab.id/main/livecode/281/513/2536)


library(dplyr)
library(corrplot)

chocolates2 <- chocolates %>% 
  select(atribut_sensoris) %>% 
  cor() %>% 
  corrplot(
    type = "upper",
    method = "square",
    diag = FALSE,
    addgrid.col = FALSE,
    order = "FPC", 
    tl.col = "gray30", 
    tl.srt = 30
  )
chocolates2


# [Tak Cukup Satu Sisi - Part 4](https://academy.dqlab.id/main/livecode/281/513/2538)


chocolates_adjmean <- readRDS("chocolates_adjmean.rds")
chocolates_adjmean
dim(chocolates_adjmean)


# [Tak Cukup Satu Sisi - Part 5](https://academy.dqlab.id/main/livecode/281/513/2539)


library(FactoMineR)

chocolates_pca <- PCA(chocolates_adjmean, graph = FALSE)
names(chocolates_pca)
chocolates_pca$eig


# [Tak Cukup Satu Sisi - Part 6](https://academy.dqlab.id/main/livecode/281/513/2540)


library(factoextra)

fviz_eig(chocolates_pca, choice = "eigenvalue", addlabels = TRUE)
fviz_eig(chocolates_pca, choice = "variance", addlabels = TRUE)


# [Tak Cukup Satu Sisi - Part 7](https://academy.dqlab.id/main/livecode/281/513/2541)


library(factoextra)

fviz_pca_ind(chocolates_pca, repel = TRUE)


# [Tak Cukup Satu Sisi - Part 8](https://academy.dqlab.id/main/livecode/281/513/2542)


library(factoextra)

fviz_pca_ind(chocolates_pca, repel = TRUE)

choc2 <- FALSE
choc3 <- TRUE
choc4 <- FALSE
choc5 <- FALSE
choc6 <- TRUE


# [Tak Cukup Satu Sisi - Part 9](https://academy.dqlab.id/main/livecode/281/513/2543)


library(factoextra)

fviz_pca_var(chocolates_pca, repel = TRUE)


# [Tak Cukup Satu Sisi - Part 10](https://academy.dqlab.id/main/livecode/281/513/2544)


library(factoextra)

fviz_pca_var(chocolates_pca, repel = TRUE)
"sticky"
"crunchy"


# [Tak Cukup Satu Sisi - Part 11](https://academy.dqlab.id/main/livecode/281/513/2545)


library(factoextra)

fviz_pca_biplot(chocolates_pca, repel = TRUE, title = "Peta Persepsi Produk Cokelat Komersial")


# [Pembukaan - Part 1](https://academy.dqlab.id/main/livecode/281/514/2547)


FALSE


# [Pembukaan - Part 2](https://academy.dqlab.id/main/livecode/281/514/2560)


TRUE


# [Konsistensi](https://academy.dqlab.id/main/livecode/281/514/2548)


metode_riset <- TRUE
kolom_panelis <- TRUE
jumlah_panelis <- TRUE
kolom_sampel <- TRUE
nama_sampel <- FALSE
jumlah_sampel <- TRUE
kolom_atribut_sensoris <- TRUE
jumlah_atribut_sensoris <- TRUE
informasi_hedonik <- TRUE
model_statistik <- FALSE


# [Dari Satu Sisi: ala SenseHub - Part 1](https://academy.dqlab.id/main/livecode/281/514/2549)


"Cochran's Q test" <- FALSE
"Analysis of variance" <- TRUE
"Chi-square test" <- FALSE


# [Dari Satu Sisi: ala SenseHub - Part 2](https://academy.dqlab.id/main/livecode/281/514/2550)


"Dotplot" <- FALSE
"Radar Plot" <- TRUE
"Dumbell Plot" <- FALSE
"Spider Plot" <- TRUE


# [Tak Cukup Satu Sisi: ala SenseHub - Part 1](https://academy.dqlab.id/main/livecode/281/514/2551)


5


# [Tak Cukup Satu Sisi: ala SenseHub - Part 2](https://academy.dqlab.id/main/livecode/281/514/2552)


96.4 # tanpa penanda persen (%)
