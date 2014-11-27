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
write.table(pop13ls3B, file = "TagRand 2013_ls3B.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3B1, file = "TagRand 2013_ls3B1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3B2, file = "TagRand 2013_ls3B2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3D, file = "TagRand 2013_ls3D.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3D1, file = "TagRand 2013_ls3D1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3D2, file = "TagRand 2013_ls3D2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3K, file = "TagRand 2013_ls3K.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3K1, file = "TagRand 2013_ls3K1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3K2, file = "TagRand 2013_ls3K2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3L, file = "TagRand 2013_ls3L.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3L1, file = "TagRand 2013_ls3L1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3L2, file = "TagRand 2013_ls3L2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3M, file = "TagRand 2013_ls3M.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3M1, file = "TagRand 2013_ls3M1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3M2, file = "TagRand 2013_ls3M2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3T, file = "TagRand 2013_ls3T.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3T1, file = "TagRand 2013_ls3T1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3T2, file = "TagRand 2013_ls3T2.csv", sep = ",", col.names = TRUE, row.names = FALSE)


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
#Tag plant variables: GR, DDFLWF (See tagged plant script)
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

#BH
pop13ls3B$logHeight  <- log10(pop13ls3B$Height+1)
pop13ls3B$sqrtHeight  <- sqrt(pop13ls3B$Height+0.5)
pop13ls3B$rankHeight  <- rank(pop13ls3B$Height, na.last="keep")
#BH Z1
pop13ls3B1$logHeight  <- log10(pop13ls3B1$Height+1)
pop13ls3B1$sqrtHeight  <- sqrt(pop13ls3B1$Height+0.5)
pop13ls3B1$rankHeight  <- rank(pop13ls3B1$Height, na.last="keep")
#BH Z2
pop13ls3B2$logHeight  <- log10(pop13ls3B2$Height+1)
pop13ls3B2$sqrtHeight  <- sqrt(pop13ls3B2$Height+0.5)
pop13ls3B2$rankHeight  <- rank(pop13ls3B2$Height, na.last="keep")

#DB
pop13ls3D$logHeight  <- log10(pop13ls3D$Height+1)
pop13ls3D$sqrtHeight  <- sqrt(pop13ls3D$Height+0.5)
pop13ls3D$rankHeight  <- rank(pop13ls3D$Height, na.last="keep")
#DB Z1
pop13ls3D1$logHeight  <- log10(pop13ls3D1$Height+1)
pop13ls3D1$sqrtHeight  <- sqrt(pop13ls3D1$Height+0.5)
pop13ls3D1$rankHeight  <- rank(pop13ls3D1$Height, na.last="keep")
#DB Z2
pop13ls3D2$logHeight  <- log10(pop13ls3D2$Height+1)
pop13ls3D2$sqrtHeight  <- sqrt(pop13ls3D2$Height+0.5)
pop13ls3D2$rankHeight  <- rank(pop13ls3D2$Height, na.last="keep")

#KB
pop13ls3K$logHeight  <- log10(pop13ls3K$Height+1)
pop13ls3K$sqrtHeight  <- sqrt(pop13ls3K$Height+0.5)
pop13ls3K$rankHeight  <- rank(pop13ls3K$Height, na.last="keep")
#KB Z1
pop13ls3K1$logHeight  <- log10(pop13ls3K1$Height+1)
pop13ls3K1$sqrtHeight  <- sqrt(pop13ls3K1$Height+0.5)
pop13ls3K1$rankHeight  <- rank(pop13ls3K1$Height, na.last="keep")
#KB Z2
pop13ls3K2$logHeight  <- log10(pop13ls3K2$Height+1)
pop13ls3K2$sqrtHeight  <- sqrt(pop13ls3K2$Height+0.5)
pop13ls3K2$rankHeight  <- rank(pop13ls3K2$Height, na.last="keep")

#LH
pop13ls3L$logHeight  <- log10(pop13ls3L$Height+1)
pop13ls3L$sqrtHeight  <- sqrt(pop13ls3L$Height+0.5)
pop13ls3L$rankHeight  <- rank(pop13ls3L$Height, na.last="keep")
#LH Z1
pop13ls3L1$logHeight  <- log10(pop13ls3L1$Height+1)
pop13ls3L1$sqrtHeight  <- sqrt(pop13ls3L1$Height+0.5)
pop13ls3L1$rankHeight  <- rank(pop13ls3L1$Height, na.last="keep")
#LH Z2
pop13ls3L2$logHeight  <- log10(pop13ls3L2$Height+1)
pop13ls3L2$sqrtHeight  <- sqrt(pop13ls3L2$Height+0.5)
pop13ls3L2$rankHeight  <- rank(pop13ls3L2$Height, na.last="keep")

#MNS
pop13ls3M$logHeight  <- log10(pop13ls3M$Height+1)
pop13ls3M$sqrtHeight  <- sqrt(pop13ls3M$Height+0.5)
pop13ls3M$rankHeight  <- rank(pop13ls3M$Height, na.last="keep")
#MNS Z1
pop13ls3M1$logHeight  <- log10(pop13ls3M1$Height+1)
pop13ls3M1$sqrtHeight  <- sqrt(pop13ls3M1$Height+0.5)
pop13ls3M1$rankHeight  <- rank(pop13ls3M1$Height, na.last="keep")
#MNS Z2
pop13ls3M2$logHeight  <- log10(pop13ls3M2$Height+1)
pop13ls3M2$sqrtHeight  <- sqrt(pop13ls3M2$Height+0.5)
pop13ls3M2$rankHeight  <- rank(pop13ls3M2$Height, na.last="keep")

#TH
pop13ls3T$logHeight  <- log10(pop13ls3T$Height+1)
pop13ls3T$sqrtHeight  <- sqrt(pop13ls3T$Height+0.5)
pop13ls3T$rankHeight  <- rank(pop13ls3T$Height, na.last="keep")
#TH Z1
pop13ls3T1$logHeight  <- log10(pop13ls3T1$Height+1)
pop13ls3T1$sqrtHeight  <- sqrt(pop13ls3T1$Height+0.5)
pop13ls3T1$rankHeight  <- rank(pop13ls3T1$Height, na.last="keep")
#TH Z2
pop13ls3T2$logHeight  <- log10(pop13ls3T2$Height+1)
pop13ls3T2$sqrtHeight  <- sqrt(pop13ls3T2$Height+0.5)
pop13ls3T2$rankHeight  <- rank(pop13ls3T2$Height, na.last="keep")


##SIZE
#ALL ls3
pop13ls3$logSIZE  <- log10(pop13ls3$SIZE+1)
pop13ls3$sqrtSIZE  <- sqrt(pop13ls3$SIZE+0.5)
pop13ls3$rankSIZE  <- rank(pop13ls3$SIZE, na.last="keep")

#AR
pop13ls3A$logSIZE  <- log10(pop13ls3A$SIZE+1)
pop13ls3A$sqrtSIZE  <- sqrt(pop13ls3A$SIZE+0.5)
pop13ls3A$rankSIZE  <- rank(pop13ls3A$SIZE, na.last="keep")
#AR Z1
pop13ls3A1$logSIZE  <- log10(pop13ls3A1$SIZE+1)
pop13ls3A1$sqrtSIZE  <- sqrt(pop13ls3A1$SIZE+0.5)
pop13ls3A1$rankSIZE  <- rank(pop13ls3A1$SIZE, na.last="keep")
#AR Z2
pop13ls3A2$logSIZE  <- log10(pop13ls3A2$SIZE+1)
pop13ls3A2$sqrtSIZE  <- sqrt(pop13ls3A2$SIZE+0.5)
pop13ls3A2$rankSIZE  <- rank(pop13ls3A2$SIZE, na.last="keep")

#BH
pop13ls3B$logSIZE  <- log10(pop13ls3B$SIZE+1)
pop13ls3B$sqrtSIZE  <- sqrt(pop13ls3B$SIZE+0.5)
pop13ls3B$rankSIZE  <- rank(pop13ls3B$SIZE, na.last="keep")
#BH Z1
pop13ls3B1$logSIZE  <- log10(pop13ls3B1$SIZE+1)
pop13ls3B1$sqrtSIZE  <- sqrt(pop13ls3B1$SIZE+0.5)
pop13ls3B1$rankSIZE  <- rank(pop13ls3B1$SIZE, na.last="keep")
#BH Z2
pop13ls3B2$logSIZE  <- log10(pop13ls3B2$SIZE+1)
pop13ls3B2$sqrtSIZE  <- sqrt(pop13ls3B2$SIZE+0.5)
pop13ls3B2$rankSIZE  <- rank(pop13ls3B2$SIZE, na.last="keep")

#DB
pop13ls3D$logSIZE  <- log10(pop13ls3D$SIZE+1)
pop13ls3D$sqrtSIZE  <- sqrt(pop13ls3D$SIZE+0.5)
pop13ls3D$rankSIZE  <- rank(pop13ls3D$SIZE, na.last="keep")
#DB Z1
pop13ls3D1$logSIZE  <- log10(pop13ls3D1$SIZE+1)
pop13ls3D1$sqrtSIZE  <- sqrt(pop13ls3D1$SIZE+0.5)
pop13ls3D1$rankSIZE  <- rank(pop13ls3D1$SIZE, na.last="keep")
#DB Z2
pop13ls3D2$logSIZE  <- log10(pop13ls3D2$SIZE+1)
pop13ls3D2$sqrtSIZE  <- sqrt(pop13ls3D2$SIZE+0.5)
pop13ls3D2$rankSIZE  <- rank(pop13ls3D2$SIZE, na.last="keep")

#KB
pop13ls3K$logSIZE  <- log10(pop13ls3K$SIZE+1)
pop13ls3K$sqrtSIZE  <- sqrt(pop13ls3K$SIZE+0.5)
pop13ls3K$rankSIZE  <- rank(pop13ls3K$SIZE, na.last="keep")
#KB Z1
pop13ls3K1$logSIZE  <- log10(pop13ls3K1$SIZE+1)
pop13ls3K1$sqrtSIZE  <- sqrt(pop13ls3K1$SIZE+0.5)
pop13ls3K1$rankSIZE  <- rank(pop13ls3K1$SIZE, na.last="keep")
#KB Z2
pop13ls3K2$logSIZE  <- log10(pop13ls3K2$SIZE+1)
pop13ls3K2$sqrtSIZE  <- sqrt(pop13ls3K2$SIZE+0.5)
pop13ls3K2$rankSIZE  <- rank(pop13ls3K2$SIZE, na.last="keep")

#LH
pop13ls3L$logSIZE  <- log10(pop13ls3L$SIZE+1)
pop13ls3L$sqrtSIZE  <- sqrt(pop13ls3L$SIZE+0.5)
pop13ls3L$rankSIZE  <- rank(pop13ls3L$SIZE, na.last="keep")
#LH Z1
pop13ls3L1$logSIZE  <- log10(pop13ls3L1$SIZE+1)
pop13ls3L1$sqrtSIZE  <- sqrt(pop13ls3L1$SIZE+0.5)
pop13ls3L1$rankSIZE  <- rank(pop13ls3L1$SIZE, na.last="keep")
#LH Z2
pop13ls3L2$logSIZE  <- log10(pop13ls3L2$SIZE+1)
pop13ls3L2$sqrtSIZE  <- sqrt(pop13ls3L2$SIZE+0.5)
pop13ls3L2$rankSIZE  <- rank(pop13ls3L2$SIZE, na.last="keep")

#MNS
pop13ls3M$logSIZE  <- log10(pop13ls3M$SIZE+1)
pop13ls3M$sqrtSIZE  <- sqrt(pop13ls3M$SIZE+0.5)
pop13ls3M$rankSIZE  <- rank(pop13ls3M$SIZE, na.last="keep")
#MNS Z1
pop13ls3M1$logSIZE  <- log10(pop13ls3M1$SIZE+1)
pop13ls3M1$sqrtSIZE  <- sqrt(pop13ls3M1$SIZE+0.5)
pop13ls3M1$rankSIZE  <- rank(pop13ls3M1$SIZE, na.last="keep")
#MNS Z2
pop13ls3M2$logSIZE  <- log10(pop13ls3M2$SIZE+1)
pop13ls3M2$sqrtSIZE  <- sqrt(pop13ls3M2$SIZE+0.5)
pop13ls3M2$rankSIZE  <- rank(pop13ls3M2$SIZE, na.last="keep")

#TH
pop13ls3T$logSIZE  <- log10(pop13ls3T$SIZE+1)
pop13ls3T$sqrtSIZE  <- sqrt(pop13ls3T$SIZE+0.5)
pop13ls3T$rankSIZE  <- rank(pop13ls3T$SIZE, na.last="keep")
#TH Z1
pop13ls3T1$logSIZE  <- log10(pop13ls3T1$SIZE+1)
pop13ls3T1$sqrtSIZE  <- sqrt(pop13ls3T1$SIZE+0.5)
pop13ls3T1$rankSIZE  <- rank(pop13ls3T1$SIZE, na.last="keep")
#TH Z2
pop13ls3T2$logSIZE  <- log10(pop13ls3T2$SIZE+1)
pop13ls3T2$sqrtSIZE  <- sqrt(pop13ls3T2$SIZE+0.5)
pop13ls3T2$rankSIZE  <- rank(pop13ls3T2$SIZE, na.last="keep")


##BRANCHES
#ALL ls3
pop13ls3$logBranches  <- log10(pop13ls3$Branches+1)
pop13ls3$sqrtBranches  <- sqrt(pop13ls3$Branches+0.5)
pop13ls3$rankBranches  <- rank(pop13ls3$Branches, na.last="keep")

#AR
pop13ls3A$logBranches  <- log10(pop13ls3A$Branches+1)
pop13ls3A$sqrtBranches  <- sqrt(pop13ls3A$Branches+0.5)
pop13ls3A$rankBranches  <- rank(pop13ls3A$Branches, na.last="keep")
#AR Z1
pop13ls3A1$logBranches  <- log10(pop13ls3A1$Branches+1)
pop13ls3A1$sqrtBranches  <- sqrt(pop13ls3A1$Branches+0.5)
pop13ls3A1$rankBranches  <- rank(pop13ls3A1$Branches, na.last="keep")
#AR Z2
pop13ls3A2$logBranches  <- log10(pop13ls3A2$Branches+1)
pop13ls3A2$sqrtBranches  <- sqrt(pop13ls3A2$Branches+0.5)
pop13ls3A2$rankBranches  <- rank(pop13ls3A2$Branches, na.last="keep")

#BH
pop13ls3B$logBranches  <- log10(pop13ls3B$Branches+1)
pop13ls3B$sqrtBranches  <- sqrt(pop13ls3B$Branches+0.5)
pop13ls3B$rankBranches  <- rank(pop13ls3B$Branches, na.last="keep")
#BH Z1
pop13ls3B1$logBranches  <- log10(pop13ls3B1$Branches+1)
pop13ls3B1$sqrtBranches  <- sqrt(pop13ls3B1$Branches+0.5)
pop13ls3B1$rankBranches  <- rank(pop13ls3B1$Branches, na.last="keep")
#BH Z2
pop13ls3B2$logBranches  <- log10(pop13ls3B2$Branches+1)
pop13ls3B2$sqrtBranches  <- sqrt(pop13ls3B2$Branches+0.5)
pop13ls3B2$rankBranches  <- rank(pop13ls3B2$Branches, na.last="keep")

#DB
pop13ls3D$logBranches  <- log10(pop13ls3D$Branches+1)
pop13ls3D$sqrtBranches  <- sqrt(pop13ls3D$Branches+0.5)
pop13ls3D$rankBranches  <- rank(pop13ls3D$Branches, na.last="keep")
#DB Z1
pop13ls3D1$logBranches  <- log10(pop13ls3D1$Branches+1)
pop13ls3D1$sqrtBranches  <- sqrt(pop13ls3D1$Branches+0.5)
pop13ls3D1$rankBranches  <- rank(pop13ls3D1$Branches, na.last="keep")
#DB Z2
pop13ls3D2$logBranches  <- log10(pop13ls3D2$Branches+1)
pop13ls3D2$sqrtBranches  <- sqrt(pop13ls3D2$Branches+0.5)
pop13ls3D2$rankBranches  <- rank(pop13ls3D2$Branches, na.last="keep")

#KB
pop13ls3K$logBranches  <- log10(pop13ls3K$Branches+1)
pop13ls3K$sqrtBranches  <- sqrt(pop13ls3K$Branches+0.5)
pop13ls3K$rankBranches  <- rank(pop13ls3K$Branches, na.last="keep")
#KB Z1
pop13ls3K1$logBranches  <- log10(pop13ls3K1$Branches+1)
pop13ls3K1$sqrtBranches  <- sqrt(pop13ls3K1$Branches+0.5)
pop13ls3K1$rankBranches  <- rank(pop13ls3K1$Branches, na.last="keep")
#KB Z2
pop13ls3K2$logBranches  <- log10(pop13ls3K2$Branches+1)
pop13ls3K2$sqrtBranches  <- sqrt(pop13ls3K2$Branches+0.5)
pop13ls3K2$rankBranches  <- rank(pop13ls3K2$Branches, na.last="keep")

#LH
pop13ls3L$logBranches  <- log10(pop13ls3L$Branches+1)
pop13ls3L$sqrtBranches  <- sqrt(pop13ls3L$Branches+0.5)
pop13ls3L$rankBranches  <- rank(pop13ls3L$Branches, na.last="keep")
#LH Z1
pop13ls3L1$logBranches  <- log10(pop13ls3L1$Branches+1)
pop13ls3L1$sqrtBranches  <- sqrt(pop13ls3L1$Branches+0.5)
pop13ls3L1$rankBranches  <- rank(pop13ls3L1$Branches, na.last="keep")
#LH Z2
pop13ls3L2$logBranches  <- log10(pop13ls3L2$Branches+1)
pop13ls3L2$sqrtBranches  <- sqrt(pop13ls3L2$Branches+0.5)
pop13ls3L2$rankBranches  <- rank(pop13ls3L2$Branches, na.last="keep")

#MNS
pop13ls3M$logBranches  <- log10(pop13ls3M$Branches+1)
pop13ls3M$sqrtBranches  <- sqrt(pop13ls3M$Branches+0.5)
pop13ls3M$rankBranches  <- rank(pop13ls3M$Branches, na.last="keep")
#MNS Z1
pop13ls3M1$logBranches  <- log10(pop13ls3M1$Branches+1)
pop13ls3M1$sqrtBranches  <- sqrt(pop13ls3M1$Branches+0.5)
pop13ls3M1$rankBranches  <- rank(pop13ls3M1$Branches, na.last="keep")
#MNS Z2
pop13ls3M2$logBranches  <- log10(pop13ls3M2$Branches+1)
pop13ls3M2$sqrtBranches  <- sqrt(pop13ls3M2$Branches+0.5)
pop13ls3M2$rankBranches  <- rank(pop13ls3M2$Branches, na.last="keep")

#TH
pop13ls3T$logBranches  <- log10(pop13ls3T$Branches+1)
pop13ls3T$sqrtBranches  <- sqrt(pop13ls3T$Branches+0.5)
pop13ls3T$rankBranches  <- rank(pop13ls3T$Branches, na.last="keep")
#TH Z1
pop13ls3T1$logBranches  <- log10(pop13ls3T1$Branches+1)
pop13ls3T1$sqrtBranches  <- sqrt(pop13ls3T1$Branches+0.5)
pop13ls3T1$rankBranches  <- rank(pop13ls3T1$Branches, na.last="keep")
#TH Z2
pop13ls3T2$logBranches  <- log10(pop13ls3T2$Branches+1)
pop13ls3T2$sqrtBranches  <- sqrt(pop13ls3T2$Branches+0.5)
pop13ls3T2$rankBranches  <- rank(pop13ls3T2$Branches, na.last="keep")


##FR.ALL
#ALL ls3
pop13ls3$logFR.ALL  <- log10(pop13ls3$FR.ALL+1)
pop13ls3$sqrtFR.ALL  <- sqrt(pop13ls3$FR.ALL+0.5)
pop13ls3$rankFR.ALL  <- rank(pop13ls3$FR.ALL, na.last="keep")

#AR
pop13ls3A$logFR.ALL  <- log10(pop13ls3A$FR.ALL+1)
pop13ls3A$sqrtFR.ALL  <- sqrt(pop13ls3A$FR.ALL+0.5)
pop13ls3A$rankFR.ALL  <- rank(pop13ls3A$FR.ALL, na.last="keep")
#AR Z1
pop13ls3A1$logFR.ALL  <- log10(pop13ls3A1$FR.ALL+1)
pop13ls3A1$sqrtFR.ALL  <- sqrt(pop13ls3A1$FR.ALL+0.5)
pop13ls3A1$rankFR.ALL  <- rank(pop13ls3A1$FR.ALL, na.last="keep")
#AR Z2
pop13ls3A2$logFR.ALL  <- log10(pop13ls3A2$FR.ALL+1)
pop13ls3A2$sqrtFR.ALL  <- sqrt(pop13ls3A2$FR.ALL+0.5)
pop13ls3A2$rankFR.ALL  <- rank(pop13ls3A2$FR.ALL, na.last="keep")

#BH
pop13ls3B$logFR.ALL  <- log10(pop13ls3B$FR.ALL+1)
pop13ls3B$sqrtFR.ALL  <- sqrt(pop13ls3B$FR.ALL+0.5)
pop13ls3B$rankFR.ALL  <- rank(pop13ls3B$FR.ALL, na.last="keep")
#BH Z1
pop13ls3B1$logFR.ALL  <- log10(pop13ls3B1$FR.ALL+1)
pop13ls3B1$sqrtFR.ALL  <- sqrt(pop13ls3B1$FR.ALL+0.5)
pop13ls3B1$rankFR.ALL  <- rank(pop13ls3B1$FR.ALL, na.last="keep")
#BH Z2
pop13ls3B2$logFR.ALL  <- log10(pop13ls3B2$FR.ALL+1)
pop13ls3B2$sqrtFR.ALL  <- sqrt(pop13ls3B2$FR.ALL+0.5)
pop13ls3B2$rankFR.ALL  <- rank(pop13ls3B2$FR.ALL, na.last="keep")

#DB
pop13ls3D$logFR.ALL  <- log10(pop13ls3D$FR.ALL+1)
pop13ls3D$sqrtFR.ALL  <- sqrt(pop13ls3D$FR.ALL+0.5)
pop13ls3D$rankFR.ALL  <- rank(pop13ls3D$FR.ALL, na.last="keep")
#DB Z1
pop13ls3D1$logFR.ALL  <- log10(pop13ls3D1$FR.ALL+1)
pop13ls3D1$sqrtFR.ALL  <- sqrt(pop13ls3D1$FR.ALL+0.5)
pop13ls3D1$rankFR.ALL  <- rank(pop13ls3D1$FR.ALL, na.last="keep")
#DB Z2
pop13ls3D2$logFR.ALL  <- log10(pop13ls3D2$FR.ALL+1)
pop13ls3D2$sqrtFR.ALL  <- sqrt(pop13ls3D2$FR.ALL+0.5)
pop13ls3D2$rankFR.ALL  <- rank(pop13ls3D2$FR.ALL, na.last="keep")

#KB
pop13ls3K$logFR.ALL  <- log10(pop13ls3K$FR.ALL+1)
pop13ls3K$sqrtFR.ALL  <- sqrt(pop13ls3K$FR.ALL+0.5)
pop13ls3K$rankFR.ALL  <- rank(pop13ls3K$FR.ALL, na.last="keep")
#KB Z1
pop13ls3K1$logFR.ALL  <- log10(pop13ls3K1$FR.ALL+1)
pop13ls3K1$sqrtFR.ALL  <- sqrt(pop13ls3K1$FR.ALL+0.5)
pop13ls3K1$rankFR.ALL  <- rank(pop13ls3K1$FR.ALL, na.last="keep")
#KB Z2
pop13ls3K2$logFR.ALL  <- log10(pop13ls3K2$FR.ALL+1)
pop13ls3K2$sqrtFR.ALL  <- sqrt(pop13ls3K2$FR.ALL+0.5)
pop13ls3K2$rankFR.ALL  <- rank(pop13ls3K2$FR.ALL, na.last="keep")

#LH
pop13ls3L$logFR.ALL  <- log10(pop13ls3L$FR.ALL+1)
pop13ls3L$sqrtFR.ALL  <- sqrt(pop13ls3L$FR.ALL+0.5)
pop13ls3L$rankFR.ALL  <- rank(pop13ls3L$FR.ALL, na.last="keep")
#LH Z1
pop13ls3L1$logFR.ALL  <- log10(pop13ls3L1$FR.ALL+1)
pop13ls3L1$sqrtFR.ALL  <- sqrt(pop13ls3L1$FR.ALL+0.5)
pop13ls3L1$rankFR.ALL  <- rank(pop13ls3L1$FR.ALL, na.last="keep")
#LH Z2
pop13ls3L2$logFR.ALL  <- log10(pop13ls3L2$FR.ALL+1)
pop13ls3L2$sqrtFR.ALL  <- sqrt(pop13ls3L2$FR.ALL+0.5)
pop13ls3L2$rankFR.ALL  <- rank(pop13ls3L2$FR.ALL, na.last="keep")

#MNS
pop13ls3M$logFR.ALL  <- log10(pop13ls3M$FR.ALL+1)
pop13ls3M$sqrtFR.ALL  <- sqrt(pop13ls3M$FR.ALL+0.5)
pop13ls3M$rankFR.ALL  <- rank(pop13ls3M$FR.ALL, na.last="keep")
#MNS Z1
pop13ls3M1$logFR.ALL  <- log10(pop13ls3M1$FR.ALL+1)
pop13ls3M1$sqrtFR.ALL  <- sqrt(pop13ls3M1$FR.ALL+0.5)
pop13ls3M1$rankFR.ALL  <- rank(pop13ls3M1$FR.ALL, na.last="keep")
#MNS Z2
pop13ls3M2$logFR.ALL  <- log10(pop13ls3M2$FR.ALL+1)
pop13ls3M2$sqrtFR.ALL  <- sqrt(pop13ls3M2$FR.ALL+0.5)
pop13ls3M2$rankFR.ALL  <- rank(pop13ls3M2$FR.ALL, na.last="keep")

#TH
pop13ls3T$logFR.ALL  <- log10(pop13ls3T$FR.ALL+1)
pop13ls3T$sqrtFR.ALL  <- sqrt(pop13ls3T$FR.ALL+0.5)
pop13ls3T$rankFR.ALL  <- rank(pop13ls3T$FR.ALL, na.last="keep")
#TH Z1
pop13ls3T1$logFR.ALL  <- log10(pop13ls3T1$FR.ALL+1)
pop13ls3T1$sqrtFR.ALL  <- sqrt(pop13ls3T1$FR.ALL+0.5)
pop13ls3T1$rankFR.ALL  <- rank(pop13ls3T1$FR.ALL, na.last="keep")
#TH Z2
pop13ls3T2$logFR.ALL  <- log10(pop13ls3T2$FR.ALL+1)
pop13ls3T2$sqrtFR.ALL  <- sqrt(pop13ls3T2$FR.ALL+0.5)
pop13ls3T2$rankFR.ALL  <- rank(pop13ls3T2$FR.ALL, na.last="keep")


##D2N
#ALL ls3
pop13ls3$logD2N  <- log10(pop13ls3$D2N+1)
pop13ls3$sqrtD2N  <- sqrt(pop13ls3$D2N+0.5)
pop13ls3$rankD2N  <- rank(pop13ls3$D2N, na.last="keep")

#AR
pop13ls3A$logD2N  <- log10(pop13ls3A$D2N+1)
pop13ls3A$sqrtD2N  <- sqrt(pop13ls3A$D2N+0.5)
pop13ls3A$rankD2N  <- rank(pop13ls3A$D2N, na.last="keep")
#AR Z1
pop13ls3A1$logD2N  <- log10(pop13ls3A1$D2N+1)
pop13ls3A1$sqrtD2N  <- sqrt(pop13ls3A1$D2N+0.5)
pop13ls3A1$rankD2N  <- rank(pop13ls3A1$D2N, na.last="keep")
#AR Z2
pop13ls3A2$logD2N  <- log10(pop13ls3A2$D2N+1)
pop13ls3A2$sqrtD2N  <- sqrt(pop13ls3A2$D2N+0.5)
pop13ls3A2$rankD2N  <- rank(pop13ls3A2$D2N, na.last="keep")

#BH
pop13ls3B$logD2N  <- log10(pop13ls3B$D2N+1)
pop13ls3B$sqrtD2N  <- sqrt(pop13ls3B$D2N+0.5)
pop13ls3B$rankD2N  <- rank(pop13ls3B$D2N, na.last="keep")
#BH Z1
pop13ls3B1$logD2N  <- log10(pop13ls3B1$D2N+1)
pop13ls3B1$sqrtD2N  <- sqrt(pop13ls3B1$D2N+0.5)
pop13ls3B1$rankD2N  <- rank(pop13ls3B1$D2N, na.last="keep")
#BH Z2
pop13ls3B2$logD2N  <- log10(pop13ls3B2$D2N+1)
pop13ls3B2$sqrtD2N  <- sqrt(pop13ls3B2$D2N+0.5)
pop13ls3B2$rankD2N  <- rank(pop13ls3B2$D2N, na.last="keep")

#DB
pop13ls3D$logD2N  <- log10(pop13ls3D$D2N+1)
pop13ls3D$sqrtD2N  <- sqrt(pop13ls3D$D2N+0.5)
pop13ls3D$rankD2N  <- rank(pop13ls3D$D2N, na.last="keep")
#DB Z1
pop13ls3D1$logD2N  <- log10(pop13ls3D1$D2N+1)
pop13ls3D1$sqrtD2N  <- sqrt(pop13ls3D1$D2N+0.5)
pop13ls3D1$rankD2N  <- rank(pop13ls3D1$D2N, na.last="keep")
#DB Z2
pop13ls3D2$logD2N  <- log10(pop13ls3D2$D2N+1)
pop13ls3D2$sqrtD2N  <- sqrt(pop13ls3D2$D2N+0.5)
pop13ls3D2$rankD2N  <- rank(pop13ls3D2$D2N, na.last="keep")

#KB
pop13ls3K$logD2N  <- log10(pop13ls3K$D2N+1)
pop13ls3K$sqrtD2N  <- sqrt(pop13ls3K$D2N+0.5)
pop13ls3K$rankD2N  <- rank(pop13ls3K$D2N, na.last="keep")
#KB Z1
pop13ls3K1$logD2N  <- log10(pop13ls3K1$D2N+1)
pop13ls3K1$sqrtD2N  <- sqrt(pop13ls3K1$D2N+0.5)
pop13ls3K1$rankD2N  <- rank(pop13ls3K1$D2N, na.last="keep")
#KB Z2
pop13ls3K2$logD2N  <- log10(pop13ls3K2$D2N+1)
pop13ls3K2$sqrtD2N  <- sqrt(pop13ls3K2$D2N+0.5)
pop13ls3K2$rankD2N  <- rank(pop13ls3K2$D2N, na.last="keep")

#LH
pop13ls3L$logD2N  <- log10(pop13ls3L$D2N+1)
pop13ls3L$sqrtD2N  <- sqrt(pop13ls3L$D2N+0.5)
pop13ls3L$rankD2N  <- rank(pop13ls3L$D2N, na.last="keep")
#LH Z1
pop13ls3L1$logD2N  <- log10(pop13ls3L1$D2N+1)
pop13ls3L1$sqrtD2N  <- sqrt(pop13ls3L1$D2N+0.5)
pop13ls3L1$rankD2N  <- rank(pop13ls3L1$D2N, na.last="keep")
#LH Z2
pop13ls3L2$logD2N  <- log10(pop13ls3L2$D2N+1)
pop13ls3L2$sqrtD2N  <- sqrt(pop13ls3L2$D2N+0.5)
pop13ls3L2$rankD2N  <- rank(pop13ls3L2$D2N, na.last="keep")

#MNS
pop13ls3M$logD2N  <- log10(pop13ls3M$D2N+1)
pop13ls3M$sqrtD2N  <- sqrt(pop13ls3M$D2N+0.5)
pop13ls3M$rankD2N  <- rank(pop13ls3M$D2N, na.last="keep")
#MNS Z1
pop13ls3M1$logD2N  <- log10(pop13ls3M1$D2N+1)
pop13ls3M1$sqrtD2N  <- sqrt(pop13ls3M1$D2N+0.5)
pop13ls3M1$rankD2N  <- rank(pop13ls3M1$D2N, na.last="keep")
#MNS Z2
pop13ls3M2$logD2N  <- log10(pop13ls3M2$D2N+1)
pop13ls3M2$sqrtD2N  <- sqrt(pop13ls3M2$D2N+0.5)
pop13ls3M2$rankD2N  <- rank(pop13ls3M2$D2N, na.last="keep")

#TH
pop13ls3T$logD2N  <- log10(pop13ls3T$D2N+1)
pop13ls3T$sqrtD2N  <- sqrt(pop13ls3T$D2N+0.5)
pop13ls3T$rankD2N  <- rank(pop13ls3T$D2N, na.last="keep")
#TH Z1
pop13ls3T1$logD2N  <- log10(pop13ls3T1$D2N+1)
pop13ls3T1$sqrtD2N  <- sqrt(pop13ls3T1$D2N+0.5)
pop13ls3T1$rankD2N  <- rank(pop13ls3T1$D2N, na.last="keep")
#TH Z2
pop13ls3T2$logD2N  <- log10(pop13ls3T2$D2N+1)
pop13ls3T2$sqrtD2N  <- sqrt(pop13ls3T2$D2N+0.5)
pop13ls3T2$rankD2N  <- rank(pop13ls3T2$D2N, na.last="keep")




##PrpnPD
#ALL ls3
pop13ls3$logPrpnPD  <- log10(pop13ls3$PrpnPD+1)
pop13ls3$sqrtPrpnPD  <- sqrt(pop13ls3$PrpnPD+0.5)
pop13ls3$rankPrpnPD <- rank(pop13ls3$PrpnPD, na.last="keep")

#AR 
pop13ls3A$logPrpnPD  <- log10(pop13ls3A$PrpnPD+1)
pop13ls3A$sqrtPrpnPD  <- sqrt(pop13ls3A$PrpnPD+0.5)
pop13ls3A$rankPrpnPD <- rank(pop13ls3A$PrpnPD, na.last="keep")
#AR Z1
pop13ls3A1$logPrpnPD  <- log10(pop13ls3A1$PrpnPD+1)
pop13ls3A1$sqrtPrpnPD  <- sqrt(pop13ls3A1$PrpnPD+0.5)
pop13ls3A1$rankPrpnPD <- rank(pop13ls3A1$PrpnPD, na.last="keep")
#AR Z2
pop13ls3A2$logPrpnPD  <- log10(pop13ls3A2$PrpnPD+1)
pop13ls3A2$sqrtPrpnPD  <- sqrt(pop13ls3A2$PrpnPD+0.5)
pop13ls3A2$rankPrpnPD <- rank(pop13ls3A2$PrpnPD, na.last="keep")

#KB 
pop13ls3K$logPrpnPD  <- log10(pop13ls3K$PrpnPD+1)
pop13ls3K$sqrtPrpnPD  <- sqrt(pop13ls3K$PrpnPD+0.5)
pop13ls3K$rankPrpnPD <- rank(pop13ls3K$PrpnPD, na.last="keep")
#KB Z1
pop13ls3K1$logPrpnPD  <- log10(pop13ls3K1$PrpnPD+1)
pop13ls3K1$sqrtPrpnPD  <- sqrt(pop13ls3K1$PrpnPD+0.5)
pop13ls3K1$rankPrpnPD <- rank(pop13ls3K1$PrpnPD, na.last="keep")
#KB Z2
pop13ls3K2$logPrpnPD  <- log10(pop13ls3K2$PrpnPD+1)
pop13ls3K2$sqrtPrpnPD  <- sqrt(pop13ls3K2$PrpnPD+0.5)
pop13ls3K2$rankPrpnPD <- rank(pop13ls3K2$PrpnPD, na.last="keep")

#LH 
pop13ls3L$logPrpnPD  <- log10(pop13ls3L$PrpnPD+1)
pop13ls3L$sqrtPrpnPD  <- sqrt(pop13ls3L$PrpnPD+0.5)
pop13ls3L$rankPrpnPD <- rank(pop13ls3L$PrpnPD, na.last="keep")
#LH Z1
pop13ls3L1$logPrpnPD  <- log10(pop13ls3L1$PrpnPD+1)
pop13ls3L1$sqrtPrpnPD  <- sqrt(pop13ls3L1$PrpnPD+0.5)
pop13ls3L1$rankPrpnPD <- rank(pop13ls3L1$PrpnPD, na.last="keep")
#LH Z2
pop13ls3L2$logPrpnPD  <- log10(pop13ls3L2$PrpnPD+1)
pop13ls3L2$sqrtPrpnPD  <- sqrt(pop13ls3L2$PrpnPD+0.5)
pop13ls3L2$rankPrpnPD <- rank(pop13ls3L2$PrpnPD, na.last="keep")

#TH 
pop13ls3T$logPrpnPD  <- log10(pop13ls3T$PrpnPD+1)
pop13ls3T$sqrtPrpnPD  <- sqrt(pop13ls3T$PrpnPD+0.5)
pop13ls3T$rankPrpnPD <- rank(pop13ls3T$PrpnPD, na.last="keep")
#TH Z1
pop13ls3T1$logPrpnPD  <- log10(pop13ls3T1$PrpnPD+1)
pop13ls3T1$sqrtPrpnPD  <- sqrt(pop13ls3T1$PrpnPD+0.5)
pop13ls3T1$rankPrpnPD <- rank(pop13ls3T1$PrpnPD, na.last="keep")
#TH Z2
pop13ls3T2$logPrpnPD  <- log10(pop13ls3T2$PrpnPD+1)
pop13ls3T2$sqrtPrpnPD  <- sqrt(pop13ls3T2$PrpnPD+0.5)
pop13ls3T2$rankPrpnPD <- rank(pop13ls3T2$PrpnPD, na.last="keep")


write.table(pop13ls1, file = "TagRand 2013_ls1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls2, file = "TagRand 2013_ls2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3, file = "TagRand 2013_ls3.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A, file = "TagRand 2013_ls3A.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A1, file = "TagRand 2013_ls3A1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3A2, file = "TagRand 2013_ls3A2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3B, file = "TagRand 2013_ls3B.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3B1, file = "TagRand 2013_ls3B1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3B2, file = "TagRand 2013_ls3B2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3D, file = "TagRand 2013_ls3D.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3D1, file = "TagRand 2013_ls3D1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3D2, file = "TagRand 2013_ls3D2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3K, file = "TagRand 2013_ls3K.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3K1, file = "TagRand 2013_ls3K1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3K2, file = "TagRand 2013_ls3K2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3L, file = "TagRand 2013_ls3L.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3L1, file = "TagRand 2013_ls3L1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3L2, file = "TagRand 2013_ls3L2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3M, file = "TagRand 2013_ls3M.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3M1, file = "TagRand 2013_ls3M1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3M2, file = "TagRand 2013_ls3M2.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3T, file = "TagRand 2013_ls3T.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3T1, file = "TagRand 2013_ls3T1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(pop13ls3T2, file = "TagRand 2013_ls3T2.csv", sep = ",", col.names = TRUE, row.names = FALSE)


pop13ls3$Site  <- pop13ls3$Site[drop=TRUE]

#********************
##Response Variable: Height
#boxplot
ggplot(data=pop13ls3, aes(x=Zone, y=Height))+
  geom_boxplot(width=0.8, position="dodge")+ 
  ylab("Height (cm)") +
  ggtitle("Height by Zone LS3")+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#NOTE: overlap, but different means, and more variation in beach than dune

#create plot using summarySE function output and Height
pophi <- summarySE(pop13ls3, measurevar="Height", groupvars=c("Site", "Zone")) 
ggplot(data=pophi, aes(x=Zone, y=Height, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=Height-se, ymax=Height+se), width=0.1, position=position_dodge(0.3)) +
  geom_line(position=position_dodge(0.3)) + geom_point(size=4, position=position_dodge(0.3))+
  xlab("Zone") + ylab("Height (cm)") +
  ggtitle("Mean Height by Zone") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(15, 16, 17, 8, 0, 1, 2))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#distribution
hist(pop13ls3$Height) #skew left, but otherwise fine

#outliers
mean(pop13ls3$Height, na.rm=TRUE)
sd(pop13ls3$Height, na.rm=TRUE)
20.11+(3*10.94) #=52.93, outliers = none

#lmer vs lm
lmehi <- lmer(Height~Zone+(1+Zone|Site), data=pop13ls3)
lmehia <- lmer(Height~Zone+(1|Site), data=pop13ls3)
anova(lmehi, lmehia) #Zone is sig  p=0.00063 chisq=14.75 AIC=2720.2, AICa=2730.9
lmhi <- lm(Height~Zone, data=pop13ls3)
x <- -2*logLik(lmhi, REML=T) +2*logLik(lmehi, REML=T)
x
pchisq(x, df=3, lower.tail=F)
AIC(lmhi) #=2878.28
AIC(lmehi) #=2713.47
#logLik=168.308, p=<0.0001, random Zone|Site is sig

#check assumptions of best model
lmehiR <- resid(lmehi) 
lmehiF <- fitted(lmehi)
plot(lmehiF, lmehiR) #raw is okay
abline(h=0, col=c("red"))
hist(lmehiR) #raw is okay
qqnorm(lmehiR, main="Q-Q plot for residuals") 
qqline(lmehiR) #raw is okay, small tails at each end

#lmer
lmehi <- lmer(Height~Zone+(1+Zone|Site), data=pop13ls3)
lmehi2 <- update(lmehi,~.-Zone)
anova(lmehi2, lmehi) #Zone is sig p=0.017 chisq=5.67
summary(lmehi)
#random: site var=63.94, zone var=22.12, resid=62.98
#fixed: intecept=21.42, zone est= -5.44

hin <- tapply(pop13ls3$Height, list(pop13ls3$Zone, pop13ls3$Site), length)
himean <- tapply(pop13ls3$Height, list(pop13ls3$Zone, pop13ls3$Site), mean)
hisd <- tapply(pop13ls3$Height, list(pop13ls3$Zone, pop13ls3$Site), sd)
hiCV <- (hisd/himean)*100

pophi <- summarySE(pop13ls3, measurevar="Height", groupvars=c("Site", "Zone")) 
ggplot(data=pophi, aes(x=Zone, y=Height, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=Height-se, ymax=Height+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Height (cm)") +
  ggtitle("Mean Height by Zone") +
  annotate("text", x=c(0.65, 2.20, 0.85, 2.20, 0.85, 2.45, 0.85, 2.20, 0.85, 2.45, 
                       0.85, 2.20, 0.85, 2.20), 
           y=c(30, 23, 23, 9, 7, 9, 27, 16, 18, 16, 16, 12, 30, 26), 
           label=paste("n=",hin)) +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18)) +
  theme(strip.text.x = element_text(size=20, face="bold")) +
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold")) +
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(15, 16, 17, 8, 0, 1, 2)) +
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#********************
##Response Variable: SIZE
#boxplot
ggplot(data=pop13ls3, aes(x=Zone, y=SIZE))+
  geom_boxplot(width=0.8, position="dodge")+ 
  ylab("Size (cm)") +
  ggtitle("SIZE by Zone LS3")+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#NOTE: overlap, but different means, and more variation in beach than dune
  #possible outliers

