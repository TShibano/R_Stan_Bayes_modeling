# 4.2 Stanのインストール

install.packages('rstan', 
                 repos = "https://cloud.r-project.org/",
                 dependencies = TRUE)

pkgbuild::has_build_tools(debug = TRUE)

# サンプルとMCMCサンプルの違い
# サンプル：母集団から標本抽出
# MCMCサンプル：事後分布に従う乱数をえる

# 4.9 分析の準備
# パッケージの読みこみ
library(rstan)
# 計算の高速化
rstan_options(auto_write = TRUE)  # コンパイルは一度だけ
options(mc.cores = parallel::detectCores())  # 計算を並列化する

# 4.10 CSVファイルから分析対象となるデータを読み込む
# data
file_beer_sales_1 <- read.csv("2-4-1-beer-sales-1.csv")
head(file_beer_sales_1)

# 4.11 list形式でデータをまとめる
# サンプルサイズ
sample_size <- nrow(file_beer_sales_1)
sample_size

# listにまとめる
data_list <- list(sales = file_beer_sales_1$sales, N = sample_size)
data_list


# 4.12 Stanと連携してMCMCを実行する
mcmc_result <- stan(
  file = "4sho.stan",  # stan file
  data = data_list,    # 対象data
  seed = 1,            # 乱数のタネ
  chains = 4,          # チェーン数
  iter = 2000,         # 乱数生成の繰り返し数
  warmup = 1000,       # バーンイン期間
  thin = 1             # 間引き数(1なら間引きなし)
)

# 4.13 推定結果を確認する
print(
  mcmc_result, 
  probs = c(0.025, 0.5, 0.975)
)

# 4.14 収束の確認
# n_eff(有効サンプルサイズ)の確認→100くらいあるのが望ましい
# Rhaの確認→1.1未満であるか
# トレースプロット(バーンイン期間なし)
traceplot(mcmc_result)
# トレースプロット(バーンイン期間あり)
traceplot(mcmc_result, inc_warmup = TRUE)

# 4.16 モデルの図式化

install.packages("rlang")
packageVersion("rlang")