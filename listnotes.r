t <- c("bob_smith","mary_jane","jose_chung","michael_marx","charlie_ivan")
pieces <- strsplit(t,"_")
sapply(pieces, "[", 1)


t <- c("bob_smith","mary_jane","jose_chung","michael_marx","charlie_ivan")
f <- function(s) strsplit(s, "_")[[1]][1]
sapply(t, f)



 tlist <- c("bob_smith","mary_jane","jose_chung","michael_marx","charlie_ivan") 
 fnames <- sapply(tlist, function(x) strsplit(x, "_")[[1]][1]) 
 fnames 
  ##bob_smith    mary_jane   jose_chung michael_marx charlie_ivan   
  ##    "bob"       "mary"       "jose"    "michael"    "charlie" 

### https://cran.r-project.org/web/packages/rlist/rlist.pdf