ggplot(data=pop13ls3, aes(x=Site, y=SIZE))+
  geom_point(aes(shape=Zone), width=0.8, position="dodge")+ 
  ylab("Size") +
  ggtitle("Size by Site")+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#BH outlier (2 beach; >9e+05), >6e+05, LH outlier (beach; >6e+05)

#create plot using summarySE function output 
popsz <- summarySE(pop13ls3, measurevar="SIZE", groupvars=c("Site", "Zone")) 
ggplot(data=popsz, aes(x=Zone, y=SIZE, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=SIZE-se, ymax=SIZE+se), width=0.1, position=position_dodge(0.3)) +
  geom_line(position=position_dodge(0.3)) + geom_point(size=4, position=position_dodge(0.3))+
  xlab("Zone") + ylab("Size (cm)") +
  ggtitle("Mean SIZE by Zone") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(15, 16, 17, 8, 0, 1, 2))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#distribution
hist(pop13ls3$SIZE) #one tall column at left
hist(pop13ls3$logSIZE) #better, slight skew right

#outliers
mean(pop13ls3$SIZE, na.rm=TRUE)
sd(pop13ls3$SIZE, na.rm=TRUE)
76820.71+(3*150465.9) #=528218.4, outliers = 39, 44, 49, 227, 266, 268, 302
mean(pop13ls3[-c(39, 44, 49, 227, 266, 268, 302),]$SIZE, na.rm=TRUE)
sd(pop13ls3[-c(39, 44, 49, 227, 266, 268, 302),]$SIZE, na.rm=TRUE)
63999.82+(3*115238.1) #=409714.1, outliers = 161, 201, 221... more and more

