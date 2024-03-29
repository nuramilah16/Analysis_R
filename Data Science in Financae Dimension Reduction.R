library(openxlsx)

df <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet="3varb")

# standarisasi variabel (centering dan scaling)
df <- scale(df, center = TRUE, scale = TRUE)
head(df, 3)


# [Contoh | Langkah 2: Menghitung Matrik Korelasi Data](https://academy.dqlab.id/main/livecode/89/173/840)


library(openxlsx)

df <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet="3varb")
df <- scale(df, center = TRUE, scale = TRUE)

cormat <- cor(df)
cormat


# [Contoh | Langkah 3: Menghitung Nilai Eigen dan Vektor Eigen](https://academy.dqlab.id/main/livecode/89/173/841)


library(openxlsx)

df <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet="3varb")
df <- scale(df, center = TRUE, scale = TRUE)

cormat <- cor(df)

eig <- eigen(cormat)
eig


# [Contoh | Langkah 4: Memilih Banyaknya Principal Component](https://academy.dqlab.id/main/livecode/89/173/842)


library(openxlsx)

df <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet="3varb")
df <- scale(df, center = TRUE, scale = TRUE)

cormat <- cor(df)
eig <- eigen(cormat)

round(eig$values/ncol(df),3)
round(cumsum(eig$values/ncol(df)),3)

pr.out <- prcomp(df, scale. = TRUE, center = TRUE)
pr.out
summary(pr.out)

library(factoextra)

fviz_eig(pr.out, addlabels = TRUE)

screeplot(pr.out, type = "line")
abline(h = 1, lty = 3, col = "red")


# [Contoh | Langkah 5: Visualisasi dengan Biplot](https://academy.dqlab.id/main/livecode/89/173/843)


library(openxlsx)

df <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet="3varb")
df <- scale(df, center = TRUE, scale = TRUE)

pr.out <- prcomp(df, scale. = TRUE, center = TRUE)

pr.out$rotation
biplot(pr.out, scale = 0)


# [Contoh | Langkah 6: Menghitung Skor Baru](https://academy.dqlab.id/main/livecode/89/173/844)


library(openxlsx)

df <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet="3varb")
df <- scale(df, center = TRUE, scale = TRUE)

pr.out <- prcomp(df, scale. = TRUE, center = TRUE)

head(df)

df_new <- df %*% pr.out$rotation
df_new[1:6,1:2]


# [Tugas Praktik](https://academy.dqlab.id/main/livecode/89/173/845)


# Panggil library openxlsx untuk membaca file data Excel
library(openxlsx)

# Baca data pada sheet "3varb" dalam file https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx
# dan simpan data dengan nama df_raw
df_raw <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet = "3varb")

# Tampilkan struktur data
str(df_raw)

# Tampilkan beberapa baris observasi dengan fungsi head()
head(df_raw)

# Lakukan analisa PCA dengan fungsi prcomp()
# simpan output dengan nama pr.out
pr.out <- prcomp(df_raw, center = TRUE, scale = TRUE, retx = TRUE)

# Tampilkan komponen output fungsi prcomp()
names(pr.out)

# Tampilkan output PCA
pr.out

# Tampilkan summary dari output PCA
summary(pr.out)

# Gambarkan scree plot
screeplot(pr.out, type = "line")

# Tambahkan garis horizontal sebagai panduan untuk menggunakan kriteria Kaiser
abline(h = 1, col = "red", lty = 3)

# Gambarkan biplot dengan menggunakan fungsi biplot()
biplot(pr.out, scale = 0)


# [Tugas Praktik: 4 Variabel](https://academy.dqlab.id/main/livecode/89/174/852)


# Panggil library openxlsx untuk membaca file data Excel
# [1]
library(openxlsx)

# Baca data pada sheet "csdata" dalam file "https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx"
# dan simpan data dengan nama "csdat_raw"
# [2]
csdat_raw <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet = "csdata")

# Tampilkan struktur data
# [3]
str(csdat_raw)

# Tampilkan beberapa baris observasi dengan fungsi head()
# [4]
head(csdat_raw)

# Tampilkan statistika deskriptif untuk semua variabel dalam data.
# [5]
summary(csdat_raw)

# Gambarkan distribusi Income berdasarkan Dependents
library(ggplot2)
ggplot(csdat_raw, aes(as.factor(dependents), income)) +
  geom_boxplot() + xlab("Dependents") + ggtitle("Boxplot Income Berdasarkan Dependents")

# Pisahkan data untuk traning set dan testing set
# untuk tiap-tiap risk rating

