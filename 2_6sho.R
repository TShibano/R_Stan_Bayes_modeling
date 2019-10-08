# 6.8 平均値の差の評価とgenerated quantitiesブロック
library(ggplot2)
# 分析対象のデータ読み込み
file_beer_sales_ab <- read.csv("2-6-1-beer-sales-ab.csv")
head(file_beer_sales_ab, n = 3)

# beerの種別のhistgram
ggplot(data = file_beer_sales_ab,
       mapping = aes(x = sales, y = ..density.., 
                     color = beer_name, fill = beer_name)) + 
    geom_histogram(alpha = 0.5, position = "identity") + 
    geom_density(alpha = 0.5, size = 0)

# beerの種別にデータを分ける
sales_a <- file_beer_sales_ab$sales[1:100]
sales_b <- file_beer_sales_ab$sales[101:200]

# listにまとめる
data_list_ab <- list(
    sales_a = sales_a,
    sales_b = sales_b,
    N = 100
)

mcmc_result_6 <- stan(
    file = "2_6_5_difference_mean.stan",
    data = data_list_ab,
    seed = 1
)

print(
    mcmc_result_6,
    probs = c(0.025, 0.5, 0.975)
)

library(bayesplot)
mcmc_sample <- rstan::extract(mcmc_result_6, permuted = FALSE)
mcmc_dens(mcmc_sample, pars = "diff")