#lmer vs lm
lmesz <- lmer(logSIZE~Zone+(1+Zone|Site), data=pop13ls3)
lmesza <- lmer(logSIZE~Zone+(1|Site), data=pop13ls3)
anova(lmesz, lmesza) #Zone is sig p=<0.0001 chisq=25.75 AIC=870.14, AICa=891.89
lmsz <- lm(logSIZE~Zone, data=pop13ls3)
x <- -2*logLik(lmsz, REML=T) +2*logLik(lmesz, REML=T)
x
pchisq(x, df=3, lower.tail=F)
AIC(lmsz) #=1171.62
AIC(lmesz) #=871.77
#logLik=312.27, p=<0.0001, random Zone|Site is sig

#check assumptions of best model
lmeszR <- resid(lmesz) 
lmeszF <- fitted(lmesz)
plot(lmeszF, lmeszR) #raw not good, log great
abline(h=0, col=c("red"))
hist(lmeszR) #raw not good, log great
qqnorm(lmeszR, main="Q-Q plot for residuals") 
qqline(lmeszR) #raw not good, log great

#lmer
lmesz <- lmer(logSIZE~Zone+(1+Zone|Site), data=pop13ls3)
lmesz2  <- update(lmesz,~.-Zone)
anova(lmesz2, lmesz) #Zone is sig p=0.0022 chisq=9.39
summary(lmesz)
#random: site var=0.93, zone var=0.303, resid=0.49
#fixed: intercept=4.19, zone est= -0.91

