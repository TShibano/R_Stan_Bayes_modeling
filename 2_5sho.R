# 5.2 MCMCの実行
# library
library(rstan)
# 計算の高速化
rstan_options(auto_write = TRUE)    # コンパイルは一度だけ
options(mc.cores = parallel::detectCores()) # 計算を並列化

# データの読み込み
file_beer_sales_1 <- read.csv("2-4-1-beer-sales-1.csv")
head(file_beer_sales_1, n = 3)

# list形式でデータをまとめる
sample_size <- nrow(file_beer_sales_1)
sample_size
data_list <- list(sales = file_beer_sales_1$sales, N = sample_size)
data_list

# Stanと連携してMCMCを実行
mcmc_result <- stan(
    file = "4sho.stan",
    data = data_list, 
    seed = 1,
    chains = 4,
    iter = 2000,
    warmup = 1000,
    thin = 1
)

# 
print(
    mcmc_result,
    probs = c(0.025, 0.5, 0.975)
)
# 5.3 MCMCサンプルの抽出
mcmc_sample <- rstan::extract(mcmc_result, permuted = FALSE)

# クラス, dimention
class(mcmc_sample)
dim(mcmc_sample)    
# -> 1000  4  3   (iter, Chains, parameter)
# 各々の名称
dimnames(mcmc_sample)

# parameter mu のChain1で得られた最初のMCMCサンプル
mcmc_sample[1, "chain:1", "mu"]

# prameter muのChain1で得られたすべてのMCMCサンプル
mcmc_sample[, "chain:1", "mu"]

# 要素数は1000個
length(mcmc_sample[, "chain:1", "mu"])

# 1000 iter x 4 Chain のmatrix
dim(mcmc_sample[, , "mu"])

# MCMCサンプルの代表値の計算
mu_mcmc_vec <- as.vector(mcmc_sample[, , "mu"])

# 事後中央値
median(mu_mcmc_vec)
# 事後期待値
mean(mu_mcmc_vec)
# 95%ベイズ信頼区間
quantile(mu_mcmc_vec, probs = c(0.025, 0.975))

print(
    mcmc_result,
    probs = c(0.025, 0.5, 0.975)
)
# 5.5 トレースプロットの描画
library(ggfortify)
autoplot(ts(mcmc_sample[, , "mu"]), 
         facets = FALSE,  # 4 Chains をまとめて1つのグラフに
         ylab = "mu",
         main = "trace plot"
         )

# 5.6 ggplot2によるposteriorの可視化
# データの整形
mu_df <- data.frame(
  mu_mcmc_sample = mu_mcmc_vec
)
ggplot(data = mu_df, mapping = aes(x = mu_mcmc_sample)) + 
  geom_density(size = 1.5)

# 5.7 bayesplotによるposteriorの可視化
library(bayesplot)
# ヒストグラム
mcmc_hist(mcmc_sample, pars = c("mu", "sigma"))
# カーネル密度推定
mcmc_dens(mcmc_sample, pars = c("mu", "sigma"))
# traceplot
mcmc_trace(mcmc_sample, pars = c("mu", "sigma"))
# posteriorとtrace plotをまとめてplot
mcmc_combo(mcmc_sample, pars = c("mu", "sigma"))

# 5.8 bayesplotによるposteriorの班にの比較
# posteriorの範囲を比較
mcmc_intervals(
  mcmc_sample, pars = c("mu", "sigma"),
  prob = 0.8,         # 太い線の範囲
  prob_outer = 0.95   # 細い線の範囲
)
# 密度を合わせて表示
mcmc_areas(mcmc_sample, pars = c("mu", "sigma"),
           prob = 0.6,          # 薄い青色で塗られた範囲
           prob_outer = 0.99    # 細い線で描画される範囲
           )

# 5.9 bayesplotによるMCMCサンプルの自己相関の評価
# MCMCサンプルのコレログラム
mcmc_acf_bar(mcmc_sample, pars = c("mu", "sigma"))

# 5.11 事後予測チェックの対象となるデータとモデル
# 小動物の発見個体数のモデル化
# ポアソン分布に従うと考えられる
# 今回は正規分布と比較してみる

# 分析対象となるデータ
# 小動物の発見個体数，観測値200点における個体数をデータに
animal_num <- read.csv("2-5-1-animal-num.csv")
head(animal_num, n = 3)

# 5.12 予測分布の考え方

# 5.13  事後予測チェックのためのMCMCの実行
# sample size
library(rstan)
rstan_options(auto_write = TRUE)    # コンパイルは一度だけ
options(mc.cores = parallel::detectCores()) # 計算を並列化

sample_size <- nrow(animal_num)
# list
data_list <- list(animal_num = animal_num$animal_num, N = sample_size)
# MCMCの実行:gaussian model
mcmc_normal <- stan(
    file = "2_5_1_normal_dist.stan",
    data = data_list,
    seed = 1
)
# MCMCの実行:poisson model
mcmc_poisson <- stan(
    file = "2_5_2_poisson_dist.stan",
    data = data_list,
    seed = 1
)
# 5.14 bayesplotによる事後予測チェック
# 事後予測値のMCMCsampleの取得
y_rep_normal <- rstan::extract(mcmc_normal)$pred
y_rep_poisson <- rstan::extract(mcmc_poisson)$pred 

# sample size (nrow(animal_num)) 200
# 4000回文のMCMCsanple
dim(y_rep_normal)

# gaussian model 
y_rep_normal[1, ]

# poisson model
y_rep_poisson[1, ]

# 参考：観測データの分布と事後予測分布の比較
hist(animal_num$animal_num)
hist(y_rep_normal[1, ])
hist(y_rep_poisson[1, ])

# gaussian model
library(bayesplot, help, pos = 2, lib.loc = NULL)
ppc_hist(y = animal_num$animal_num,
         yrep = y_rep_normal[1:5, ])


# poisson model
ppc_hist(y = animal_num$animal_num,
         yrep = y_rep_poisson[1:5, ])

ppc_dens(y = animal_num$animal_num, 
         yrep = y_rep_poisson[1:5, ])