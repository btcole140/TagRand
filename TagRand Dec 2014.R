setwd("/Users/mac/Google Drive/R Datasets/TagRand") #home computer
#note need to change user if working on diff computer
setwd("/Users/brittany/Google Drive/R Datasets/TagRand") #lab computer
pop13  <- read.csv("TagRand 2013.csv")


#Columns
str(pop13)
#Zone, Number, N.1, N.2, MsSS

pop13$LifeStage  <- as.factor(pop13$LifeStage)
class(pop13$LifeStage)
pop13$Zone  <- as.factor(pop13$Zone)
class(pop13$Zone)
pop13$Number  <- as.factor(pop13$Number)
class(pop13$Number)
pop13$N.1  <- as.factor(pop13$N.1)
class(pop13$N.1)
pop13$N.2  <- as.factor(pop13$N.2)
class(pop13$N.2)
pop13$MsSS  <- as.factor(pop13$MsSS)
class(pop13$MsSS)

#DDFLWF, DDRF, D2HT, Leaves, Branches, D2N

pop13$DDFLWF  <- as.numeric(pop13$DDFLWF)
class(pop13$DDFLWF)
pop13$DDRF  <- as.numeric(pop13$DDRF)
class(pop13$DDRF)
pop13$D2HT  <- as.numeric(pop13$D2HT)
class(pop13$D2HT)
pop13$Leaves  <- as.numeric(pop13$Leaves)
class(pop13$Leaves)
pop13$Branches  <- as.numeric(pop13$Branches)
class(pop13$Branches)
pop13$D2N  <- as.numeric(pop13$D2N)
class(pop13$D2N)

write.table(pop13, file = "TagRand 2013.csv", sep = ",", col.names = TRUE, row.names = FALSE)

#subset data by lifestage
pop13ls1  <- subset(pop13, LifeStage == "1")
pop13ls2  <- subset(pop13, LifeStage == "2")
pop13ls3  <- subset(pop13, LifeStage == "3")

#subset each ls3 by site and zone (A, B, D, K, L, M, T)
pop13ls3A  <- subset(pop13ls3, Site == "AR")
pop13ls3A1  <- subset(pop13ls3A, Zone == "1")
pop13ls3A2  <- subset(pop13ls3A, Zone == "2")

pop13ls3B  <- subset(pop13ls3, Site == "BH")
pop13ls3B1  <- subset(pop13ls3B, Zone == "1")
pop13ls3B2  <- subset(pop13ls3B, Zone == "2")

pop13ls3D  <- subset(pop13ls3, Site == "DB")
pop13ls3D1  <- subset(pop13ls3D, Zone == "1")
pop13ls3D2  <- subset(pop13ls3D, Zone == "2")

pop13ls3K  <- subset(pop13ls3, Site == "KB")
pop13ls3K1  <- subset(pop13ls3K, Zone == "1")
pop13ls3K2  <- subset(pop13ls3K, Zone == "2")

pop13ls3L  <- subset(pop13ls3, Site == "LH")
pop13ls3L1  <- subset(pop13ls3L, Zone == "1")
pop13ls3L2  <- subset(pop13ls3L, Zone == "2")

pop13ls3M  <- subset(pop13ls3, Site == "MNS")
pop13ls3M1  <- subset(pop13ls3M, Zone == "1")
pop13ls3M2  <- subset(pop13ls3M, Zone == "2")

pop13ls3T  <- subset(pop13ls3, Site == "TH")
pop13ls3T1  <- subset(pop13ls3T, Zone == "1")
pop13ls3T2  <- subset(pop13ls3T, Zone == "2")

write.table(pop13ls1, file = "TagRand 2013_ls1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls2, file = "TagRand 2013_ls2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3, file = "TagRand 2013_ls3.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3A.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3A1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3A2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3B.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3B1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3B2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3D.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3D1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3D2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3K.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3K1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3K2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3L.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3L1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3L2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3M.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3M1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3M2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3T.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3T1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3T2.csv", sep = ",", col.names = TRUE, row.names = FALSE)


#***********************************************
###FUNCTIONS
#***********************

# Set Fuction to Summarize data for plotting ggplot with standard error bars.
# Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
#   data: a data frame.
#   measurevar: the name of a column that contains the variable to be summariezed
#   groupvars: a vector containing names of columns that contain grouping variables
#   na.rm: a boolean that indicates whether to ignore NA's
#   conf.interval: the percent range of the confidence interval (default is 95%)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=TRUE,
                      conf.interval=.95, .drop=TRUE) {
  require(plyr)
  length2 <- function (x, na.rm=TRUE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  datac <- rename(datac, c("mean" = measurevar))
  datac$se <- datac$sd / sqrt(datac$N)
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  return(datac)
}


#******************************************
#TRANSFORMATIONS
#**********************************
#variables: Height, SIZE, Branches, FR.ALL, D2N
#Tag plant variables: GR, DDFLWF
#data subset variables: PrpnPD

##Height
#ALL ls3
pop13ls3$logHeight  <- log10(pop13ls3$Height+1)
pop13ls3$sqrtHeight  <- sqrt(pop13ls3$Height+0.5)
pop13ls3$rankHeight  <- rank(pop13ls3$Height, na.last="keep")

#AR
pop13ls3A$logHeight  <- log10(pop13ls3A$Height+1)
pop13ls3A$sqrtHeight  <- sqrt(pop13ls3A$Height+0.5)
pop13ls3A$rankHeight  <- rank(pop13ls3A$Height, na.last="keep")
#AR Z1
pop13ls3A1$logHeight  <- log10(pop13ls3A1$Height+1)
pop13ls3A1$sqrtHeight  <- sqrt(pop13ls3A1$Height+0.5)
pop13ls3A1$rankHeight  <- rank(pop13ls3A1$Height, na.last="keep")
#AR Z2
pop13ls3A2$logHeight  <- log10(pop13ls3A2$Height+1)
pop13ls3A2$sqrtHeight  <- sqrt(pop13ls3A2$Height+0.5)
pop13ls3A2$rankHeight  <- rank(pop13ls3A2$Height, na.last="keep")