szn <- tapply(pop13ls3$SIZE, list(pop13ls3$Zone, pop13ls3$Site), length)
szmean <- tapply(pop13ls3$SIZE, list(pop13ls3$Zone, pop13ls3$Site), mean)
szsd <- tapply(pop13ls3$SIZE, list(pop13ls3$Zone, pop13ls3$Site), sd)
szCV <- (szsd/szmean)*100

popsz <- summarySE(pop13ls3, measurevar="logSIZE", groupvars=c("Site", "Zone")) 
ggplot(data=popsz, aes(x=Zone, y=logSIZE, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=logSIZE-se, ymax=logSIZE+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(Log[10]~Size~(HxWxL~cm^3)))) +
  ggtitle("Mean logSIZE by Zone") +
  annotate("text", x=c(0.85, 2.25, 0.85, 2.25, 0.85, 2.25, 0.85, 2.25, 0.85, 2.45,
                       0.85, 2.25, 0.85, 2.25), 
           y=c(4.65, 4.1, 4.45, 2.5, 2.2, 1.8, 4.9, 3.8, 4.15, 3.8, 
                3.95, 2.7, 5.1, 4.35), 
           label=paste("n=",szn)) +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18)) +
  theme(strip.text.x = element_text(size=20, face="bold")) +
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold")) +
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(15, 16, 17, 8, 0, 1, 2)) +
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#********************
##Response Variable: Branches
#boxplot
ggplot(data=pop13ls3, aes(x=Zone, y=Branches))+
  geom_boxplot(width=0.8, position="dodge")+ 
  ylab("Size (cm)") +
  ggtitle("Branches by Zone LS3")+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#NOTE: overlap, but different means

