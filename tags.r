sltagged<-read.csv("sltagged.csv")
UqEmotions<-unique(trimws(unlist(lapply(as.character(sltagged$emotion), strsplit, ","))))
emotion_matrix<-as.data.frame(matrix(rep(0), dim(sltagged)[1], length(UqEmotions) ))
colnames(emotion_matrix)<-UqEmotions

for (i in 1:length(UqEmotions)) {

emotion_matrix[grepl(UqEmotions[i], sltagged$emotion ), i]<-1


}
final_matrix<-cbind(sltagged, emotion_matrix, row.names = FALSE )
