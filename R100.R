source('R4.R')
source('R121.R')
library(foreach)

#library(doParallel)
#cl <- makePSOCKcluster(2)
#registerDoParallel(cores=70)

params1 = list(100,0,1.0001,0.5,0.3)
params2 = list(2,1000000000)
N = 10000
calc_data_params_lists_SEQ_WITHFIX(c(N,get_corr_snow_Memory_CRYSTAL,params1),params2,calc_exp42_Snow_Memory,'RData/res_CRYSTAL42-') 
r = get(load(paste('RData/res_CRYSTAL42-',N,'-',paste(params1,collapse='-'),'.RData',sep='')))[[1]]$ts

hist(r,br=100)



N = 3000; p = 0.1
g = graph(edges=c(),n=N,directed=FALSE)
#for(j in 1:10)
for(i in 1:N) if(runif(1)<p) g = g + edge(i,sample(N,1))