ggplot(data=pop13ls3, aes(x=Site, y=Branches))+
  geom_point(aes(shape=Zone), width=0.8, position="dodge")+ 
  ylab("Branches") +
  ggtitle("Branches by Site")+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#no outliers

#create plot using summarySE function output 
popbr <- summarySE(pop13ls3, measurevar="Branches", groupvars=c("Site", "Zone")) 
ggplot(data=popbr, aes(x=Zone, y=Branches, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=Branches-se, ymax=Branches+se), width=0.1, position=position_dodge(0.3)) +
  geom_line(position=position_dodge(0.3)) + geom_point(size=4, position=position_dodge(0.3))+
  xlab("Zone") + ylab("Number of Branches") +
  ggtitle("Mean Branches by Zone") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(15, 16, 17, 8, 0, 1, 2))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#distribution
hist(pop13ls3$Branches) #one tall column at left
hist(pop13ls3$sqrtBranches) #better

#outliers
mean(pop13ls3$Branches, na.rm=TRUE)
sd(pop13ls3$Branches, na.rm=TRUE)
6.64+(3*4.27) #=19.45, outliers = 266
mean(pop13ls3[-c(266),]$Branches, na.rm=TRUE)
sd(pop13ls3[-c(266),]$Branches, na.rm=TRUE)
6.602+(3*4.22) #=19.26, outliers = none

