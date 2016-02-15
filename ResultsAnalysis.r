results.analysis.pred.2 <-
function(file){

#-------------------------------------------------------------------------------------------------------
#-------------START OF R-FUNCTION-----------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------
#----Input file needs to have the experimental design and 3 extra columns SENT, RESPONDED and RR--------
#----form is the model in the form c("~sentense+intro+intro/intro1+benefit+sentence*benefit")-----------
#----returns:
#----i)  analysis : the anova table with the p-values
#----ii) glm.mod1.anova : Anova Table for whole effects
#----iii) best.combination : the combination with the best gene values 
#----iv) exp.RR : The expected RR for the best.combination
#----v) ci.low: The lower 95% bound for the confidence interval for the best.comb
#----vi) ci.high: The upper 95% bound for the confidence interval for the best.comb
#----requires car package
#----call: results.analysis(file,form)

options(warn=-1)

require(car)
	
	pivot.table = list()
	for (i in 1:(ncol(file)-3)){
	tmp=cbind(tapply(file$RESPONDED, file[,i], sum), tapply(file$SENT, file[,i],  sum), tapply(file$RESPONDED, file[,i], sum)/tapply(file$SENT, file[,i], sum))
	colnames(tmp)<-c("RESPONDED", "SENT", "RR")
	pivot.table[[i]]=tmp
	}
	names(pivot.table)=names(file[, 1:(ncol(file)-3)])

	BP.comb<-file[1,1:(ncol(file)-3)]
	for (i in 1:(ncol(file)-3)){
	maxlev<-which.max(tapply(file$RESPONDED, file[,i], sum)/tapply(file$SENT, file[,i],  sum))
	file[,i]<-relevel(file[,i],ref=maxlev) 	#Relevel each gene in such a way that the maximum level is the reference level
	BP.comb[[i]]=names(maxlev)		#Define the combination with the best gene values
	}

	#Run GLM LR model
	l.h.s<-c("cbind(RESPONDED, SENT-RESPONDED)")
	formula<-as.formula(paste(l.h.s,"~",paste(head(names(file),-3),collapse="+")))
	glm.mod1<-glm(formula, family=binomial("logit"),data=file)
	analysis<-summary(glm.mod1)

	# Obtain Anova Table for effects
	glm.mod1.anova<-Anova(glm.mod1, test.statistic="LR",error.estimate="deviance")
   
    # Select genes whose p-value is bellow 0.15 to include in the prediction
    genes.to.pred<-rownames(glm.mod1.anova[3])[which(glm.mod1.anova[3]<0.15)]
    
    #Create model and run GLM2
    form.reduced<-paste("~",paste(genes.to.pred,collapse="+"),sep="")
    formula.reduced<-as.formula(paste(l.h.s,form.reduced))
    glm.mod2<-glm(formula.reduced, family=binomial("logit"),data=file)
	analysis2<-summary(glm.mod2)
	# Obtain Anova Table for reduced model effects
	glm.mod2.anova<-Anova(glm.mod2, test.statistic="LR",error.estimate="deviance")

    
     #Obtain the expected RR for the combination of the best gene values
	BP.combination<-as.data.frame(BP.comb)
	BP.predicted.values<- predict(glm.mod2, BP.combination, se=T)
	BP.exp.RR<-max(exp(BP.predicted.values$fit)/(1+exp(BP.predicted.values$fit)))
	
	#Obtain CI for the combination of the best gene values
	BP.sepredval<- BP.predicted.values$se
	BP.loweci<- BP.predicted.values$fit-qnorm(0.975)*BP.predicted.values$se
	BP.upci<- BP.predicted.values$fit+qnorm(0.975)*BP.predicted.values$se
	BP.prlowe<-exp(BP.loweci)/(1+exp(BP.loweci))
	BP.prup<- exp(BP.upci)/(1+exp(BP.upci))

	 #Obtain the expected RR for the BO combination
	BO.row<-which.max(file$RESPONDED/file$SENT)
	BO.combination<-file[BO.row,1:(ncol(file)-3)]
	BO.combination<-as.data.frame(BO.combination)
	BO.predicted.values<- predict(glm.mod1, BO.combination, se=T)
	BO.exp.RR<-max(exp(BO.predicted.values$fit)/(1+exp(BO.predicted.values$fit)))

	#Obtain CI for the BO combination
	BO.sepredval<- BO.predicted.values$se
	BO.loweci<- BO.predicted.values$fit-qnorm(0.975)*BO.predicted.values$se
	BO.upci<- BO.predicted.values$fit+qnorm(0.975)*BO.predicted.values$se
	BO.prlowe<-exp(BO.loweci)/(1+exp(BO.loweci))
	BO.prup<- exp(BO.upci)/(1+exp(BO.upci))

	return (list( analysis = analysis,glm.mod1.anova = glm.mod1.anova,glm.mod2.anova = glm.mod2.anova, best.comb = BP.combination, max.RR = BP.exp.RR, ci.low = BP.prlowe, ci.high = BP.prup,pivots=pivot.table))	
}
