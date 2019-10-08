# 2sho
# import data
fish <- read.csv("2-2-1-fish.csv")
head(fish)
hist(fish$length)

# kernel density estimation
kernel_density <- density(fish$length)
plot(kernel_density)

# band haba wo adjust bai ni henko
kernel_density_quarter <- density(fish$length, adjust = 0.25)
kernel_density_quadruple <- density(fish$length, adjust = 4)
plot(kernel_density, 
    lwd = 2,                   # sen no hutosa
    xlab = "",                 # x label
    ylim = c(0, 0.26),         # y jiku no hanni
    main = "band haba wo kaeru")    # title of graph
lines(kernel_density_quarter, col = 2)
lines(kernel_density_quadruple, col = 4)
# hanrei wo tuika
legend("topleft",
       col = c(1, 2, 4),
       lwd = 1,
       bty = "n",
       legend = c("x1", "x1/4", "x4"))
お
# 2.4
mean(fish$length)

# 2.5 中央値，四分位点，パーセント点
suretu <- 0:1000
suretu
length(suretu)
median(suretu)
quantile(suretu, probs = c(0.5))
quantile(suretu, probs = seq(0, 1, 0.25))
quantile(suretu, probs = c(0.05, 0.95))

# 2.6 ピアソンの積立相関係数
birds <- read.csv("2-1-1-birds.csv")
head(birds)
cor(birds$body_length, birds$feather_length)

# 2.7 自己共分散・自己相関係数・コレログラム
Nile   # 組み込みデータ
# 標本自己共分散
acf(
    Nile,
    type = "covariance",   # default is 自己相関
    plot = F,   # グラフは非表示
    lag.max = 5
)
# 標本自己相関係数
acf(
    Nile,
    plot = FALSE,
    lag.max = 5
)
# コレログラム：次数別の自己相関を可視化したもの
acf(Nile)