#lmer vs lm
lmebr <- lmer(sqrtBranches~Zone+(1+Zone|Site), data=pop13ls3)
lmebra <- lmer(sqrtBranches~Zone+(1|Site), data=pop13ls3)
anova(lmebr, lmebra) #Zone is sig p=0.00046 chisq=15.36 AIC=726.12, AICa=737.49
lmbr <- lm(sqrtBranches~Zone, data=pop13ls3)
x <- -2*logLik(lmbr, REML=T) +2*logLik(lmebr, REML=T)
x
pchisq(x, df=3, lower.tail=F)
AIC(lmbr) #=896.36
AIC(lmebr) #=729.58
#logLik=180.64, p=<0.0001, random Zone|Site is sig

#check assumptions of best model
lmebrR <- resid(lmebr) 
lmebrF <- fitted(lmebr)
plot(lmebrF, lmebrR) #raw not good, sqrt good
abline(h=0, col=c("red"))
hist(lmebrR) #raw not good, sqrt good
qqnorm(lmebrR, main="Q-Q plot for residuals") 
qqline(lmebrR) #raw not good, sqrt good

#lmer
lmebr <- lmer(sqrtBranches~Zone+(1+Zone|Site), data=pop13ls3)
lmebr2  <- update(lmebr,~.-Zone)
anova(lmebr2, lmebr) #Zone is sig p=0.00404 chisq=8.27
summary(lmebr)
#random: site var=0.29, zone var=0.14, resid=0.34
#fixed: intercept=2.76, zone est= -0.57

