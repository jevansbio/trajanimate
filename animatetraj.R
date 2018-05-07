
animatetraj=function(trajdf,basezoom){
	require(ggmap)
	for(i in 1:(nrow(trajdf)-1)){
		if(trajdf$dist[i]>0){
				zoom=round(zoom=basezoom-((trajdf$dist[i])))
				if(zoom<2){
					zoom=2
				}
			} else {
				zoom=basezoom
		}
		if(i==1|trajdf$dist[i]>0){
			gotmap=F
			while(gotmap==F){
			
				g1=try(get_map(location=data.frame(trajdf$x[i],trajdf$y[i]),zoom=zoom,maptype = "satellite",messaging=F),T)
				if(class(g1)[1]=="ggmap"){
					m=g1
					gotmap=T
				} else {
					#to avoid overloading google maps API if we fail we wait a bit
					Sys.sleep(5)
				}
			}
			mbb=as.numeric(attributes(m)$bb)
		}
		
		if(i>1){
			m2=ggmap(m,extent="normal")+
			geom_path(data =trajdf[1:i,] , aes(x, y),colour="black",linetype = 2,show.legend=F)+
			geom_point(data =trajdf[i,] , aes(x, y,colour="red",size=1.5),show.legend=F)+
				scale_y_continuous(lim=mbb[c(1,3)],expand = c(0, 0),oob=c)+
				scale_x_continuous(lim=mbb[c(2,4)],expand = c(0,0),oob=c)
		} else {
			m2=ggmap(m)+geom_point(data =trajdf[i,] , aes(x, y,colour="red",size=1.5),show.legend=F)

		}
	

		plot(m2)
	}
}

