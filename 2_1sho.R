# 1.4
1 + 1
3 -1
3 * 4
8 / 6
2 ^ 10

# 1.5 variable
x <- 2
x + 1

# 1.6 function
sqrt(4)

# 1.7 vector
vector_1 <- c(1, 2, 3, 4, 5)
vector_1
1:10

# 1.8 matrix
matrix_1 <- matrix(
    data = 1:10,     # data
    nrow = 2,       # 2行にする
    byrow = TRUE,   # 行(横)の順番でデータを格納する
)
matrix_1


# 1.9 array
array_1 <- array(
    data = 1:30,
    dim = c(3, 5, 3)    # (行数，列数，行列の数)
)
array_1

# 1.10 data frame
data_frame_1 <- data.frame(
    col1 = c("A", "B", "C", "D", "E"),
    col2 = c(1, 2, 3, 4 ,5)
)
data_frame_1
nrow(data_frame_1)

# 1.11 list
list_1 <- list(
    chara = c("A", "B", "C"),
    matrix = matrix_1,
    df = data_frame_1
)
list_1

# 1.12 データの抽出
# vector
vector_1[1]
# matrix
matrix_1[1, 2]
# array
array_1[1, 2, 1]

# 特定行を取得
matrix_1[1, ]
# 特定列を取得
matrix_1[, 1]
# 特定の範囲を取得
matrix_1[1, 2:4]
dim(matrix_1)
dim(array_1)
dimnames(matrix_1)

# data.frame, 特定の列を抽出
data_frame_1$col2
data_frame_1$col2[2]
head(data_frame_1, n = 2)

# 1.13 時系列データ(ts)
data_frame_2 <- data.frame(
    data = 1:24
)
ts_1 <- ts(
    data_frame_2,       # 対象データ
    start = c(2010, 1),  # 開始年月
    frequency = 12      # 1年におけるデータの数(頻度)
)
ts_1

# 1.14 ファイルからのデータの読み込み
# csvファイルから読み込む
birds <- read.csv("2-1-1-birds.csv")
head(birds, n = 3)

# 1.15 乱数の生成
# 平均0, 標準偏差1のgaussianに従う乱数を1つ
rnorm(n = 1, mean = 0, sd = 1)

set.seed(1)
rnorm(n = 1, mean = 0, sd = 1)

set.seed(1)
rnorm(n = 1, mean = 0, sd = 1)
# 再現性

# 1.16 繰り返し構文とforループ
for (i in 1:3){
    print(i)
}

result_vec_1 <- c(0, 0, 0)
set.seed(1)
for (i in 1:3){
    result_vec_1[i] <- rnorm(n = 1, mean = 0, sd = 1)
}
result_vec_1

result_vec_2 <- c(0, 0, 0)  # 結果を入れる
mean_vec <- c(0, 10, -5)    # meanを指定したvector
set.seed(1)
for (i in 1:3){
    result_vec_2[i] <- rnorm(n = 1, mean = mean_vec[i], sd = 1)
}
result_vec_2

# 外部パッケージの活用
install.packages("tidyverse")
library(tidyverse)