brn <- tapply(pop13ls3$Branches, list(pop13ls3$Zone, pop13ls3$Site), length)
brmean <- tapply(pop13ls3$Branches, list(pop13ls3$Zone, pop13ls3$Site), mean)
brsd <- tapply(pop13ls3$Branches, list(pop13ls3$Zone, pop13ls3$Site), sd)
brCV <- (brsd/brmean)*100

popbr <- summarySE(pop13ls3, measurevar="sqrtBranches", groupvars=c("Site", "Zone")) 
ggplot(data=popbr, aes(x=Zone, y=sqrtBranches, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=sqrtBranches-se, ymax=sqrtBranches+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(sqrt(Number~of~Branches)))) +
  ggtitle("Mean sqrtBranches by Zone") +
  annotate("text", x=c(0.85, 2.25, 0.85, 2.25, 0.85, 2.25, 0.85, 2.45, 0.85, 2.25,
                       0.85, 2.25, 0.85, 2.25), 
           y=c(3.17, 2.58, 2.82, 1.78, 1.68, 1.45, 2.62, 2.601, 2.92, 2.44, 
               2.73, 1.55, 3.42, 2.86), 
           label=paste("n=",brn)) +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18)) +
  theme(strip.text.x = element_text(size=20, face="bold")) +
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold")) +
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(15, 16, 17, 8, 0, 1, 2)) +
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#********************
##Response Variable: FR.ALL
#boxplot
ggplot(data=pop13ls3, aes(x=Zone, y=Branches))+
  geom_boxplot(width=0.8, position="dodge")+ 
  ylab("Size (cm)") +
  ggtitle("Branches by Zone LS3")+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#NOTE: overlap, but different means

