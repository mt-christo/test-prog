calc_exp42_Snow_Memory = function(n_steps,corr_func,cells_num,x1,x2,x3,x4,x_FIX){

#	foreach(x_fixs = foreach(i=x_FIX[[1]],.combine=c,.packages=c('igraph','foreach'))%do%{ foreach(j=x_FIX[[2]])%do%c(i,j) },.packages=c('igraph','foreach'))%dopar%{
	foreach(x_fixs = foreach(i=x_FIX[[1]],.combine=c)%do%{ foreach(j=x_FIX[[2]])%do%c(i,j) })%dopar%{

		N = cells_num; a = x1; b = x2; d = x3; da = x4
		xx1 = x_fixs[1]; xx2 = x_fixs[2]

		g = graph(edges=c(),n=N,directed=FALSE)

		#res = foreach(i=1:n_steps, .combine=c, .packages=c('igraph','foreach'))%do%{
		res = foreach(i=1:n_steps, .combine=c)%do%{
if(i%%100==0) print(i)

			rnd_As = runif(N)
			rnd_Ps = sample(N,N,replace=TRUE)

			for(k in 1:N) 
				if(rnd_As[k] < a) 
					g = g + edge(k,rnd_Ps[k])

			s = cor2cov(exp(log(0.99999)*s0),  sd_rnd)
			s_r = tryCatch({ rmnorm(1, rp0, s)}, error=function(ex){ s1=make.positive.definite(s, tol=0.001); rmnorm(1, rp0, s1) })

			#idx_corr = cs$membership==which.max(cs$csize)
			#alf = xx1 - 1
			#max_sz = xx2
			#sd_rnd = (1-alf*runif(N,min=0,max=(1-1/max_sz^alf)/alf))^(-1/alf)
			#sd_rnd = N*sd_rnd/sum(sd_rnd)
			
			#s_r = array(0,N)
			#s_r[idx_corr] = rnorm(1)*sd_rnd[idx_corr]
			#s_r[!idx_corr] = rnorm(sum(!idx_corr),sd = sd_rnd[!idx_corr])

			if(max(cs$csize) < N)
				mean(s_r)#/(1-sum(sd_rnd[which(cs$membership==which.max(cs$csize))]))
			else
				NA
		}

		list(ts=res[!is.na(res)], params=c(x1,x2,x3,x4,xx1,xx2))
	}
}


			
