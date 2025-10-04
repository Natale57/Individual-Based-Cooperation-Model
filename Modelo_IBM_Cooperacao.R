##Parâmetros <- editar esta parte
total_time <- 6000 #Iterações
N <- 500 # Tamanho da população 
C0 <- 0.9 # Densidade inicial de C,os demais sao desertores
repetitions<- 10 # Numero de repetições

##Estruturação dos dados
individuals_data=data.frame(
  name=as.numeric(),
  phenotype=as.character(), 
  group=as.numeric())
output_data=data.frame(
  repetition=as.numeric(),
  iteration=as.numeric(),
  Cooperators=as.numeric(),
  Defectors=as.numeric(),
  Traitors=as.numeric()
)
individuals_data[1:N,]=NA

##IBM
cont_line=0
for (rep in 1:repetitions ){
  C=round(N*C0)
  individuals_data$name=c(1:N)
  individuals_data$phenotype[1:C]="C"
  individuals_data$phenotype[(C+1):N]="NC"
  individuals_data$group=c(1:N)
  total_groups=N
  cont_line=cont_line+1
  output_data[cont_line,]=c(rep,0,C,N-C,0)
  for(t in 1:total_time){
    #Femea escolhe um indivíduo 
    ind=sample(c(1:N),1)
    #Checar grupo e dominante (alfa)
    cond=individuals_data$group==individuals_data$group[ind]&individuals_data$phenotype=="NC"
    ialpha=individuals_data$name[cond] 
    #um indivíduo morre
    ind_die=sample(c(1:N),1)
    if(length(ialpha)>0){ # Dominante é "NC"
      # novo NC nasce <- novo grupo 
      total_groups=total_groups+1
      individuals_data[ind_die,]=c(ind_die, "NC",total_groups)
    }else{
      # novo C nasce <- sorteia um grupo
      id_group=sample(individuals_data$group,1)
      individuals_data[ind_die,]=c(ind_die, "C",id_group)
    }
    #gerar output
    condD=individuals_data$phenotype=="NC"
    D=length(individuals_data$phenotype[condD])
    if(D>0){
      # verificar quantos são Traidores
      groups_D=individuals_data$group[condD]
      cond_C=individuals_data$phenotype=="C"
      cond_group=individuals_data$group%in%groups_D
      T=length(individuals_data$phenotype[cond_C&cond_group])
    }else{
      T=0
    }
    C=N-D-T
    cont_line=cont_line+1
    output_data[cont_line,]=c(rep,t,C,D,T)
  }
}

View(output_data) 
plot(output_data$iteration,output_data$Cooperators, ylim=c(0,N))
points(output_data$iteration,output_data$Defectors, col=2)
points(output_data$iteration,output_data$Traitors, col=3)

write.csv(output_data, file=paste("IBM", C0, "_N",N, "_t", total_time, "_rep", repetitions, "_NULO.csv"))



##Equações Mestras
C=round(N*C0)
D=N-C
Tv=0
output_Master=data.frame(
  iteration=as.numeric(),
  Cooperators=as.numeric(),
  Defectors=as.numeric(),
  Traitors=as.numeric()
)
for(t in 1:total_time){
  Cn=C+(C/N)^2+(Tv-C)/N
  Dn=D+Tv/N
  Tn=Tv+C*(D+Tv)/(N^2)-2*Tv/N
  output_Master[t,]=c(t,C,D,Tv)
  C=Cn
  D=Dn
  Tv=Tn
}
View(output_Master)
points(output_Master$iteration,output_Master$Cooperators, col="grey")
points(output_Master$iteration,output_Master$Defectors, col="pink")
points(output_Master$iteration,output_Master$Traitors, col="darkgreen")




