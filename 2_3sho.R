# 3sho ggplot2によるデータの可視化

library(ggplot2)

fish <- read.csv("2-2-1-fish.csv")
head(fish, n = 3)

# ヒストグラムとカーネル密度推定
# ヒストグラム
ggplot(data = fish, mapping = aes(x = length))  +
    geom_histogram(alpha = 0.5, bins = 20) + 
    labs(title = "histogram")
# カーネル密度推定
ggplot(data = fish, mapping = aes(x = length)) + 
    geom_density(size = 1.5) + 
    labs(title = "kernel density estimation")

# ヒストグラムとカーネル密度推定の重ね合わせ
ggplot(data = fish, mapping = aes(x = length, y = ..density..)) +
    geom_histogram(alpha = 0.5, bins = 20) + 
    geom_density(size = 1.5) + 
    labs(title = "グラフの重ね合わせ")

# グラフの一覧表示
library(gridExtra)
p_hist <- ggplot(data = fish, mapping = aes(x = length)) + 
    geom_histogram(alpha = 0.5, bins = 20) + 
    labs(title = "ヒストグラム")
p_density <- ggplot(data = fish, mapping = aes(x = length)) + 
    geom_density(size = 1.5) + 
    labs(title = "カーネル密度推定")
grid.arrange(p_hist, p_density, ncol = 2)

# 箱ひげ図とバイオリンプロット
# アヤメデータ
head(iris, n=3)
# 箱ひげ図
p_box <- ggplot(data = iris,
                mapping = aes(x = Species, y = Petal.Length)) +
    geom_boxplot() + 
    labs(title = "箱ひげ図")
p_box
# バイオリンプロット：箱ひげの代わりにカーネル密度推定の結果を用いた箱ひげ図
p_violin <- ggplot(data = iris, mapping = aes(x = Species, y = Petal.Length)) + 
    geom_violin() + 
    labs(title = "バイオリンプロット")
p_violin
grid.arrange(p_box, p_violin, ncol = 2)

# 散布図
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color = Species)) + 
    geom_point()

# 折れ線グラフ
# ナイル川データはts(時系列)なので，ggplot2で扱えるようにデータフレーム化する
Nile
# data.frameに変換
nile_data_frame <- data.frame(
    year = 1871:1970, 
    Nile = as.numeric(Nile))
head(nile_data_frame, n = 4)

ggplot(data = nile_data_frame, 
    mapping = aes(x = year, y = Nile)) + 
    geom_line() + 
    labs(title = "")