# Catat indeks/ nomor baris untuk tiap-tiap risk rating
index1 <- which(csdat_raw$riskrating == 1)
index2 <- which(csdat_raw$riskrating == 2)

# Lakukan pencatatan indeks untuk risk rating berikutnya
# [6]
index3 <- which(csdat_raw$riskrating == 3)
index4 <- which(csdat_raw$riskrating == 4)
index5 <- which(csdat_raw$riskrating == 5)

# 80% data akan digunakan sebagai traning set.
# [7]
ntrain1 <- round(0.8 * length(index1))
ntrain2 <- round(0.8 * length(index2))
ntrain3 <- round(0.8 * length(index3))
ntrain4 <- round(0.8 * length(index4))
ntrain5 <- round(0.8 * length(index5))

# set seed agar sampling ini bisa direproduksi
set.seed(100)

# sampling data masing-masing rating untuk training set
# [8]
train1_index <- sample(index1, ntrain1)
train2_index <- sample(index2, ntrain2)
train3_index <- sample(index3, ntrain3)
train4_index <- sample(index4, ntrain4)
train5_index <- sample(index5, ntrain5)

# menyimpan data ke dalam testing set
# [9]
test1_index <- setdiff(index1, train1_index)
test2_index <- setdiff(index2, train2_index)
test3_index <- setdiff(index3, train3_index)
test4_index <- setdiff(index4, train4_index)
test5_index <- setdiff(index5, train5_index)

# Menggabungkan hasil sampling masing-masing risk rating ke dalam training set
csdattrain <- do.call("rbind", list(csdat_raw[train1_index,],
                                    csdat_raw[train2_index,], csdat_raw[train3_index,],
                                    csdat_raw[train4_index,], csdat_raw[train5_index,]))
cstrain <- subset(csdattrain, select =
                    -c(contractcode,riskrating))

# Menggabungkan hasil sampling masing-masing risk rating ke dalam testing set
csdattest <- do.call("rbind", list(csdat_raw[test1_index,],
                                   csdat_raw[test2_index,], csdat_raw[test3_index,],
                                   csdat_raw[test4_index,], csdat_raw[test5_index,])) # [10]
cstest <- subset(csdattest,
                 select = -c(contractcode,riskrating)) # [11]

# Menghitung korelasi antar variabel
cor(cstrain)

# Lakukan analisa PCA dengan fungsi prcomp() dan
# simpan output ke dalam obyek dengan nama pr.out
# [12]
pr.out <- prcomp(cstrain, scale = TRUE, center = TRUE)

# Tampilkan output PCA dengan memanggil obyek pr.out
# [13]
pr.out

# Tampilkan summary dari output PCA
# [14]
summary(pr.out)

# Gambarkan scree plot dengan menggunakan fungsi screeplot()
# [15]
screeplot(pr.out, type = "line", ylim = c(0,2))

# Tambahkan garis horizontal sebagai panduan untuk menggunakan kriteria Kaiser
abline(h = 1, lty = 3, col = "red")

# Gambarkan biplot dengan menggunakan fungsi biplot()
# [16]
biplot(pr.out, scale = 0) # draw first 2 principal components


# [Tugas Praktik: 8 Variabel](https://academy.dqlab.id/main/livecode/89/175/859)


# Panggil library openxlsx untuk membaca file data Excel
library(openxlsx)

# Baca data pada sheet "cslarge" dalam file "https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx"
# dan simpan data dengan nama "cslarge_raw"
cslarge_raw <- read.xlsx("https://academy.dqlab.id/dataset/dqlab_pcadata.xlsx", sheet = "cslarge")

# Tampilkan struktur data
str(cslarge_raw)

# Tampilkan beberapa baris observasi dengan fungsi head()
head(cslarge_raw)

# Tampilkan statistika deskriptif untuk semua variabel dalam data frame.
summary(cslarge_raw)

# Gambarkan distribusi income berdasarkan dependents.
library(ggplot2)
ggplot(cslarge_raw, aes(as.factor(dependents), income)) +
  geom_boxplot() + xlab("Dependents") + ggtitle("Boxplot Income Berdasarkan Dependents")

# Gambarkan distribusi debt berdasarkan dependents.
ggplot(cslarge_raw, aes(as.factor(dependents), debt)) +
  geom_boxplot() + xlab("Dependents") + ggtitle("Boxplot Debt Berdasarkan Dependents")

# Pisahkan data untuk traning set dan testing set
# untuk tiap-tiap risk rating

# Catat indeks/ nomor baris untuk tiap-tiap risk rating
index1 <- which(cslarge_raw$riskrating == 1)
index2 <- which(cslarge_raw$riskrating == 2)

