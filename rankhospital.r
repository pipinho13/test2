rankhospital<- function (state, outcome, num="best") {

### read oucome data


## check that and outcome are valid

## return hospital name in that stat with lowest 30-day d-rate
outcome_data=read.csv("outcome-of-care-measures.csv", colClass="character")
valid_outcomes<-c("heart attack", "heart failure", "pneumonia")
colindex<-as.numeric(c(11,17,23))
two_column_table<-as.data.frame(cbind(colindex,valid_outcomes))



if(any(unique(outcome_data[,"State"])==state)==FALSE) {stop("invalid state")}
else if(any(valid_outcomes==outcome)==FALSE) {stop("invalid outcome")}

else {

index<-as.numeric(as.vector(two_column_table[two_column_table$valid_outcomes==outcome,1]))
outcome_data<-outcome_data[outcome_data$State==state,]
my_data<-outcome_data[,c(2,7,index)]




output<-my_data[order(as.numeric(my_data[,3]), my_data[,1], na.last=NA),]

if(num=="best") { output<-output[1,1]}
else if (num=="worst") { output<-tail(output[,1], n=1L) } 
else if(length(output[,1])<num) {output<-c(NA)}
else output<-output[num,1]

output



}


}