ggplot(data=pop13ls3, aes(x=Site, y=Branches))+
  geom_point(aes(shape=Zone), width=0.8, position="dodge")+ 
  ylab("Branches") +
  ggtitle("Branches by Site")+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#no outliers

#create plot using summarySE function output 
popbr <- summarySE(pop13ls3, measurevar="Branches", groupvars=c("Site", "Zone")) 
ggplot(data=popbr, aes(x=Zone, y=Branches, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=Branches-se, ymax=Branches+se), width=0.1, position=position_dodge(0.3)) +
  geom_line(position=position_dodge(0.3)) + geom_point(size=4, position=position_dodge(0.3))+
  xlab("Zone") + ylab("Number of Branches") +
  ggtitle("Mean Branches by Zone") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(15, 16, 17, 8, 0, 1, 2))+
  theme(axis.title.y = element_text(vjust=1, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#distribution
hist(pop13ls3$Branches) #one tall column at left
hist(pop13ls3$sqrtBranches) #better

#outliers
mean(pop13ls3$Branches, na.rm=TRUE)
sd(pop13ls3$Branches, na.rm=TRUE)
6.64+(3*4.27) #=19.45, outliers = 266
mean(pop13ls3[-c(266),]$Branches, na.rm=TRUE)
sd(pop13ls3[-c(266),]$Branches, na.rm=TRUE)
6.602+(3*4.22) #=19.26, outliers = none

#lmer vs lm
lmebr <- lmer(sqrtBranches~Zone+(1+Zone|Site), data=pop13ls3)
lmebra <- lmer(sqrtBranches~Zone+(1|Site), data=pop13ls3)
anova(lmebr, lmebra) #Zone is sig p=0.00046 chisq=15.36 AIC=726.12, AICa=737.49
lmbr <- lm(sqrtBranches~Zone, data=pop13ls3)
x <- -2*logLik(lmbr, REML=T) +2*logLik(lmebr, REML=T)
x
pchisq(x, df=3, lower.tail=F)
AIC(lmbr) #=896.36
AIC(lmebr) #=729.58
#logLik=180.64, p=<0.0001, random Zone|Site is sig

#check assumptions of best model
lmebrR <- resid(lmebr) 
lmebrF <- fitted(lmebr)
plot(lmebrF, lmebrR) #raw not good, sqrt good
abline(h=0, col=c("red"))
hist(lmebrR) #raw not good, sqrt good
qqnorm(lmebrR, main="Q-Q plot for residuals") 
qqline(lmebrR) #raw not good, sqrt good