# Lakukan pencatatan indeks untuk risk rating berikutnya
index3 <- which(cslarge_raw$riskrating == 3)
index4 <- which(cslarge_raw$riskrating == 4)
index5 <- which(cslarge_raw$riskrating == 5)

# 80% data akan digunakan sebagai traning set.
ntrain1 <- round(0.8 * length(index1))
ntrain2 <- round(0.8 * length(index2))
ntrain3 <- round(0.8 * length(index3))
ntrain4 <- round(0.8 * length(index4))
ntrain5 <- round(0.8 * length(index5))

# set seed agar sampling ini bisa direproduksi
set.seed(100)

# sampling data masing-masing rating untuk training set
train1_index <- sample(index1, ntrain1)
train2_index <- sample(index2, ntrain2)
train3_index <- sample(index3, ntrain3)
train4_index <- sample(index4, ntrain4)
train5_index <- sample(index5, ntrain5)

# menyimpan data ke dalam testing set
test1_index <- setdiff(index1, train1_index)
test2_index <- setdiff(index2, train2_index)
test3_index <- setdiff(index3, train3_index)
test4_index <- setdiff(index4, train4_index)
test5_index <- setdiff(index5, train5_index)

# Menggabungkan hasil sampling masing-masing risk rating ke dalam training set
cslarge_train <- do.call("rbind", list(cslarge_raw[train1_index,],
                                       cslarge_raw[train2_index,], cslarge_raw[train3_index,],
                                       cslarge_raw[train4_index,], cslarge_raw[train5_index,]))
cstrain <- subset(cslarge_train, select = -c(contractcode,riskrating))

# Menggabungkan hasil sampling masing-masing risk rating ke dalam testing set
cslarge_test <- do.call("rbind", list(cslarge_raw[test1_index,],
                                      cslarge_raw[test2_index,], cslarge_raw[test3_index,],
                                      cslarge_raw[test4_index,], cslarge_raw[test5_index,]))
cstest <- subset(cslarge_test, select = -c(contractcode,riskrating))

# Menghitung korelasi antar variabel
cor(cstrain)
# Menggambarkan matrik korelasi dengan ggcorrplot
library(ggcorrplot)
ggcorrplot(cor(cstrain))


# Lakukan analisa PCA dengan fungsi prcomp() dan
# simpan output ke dalam obyek dengan nama pr.out
pr.out <- prcomp(cstrain, scale = TRUE, center = TRUE)

# Tampilkan output PCA dengan memanggil obyek pr.out
pr.out

# Tampilkan summary dari output PCA
summary(pr.out)

# Gambarkan scree plot dengan menggunakan fungsi screeplot()
screeplot(pr.out, type = "line", ylim = c(0,2))

# Tambahkan garis horizontal sebagai panduan untuk menggunakan kriteria Kaiser
abline(h = 1, lty = 3, col = "red")

# Gambarkan biplot dengan menggunakan fungsi biplot()
biplot(pr.out, scale = 0) #draw first 2 principal components

# Gambarkan Principal Component dan risk rating dengan menggunakan
# fungsi autoplot() dari package ggfortify.
library(ggfortify)
autoplot(pr.out, data = cslarge_train, colour = 'riskrating',
         loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3, scale = 0)

# Gambarkan Principal Component dan risk rating dengan menggunakan
# fungsi fviz_pca_ind() package factoextra.
library(factoextra)
fviz_pca_ind(pr.out, label="none", habillage=cslarge_train$riskrating)


# [Contoh](https://academy.dqlab.id/main/livecode/89/179/874)


(A <- as.matrix(data.frame(c(1,0,1),c(0,1,1),c(1,1,0))))
e <- eigen(A)
str(e)
e


# [Tugas Praktik](https://academy.dqlab.id/main/livecode/89/179/875)


# Ketik perintah berikut ini untuk membaca help tentang matriks
?matrix

# Buatlah matriks 3 x 3 dan simpan dengan nama matriks A.
A <- matrix(c(1, 1, 0, 0, -2, 1, 0, 0, 3), nrow = 3, ncol = 3, byrow = TRUE)

# Tuliskan perintah untuk menampilkan matriks A
A

# Tuliskan perintah R untuk menghitung nilai eigen dan vektor eigen
# dan simpanlah hasilnya dalam variable ev
ev <- eigen(A)

# Tuliskan perintah untuk melihat struktur obyek eigen
str(ev)

# Tuliskan perintah untuk melihat hasil output
ev

# Tuliskan perintah untuk mengakses nilai eigen
ev$values

# Tuliskan perintah untuk mengakses vektor eigen
ev$vectors