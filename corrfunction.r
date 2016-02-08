corr <- function(directory, threshold = 0) {


id=1:332
dat<-data.frame()
for (i in 1:length(id)) {
dat<-rbind(dat, read.csv(files_list[id[i]]))
}

dat_complete<-dat[complete.cases(dat),]


locations<-subset(complete()$id, complete()$nobs>threshold)



correlations<-vector()

if (max(complete()$nobs)<threshold)  {
correlations<-numeric(0)
}

else
{
for (i in 1:length(locations)) {


correlations[i]<-cor(subset(dat_complete$sulfate, dat_complete$ID==locations[i]), subset(dat_complete$nitrate, dat_complete$ID==locations[i]))


}}

correlations
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
}
