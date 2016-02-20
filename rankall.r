rankall<- function (outcome, num="best") {
if (num=="best") {num<-1} else {num}


### read oucome data


## check that and outcome are valid

## return hospital name in that stat with lowest 30-day d-rate
outcome_data=read.csv("outcome-of-care-measures.csv", colClass="character")
valid_outcomes<-c("heart attack", "heart failure", "pneumonia")
colindex<-as.numeric(c(11,17,23))
two_column_table<-as.data.frame(cbind(colindex,valid_outcomes))



if(any(valid_outcomes==outcome)==FALSE) {stop("invalid outcome")}

else {

index<-as.numeric(as.vector(two_column_table[two_column_table$valid_outcomes==outcome,1]))

my_data<-outcome_data[,c(2,7,index)]


if(num=="worst") 
				{
				my_ranked_data<-  cbind(my_data, rank=ave(as.numeric(my_data[,3]), my_data$State, FUN= function(x) rank(x, na.last="keep", ties.method="min")))

				my_cleaned_data<-my_ranked_data[complete.cases(my_ranked_data$rank),]





				alphabeticrank<-  cbind(my_cleaned_data, alphabetic=ave(my_cleaned_data$Hospital.Name, my_cleaned_data$State, my_cleaned_data$rank, FUN= function(x) rank(x, na.last="keep", ties.method="min")))
				dummy<-cbind(alphabeticrank,as.numeric(as.vector(alphabeticrank[,4]))+as.numeric(as.vector(alphabeticrank[,5])))
				names(dummy)[6]<-c("dummy_value")
				final_rank<- cbind(dummy, final_rank=ave(dummy$dummy_value, dummy$State, FUN= function(x) rank(-x, na.last="keep", ties.method="min"))) ###ede kanw opposite ranking
				k<-final_rank[final_rank$final_rank==1,]


				all_states<-data.frame(cbind(unique(outcome_data$State) ,rep(NA, length(unique(outcome_data$State)))))
				colnames(all_states)<-c("State", "hospital")


				output<-merge(x = all_states, y = k, by = "State", all.x = TRUE)

				}

else

				{


				my_ranked_data<-  cbind(my_data, rank=ave(as.numeric(my_data[,3]), my_data$State, FUN= function(x) rank(x, na.last="keep", ties.method="min")))

				my_cleaned_data<-my_ranked_data[complete.cases(my_ranked_data$rank),]





				alphabeticrank<-  cbind(my_cleaned_data, alphabetic=ave(my_cleaned_data$Hospital.Name, my_cleaned_data$State, my_cleaned_data$rank, FUN= function(x) rank(x, na.last="keep", ties.method="min")))
				dummy<-cbind(alphabeticrank,as.numeric(as.vector(alphabeticrank[,4]))+as.numeric(as.vector(alphabeticrank[,5])))
				names(dummy)[6]<-c("dummy_value")
				final_rank<- cbind(dummy, final_rank=ave(dummy$dummy_value, dummy$State, FUN= function(x) rank(x, na.last="keep", ties.method="min")))
				k<-final_rank[final_rank$final_rank==num,]


				all_states<-data.frame(cbind(unique(outcome_data$State) ,rep(NA, length(unique(outcome_data$State)))))
				colnames(all_states)<-c("State", "hospital")


				output<-merge(x = all_states, y = k, by = "State", all.x = TRUE)

				}




output<-output[,c(3,1)]

names(output)[1]<-c("hospital")
names(output)[2]<-c("state")
output


}


}


head(rankall("heart attack", 20),10)