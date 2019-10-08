//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int N;
  vector[N] sales;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real mu; // mean
  real<lower=0> sigma;  // sd
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  // 平均mu, 標準偏差sigmaのgaussianにしたがってデータが得られたと仮定
  //for (i in 1:N){
    //sales[i] ~ normal(mu, sigma);
  //}
  // ベクトル化した書き方
  sales ~ normal(mu, sigma);
}

