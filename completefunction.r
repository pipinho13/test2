
complete <- function(directory, id = 1:332) {

dat<-data.frame()
for (i in 1:length(id)) {
dat<-rbind(dat, read.csv(files_list[id[i]]))
}

dat_complete<-dat[complete.cases(dat),]

nobs<-vector()

for (i in 1:length(id)) {


nobs[i]<-length(dat_complete[dat_complete[,"ID"]==id[i],"ID"])


}

result<-cbind(id, nobs)
as.data.frame(result)

###s <- split(dat_complete, dat_complete$ID)
###nobs<-result<-sapply(s, function(x) length(x[,1]))
###result<-as.data.frame(cbind(id,nobs))
###result

        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
}
