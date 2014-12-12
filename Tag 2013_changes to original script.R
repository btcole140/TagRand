#setwd("/Users/brittanycole/Desktop/Cakile Project Documents/Project Documents/R data")
setwd("/Users/mac/Google Drive/R Datasets/Tag")
#popt13 <- read.csv("PopTag13 all_indivLS.csv") #standarized variables by Site and Life.Stage.
  #"PopTag13 all_indivLS.csv" = Life Stage by individual
  #"PopTag13 all.csv" = Life Stage by Site (<50% are nonrepro=ls1, >50% are repro=ls2, >50% are senesc=ls3)
#popt13  <- read.csv("PopTag 2013 NJL.csv") #same as above... but added column for total buds+flowers

popt13  <- read.csv("Tag 2013_indivLS.csv")

popt13$FlwPer <- popt13$J.Date.FLW/popt13$J.Date.FR #DNU

#Data- Columns
str(popt13)
popt13$LifeStage <- as.factor(popt13$LifeStage)
class(popt13$LifeStage)
popt13$Zone <- as.factor(popt13$Zone)
class(popt13$Zone)
popt13$Number <- as.factor(popt13$Number)
class(popt13$Number)
popt13$J.Date.R <- as.numeric(popt13$J.Date.R)
class(popt13$J.Date.R)
popt13$J.Date.FLW <- as.numeric(popt13$J.Date.FLW)
class(popt13$J.Date.FLW)
popt13$J.Date.FR <- as.numeric(popt13$J.Date.FR)
class(popt13$J.Date.FR)
popt13$J.Date.F <- as.numeric(popt13$J.Date.F)
class(popt13$J.Date.F)
popt13$DDFLWFR <- as.numeric(popt13$DDFLWFR)
class(popt13$DDFLWFR)
popt13$DDFLWF <- as.numeric(popt13$DDFLWF)
class(popt13$DDFLWF)
popt13$DDRF <- as.numeric(popt13$DDRF)
class(popt13$DDRF)
popt13$D2HT <- as.numeric(popt13$D2HT)
class(popt13$D2HT)
popt13$Leaves <- as.numeric(popt13$Leaves)
class(popt13$Leaves)
popt13$Branches <- as.numeric(popt13$Branches)
class(popt13$Branches)
popt13$N.1 <- as.factor(popt13$N.1)
class(popt13$N.1)
popt13$N.2 <- as.factor(popt13$N.2)
class(popt13$N.2)
popt13$FlwPer <- as.numeric(popt13$FlwPer)
class(popt13$FlwPer)


write.table(popt13, file = "PopTag13 all_indivLS.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(popt13, file = "PopTag 2013 NJL.csv", sep = ",", col.names = TRUE, row.names = FALSE)

#This script will be organized by response variable for lm and lmer analysis
  #GR, FR, FLW, Size, D2N, Diff.Date.FLW.FR
#At the end of the script, correlation tests between response variables will be run
###
#NOTE: random effects in {nlme} written as "random=~1|Site/Zone" or "random=list(Site=~1, Zone=~1)" are the same.

#subset data by LS
poptls3 <- subset(popt13, LifeStage == "3")
poptls2 <- subset(popt13, LifeStage =="2")
poptls1 <- subset(popt13, LifeStage =="1")

#need to remove duplicated points LS1
duplicated(poptls1$S.Z.N)
poptls1x <- poptls1[!duplicated(poptls1$S.Z.N),]
#need to remove duplicated points LS2
duplicated(poptls2$S.Z.N)
poptls2x <- poptls2[!duplicated(poptls2$S.Z.N),]
#remove duplicates from poptls3
duplicated(poptls3$S.Z.N)
poptls3x <- poptls3[!duplicated(poptls3$S.Z.N),]

#subset LS1x by site
poptls1xM <- subset(poptls1x, Site =="MNS")
poptls1xL <- subset(poptls1x, Site =="LH")
#subset LS2x by site
poptls2xM <- subset(poptls2x, Site =="MNS")
poptls2xL <- subset(poptls2x, Site =="LH")
#subset LS3x by site
poptls3xM <- subset(poptls3x, Site =="MNS")
poptls3xL <- subset(poptls3x, Site =="LH")

#subset to remove empty cells that were named "150" 
poptls1x150 <- subset(poptls1x, StndD2N <"1.5")
poptls2x150 <- subset(poptls2x, StndD2N <"1.5")
poptls3x150 <- subset(poptls3x, StndD2N < "1.5")
#subset for MNS
poptls1xM150 <- subset(poptls1xM, StndD2N <"1.5")
poptls2xM150 <- subset(poptls2xM, StndD2N <"1.5")
poptls3xM150 <- subset(poptls3xM, StndD2N < "1.5")
#subset for LH
poptls1xL150 <- subset(poptls1xL, StndD2N <"1.5")
poptls2xL150 <- subset(poptls2xL, StndD2N <"1.5")
poptls3xL150 <- subset(poptls3xL, StndD2N < "1.5")

#LH LS3x subset with added Seed Set Data  <- Column Headings
poptls3xL <- read.csv("PopTag13 ls3xLss.csv")
poptls3xL$FRss <- poptls3xL$FR.ALL*poptls3xL$PrpnPD
str(poptls3xL)
poptls3xL$LifeStage <- as.factor(poptls3xL$LifeStage)
class(poptls3xL$LifeStage)
poptls3xL$Zone <- as.factor(poptls3xL$Zone)
class(poptls3xL$Zone)
poptls3xL$Number <- as.factor(poptls3xL$Number)
class(poptls3xL$Number)
poptls3xL$J.Date.R <- as.numeric(poptls3xL$J.Date.R)
class(poptls3xL$J.Date.R)
poptls3xL$J.Date.FLW <- as.numeric(poptls3xL$J.Date.FLW)
class(poptls3xL$J.Date.FLW)
poptls3xL$J.Date.FR <- as.numeric(poptls3xL$J.Date.FR)
class(poptls3xL$J.Date.FR)
poptls3xL$J.Date.F <- as.numeric(poptls3xL$J.Date.F)
class(poptls3xL$J.Date.F)
poptls3xL$DDFLWFR <- as.numeric(poptls3xL$DDFLWFR)
class(poptls3xL$DDFLWFR)
poptls3xL$DDFLWF <- as.numeric(poptls3xL$DDFLWF)
class(poptls3xL$DDFLWF)
poptls3xL$DDRF <- as.numeric(poptls3xL$DDRF)
class(poptls3xL$DDRF)
poptls3xL$D2HT <- as.numeric(poptls3xL$D2HT)
class(poptls3xL$D2HT)
poptls3xL$Leaves <- as.numeric(poptls3xL$Leaves)
class(poptls3xL$Leaves)
poptls3xL$Branches <- as.numeric(poptls3xL$Branches)
class(poptls3xL$Branches)
poptls3xL$N.1 <- as.factor(poptls3xL$N.1)
class(poptls3xL$N.1)
poptls3xL$N.2 <- as.factor(poptls3xL$N.2)
class(poptls3xL$N.2)
poptls3xL$FlwPer <- as.numeric(poptls3xL$FlwPer)
class(poptls3xL$FlwPer)
poptls3xL$FRss  <- as.numeric(poptls3xL$FRss)
class(poptls3xL$FRss)

#save data class to data files
write.table(poptls1x, file = "PopTag13 ls1x.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1x150, file = "PopTag13 ls1x150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xL, file = "PopTag13 ls1xL.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xL150, file = "PopTag13 ls1xL150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xM, file = "PopTag13 ls1xM.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xM150, file = "PopTag13 ls1xM150.csv", sep = ",", col.names = TRUE, row.names = FALSE)

write.table(poptls2x, file = "PopTag13 ls2x.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2x150, file = "PopTag13 ls2x150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xL, file = "PopTag13 ls2xL.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xL150, file = "PopTag13 ls2xL150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xM, file = "PopTag13 ls2xM.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xM150, file = "PopTag13 ls2xM150.csv", sep = ",", col.names = TRUE, row.names = FALSE)

write.table(poptls3x, file = "PopTag13 ls3x.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3x150, file = "PopTag13 ls3x150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xL, file = "PopTag13 ls3xL.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xL150, file = "PopTag13 ls3xL150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xM, file = "PopTag13 ls3xM.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xM150, file = "PopTag13 ls3xM150.csv", sep = ",", col.names = TRUE, row.names = FALSE)



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


#**********************************************************
###Data Distribution
#****************************
##GR
#LS3
#histogram of LS3 StndGR-DNU
hist(poptls3$StndGR) # data not normal
poptls3$logStndGR <- log10(poptls3$StndGR+1)
hist(poptls3$logStndGR) # much better, bit of a left skew, but good
tapply(poptls3$StndGR, list(poptls3$Site, poptls3$Zone), length)
  #19 points in LH and 10 in MNS Zone 1
  #30 points in Zone 2 for LH, 20 for MNS


#histogram of LS3x StndGR ***
hist(poptls3x$StndGR)# not normal
poptls3x$logStndGR <- log10(poptls3x$StndGR+1) #USE THIS ONE***
hist(poptls3x$logStndGR) # much better... normally distributed with slight skew right
  #Removing duplicated plants from poptls3 data set was done on March 25 
tapply(poptls3x$StndGR, list(poptls3x$Site, poptls3x$Zone), length)
#18 points LH Z1, 9 MNS
#22 points LH Z2, 13 MNS

#************
#histogram of LS3x GR ***
poptls3x$logGR <- log10(poptls3x$GR+1)
poptls3x$sqrtGR <- sqrt(poptls3x$GR+0.5)
poptls3x$rankGR  <- rank(poptls3x$GR, na.last="keep")

#histogram of LS3xM GR***
poptls3xM$logGR <- log10(poptls3xM$GR+1) 
poptls3xM$sqrtGR <- sqrt(poptls3xM$GR+0.5) 
poptls3xM$rankGR <- rank(poptls3xM$GR, na.last="keep")

#histogram of LS3xL GR***
poptls3xL$logGR <- log10(poptls3xL$GR+1)
poptls3xL$sqrtGR <- sqrt(poptls3xL$GR+0.5) 
poptls3xL$rankGR <- rank(poptls3xL$GR, na.last="keep")
#****************

#LS2
#histogram of LS2 StndGR data
hist(poptls2$StndGR) # not normal
poptls2$logStndGR <- log10(poptls2$StndGR+1)
hist(poptls2$logStndGR) # much better... slight left skew, but good distribution
  #How many data points
tapply(poptls2$StndGR, list(poptls2$Site, poptls2$Zone), length)
  #86 points LH Zone 1, 38 for MNS
  #51 points LH Zone 2, 27 for MNS
  #NOTE: Many of these points are repeated plant numbers

#histogram of LS2x StndGR data
hist(poptls2x$StndGR) # not normal.. one large column at far left
poptls2x$sqrtStndGR <- sqrt(poptls2x$StndGR+1)
hist(poptls2x$sqrtStndGR) # not any better
poptls2x$logStndGR <- log10(poptls2x$StndGR+1) #USE THIS ONE ***
hist(poptls2x$logStndGR) # Much better distribution.
tapply(poptls2x$StndGR, list(poptls2x$Site, poptls2x$Zone), length)
  #39 points LH Zone 1, 17 MNS
  #33 points LH Zone 2, 18 MNS
  #This data set still has more points than LS3 does... may consider using LS2x for GR analysis
  #since not all plants survived to LS3.

#histogram of LS2x GR data
hist(poptls2x$GR) # not normal... one large column far left
poptls2x$logGR <- log10(poptls2x$GR+1) #USE THIS ONE ***
hist(poptls2x$logGR) # good distribution

#histogram of LS2xM GR***
hist(poptls2xM$GR) # skewed left with one large column at far left
poptls2xM$logGR <- log10(poptls2xM$GR+1) 
hist(poptls2xM$logGR) #better, but not a good distribution two sets of equal height columns
poptls2xM$sqrtGR <- sqrt(poptls2xM$GR) 
hist(poptls2xM$sqrtGR) # not good, largest column to far left... half distribution curve
poptls2xM$GRx <- 1/(poptls2xM$GR) 
hist(poptls2xM$GRx) #not any better
poptls2xM$rankGR <- rank(poptls2xM$GR) #USE THIS ONE***

#histogram of LS2xL GR***
hist(poptls2xL$GR) # not good, one large column at far left
poptls2xL$logGR <- log10(poptls2xL$GR+1) #USE THIS ONE***
hist(poptls2xL$logGR) #better, two almost equal large columns at middle
poptls2xL$sqrtGR <- sqrt(poptls2xL$GR+1) 
hist(poptls2xL$sqrtGR) # not good, largest column to far left
poptls2xL$GRx <- 1/(poptls2xL$GR+1) 
hist(poptls2xL$GRx) #not any better

#LS1
#histogram of LS1 GR data
hist(poptls1$StndGR) #not normal
poptls1$logStndGR <- log10(poptls1$StndGR+1)
hist(poptls1$logStndGR) # better... going to use this, but has one large column and several small columns
  #How many data points
tapply(poptls1$StndGR, list(poptls1$Site, poptls1$Zone), length)
  #184 points LH Zone 1, 54 for MNS
  #255 points LH Zone 2, 59 for MNS
  #NOTE: Many of these points are repeated plant numbers

#histogram of ls1x StndGR
hist(poptls1x$StndGR)# not normal
poptls1x$logStndGR <- log10(poptls1x$StndGR+1) #USE THIS ONE ***
hist(poptls1x$logStndGR) # better... but have one giant column and the rest are small
poptls1x$sqrtStndGR <- sqrt(poptls1x$StndGR+1)
hist(poptls1x$sqrtStndGR) # same as raw data
tapply(poptls1x$StndGR, list(poptls1x$Site, poptls1x$Zone), length)
  #50 points LH Zone 1, 28 MNS
  #71 points LH Zone 2, 30 MNS

#histogram of LS1x GR data
hist(poptls1x$GR)# not normal... one large column
poptls1x$logGR <- log10(poptls1x$GR+10) #USE THIS ONE ***
hist(poptls1x$logGR) #better than raw data but skewed left
poptls1x$sqrtGR <- sqrt(poptls1x$GR+10)
hist(poptls1x$sqrtGR) # worse
 
#histogram of LS1xM GR***
hist(poptls1xM$GR) # skewed left with one large column at far left
poptls1xM$logGR <- log10(poptls1xM$GR) 
hist(poptls1xM$logGR)  #better, four tall columns at center
poptls1xM$sqrtGR <- sqrt(poptls1xM$GR) 
hist(poptls1xM$sqrtGR) # not good, largest column to far left... half distribution curve
poptls1xM$GRx <- 1/(poptls1xM$GR) 
hist(poptls1xM$GRx) #not any better
poptls1xM$rankGR <- rank(poptls1xM$GR) #USE THIS ONE***

#histogram of LS1xL GR***
hist(poptls1xL$GR) # not good, one large column at far left
poptls1xL$logGR <- log10(poptls1xL$GR+10) #USE THIS ONE***
hist(poptls1xL$logGR) #better, skewed left
poptls1xL$sqrtGR <- sqrt(poptls1xL$GR+10) 
hist(poptls1xL$sqrtGR) # not good, largest column to far left... half distribution curve
poptls1xL$GRx <- 1/(poptls1xL$GR+10) 
hist(poptls1xL$GRx) #not any better



##FR
#histogram of LS3x StndFR data ***
hist(poptls3x$StndFR) #not normally distributed
poptls3x$logStndFR <- log10(poptls3x$StndFR+1) #USE THIS ONE***
hist(poptls3x$logStndFR) # much better, but not a perfect distribution
poptls3x$sqrtStndFR <- sqrt(poptls3x$StndFR+1)
hist(poptls3x$sqrtStndFR) # not as good as log10
tapply(poptls3x$StndFR, list(poptls3x$Site, poptls3x$Zone), length)
  #18 points for LH and 9 points for MNS in Z1, 22 LH and 13 MNS for Z2

#histogram of LS3x FR.ALL data ***
hist(poptls3x$FR.ALL) #not normally distributed... one large column to far left
poptls3x$logFR.ALL <- log10(poptls3x$FR.ALL+1) #USE THIS ONE***
hist(poptls3x$logFR.ALL) # much better, but distribution sightly off
poptls3x$sqrtFR.ALL <- sqrt(poptls3x$FR.ALL+1)
hist(poptls3x$sqrtFR.ALL) # worse

#histogram of LS3xM FR.ALL data ***
hist(poptls3xM$FR.ALL) #not normally distributed... two large columns to far left
poptls3xM$logFR.ALL <- log10(poptls3xM$FR.ALL+1) 
hist(poptls3xM$logFR.ALL) # better, but tallest column is mid right
poptls3xM$sqrtFR.ALL <- sqrt(poptls3xM$FR.ALL)
hist(poptls3xM$sqrtFR.ALL) # worse
poptls3xM$FR.ALLx <- 1/(poptls3xM$FR.ALL)
hist(poptls3xM$FR.ALLx) # worse
poptls3xM$rankFR.ALL <- rank(poptls3xM$FR.ALL) #USE THIS ONE ***

#histogram of LS3xL FR.ALL data ***
hist(poptls3xL$FR.ALL) #not normally distributed... one large column to far left
poptls3xL$logFR.ALL <- log10(poptls3xL$FR.ALL+1) #USE THIS ONE***
hist(poptls3xL$logFR.ALL) # better, but columns to left are about same height 
poptls3xL$sqrtFR.ALL <- sqrt(poptls3xL$FR.ALL)
hist(poptls3xL$sqrtFR.ALL) # skewed left, half distribution curve
poptls3xL$FR.ALLx <- 1/(poptls3xL$FR.ALL)
hist(poptls3xL$FR.ALLx) # worse
poptls3xL$rankFR.ALL <- rank(poptls3xL$FR.ALL)

##FRss
#histogram of LS3xL FRss data 
hist(poptls3xL$FRss) #not normally distributed... one large column to far left
poptls3xL$logFRss <- log10(poptls3xL$FRss+1) #USE THIS ONE***
hist(poptls3xL$logFRss) # better, but columns to left are about same height 
poptls3xL$sqrtFRss <- sqrt(poptls3xL$FRss)
hist(poptls3xL$sqrtFRss) # skewed left, half distribution curve
poptls3xL$FRssx <- 1/(poptls3xL$FRss)
hist(poptls3xL$FRssx) # worse
poptls3xL$rankFRss <- rank(poptls3xL$FRss)



##FLW
#histogram of LS2x StndFLW data ***
hist(poptls2x$StndFLW) # not normal
poptls2x$logStndFLW <- log10(poptls2x$StndFLW+1)
hist(poptls2x$logStndFLW) # not much different than raw data.
poptls2x$sqrtStndFLW <- sqrt(poptls2x$StndFLW+1)
hist(poptls2x$sqrtStndFLW) # not different than raw
#Raw and transformed plots have same one large column to left and shrink down to right
poptls2x$rankStndFLW <- rank(poptls2x$StndFLW) #USE THIS ONE ***

#histogram of LS2x FLW.ALL data ***
hist(poptls2x$FLW.ALL) # not normal... one large column to far left
poptls2x$logFLW.ALL <- log10(poptls2x$FLW.ALL+0.1)
hist(poptls2x$logFLW.ALL) #not much better than raw.. one large column to far left
poptls2x$sqrtFLW.ALL <- sqrt(poptls2x$FLW.ALL)
hist(poptls2x$sqrtFLW.ALL) #not much better than raw.. one large column to far left
poptls2x$FLW.ALLx <- 1/(poptls2x$FLW.ALL+1)
hist(poptls2x$FLW.ALLx) # better, but not good. still one large column to left and only 4 columns total
poptls2x$rankFLW.ALL <- rank(poptls2x$FLW.ALL) #USE THIS ONE***

#histogram of LS2xM FLW.ALL data ***
hist(poptls2xM$FLW.ALL) #not normally distributed... one large column to far left
poptls2xM$logFLW.ALL <- log10(poptls2xM$FLW.ALL+1) 
hist(poptls2xM$logFLW.ALL) #  tallest column is far left
poptls2xM$sqrtFLW.ALL <- sqrt(poptls2xM$FLW.ALL)
hist(poptls2xM$sqrtFLW.ALL) # same
poptls2xM$FLW.ALLx <- 1/(poptls2xM$FLW.ALL)
hist(poptls2xM$FLW.ALLx) # only four columns.. two same height far left
poptls2xM$rankFLW.ALL <- rank(poptls2xM$FLW.ALL) #USE THIS ONE ***

#histogram of LS2xL FLW.ALL data ***
hist(poptls2xL$FLW.ALL) #not normally distributed... one large column to far left
poptls2xL$logFLW.ALL <- log10(poptls2xL$FLW.ALL+1) 
hist(poptls2xL$logFLW.ALL) # same... one large column to far left
poptls2xL$sqrtFLW.ALL <- sqrt(poptls2xL$FLW.ALL)
hist(poptls2xL$sqrtFLW.ALL) # same... one large column to far left
poptls2xL$FLW.ALLx <- 1/(poptls2xL$FLW.ALL)
hist(poptls2xL$FLW.ALLx) # worse
poptls2xL$rankFLW.ALL <- rank(poptls2xL$FLW.ALL)



##Size
#LS3
#histogram of LS3x StndSize ***
hist(poptls3x$StndSize) 
poptls3x$logStndSize <- log10(poptls3x$StndSize+1) #USE THIS ONE***
hist(poptls3x$logStndSize) # much better distribution 

#histogram of LS3x SIZE ***
hist(poptls3x$SIZE) # not normal.. only two columns, one large column to far left and very small to far right
poptls3x$logSIZE <- log10(poptls3x$SIZE+1) #USE THIS ONE ***
hist(poptls3x$logSIZE) # much better, skewed slightly right

#histogram of LS3xM SIZE data ***
hist(poptls3xM$SIZE) #not normally distributed... one large column to far left
poptls3xM$logSIZE <- log10(poptls3xM$SIZE) 
hist(poptls3xM$logSIZE) # better, but middle column is smaller than columns around it
poptls3xM$sqrtSIZE <- sqrt(poptls3xM$SIZE)
hist(poptls3xM$sqrtSIZE) # worse
poptls3xM$SIZEx <- 1/(poptls3xM$SIZE)
hist(poptls3xM$SIZEx) # worse, one large column 
poptls3xM$rankSIZE <- rank(poptls3xM$SIZE) #USE THIS ONE ***

#histogram of LS3xL SIZE data ***
hist(poptls3xL$SIZE) #not normally distributed... one large column to far left
poptls3xL$logSIZE <- log10(poptls3xL$SIZE+1)  #USE THIS ONE***
hist(poptls3xL$logSIZE) # good... has one empty column space to far right
poptls3xL$sqrtSIZE <- sqrt(poptls3xL$SIZE)
hist(poptls3xL$sqrtSIZE) # worse
poptls3xL$SIZEx <- 1/(poptls3xL$SIZE)
hist(poptls3xL$SIZEx) # worse
poptls3xL$rankSIZE <- rank(poptls3xL$SIZE)


#LS2
#histogram of LS2x StndSize***
hist(poptls2x$StndSize) # not normal.. two large columns far left
poptls2x$logStndSize <- log10(poptls2x$StndSize+1) 
hist(poptls2x$logStndSize) # better, but skewed to the far left.. only half of distribution curve (very nice half though)
poptls2x$sqrtStndSize <- sqrt(poptls2x$StndSize+1) 
hist(poptls2x$sqrtStndSize) #not any better
poptls2x$StndSizex <- 1/(poptls2x$StndSize) 
hist(poptls2x$StndSizex) #not any better... more centered, but has one large column in middle and rest are very small
poptls2x$rankStndSize <- rank(poptls2x$StndSize) #USE THIS ONE***

#histogram of LS2x SIZE data***
hist(poptls2x$SIZE) # not normal.. one large column far left
poptls2x$logSIZE <- log10(poptls2x$SIZE+1) #USE THIS ONE***
hist(poptls2x$logSIZE) # much better.. nice distribution

#histogram of LS2xM SIZE data ***
hist(poptls2xM$SIZE) #not normally distributed... two large columns to far left
poptls2xM$logSIZE <- log10(poptls2xM$SIZE) #USE THIS ONE ***
hist(poptls2xM$logSIZE) # better, but middle columns are equal
poptls2xM$sqrtSIZE <- sqrt(poptls2xM$SIZE)
hist(poptls2xM$sqrtSIZE) # worse
poptls2xM$SIZEx <- 1/(poptls2xM$SIZE)
hist(poptls2xM$SIZEx) # worse, one large column 


#histogram of LS2xL SIZE data ***
hist(poptls2xL$SIZE) #not normally distributed... one large column to far left
poptls2xL$logSIZE <- log10(poptls2xL$SIZE+1)  #USE THIS ONE***
hist(poptls2xL$logSIZE) # good... slight right skew
poptls2xL$sqrtSIZE <- sqrt(poptls2xL$SIZE)
hist(poptls2xL$sqrtSIZE) # worse
poptls2xL$SIZEx <- 1/(poptls2xL$SIZE)
hist(poptls2xL$SIZEx) # worse

#LS1
#histogram of LS1x StndSize ***
hist(poptls1x$StndSize) # not normal.. one large column in middle of dataset with other columns very small
poptls1x$logStndSize <- log10(poptls1x$StndSize+1) 
hist(poptls1x$logStndSize) # not much better... one large column in middle
poptls1x$sqrtStndSize <- sqrt(poptls1x$StndSize+1) 
hist(poptls1x$sqrtStndSize) #not any better
poptls1x$StndSizex <- 1/(poptls1x$StndSize) 
hist(poptls1x$StndSizex) # the same one large column in middle
poptls1x$rankStndSize <- rank(poptls1x$StndSize) #USE THIS ONE***

#histogram of LS1x SIZE data ***
hist(poptls1x$SIZE) # not normal... half of distribution curve with largest column to left
poptls1x$logSIZE <- log10(poptls1x$SIZE+1) #USE THIS ONE***
hist(poptls1x$logSIZE) # much better.. slight skew right
poptls1x$rankSIZE <- rank(poptls1x$SIZE)

#histogram of LS1xM SIZE data ***
hist(poptls1xM$SIZE) #not normally distributed... half distribution curve to left
poptls1xM$logSIZE <- log10(poptls1xM$SIZE) #USE THIS ONE ***
hist(poptls1xM$logSIZE) # better, but gap between leftmiddle and far left, skew right
poptls1xM$sqrtSIZE <- sqrt(poptls1xM$SIZE)
hist(poptls1xM$sqrtSIZE) # okay... skew left with three taller columns
poptls1xM$SIZEx <- 1/(poptls1xM$SIZE)
hist(poptls1xM$SIZEx) # worse, two large columns 


#histogram of LS1xL SIZE data ***
hist(poptls1xL$SIZE) #not normally distributed... one large column to far left trailing right
poptls1xL$logSIZE <- log10(poptls1xL$SIZE+1)  #USE THIS ONE***
hist(poptls1xL$logSIZE) # good... slight right skew
poptls1xL$sqrtSIZE <- sqrt(poptls1xL$SIZE)
hist(poptls1xL$sqrtSIZE) # okay... left skew with three middle columns about same height
poptls1xL$SIZEx <- 1/(poptls1xL$SIZE)
hist(poptls1xL$SIZEx) # worse

##Height
#histogram of LS3x Height ***
hist(poptls3x$Height) # pretty good
poptls3x$logHeight <- log10(poptls3x$Height+1) #USE THIS ONE ***
hist(poptls3x$logHeight) # better

#histogram of LS3xM Height data ***
hist(poptls3xM$Height) #very fat bars, but okay
poptls3xM$logHeight <- log10(poptls3xM$Height) 
hist(poptls3xM$logHeight) # bit better, but gap to left
poptls3xM$sqrtHeight <- sqrt(poptls3xM$Height)
hist(poptls3xM$sqrtHeight) # much better #USE THIS ONE ***
poptls3xM$Heightx <- 1/(poptls3xM$Height)
hist(poptls3xM$Heightx) # worse than sqrt
poptls3xM$rankHeight <- rank(poptls3xM$Height) 

#histogram of LS3xL Height data ***
hist(poptls3xL$Height) #okay
poptls3xL$logHeight <- log10(poptls3xL$Height+1)  #USE THIS ONE***
hist(poptls3xL$logHeight) # better
poptls3xL$sqrtHeight <- sqrt(poptls3xL$Height)
hist(poptls3xL$sqrtHeight) # okay
poptls3xL$Heightx <- 1/(poptls3xL$Height)
hist(poptls3xL$Heightx) # worse
poptls3xL$rankHeight <- rank(poptls3xL$Height)


##D2N
#LS1
#histogram of LS1x150 StndD2N data***
hist(poptls1x150$StndD2N) # fairly good distribution but with a left skew #USE THIS ONE***

#histogram of LS1x150 D2N data***
hist(poptls1x150$D2N) # not normal... half of distribution curve with large column at far left
poptls1x150$logD2N <- log10(poptls1x150$D2N)#USE THIS ONE***
hist(poptls1x150$logD2N) # better, but one large column to right of middle
poptls1x150$sqrtD2N <- sqrt(poptls1x150$D2N) 
hist(poptls1x150$sqrtD2N) # slight left skew.. still a good distribution

#histogram of LS1xM150 D2N data ***
hist(poptls1xM150$D2N) #okay distribution... skew left
poptls1xM150$logD2N <- log10(poptls1xM150$D2N) #USE THIS ONE ***
hist(poptls1xM150$logD2N) # good
poptls1xM150$sqrtD2N <- sqrt(poptls1xM150$D2N)
hist(poptls1xM150$sqrtD2N) # okay
poptls1xM150$D2Nx <- 1/(poptls1xM150$D2N)
hist(poptls1xM150$D2Nx) # worse, two large columns to left 


#histogram of LS1xL150 D2N data ***
hist(poptls1xL150$D2N) #not normally distributed... two large columns to far left trailing right
poptls1xL150$logD2N <- log10(poptls1xL150$D2N+1)  #USE THIS ONE***
hist(poptls1xL150$logD2N) # okay... middel columns about same height
poptls1xL150$sqrtD2N <- sqrt(poptls1xL150$D2N) 
hist(poptls1xL150$sqrtD2N) # okay... left skew with three middle columns about same height
poptls1xL150$D2Nx <- 1/(poptls1xL150$D2N)
hist(poptls1xL150$D2Nx) # worse

#histogram of LS1x D2N data
hist(poptls1x$D2N) # not normal... one large column to far left and one med column to far right
poptls1x$logD2N <- log10(poptls1x$D2N) #USE THIS ONE***
hist(poptls1x$logD2N) # better, one large column at far right
poptls1x$sqrtD2N <- sqrt(poptls1x$D2N)
hist(poptls1x$sqrtD2N) # okay but skewed left with the large column at far right.
  #This shows that need to exclude 150 values

#LS2
#histogram of LS2x D2N data
hist(poptls2x$D2N) # not normal
poptls2x$logD2N <- log10(poptls2x$D2N) #USE THIS ONE***
hist(poptls2x$logD2N) #better, but one large column at far left
  #shows that need to exclude 150 values

#histogram of LS2x150 D2N data ***
hist(poptls2x150$D2N) # not too bad.. skewed left
poptls2x150$logD2N <- log10(poptls2x150$D2N) #USE THIS ONE***
hist(poptls2x150$logD2N) #better than raw

#histogram of LS2xM150 D2N data ***
hist(poptls2xM150$D2N) #poor distribution... skew left
poptls2xM150$logD2N <- log10(poptls2xM150$D2N) #USE THIS ONE ***
hist(poptls2xM150$logD2N) # okay... gap between mid left and far left, two middle columns equal
poptls2xM150$sqrtD2N <- sqrt(poptls2xM150$D2N)
hist(poptls2xM150$sqrtD2N) # okay
poptls2xM150$D2Nx <- 1/(poptls2xM150$D2N)
hist(poptls2xM150$D2Nx) # worse, two large columns to left 


#histogram of LS2xL150 D2N data ***
hist(poptls2xL150$D2N) #okay, skew left with gap in mid right
poptls2xL150$logD2N <- log10(poptls2xL150$D2N+1)  #USE THIS ONE***
hist(poptls2xL150$logD2N) # okay
poptls2xL150$sqrtD2N <- sqrt(poptls2xL150$D2N) 
hist(poptls2xL150$sqrtD2N) # okay
poptls2xL150$D2Nx <- 1/(poptls2xL150$D2N)
hist(poptls2xL150$D2Nx) # worse than raw

#histogram of LS2x150 StndD2N data ***
hist(poptls2x150$StndD2N) # pretty good.. skewed left #USE THIS ONE***

#LS3
#histogram of LS3x StndD2N data
hist(poptls3x$StndD2N) # not normal
poptls3x$logStndD2N <- log10(poptls3x$StndD2N+1)
hist(poptls3x$logStndD2N) #better, but middle column quite tall, and a medium column at far right

#histogram of LS3x D2N data***
hist(poptls3x$D2N) # not normal
poptls3x$logD2N <- log10(poptls3x$D2N) #USE THIS ONE***
hist(poptls3x$logD2N) #bit better, but not great.. has gap btwn middle and right
poptls3x$sqrtD2N <- sqrt(poptls3x$D2N)
hist(poptls3x$sqrtD2N) #worse
poptls3x$D2Nx <- 1/(poptls3x$D2N)
hist(poptls3x$D2Nx) #worse
poptls3x$rankD2N <- rank(poptls3x$D2N)

#histogram of LS3xM D2N data***
hist(poptls3xM$D2N) #not normal
poptls3xM$logD2N <- log10(poptls3xM$D2N) #USE THIS ONE***
hist(poptls3xM$logD2N) #better...has one small column to left then tallest column fading right
poptls3xM$sqrtD2N <- sqrt(poptls3xM$D2N)
hist(poptls3xM$sqrtD2N) #worse
poptls3xM$rankD2N <- rank(poptls3xM$D2N)

#histogram of LS3xL D2N data***
hist(poptls3xL$D2N) #not normal
poptls3xL$logD2N <- log10(poptls3xL$D2N) 
hist(poptls3xL$logD2N) #better...but not normal
poptls3xL$sqrtD2N <- sqrt(poptls3xL$D2N)
hist(poptls3xL$sqrtD2N) #a bit better than log, but still has one random column to far right
poptls3xL$rankD2N <- rank(poptls3xL$D2N)#USE THIS ONE***

#histogram of LS3x150 StndD2N data***
hist(poptls3x150$StndD2N) #not noraml
poptls3x150$logStndD2N <- log10(poptls3x150$StndD2N+1) #USE THIS ONE***
hist(poptls3x150$logStndD2N) # better... but still has med columns to far right
poptls3x150$sqrtStndD2N <- sqrt(poptls3x150$StndD2N+1)
hist(poptls3x150$sqrtStndD2N) # not sure which is better log or sqrt??*

#histogram of LS3x150 D2N data***
hist(poptls3x150$D2N) #not noraml
poptls3x150$logD2N <- log10(poptls3x150$D2N) #USE THIS ONE***
hist(poptls3x150$logD2N) # much better... one small column next to middle

#histogram of LS3xM150 D2N data ***
hist(poptls3xM150$D2N) #poor distribution... tallest column at far left
poptls3xM150$logD2N <- log10(poptls3xM150$D2N) #USE THIS ONE***
hist(poptls3xM150$logD2N) # okay... gap between middle and far right, two middle columns equal
poptls3xM150$sqrtD2N <- sqrt(poptls3xM150$D2N)
hist(poptls3xM150$sqrtD2N) # okay
poptls3xM150$D2Nx <- 1/(poptls3xM150$D2N)
hist(poptls3xM150$D2Nx) # worse

#histogram of LS3xL150 D2N data ***
hist(poptls3xL150$D2N) #poor... one large column and rest all small
poptls3xL150$logD2N <- log10(poptls3xL150$D2N+1)
hist(poptls3xL150$logD2N) # better, but not nice distribution
poptls3xL150$sqrtD2N <- sqrt(poptls3xL150$D2N) #USE THIS ONE***
hist(poptls3xL150$sqrtD2N) # bit better than log10, gap between middle and right
poptls3xL150$D2Nx <- 1/(poptls3xL150$D2N)
hist(poptls3xL150$D2Nx) # worse


##DDFLWFR
#LS3
#histogram of LS3x DDFLWFR data ***
hist(poptls3x$DDFLWFR) # not normal
poptls3x$logDDFLWFR <- log10(poptls3x$DDFLWFR+1)
hist(poptls3x$logDDFLWFR) #made distribution worse
poptls3x$sqrtDDFLWFR <- sqrt(poptls3x$DDFLWFR+1)
hist(poptls3x$sqrtDDFLWFR) #not any better
poptls3x$DDFLWFRx <- 1/(poptls3x$DDFLWFR+10)
hist(poptls3x$DDFLWFRx) #not better
poptls3x$rankDDFLWFR <- rank(poptls3x$DDFLWFR) #USE THIS ONE***

#histogram of LS3xM DDFLWFR data ***
hist(poptls3xM$DDFLWFR) #not normally distributed... lots of gaps
poptls3xM$logDDFLWFR <- log10(poptls3xM$DDFLWFR+1) 
hist(poptls3xM$logDDFLWFR) # worse
poptls3xM$sqrtDDFLWFR <- sqrt(poptls3xM$DDFLWFR+0.5)
hist(poptls3xM$sqrtDDFLWFR) # worse
poptls3xM$DDFLWFRx <- 1/(poptls3xM$DDFLWFR)
hist(poptls3xM$DDFLWFRx) # worse
poptls3xM$rankDDFLWFR <- rank(poptls3xM$DDFLWFR) #USE THIS ONE ***

#histogram of LS3xL DDFLWFR data ***
hist(poptls3xL$DDFLWFR) #not normally distributed... only 4 columns and gaps
poptls3xL$logDDFLWFR <- log10(poptls3xL$DDFLWFR+1)  
hist(poptls3xL$logDDFLWFR) # worse
poptls3xL$sqrtDDFLWFR <- sqrt(poptls3xL$DDFLWFR)
hist(poptls3xL$sqrtDDFLWFR) # worse
poptls3xL$DDFLWFRx <- 1/(poptls3xL$DDFLWFR)
hist(poptls3xL$DDFLWFRx) # worse
poptls3xL$rankDDFLWFR <- rank(poptls3xL$DDFLWFR) #USE THIS ONE ***


#histogram of LS3x StndDDFL.FR data***
hist(poptls3x$StndDDFL.FR)
poptls3x$logStndDDFL.FR <- log10(poptls3x$StndDDFL.FR+1)
hist(poptls3x$logStndDDFL.FR)# slightly better, but data has missing columns
poptls3x$sqrtStndDDFL.FR <- sqrt(poptls3x$StndDDFL.FR+1)
hist(poptls3x$sqrtStndDDFL.FR) #not any better, but data has missing columns
poptls3x$rankStndDDFL.FR <- rank(poptls3x$StndDDFL.FR) #USE THIS ONE***

#***************
##DDFLWF
#LS3
#histogram of LS3x DDFLWF data ***
poptls3x$logDDFLWF <- log10(poptls3x$DDFLWF+1)
poptls3x$sqrtDDFLWF <- sqrt(poptls3x$DDFLWF+0.5)
poptls3x$rankDDFLWF <- rank(poptls3x$DDFLWF, na.last="keep")

#histogram of LS3xM DDFLWF data ***
poptls3xM$logDDFLWF <- log10(poptls3xM$DDFLWF+1) 
poptls3xM$sqrtDDFLWF <- sqrt(poptls3xM$DDFLWF+0.5)
poptls3xM$rankDDFLWF <- rank(poptls3xM$DDFLWF, na.last="keep")

#histogram of LS3xL DDFLWF data ***
poptls3xL$logDDFLWF <- log10(poptls3xL$DDFLWF+1)  
poptls3xL$sqrtDDFLWF <- sqrt(poptls3xL$DDFLWF+0.5)
poptls3xL$rankDDFLWF <- rank(poptls3xL$DDFLWF, na.last="keep")
#*****************

##DDRF
#LS3
#histogram of LS3x DDRF data ***
hist(poptls3x$DDRF) # not normal
poptls3x$logDDRF <- log10(poptls3x$DDRF+1)
hist(poptls3x$logDDRF) #bit better
poptls3x$sqrtDDRF <- sqrt(poptls3x$DDRF+1)
hist(poptls3x$sqrtDDRF) #not any better
poptls3x$DDRFx <- 1/(poptls3x$DDRF+10)
hist(poptls3x$DDRFx) #better than others, but data still not normal
poptls3x$rankDDRF <- rank(poptls3x$DDRF) #USE THIS ONE***

#histogram of LS3xM DDRF data ***
hist(poptls3xM$DDRF) #not normally distributed... lots of gaps
poptls3xM$logDDRF <- log10(poptls3xM$DDRF+1) 
hist(poptls3xM$logDDRF) # bit better
poptls3xM$sqrtDDRF <- sqrt(poptls3xM$DDRF+0.5)
hist(poptls3xM$sqrtDDRF) # skew left, not any better than log
poptls3xM$DDRFx <- 1/(poptls3xM$DDRF)
hist(poptls3xM$DDRFx) # worse
poptls3xM$rankDDRF <- rank(poptls3xM$DDRF) #USE THIS ONE ***

#histogram of LS3xL DDRF data ***
hist(poptls3xL$DDRF) #not normally distributed... only 4 columns and gaps
poptls3xL$logDDRF <- log10(poptls3xL$DDRF+1)  
hist(poptls3xL$logDDRF) # bit better
poptls3xL$sqrtDDRF <- sqrt(poptls3xL$DDRF+0.5)
hist(poptls3xL$sqrtDDRF) # worse
poptls3xL$DDRFx <- 1/(poptls3xL$DDRF)
hist(poptls3xL$DDRFx) # best, but still not normal
poptls3xL$rankDDRF <- rank(poptls3xL$DDRF) #USE THIS ONE ***


##D2HT
#histogram of LS3x D2HT
hist(poptls3x$D2HT) # pretty good distribution #USE THIS ONE***
poptls3x$logD2HT <- log10(poptls3x$D2HT)

#histogram of LS3xM D2HT data ***
hist(poptls3xM$D2HT) #not good
poptls3xM$logD2HT <- log10(poptls3xM$D2HT)
hist(poptls3xM$logD2HT) # not much different than raw
poptls3xM$sqrtD2HT <- sqrt(poptls3xM$D2HT)
hist(poptls3xM$sqrtD2HT) # a lot of gaps in data, but better than log
poptls3xM$D2HTx <- 1/(poptls3xM$D2HT) #USE THIS ONE***
hist(poptls3xM$D2HTx) # a lot of gaps in data, better than log... but not much better than sqrt
poptls3xM$rankD2HT <- rank(poptls3xM$D2HT)

#histogram of LS3xL D2HT***
hist(poptls3xL$D2HT) #not too bad... but not a great distribution
poptls3xL$logD2HT <- log10(poptls3xL$D2HT)
hist(poptls3xL$logD2HT) # not much better than raw... one large column a bit right of center
poptls3xL$sqrtD2HT <- sqrt(poptls3xL$D2HT) #USE THIS ONE***
hist(poptls3xL$sqrtD2HT) # best distribution
poptls3xL$rankD2HT <- rank(poptls3xL$D2HT)

##BR
#LS3
#histogram of LS3x StndBR***
hist(poptls3x$StndBR) # pretty good distribution #USE THIS ONE***

#histogram of LS3x Branches***
hist(poptls3x$Branches) #pretty good.. two middle columns are almost equal #USE THIS ONE***
poptls3x$logBranches <- log10(poptls3x$Branches)
hist(poptls3x$logBranches) #worse
poptls3x$sqrtBranches <- sqrt(poptls3x$Branches)
hist(poptls3x$sqrtBranches) #same as raw
poptls3x$Branchesx <- 1/(poptls3x$Branches)
hist(poptls3x$Branchesx) #worse


#histogram of LS3xM Branches data ***
hist(poptls3xM$Branches) #poor... tallest column is far left
poptls3xM$logBranches <- log10(poptls3xM$Branches)
hist(poptls3xM$logBranches) # worse
poptls3xM$sqrtBranches <- sqrt(poptls3xM$Branches)
hist(poptls3xM$sqrtBranches) # worse
poptls3xM$Branchesx <- 1/(poptls3xM$Branches)
hist(poptls3xM$Branchesx) # worse
poptls3xM$rankBranches <- rank(poptls3xM$Branches) #USE THIS ONE***

#histogram of LS3xL Branches***
hist(poptls3xL$Branches) #poor.. three tall to left, three small to right
poptls3xL$logBranches <- log10(poptls3xL$Branches)
hist(poptls3xL$logBranches) # not much better... 
poptls3xL$sqrtBranches <- sqrt(poptls3xL$Branches) #USE THIS ONE***
hist(poptls3xL$sqrtBranches) # best distribution
poptls3xL$rankBranches <- rank(poptls3xL$Branches)

#LS2
#histogram of LS2x StndBR***
hist(poptls2x$StndBR) #okay... tall columns on left, small on right
poptls2x$logStndBR <- log10(poptls2x$StndBR+10)
hist(poptls2x$logStndBR) #not much better.. gap in middle of dist.
poptls2x$sqrtStndBR <- sqrt(poptls2x$StndBR+10) #USE THIS ONE***
hist(poptls2x$sqrtStndBR)# good

#histogram of LS2x Branches***
hist(poptls2x$Branches) #gradient from left to right
poptls2x$logBranches <- log10(poptls2x$Branches)
hist(poptls2x$logBranches) #not great
poptls2x$sqrtBranches <- sqrt(poptls2x$Branches)
hist(poptls2x$sqrtBranches) #not as bad as log
poptls2x$Branchesx <- 1/(poptls2x$Branches)
hist(poptls2x$Branchesx) #worse
poptls2x$rankBranches <- rank(poptls2x$Branches) #USE THIS ONE***


#histogram of LS2xM Branches data ***
hist(poptls2xM$Branches) #poor... tallest column is far left
poptls2xM$logBranches <- log10(poptls2xM$Branches)
hist(poptls2xM$logBranches) # worse
poptls2xM$sqrtBranches <- sqrt(poptls2xM$Branches)
hist(poptls2xM$sqrtBranches) #better but half distribution curve left
poptls2xM$Branchesx <- 1/(poptls2xM$Branches)
hist(poptls2xM$Branchesx) # worse
poptls2xM$rankBranches <- rank(poptls2xM$Branches)#USE THIS ONE***

#histogram of LS2xL Branches***
hist(poptls2xL$Branches) #poor.. three tall to left, three small to right
poptls2xL$logBranches <- log10(poptls2xL$Branches)
hist(poptls2xL$logBranches) # not much better... 
poptls2xL$sqrtBranches <- sqrt(poptls2xL$Branches) 
hist(poptls2xL$sqrtBranches) # tall column far left
poptls2xL$Branchesx <- 1/(poptls2xL$Branches)
hist(poptls2xL$Branchesx) # worse
poptls2xL$rankBranches <- rank(poptls2xL$Branches) #USE THIS ONE***


##Leaves
#LS1
#histogram of LS1x Leaves***
hist(poptls1x$Leaves) #okay... skewed left #USE THIS ONE***
poptls1x$logLeaves <- log10(poptls1x$Leaves+1)
hist(poptls1x$logLeaves) #not as nice as raw... gap between middle and left
poptls1x$sqrtLeaves <- sqrt(poptls1x$Leaves)
hist(poptls1x$sqrtLeaves) #same as raw
poptls1x$Leavesx <- 1/(poptls1x$Leaves)
hist(poptls1x$Leavesx)
poptls1x$rankLeaves <- rank(poptls1x$Leaves)

#histogram of LS1xM Leaves***
hist(poptls1xM$Leaves) #okay... one jut out column to left of middle #USE THIS ONE***
poptls1xM$logLeaves <- log10(poptls1xM$Leaves+1)
hist(poptls1xM$logLeaves) #not as nice as raw... gap between middle and left and skewed right
poptls1xM$sqrtLeaves <- sqrt(poptls1xM$Leaves)
hist(poptls1xM$sqrtLeaves) #worse
poptls1xM$Leavesx <- 1/(poptls1xM$Leaves)
hist(poptls1xM$Leavesx) #worse
poptls1xM$rankLeaves <- rank(poptls1xM$Leaves)

#histogram of LS1xL Leaves***
hist(poptls1xL$Leaves) #poor... skewed left 
poptls1xL$logLeaves <- log10(poptls1xL$Leaves+1)
hist(poptls1xL$logLeaves) #not much better... gap between middle and left and very small columns to right
poptls1xL$sqrtLeaves <- sqrt(poptls1xL$Leaves)
hist(poptls1xL$sqrtLeaves) #same as raw
poptls1xL$Leavesx <- 1/(poptls1xL$Leaves)
hist(poptls1xL$Leavesx) #not good.. middle column is shorter than two surrounding and large gaps
poptls1xL$rankLeaves <- rank(poptls1xL$Leaves)#USE THIS ONE***


##FlwPer
#LS3x
hist(poptls3x$FlwPer)
poptls3x$logFlwPer <- log10(poptls3x$FlwPer) 
hist(poptls3x$logFlwPer) #same as raw
poptls3x$sqrtFlwPer <- sqrt(poptls3x$FlwPer) 
hist(poptls3x$sqrtFlwPer) #worse
poptls3x$FlwPerx <- 1/(poptls3x$FlwPer) 
hist(poptls3x$FlwPerx) #same
poptls3x$rankFlwPer <- rank(poptls3x$FlwPer) 

#LS3xL
hist(poptls3xL$FlwPer)
poptls3xL$logFlwPer <- log10(poptls3xL$FlwPer) 
hist(poptls3xL$logFlwPer) #same as raw
poptls3xL$sqrtFlwPer <- sqrt(poptls3xL$FlwPer) 
hist(poptls3xL$sqrtFlwPer) #worse
poptls3xL$FlwPerx <- 1/(poptls3xL$FlwPer) 
hist(poptls3xL$FlwPerx) #same
poptls3xL$rankFlwPer <- rank(poptls3xL$FlwPer) 

#LS3xM
hist(poptls3xM$FlwPer)
poptls3xM$logFlwPer <- log10(poptls3xM$FlwPer) 
hist(poptls3xM$logFlwPer) #same as raw
poptls3xM$sqrtFlwPer <- sqrt(poptls3xM$FlwPer) 
hist(poptls3xM$sqrtFlwPer) #worse
poptls3xM$FlwPerx <- 1/(poptls3xM$FlwPer) 
hist(poptls3xM$FlwPerx) #same
poptls3xM$rankFlwPer <- rank(poptls3xM$FlwPer) 

#LS1x
hist(poptls1x$FlwPer)
poptls1x$logFlwPer <- log10(poptls1x$FlwPer) 
hist(poptls1x$logFlwPer) #same as raw
poptls1x$sqrtFlwPer <- sqrt(poptls1x$FlwPer) 
hist(poptls1x$sqrtFlwPer) #worse
poptls1x$FlwPerx <- 1/(poptls1x$FlwPer) 
hist(poptls1x$FlwPerx) #same
poptls1x$rankFlwPer <- rank(poptls1x$FlwPer) 

#LS2x
hist(poptls2x$FlwPer)
poptls2x$logFlwPer <- log10(poptls2x$FlwPer) 
hist(poptls2x$logFlwPer) #same as raw
poptls2x$sqrtFlwPer <- sqrt(poptls2x$FlwPer) 
hist(poptls2x$sqrtFlwPer) #worse
poptls2x$FlwPerx <- 1/(poptls2x$FlwPer) 
hist(poptls2x$FlwPerx) #same
poptls2x$rankFlwPer <- rank(poptls2x$FlwPer) 

##Seed Set Prpns
#PrpnD
hist(poptls3xL$PrpnD)
poptls3xL$logPrpnD <- log10(poptls3xL$PrpnD) 
hist(poptls3xL$logPrpnD) #same as raw
poptls3xL$sqrtPrpnD <- sqrt(poptls3xL$PrpnD) 
hist(poptls3xL$sqrtPrpnD) #worse
poptls3xL$PrpnDx <- 1/(poptls3xL$PrpnD) 
hist(poptls3xL$PrpnDx) #same
poptls3xL$rankPrpnD <- rank(poptls3xL$PrpnD) #**

#PrpnP
hist(poptls3xL$PrpnP)
poptls3xL$logPrpnP <- log10(poptls3xL$PrpnP) 
hist(poptls3xL$logPrpnP) #bit better than raw
poptls3xL$sqrtPrpnP <- sqrt(poptls3xL$PrpnP) 
hist(poptls3xL$sqrtPrpnP) #same
poptls3xL$PrpnPx <- 1/(poptls3xL$PrpnP) 
hist(poptls3xL$PrpnPx) #bit better #**
poptls3xL$rankPrpnP <- rank(poptls3xL$PrpnP) #**

#PrpnPD
hist(poptls3xL$PrpnPD) #pretty good
poptls3xL$logPrpnPD <- log10(poptls3xL$PrpnPD+1) 
hist(poptls3xL$logPrpnPD) #good dist. #**
poptls3xL$sqrtPrpnPD <- sqrt(poptls3xL$PrpnPD) 
hist(poptls3xL$sqrtPrpnPD) #not as good as log
poptls3xL$PrpnPDx <- 1/(poptls3xL$PrpnPD) 
hist(poptls3xL$PrpnPDx) #not as good as log
poptls3xL$rankPrpnPD <- rank(poptls3xL$PrpnPD) 

## Reproductive output at ls2 (TBud.Flw)
hist(poptls2x$TBud.Flw)
poptls2x$logBud.Flw  <- log10(poptls2x$TBud.Flw+1)
hist(poptls2x$logBud.Flw) #better... most columns same height 
poptls2x$sqrtBud.Flw  <- sqrt(poptls2x$TBud.Flw+0.5)
hist(poptls2x$sqrtBud.Flw) #same as raw
poptls2x$Bud.Flwx  <- 1/(poptls2x$TBud.Flw+1)
hist(poptls2x$Bud.Flwx) #same as raw
poptls2x$rankBud.Flw  <- rank(poptls2x$TBud.Flw)

#Bud.Flw LH
hist(poptls2xL$TBud.Flw)
poptls2xL$logBud.Flw  <- log10(poptls2xL$TBud.Flw+1)
hist(poptls2xL$logBud.Flw) #better... most columns same height
poptls2xL$sqrtBud.Flw  <- sqrt(poptls2xL$TBud.Flw+0.5)
hist(poptls2xL$sqrtBud.Flw) #same as raw
poptls2xL$Bud.Flwx  <- 1/(poptls2xL$TBud.Flw+1)
hist(poptls2xL$Bud.Flwx) #same as raw
poptls2xL$rankBud.Flw  <- rank(poptls2xL$TBud.Flw)

#Bud.Flw MNS
hist(poptls2xM$TBud.Flw)
poptls2xM$logBud.Flw  <- log10(poptls2xM$TBud.Flw+1)
hist(poptls2xM$logBud.Flw) #better... but not good
poptls2xM$sqrtBud.Flw  <- sqrt(poptls2xM$TBud.Flw+0.5)
hist(poptls2xM$sqrtBud.Flw) #same as raw
poptls2xM$Bud.Flwx  <- 1/(poptls2xM$TBud.Flw+1)
hist(poptls2xM$Bud.Flwx) #same as raw
poptls2xM$rankBud.Flw  <- rank(poptls2xM$TBud.Flw)

#total reproductive output LS3 (TBud.Flw)
hist(poptls3x$TBud.Flw)
poptls3x$logBud.Flw  <- log10(poptls3x$TBud.Flw+1)
hist(poptls3x$logBud.Flw) #better
poptls3x$sqrtBud.Flw  <- sqrt(poptls3x$TBud.Flw+0.5)
hist(poptls3x$sqrtBud.Flw) #same as raw
poptls3x$Bud.Flwx  <- 1/(poptls3x$TBud.Flw+1)
hist(poptls3x$Bud.Flwx) #worse
poptls3x$rankBud.Flw  <- rank(poptls3x$TBud.Flw)

#Bud.Flw LH
hist(poptls3xL$TBud.Flw)
poptls3xL$logBud.Flw  <- log10(poptls3xL$TBud.Flw+1)
hist(poptls3xL$logBud.Flw) #better... three columns same height
poptls3xL$sqrtBud.Flw  <- sqrt(poptls3xL$TBud.Flw+0.5)
hist(poptls3xL$sqrtBud.Flw) #same as raw
poptls3xL$Bud.Flwx  <- 1/(poptls3xL$TBud.Flw+1)
hist(poptls3xL$Bud.Flwx) #worse
poptls3xL$rankBud.Flw  <- rank(poptls3xL$TBud.Flw)

#Bud.Flw MNS
hist(poptls3xM$TBud.Flw)
poptls3xM$logBud.Flw  <- log10(poptls3xM$TBud.Flw+1)
hist(poptls3xM$logBud.Flw) #better... but not good
poptls3xM$sqrtBud.Flw  <- sqrt(poptls3xM$TBud.Flw+0.5)
hist(poptls3xM$sqrtBud.Flw) #same as raw
poptls3xM$Bud.Flwx  <- 1/(poptls3xM$TBud.Flw+1)
hist(poptls3xM$Bud.Flwx) #worse
poptls3xM$rankBud.Flw  <- rank(poptls3xM$TBud.Flw)

#save transformations to data files
write.table(poptls1x, file = "PopTag13 ls1x.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1x150, file = "PopTag13 ls1x150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xL, file = "PopTag13 ls1xL.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xL150, file = "PopTag13 ls1xL150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xM, file = "PopTag13 ls1xM.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls1xM150, file = "PopTag13 ls1xM150.csv", sep = ",", col.names = TRUE, row.names = FALSE)

write.table(poptls2x, file = "PopTag13 ls2x.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2x150, file = "PopTag13 ls2x150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xL, file = "PopTag13 ls2xL.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xL150, file = "PopTag13 ls2xL150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xM, file = "PopTag13 ls2xM.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls2xM150, file = "PopTag13 ls2xM150.csv", sep = ",", col.names = TRUE, row.names = FALSE)

write.table(poptls3x, file = "PopTag13 ls3x.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3x150, file = "PopTag13 ls3x150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xL, file = "PopTag13 ls3xL.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xL150, file = "PopTag13 ls3xL150.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xM, file = "PopTag13 ls3xM.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xM150, file = "PopTag13 ls3xM150.csv", sep = ",", col.names = TRUE, row.names = FALSE)

#These files do NOT have classes applied to variables** DNU unless change classes after running.
poptls1x <- read.csv("PopTag13 ls1x.csv") 
poptls1x150 <- read.csv("PopTag13 ls1x150.csv") 
poptls1xL <- read.csv("PopTag13 ls1xL.csv") 
poptls1xL150 <- read.csv("PopTag13 ls1xL150.csv") 
poptls1xM <- read.csv("PopTag13 ls1xM.csv") 
poptls1xM150 <- read.csv("PopTag13 ls1xM150.csv") 

poptls2x <- read.csv("PopTag13 ls2x.csv") 
poptls2x150 <- read.csv("PopTag13 ls2x150.csv") 
poptls2xL <- read.csv("PopTag13 ls2xL.csv") 
poptls2xL150 <- read.csv("PopTag13 ls2xL150.csv") 
poptls2xM <- read.csv("PopTag13 ls2xM.csv") 
poptls2xM150 <- read.csv("PopTag13 ls2xM150.csv") 

poptls3x <- read.csv("PopTag13 ls3x.csv") 
poptls3x150 <- read.csv("PopTag13 ls3x150.csv") 
poptls3xL <- read.csv("PopTag13 ls3xL.csv") 
poptls3xL150 <- read.csv("PopTag13 ls3xL150.csv") 
poptls3xM <- read.csv("PopTag13 ls3xM.csv") 
poptls3xM150 <- read.csv("PopTag13 ls3xM150.csv") 


#**********************************************************************************
#Question 1) Do traits significantly vary between zones?
  #Traits= GR, FR.ALL, FLW.ALL*, SIZE, D2N, DDFLWFR*, Branches, FlwPer
#*********************************************
#Model Analysis
###Response Variable: GR LS3x ********************

#create plot using summarySE function output and GR #CC99FF purple, 336600 green
poptls3xgr <- summarySE(poptls3x, measurevar="GR", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xgr, aes(x=Zone, y=GR, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=GR-se, ymax=GR+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Plant Growth Rate (cm/day)") +
  scale_colour_hue(name="Site", l=40) + 
  ggtitle("Mean Growth Rate by Zone (LS3x)") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#NOTE: a lot of variation in LH beach, but still no overlap between means


#outliers
mean(poptls3x$GR)
sd(poptls3x$GR)
239.76 + (3*762.5) #=2527.26, outlers= 1
mean(poptls3x[-c(1),]$GR)
sd(poptls3x[-c(1),]$GR)
146.16 + (3*197.022) #=737.23, outlers= 53, 14

poptls3x[-c(1),]$logGR  <- log10(poptls3x[-c(1),]$GR+1)
poptls3x[-c(1),]$sqrtGR  <- sqrt(poptls3x[-c(1),]$GR+0.5)
poptls3x[-c(1),]$rankGR  <- rank(poptls3x[-c(1),]$GR, na.last="keep")

#lmer testing effect of zone and site(random) on GR
lme3xgra <- lmer(logGR~Zone+(1|Site), data=poptls3x[-c(1),])
lm3xgr <- lm(logGR~Zone, data=poptls3x[-c(1),])
x <- -2*logLik(lm3xgr, REML=T) +2*logLik(lme3xgra, REML=T)
x
pchisq(x, df=3, lower.tail=F)
#logLik=6.43, p=0.092, random effect of Site marginally non sig
0.5*(1-pchisq(6.43, 3)) #=0.046
lme3xgr <- lmer(logGR~Zone+(1+Zone|Site), data=poptls3x[-c(1),])
x <- -2*logLik(lm3xgr, REML=T) +2*logLik(lme3xgr, REML=T)
x
pchisq(x, df=3, lower.tail=F)
#logLik=19.58, p=0.000208, random effect of Zone|Site sig
0.5*(1-pchisq(19.58, 3)) #=0.000104

#check assumptions of best model
lmegrR <- resid(lme3xgr) 
lmegrF <- fitted(lme3xgr)
plot(lmegrF, lmegrR) #not good... log okay
abline(h=0, col=c("red"))
hist(lmegrR) #not good... log okay
qqnorm(lmegrR, main="Q-Q plot for residuals") 
qqline(lmegrR) #not good... log okay

#lmer
lme3xgr <- lmer(logGR~Zone+(1+Zone|Site), data=poptls3x[-c(1),])
lme3xgr2  <- update(lme3xgr,~.-Zone)
anova(lme3xgr2, lme3xgr) #Zone not sig p=0.20 chisq=1.67
summary(lme3xgr)
#random: site var=0.011, zone var=0.69, resid=0.31
#fixed: intercept=2.068, zone est= -0.69


#DNU **
#allowing for heterogeneity between zones {nlme}
lmgrls3xno <- gls(logGR~1+Zone, data=poptls3xgrno3)
lmgrls3xno2 <- gls(logGR~1+Zone, data=poptls3xgrno3, weights=varIdent(form=~1|Zone*Site))
anova(lmgrls3xno2, lmgrls3xno) #weights are sig p=0.0023 lratio=14.4653
lmegrls3xno <- lme(logGR~1+Zone, random=~1|Site, data=poptls3xgrno3, weights=varIdent(form=~1|Zone*Site))
lmegrls3xno2 <- lme(logGR~1+Zone, random=~1|Site/Zone, data=poptls3xgrno3, method="ML", weights=varIdent(form=~1|Zone*Site))
lmegrls3xno3 <- lme(logGR~1+Zone, random=~1+Zone|Site, data=poptls3xgrno3,  weights=varIdent(form=~1|Zone*Site))
  #too few plants in MNSz1 to run lme model 3
anova(lmgrls3xno2, lmegrls3xno, lmegrls3xno2) #lme model 2 is best, AIC: lme1=114.12 lme2=105.22
anova(lmgrls3xno2, lmegrls3xno) #lme 1 p=0.9999 lratio=1.26e-08
0.5*(1-pchisq(0.00000001,1)) #testing on the boundary lme model 1 p=0.5000
anova(lmgrls3xno2, lmegrls3xno2) #lme model 2 is sig p=0.0043 lratio=10.9061
0.5*((1-pchisq(10.91,1))+(1-pchisq(10.91, 2))) #testing on the boundary lme model 2 p=0.0026*
lmegrls3xno2b <- lme(logGR~1, random=~1|Site/Zone, data=poptls3xgrno3, method="ML", weights=varIdent(form=~1|Zone*Site))
anova(lmegrls3xno2,lmegrls3xno2b) #Zone not sig p=0.1475 lratio=2.0977
summary(lmegrls3xno2)
#Random effect stdDev: Site=2.5775e-05, Zone/Site=0.3375 residual=0.5802
#Variance fxn: estimates: LH1=1.0, LH2=0.7625, MNS1=0.5032, MNS2=1.1574
#Fixed: Intercept=1.9862, zone est=-0.5932 tvalue=-1.6010
#**

tGRn <- tapply(poptls3x[-c(1),]$GR, list(poptls3x[-c(1),]$Zone, poptls3x[-c(1),]$Site), length)
tGRn <- tapply(poptls3x[-c(1),]$GR, list(poptls3x[-c(1),]$Zone), length)
tGRmean <- tapply(poptls3x[-c(1),]$GR, list(poptls3x[-c(1),]$Zone, poptls3x[-c(1),]$Site), mean)
tGRsd <- tapply(poptls3x[-c(1),]$GR, list(poptls3x[-c(1),]$Zone, poptls3x[-c(1),]$Site), sd)
tGRCV <- (GRsd/GRmean)*100

poptgr <- summarySE(poptls3x[-c(1),], measurevar="logGR", groupvars=c("Site", "Zone")) 
ggplot(data=poptgr, aes(x=Zone, y=logGR, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=logGR-se, ymax=logGR+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(Log[10]~Growth~Rate~(cm^3/day)))) +
  ggtitle("Mean Growth Rate by Zone (LS3x)") +
  annotate("text", x=c(0.75, 2.25, 0.75, 2.25), y=c(1.99, 1.89, 2.14, 0.85), label=paste("n=",tGRn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  scale_shape_manual(values=c(0, 1)) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
#appears as though the difference is only at MNS


#DNU **
#subset data by site, since appears to have beach vs dune diff at MNS
#allowing for heterogeneity between zones {nlme}
lmgrls3xM <- gls(logGR~1+Zone, data=poptls3xM, method="ML")
lmgrls3xM2 <- gls(logGR~1+Zone, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone))
anova(lmgrls3xM2, lmgrls3xM) #weights are significant P=0.0128 lratio=6.1926
lmgrls3xM2b <- gls(logGR~1, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone))
anova(lmgrls3xM2b, lmgrls3xM2) # zone is sig p=<0.0001 lratio=20.6396
summary(lmgrls3xM2)
#Variance fxn: estimates: MNS1=1.00, MNS2=2.3122
#Fixed: Intercept=2.1453, Zone est=-1.2970, t=-6.1916

#recheck assumptions
lmgrls3xM2R <- resid(lmgrls3xM2)
lmgrls3xM2F <- fitted(lmgrls3xM2)
qqnorm(lmgrls3xM2R, main="Q-Q plot for residuals") 
qqline(lmgrls3xM2R) #majority is on line.


#subset data by site, LH
#allowing for heterogeneity between zones {nlme}
lmgrls3xL <- gls(logGR~1+Zone, data=poptls3xL, method="ML")
lmgrls3xL2 <- gls(logGR~1+Zone, data=poptls3xL, method="ML", weights=varIdent(form=~1|Zone))
anova(lmgrls3xL2, lmgrls3xL) #weights are significant P=0.0402 lratio=4.2080
lmgrls3xL2b <- gls(logGR~1, data=poptls3xL, method="ML",  weights=varIdent(form=~1|Zone))
anova(lmgrls3xL2, lmgrls3xL2b) #Zone is NOT significant P=0.3284, lratio=0.9552
summary(lmgrls3xL2b)
#Variance fxn: estimates: LH1=1.00, LH2=0.6206
#Fixed: Intercept=1.9393

#recheck assumptions
lmgrls3xL2bR <- resid(lmgrls3xL2b)
lmgrls3xL2bF <- fitted(lmgrls3xL2b)
qqnorm(lmgrls3xL2bR, main="Q-Q plot for residuals") 
qqline(lmgrls3xL2bR) #majority is on line.
#**

#*********************************************************
###Response Variable: FR.ALL
#create plot using summarySE function output and FR.ALL
poptls3xDfr <- summarySE(poptls3xfrno2, measurevar="FR.ALL", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xDfr, aes(x=Zone, y=FR.ALL, group=Site, shape=Site)) +
    geom_errorbar(aes(ymin=FR.ALL-se, ymax=FR.ALL+se), width=0.1, position=position_dodge(0.1)) +
    geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
    xlab("Zone") + ylab("Mean Fruit Count") +
    scale_colour_hue(name="Site", l=40) + ggtitle("Mean Fruit Count by Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(0, 0,-15, -15), label=paste("n=",FRn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #raw plot shows LH does better in both Z1 and Z2, but Z1 always does better than Z2 
  # large variation in LHZ1. Try a transformation of FR.ALL

FRn <- tapply(poptls3x$FR.ALL, list(poptls3x$Zone, poptls3x$Site), length)
FRmean <- tapply(poptls3x$FR.ALL, list(poptls3x$Zone, poptls3x$Site), mean)
FRsd <- tapply(poptls3x$FR.ALL, list(poptls3x$Zone, poptls3x$Site), sd)
FRCV <- (FRsd/FRmean)*100
(mean(poptls3x$FR.ALL))+(3*sd(poptls3x$FR.ALL))
(mean(poptls3x$FR.ALL))-(3*sd(poptls3x$FR.ALL))
  #have one outlier

poptls3xfrno <- subset(poptls3x, FR.ALL < 1747)
(mean(poptls3xfrno$FR.ALL))+(3*sd(poptls3xfrno$FR.ALL))
(mean(poptls3xfrno$FR.ALL))-(3*sd(poptls3xfrno$FR.ALL))
  #few more outliers

poptls3xfrno2 <- subset(poptls3xfrno, FR.ALL < 1094)
(mean(poptls3xfrno2$FR.ALL))+(3*sd(poptls3xfrno2$FR.ALL))
(mean(poptls3xfrno2$FR.ALL))-(3*sd(poptls3xfrno2$FR.ALL))
  #no more outliers
write.table(poptls3xfrno2, file = "PopTag13 ls3x frno2.csv", sep = ",", col.names = TRUE, row.names = FALSE)

FRn <- tapply(poptls3xfrno2$FR.ALL, list(poptls3xfrno2$Zone, poptls3xfrno2$Site), length)

#plot stndFR residuals to see if need to include site as a random effect
lmls3frzsx <- lm(logFR.ALL~Zone, data=poptls3x)
lmls3frzsxR <- rstandard(lmls3frzsx) #for producing a plot against residuals
boxplot(lmls3frzsxR~Site, data=poptls3x, axes=FALSE, ylim=c(-3, 3), xlab="Site", ylab="Standardized Residuals")
abline(0,0, col=c("red"))
axis(2)
text(1:27, -2.75, levels(poptls3x$Site), cex=0.75, srt=65)
  #Above plot shows MNS below line and LH at line. Thus Site needs to be included in model

#load packages
library("lme4", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#compare models
lmefrsls3x <- lmer(logFR.ALL~1+(1|Site), data=poptls3x)
lmfrzls3x<- lm(logFR.ALL~1, data=poptls3x)
x <- -2*logLik(lmfrzls3x, REML=T) +2*logLik(lmefrsls3x, REML=T)
x # logLik=6.523666
pchisq(x, df=2, lower.tail=F) #p=0.03832
AIC(lmfrzls3x) #=130.1428
AIC(lmefrsls3x) #=128.7036
  #therefore need to include Site as random factor


lmefrsls3x2 <- lmer(logFR.ALL~1+(1+Zone|Site), data=poptls3x)
anova(lmefrsls3x, lmefrsls3x2) #Zone|Site is sig p=<0.0001 chisq=21.065
lmefrsls3x3 <- lmer(logFR.ALL~Zone+(1+Zone|Site), data=poptls3x)
anova(lmefrsls3x3, lmefrsls3x2)
  #Zone is marginally non- significant p=0.0733 chisq=3.2069

#check assumptions
lmefrsls3x3R <- resid(lmefrsls3x3)
lmefrsls3x3F <- fitted(lmefrsls3x3)
plot(lmefrsls3x3F, lmefrsls3x3R)
abline(h=0, col=c("red"))
  #fairly homogeneous variation
qqnorm(lmefrsls3x3R, main="Q-Q plot for residuals") #meets normality assumptions
boxplot(lmefrsls3x3R, poptls3x$Zone, xlab="Zone", ylab="Residuals")
  #Does NOT meet homogeneity assumptions!

#analysis with {nlme} <- log10 transformation required
lmfrls3x <- gls(logFR.ALL~1+Zone, data=poptls3xfrno2)
lmfrls3xb <- gls(logFR.ALL~1+Zone, data=poptls3xfrno2, weights=varIdent(form=~1|Zone*Site))
anova(lmfrls3xb, lmfrls3x) #weights are significant p=0.0030 lratio=13.9348
lmefrls3x <- lme(logFR.ALL~1+Zone, random=~1|Site, data=poptls3xfrno2, weights=varIdent(form=~1|Zone*Site))
lmefrls3x2 <- lme(logFR.ALL~1+Zone, random=~1|Site/Zone, data=poptls3xfrno2, method="ML", weights=varIdent(form=~1|Zone*Site))
anova(lmfrls3xb, lmefrls3x, lmefrls3x2) #lme() model 2 is best, AIC: lme1=99.4452, lme2=91.7112
anova(lmfrls3xb, lmefrls3x) #lme1 p=0.9999 lratio=1.75e-08
0.5*(1-pchisq(0.00000001, 1)) # boundary testing lme model 1 p=0.5000
anova(lmfrls3xb, lmefrls3x2) # model 2 is sig p=0.0077 lratio=9.7340
0.5*((1-pchisq(9.7340, 1))+(1-pchisq(9.7340, 2))) #boundary testing p=0.0047*
lmefrls3x2b <- lme(logFR.ALL~1, random=~1|Site/Zone, data=poptls3xfrno2, method="ML", weights=varIdent(form=~1|Zone*Site))
anova(lmefrls3x2b, lmefrls3x2) #Zone is marginally non-significant p=0.0758 lratio=3.1528
summary(lmefrls3x2)
  #random stdev: Site=2.4041e-05, Site/Zone=0.2582, residual=0.4676
  #variance structure: LH1=1.00, LH2=1.1293, MNS1=0.3926, MNS2=1.0246
  #intercept=2.1851, zone est=-0.6184 tvalue=-2.1640


#check assumptions
lmefrls3x2R <- resid(lmefrls3x2)
lmefrls3x2F <- fitted(lmefrls3x2)
plot(lmefrls3x2F, lmefrls3x2R)
abline(h=0, col=c("red"))
  #fairly homogeneous variation - bit less variation in one group than rest, but var structure accounts for this
qqnorm(lmefrls3x2R, main="Q-Q plot for residuals")
qqline(lmefrls3x2R) #majority is on line.

#create plot using summarySE function output and logFR.ALL
poptls3xDfr <- summarySE(poptls3xfrno2, measurevar="logFR.ALL", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xDfr, aes(x=Zone, y=logFR.ALL, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=logFR.ALL-se, ymax=logFR.ALL+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(Log[10]~Fruit~Count))) +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Fruit Count by Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(0.86, 0.96,0.96, 0.86), label=paste("n=",FRn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#subset data by site since MNS seems to have sig diff btwn zones
lmfrls3xM <- gls(logFR.ALL~1+Zone, data=poptls3xM, method="ML")
lmfrls3xMb <- gls(logFR.ALL~1+Zone, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone))
lmfrls3xM2 <- gls(logFR.ALL~1, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone))
anova(lmfrls3xMb, lmfrls3xM) #weights are significant p=0.0054 lratio=7.7409
anova(lmfrls3xM2, lmfrls3xMb) #Zone is significant p<0.0001 lratio=32.0047

#check assumptions
lmfrls3xM2R <- resid(lmfrls3xM2)
lmfrls3xM2F <- fitted(lmfrls3xM2)
plot(lmfrls3xM2F, lmfrls3xM2R)
abline(h=0, col=c("red"))
  #one zone had less variation than other, but used varIdent to account for that
qqnorm(lmfrls3xM2R, main="Q-Q plot for residuals")
qqline(lmfrls3xM2R) #majority is on line.

#subset data by site, LH 
lmfrls3xL <- gls(logFR.ALL~1+Zone, data=poptls3xL, method="ML")
lmfrls3xLb <- gls(logFR.ALL~1+Zone, data=poptls3xL, method="ML", weights=varIdent(form=~1|Zone))
lmfrls3xL2 <- gls(logFR.ALL~1, data=poptls3xL, method="ML")
anova(lmfrls3xLb, lmfrls3xL) #weights are not significant P=0.4171 lratio=0.6584
anova(lmfrls3xL2, lmfrls3xL) #Zone is marginally non-significant p=0.021 lratio=5.3273

#check assumptions
lmfrls3xL2R <- resid(lmfrls3xL2)
lmfrls3xL2F <- fitted(lmfrls3xL2)
plot(lmfrls3xL2F, lmfrls3xL2R)
abline(h=0, col=c("red")) # good
qqnorm(lmfrls3xL2R, main="Q-Q plot for residuals")
qqline(lmfrls3xL2R) #majority is on line.

#***************************************************
###Response Variable: FRss
#create plot using summarySE function output and FRss
poptls3xLfrs <- summarySE(poptls3xL, measurevar="FRss", groupvars=c("Zone")) 
ggplot(data=poptls3xLfrs, aes(x=Zone, y=FRss)) +
  geom_errorbar(aes(ymin=FRss-se, ymax=FRss+se), width=0.1) +
  geom_point(size=3)+
  xlab("Zone") + ylab("Mean Fruit Count [adjusted with \nproportion distal vs proximal seed]") +
  scale_colour_hue(name="Zone", l=40) + ggtitle("Mean Fruit Count (ss) by Zone at Senescence Life Stage LH") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.3, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #Adjusting fruit count with prpnPD did not seem to make any difference to mean fruit counts between zones.




#**********************************************************
###Response Variable: FLW.ALL *** Do I want to look at just Flowers?? ANS: nope, use Bud.Flw instead
    #Seems that I missed flowers for a lot of plants.
##DNU***

#plot to see how it looks
#create plot using summarySE function output and FLW.ALL
poptls2xDflw <- summarySE(poptls2x, measurevar="FLW.ALL", groupvars=c("Site", "Zone")) 
ggplot(data=poptls2xDflw, aes(x=Zone, y=FLW.ALL, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=FLW.ALL-se, ymax=FLW.ALL+se), width=0.1) +
  geom_line() + geom_point(size=3)+
  xlab("Zone") + ylab("Mean Flower Count") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Flower Count by Zone at Reproductive Life Stage") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position=c(1,0.5))+
  theme(axis.title.x = element_text(face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.5, size=16))+ 
  theme(axis.title.y = element_text(face="bold", size=20),
        axis.text.y  = element_text(size=16))
  #LH has fewer flowers in zone 1 than zone 2, MNS has more flowers in z1 than z2
  #MNS has more flowers than LH in Z1, opposite in Z2
  #Huge variation in MNS1 and LH1, and a bit in LH2. Try transformation

FLWn <- tapply(poptls2x$FLW.ALL, list(poptls2x$Zone, poptls2x$Site), length)


poptls2xDflw <- summarySE(poptls2x, measurevar="logFLW.ALL", groupvars=c("Site", "Zone")) 
ggplot(data=poptls2xDflw, aes(x=Zone, y=logFLW.ALL, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=logFLW.ALL-se, ymax=logFLW.ALL+se), width=0.1) +
  geom_line() + geom_point(size=3)+
  xlab("Zone") + ylab("log10[Mean Flower Count]") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Flower Count by Zone at Reproductive Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(0, 0.03, 0.03, 0), label=paste("n=",FLWn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position=c(1,0.5))+
  theme(axis.title.x = element_text(face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.5, size=16))+ 
  theme(axis.title.y = element_text(face="bold", size=20),
        axis.text.y  = element_text(size=16))
  #still a lot of variation in z1, and now appears to have more in z2


#plot stndFLW residuals to see if need to include site as a random effect
lmls2flwzsx <- lm(logFLW.ALL~Zone, data=poptls2x)
lmls2flwzsxR <- rstandard(lmls2flwzsx) #for producing a plot against residuals
boxplot(lmls2flwzsxR~Site, data=poptls2x, axes=FALSE, ylim=c(-3, 3), xlab="Site", ylab="Standardized Residuals")
abline(0,0, col=c("red"))
axis(2)
text(1:27, -2.75, levels(poptls2x$Site), cex=0.75, srt=65)
  #Plot shows both sites hover around the zero line. Site may not need to be included


#load package
library("lme4", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#comparing models
lmeflwsls2x <- lmer(logFLW.ALL~(1|Site), data=poptls2x)
lmflwzls2x<- lm(logFLW.ALL~1, data=poptls2x)
x <- -2*logLik(lmflwzls2x, REML=T) +2*logLik(lmeflwsls2x, REML=T)
x # logLik=0
pchisq(x, df=2, lower.tail=F) #p=1
AIC(lmflwzls2x) #= 149.9162
AIC(lmeflwsls2x) #= 156.2206
  #model without site as random has lower AIC, therefore continue with lm()

lmflwzls2x2 <- lm(logFLW.ALL~Zone, data=poptls2x)
summary(lmflwzls2x2) #No effect of zone (p=0.405, estimate=0.07796, tvalue=0.837)
lmflwzls2x2R <- resid(lmflwzls2x2)
boxplot(lmflwzls2x2R, poptls2x$Zone, xlab="Zone", ylab="Residuals") #Zone 2 has more variation
plot(lmflwzls2x2) # not very normal, but looks fine for homogeneity for FLW.ALL
  #DO I NEED TO FIX HETEROGENEITY WITH ZONE WHEN ZONE IS NOT SIGNIFICANT?****

#do analysis using {nlme}
lmeflwzls2x <- lme(logFLW.ALL~1, random=~1|Site, data=poptls2x)
lmflwzls2x <- gls(logFLW.ALL~1, data=poptls2x, method="ML")
anova(lmflwzls2x, lmeflwzls2x) #Site not significant as random effect, continue with gls()
lmflwzls2xb <- gls(logFLW.ALL~Zone, data=poptls2x, method="ML")
anova(lmflwzls2x, lmflwzls2xb) #zone not significant, AIC lower for model 1
lmflwzls2x2 <- gls(logFLW.ALL~1+Zone, data=poptls2x, method="ML", weights=varIdent(form=~1|Zone))
anova(lmflwzls2x2, lmflwzls2x) #model with varIdent has slightly higher AIC than model with no weights
summary(lmflwzls2x)

#check assumptions of gls()
lmflwzls2xbR <- resid(lmflwzls2xb)
lmflwzls2xbF <- fitted(lmflwzls2xb)
plot(lmflwzls2xbF, lmflwzls2xbR)
abline(h=0, col=c("red"))
#fairly homogeneous variation
qqnorm(lmflwzls2xbR, main="Q-Q plot for residuals") #Not normal!!!
boxplot(lmflwzls2xbR, poptls3x$Zone, xlab="Zone", ylab="Residuals") #heterogeneity


#try a different transformation with FLW.ALL data to correct normality issue
#do analysis using {nlme}
lmeflwzls2x <- lme(sqrtFLW.ALL~1, random=~1|Site, data=poptls2x, method="ML")
lmflwzls2x <- gls(sqrtFLW.ALL~1, data=poptls2x, method="ML")
anova(lmflwzls2x, lmeflwzls2x) #Site not significant as random effect, continue with gls()
lmflwzls2xb <- gls(sqrtFLW.ALL~Zone, data=poptls2x, method="ML")
anova(lmflwzls2x, lmflwzls2xb) #zone not significant, AIC lower for model 1
lmflwzls2x2 <- gls(sqrtFLW.ALL~1+Zone, data=poptls2x, method="ML", weights=varIdent(form=~1|Zone))
anova(lmflwzls2x2, lmflwzls2x) #model with varIdent has slightly higher AIC than model with no weights
summary(lmflwzls2x)

#check assumptions of gls()
lmflwzls2xbR <- resid(lmflwzls2xb)
lmflwzls2xbF <- fitted(lmflwzls2xb)
plot(lmflwzls2xbF, lmflwzls2xbR)
abline(h=0, col=c("red"))
#fairly homogeneous variation
qqnorm(lmflwzls2xbR, main="Q-Q plot for residuals") #Not normal!!!

#try a different transformation with FLW.ALL data to correct normality issue
#do analysis using {nlme}
lmeflwzls2x <- lme(rankFLW.ALL~1, random=~1|Site, data=poptls2x, method="ML")
lmflwzls2x <- gls(rankFLW.ALL~1, data=poptls2x, method="ML")
anova(lmflwzls2x, lmeflwzls2x) #Site not significant as random effect, continue with gls()
lmflwzls2xb <- gls(rankFLW.ALL~Zone, data=poptls2x, method="ML")
anova(lmflwzls2x, lmflwzls2xb) #zone slightly not significant, but slightly lower AIC for model b. 
lmflwzls2x2 <- gls(rankFLW.ALL~1+Zone, data=poptls2x, method="ML", weights=varIdent(form=~1|Zone))
anova(lmflwzls2x2, lmflwzls2xb) #model with varIdent has slightly higher AIC than model with no weights
summary(lmflwzls2x)

#check assumptions of gls()
lmflwzls2xbR <- resid(lmflwzls2xb)
lmflwzls2xbF <- fitted(lmflwzls2xb)
plot(lmflwzls2xbF, lmflwzls2xbR)
abline(h=0, col=c("red"))
#fairly homogeneous variation
qqnorm(lmflwzls2xbR, main="Q-Q plot for residuals") #Not normal, but a bit better.
#try a different transformation with FLW.ALL data to correct normality issue

#do analysis using {nlme}
lmeflwzls2x <- lme(FLW.ALLx~1, random=~1|Site, data=poptls2x)
lmflwzls2x <- gls(FLW.ALLx~1, data=poptls2x, method="ML")
anova(lmflwzls2x, lmeflwzls2x) #Site not significant as random effect, continue with gls()
lmflwzls2xb <- gls(FLW.ALLx~1+Zone, data=poptls2x, method="ML")
anova(lmflwzls2x, lmflwzls2xb) #zone slightly not significant (p=0.051), but slightly lower AIC for model b. 
lmflwzls2x2 <- gls(FLW.ALLx~1+Zone, data=poptls2x, method="ML", weights=varIdent(form=~1|Zone))
anova(lmflwzls2x2, lmflwzls2xb) #model with varIdent has slightly higher AIC than model b with no weights
summary(lmflwzls2xb)

#check assumptions of gls()
lmflwzls2xbR <- resid(lmflwzls2xb)
lmflwzls2xbF <- fitted(lmflwzls2xb)
plot(lmflwzls2xbF, lmflwzls2xbR)
abline(h=0, col=c("red"))
#fairly homogeneous variation
qqnorm(lmflwzls2xbR, main="Q-Q plot for residuals") #Not normal, and worse plot than other transform.

#*************************************************
###Response Variable: TBud.Flw
#create plot using summarySE function output and Bud.Flw LS2x
poptls2xbf <- summarySE(poptls2xbfno3, measurevar="TBud.Flw", groupvars=c("Site", "Zone")) 
ggplot(data=poptls2xbf, aes(x=Zone, y=TBud.Flw, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=TBud.Flw-se, ymax=TBud.Flw+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Total Buds and Flowers") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Buds+Flowers by Zone at LS2x") +
  annotate("text", x=c(1, 2, 1, 2), y=c(-10, 5,5, -10), label=paste("n=",bfn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

(mean(poptls2x$TBud.Flw))+(3*sd(poptls2x$TBud.Flw))
(mean(poptls2x$TBud.Flw))-(3*sd(poptls2x$TBud.Flw))

poptls2xbfno  <- subset(poptls2x, TBud.Flw < 971.39)
(mean(poptls2xbfno$TBud.Flw))+(3*sd(poptls2xbfno$TBud.Flw))
(mean(poptls2xbfno$TBud.Flw))-(3*sd(poptls2xbfno$TBud.Flw))

poptls2xbfno2  <- subset(poptls2x, TBud.Flw < 793.6)
(mean(poptls2xbfno2$TBud.Flw))+(3*sd(poptls2xbfno2$TBud.Flw))
(mean(poptls2xbfno2$TBud.Flw))-(3*sd(poptls2xbfno2$TBud.Flw))

poptls2xbfno3  <- subset(poptls2x, TBud.Flw < 633.15)
#stop here

bfn <- tapply(poptls2xbfno3$TBud.Flw, list(poptls2xbfno3$Zone, poptls2xbfno3$Site), length)
bfmean <- tapply(poptls2xbfno3$TBud.Flw, list(poptls2xbfno3$Zone, poptls2xbfno3$Site), mean)
bfsd <- tapply(poptls2xbfno3$TBud.Flw, list(poptls2xbfno3$Zone, poptls2xbfno3$Site), sd)
bfCV <- (bfsd/bfmean)*100



write.table(poptls2xbfno3, file = "PopTag13 ls2x bfno3.csv", sep = ",", col.names = TRUE, row.names = FALSE)


#run model with {nlme} to include weights function
lmbfls2x <- gls(sqrtBud.Flw~1+Zone, data=poptls2xbfno3)
lmbfls2x2 <- gls(sqrtBud.Flw~1+Zone, data=poptls2xbfno3, weights=varIdent(form=~1|Zone*Site))
anova(lmbfls2x2, lmbfls2x) #weights are significant p=0.0067 lratio=12.222
lmebfls2x <- lme(sqrtBud.Flw~1+Zone, random=~1|Site, data=poptls2xbfno3, weights=varIdent(form=~1|Zone*Site))
lmebfls2x2 <- lme(logBud.Flw~1+Zone, random=~1|Site/Zone, data=poptls2xbfno3, method="ML", weights=varIdent(form=~1|Zone*Site))
anova(lmbfls2x, lmebfls2x, lmebfls2x2) #lme2 is best, AIC: lme1=649.099, lme2=644.55*
anova(lmbfls2x, lmebfls2x2) #lme2 p=0.0021 lratio=18.77
anova(lmbfls2x, lmebfls2x) # site as random p=0.0158 lratio=12.22
lmebfls2x2b <- lme(sqrtBud.Flw~1, random=~1|Site/Zone, data=poptls2xbfno3, method="ML", weights=varIdent(form=~1|Zone*Site))
anova(lmebfls2x2b, lmebfls2x2) #Zone is significant p=0.0289 Lratio=4.77
summary(lmebfls2x2)
#random effects stdev: Site=0.0003, Site/Zone=1.52 residual=6.82
#variance structure: LH1=1.00, LH2=0.97, MNS1=0.68, MNS2=0.43
#fixed effects: intercept=11.99, zone est=-5.82, tvalue=-3.12 

#check assumptions of lme()
lmebfls2xR <- resid(lmebfls2x2)
lmebfls2xF <- fitted(lmebfls2x2)
plot(lmebfls2xF, lmebfls2xR)
abline(h=0, col=c("red"))
  #bit less variation in two zones... log transformation made better... but var structure accounts for this
qqnorm(lmebfls2xR, main="Q-Q plot for residuals")
qqline(lmebfls2xR) #not overly normal, try a transformation... acceptable with log tranformation, but not great


hist(poptls2xbfno3$TBud.Flw)
poptls2xbfno3$logBud.Flw  <- log10(poptls2xbfno3$TBud.Flw+0.1)
hist(poptls2xbfno3$logBud.Flw)#best**
poptls2xbfno3$sqrtBud.Flw  <- sqrt(poptls2xbfno3$TBud.Flw+0.5)
hist(poptls2xbfno3$sqrtBud.Flw) 
poptls2xbfno3$Bud.Flwx  <- 1/(poptls2xbfno3$TBud.Flw+1)
hist(poptls2xbfno3$Bud.Flwx)
poptls2xbfno3$rankBud.Flw  <- rank(poptls2xbfno3$TBud.Flw)


#create plot using summarySE function output and rankBud.Flw LS2x
poptls2xbf <- summarySE(poptls2xbfno3, measurevar="logBud.Flw", groupvars=c("Site", "Zone")) 
ggplot(data=poptls2xbf, aes(x=Zone, y=logBud.Flw, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=logBud.Flw-se, ymax=logBud.Flw+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(Log[10]~Total~Buds~and~Flowers))) +
  scale_colour_hue(name="Site", l=40) + ggtitle("Log Buds+Flowers by Zone at LS2x") +
  annotate("text", x=c(1, 2, 1, 2), y=c(0.83, 0.98, 0.98, 0.83), label=paste("n=",bfn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#subset data by site since MNS appears to have sig diff between zones
lmls2xbfM <- gls(logBud.Flw~1+Zone, data=poptls2xM, method="ML")
lmls2xbfM2 <- gls(logBud.Flw~1+Zone, data=poptls2xM, method="ML", weights=varIdent(form=~1|Zone))
anova(lmls2xbfM,lmls2xbfM2) #weights are not sig varIdent p=0.9729 lratio=0.0011
lmls2xbfMb <- gls(logBud.Flw~1, data=poptls2xM, method="ML")
anova(lmls2xbfMb, lmls2xbfM) #Zone is sig p<0.0001 lratio=35.0

#check assumptions
lmls2xbfM2R <- resid(lmls2xbfM)
lmls2xbfM2F <- fitted(lmls2xbfM)
plot(lmls2xbfM2F, lmls2xbfM2R)
abline(h=0, col=c("red"))
  #not good, but weights accounts for this
qqnorm(lmls2xbfM2R, main="Q-Q plot for residuals")
qqline(lmls2xbfM2R) #not great, tray transformation... log is okay



poptls2xM$logBud.Flw  <- log10(poptls2xM$TBud.Flw+0.1)
poptls2xM$sqrtBud.Flw  <- sqrt(poptls2xM$TBud.Flw+0.5)
poptls2xM$Bud.Flwx  <- 1/(poptls2xM$TBud.Flw+1)
poptls2xM$rankBud.Flw  <- rank(poptls2xM$TBud.Flw)


#subset data by site, LH
lmls2xbfL <- gls(logBud.Flw~1+Zone, data=poptls2xL,  method="ML")
lmls2xbfL2 <- gls(logBud.Flw~1+Zone, data=poptls2xL, method="ML", weights=varIdent(form=~1|Zone))
anova(lmls2xbfL,lmls2xbfL2) #weights are not sig varIdent p=0.2479 lratio=1.33
lmls2xbfLb <- gls(logBud.Flw~1, data=poptls2xL, method="ML")
anova(lmls2xbfLb, lmls2xbfL) #Zone is sig p=0.0404 lratio=4.2009

#check assumptions
lmls2xbfL2R <- resid(lmls2xbfL)
lmls2xbfL2F <- fitted(lmls2xbfL)
plot(lmls2xbfL2F, lmls2xbfL2R)
abline(h=0, col=c("red"))
  #okay... weights account for the variation
qqnorm(lmls2xbfL2R, main="Q-Q plot for residuals")
qqline(lmls2xbfL2R) #not good, try transformation... sqrt is best

poptls2xL$logBud.Flw  <- log10(poptls2xL$TBud.Flw+0.1)
poptls2xL$sqrtBud.Flw  <- sqrt(poptls2xL$TBud.Flw+0.5)
poptls2xL$Bud.Flwx  <- 1/(poptls2xL$TBud.Flw+1)
poptls2xL$rankBud.Flw  <- rank(poptls2xL$TBud.Flw)

#**************************************************
###Response Variable: SIZE
#plot to see how it looks
#create plot using summarySE function output and Size LS3
poptls3xsize <- summarySE(poptls3xszno3, measurevar="SIZE", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xsize, aes(x=Zone, y=SIZE, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=SIZE-se, ymax=SIZE+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(Plant~Size~ (cm^3)))) +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Plant Size by Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(-1000, 0,0, -1000), label=paste("n=",sizen))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #LH plants are larger than MNS in Z1 and Z2. Z1 plants are always larger than Z2. 
  #a lot of variation with LHZ1. Try transformation

sizen <- tapply(poptls3xszno3$SIZE, list(poptls3xszno3$Zone, poptls3xszno3$Site), length)
sizemean <- tapply(poptls3x$SIZE, list(poptls3x$Zone, poptls3x$Site), mean)
sizesd <- tapply(poptls3x$SIZE, list(poptls3x$Zone, poptls3x$Site), sd)
sizeCV <- (sizesd/sizemean)*100
(mean(poptls3x$SIZE))+(3*sd(poptls3x$SIZE))
(mean(poptls3x$SIZE))-(3*sd(poptls3x$SIZE))
  #one outlier

poptls3xszno <- subset(poptls3x, SIZE < 261936)
(mean(poptls3xszno$SIZE))+(3*sd(poptls3xszno$SIZE))
(mean(poptls3xszno$SIZE))-(3*sd(poptls3xszno$SIZE))
  #few more outliers

poptls3xszno2 <- subset(poptls3x, SIZE < 74653)
(mean(poptls3xszno2$SIZE))+(3*sd(poptls3xszno2$SIZE))
(mean(poptls3xszno2$SIZE))-(3*sd(poptls3xszno2$SIZE))
  #few more outliers

poptls3xszno3 <- subset(poptls3x, SIZE < 61816)
(mean(poptls3xszno3$SIZE))+(3*sd(poptls3xszno3$SIZE))
(mean(poptls3xszno3$SIZE))-(3*sd(poptls3xszno3$SIZE))
  #stop here
write.table(poptls3xszno3, file = "PopTag13 ls3x szno3.csv", sep = ",", col.names = TRUE, row.names = FALSE)



#plot stndsize residuals to see if need to include site as a random effect
lmls3sizzsx <- lm(logSIZE~Zone, data=poptls3x)
lmls3sizzsxR <- rstandard(lmls3sizzsx) #for producing a plot against residuals
boxplot(lmls3sizzsxR~Site, data=poptls3x, axes=FALSE, ylim=c(-3, 3), xlab="Site", ylab="Standardized Residuals")
abline(0,0, col=c("red"))
axis(2)
text(1:27, -2.75, levels(poptls3x$Site), cex=0.75, srt=65)
  #Plot shows that MNS hovers below zero line while LH is close to line/above. Site needs to be included in model

#load package
library("lme4", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#comparing models
lmesizesls3x <- lmer(logSIZE~1+(1|Site), data=poptls3x)
lmsizezls3x<- lm(logSIZE~1, data=poptls3x)
x <- -2*logLik(lmsizezls3x, REML=T) +2*logLik(lmesizesls3x, REML=T)
x # logLik= 7.86024
pchisq(x, df=2, lower.tail=F) #p=0.01964
AIC(lmsizezls3x) #= 153.3873
AIC(lmesizesls3x) #= 150.2366
  #Therefore Site does need to be included in model

lmesizesls3x2 <- lmer(logSIZE~1+(1+Zone|Site), data=poptls3x)
anova(lmesizesls3x, lmesizesls3x2) # Zone|Site is significant to model (p=<0.0001, chisq=18.816)
lmesizesls3x3<- lmer(logSIZE~Zone+(1+Zone|Site), data=poptls3x)
anova(lmesizesls3x3, lmesizesls3x2) #Zone is not sig fixed effect P=0.1333 chisq=2.2541
summary(lmesizesls3x2) 
  #intercept=4.0553
  #random stdev: site=0.00, Zone(Site) =0.9563, residual =0.6286

#check assumptions
lmesizesls3x3R <- resid(lmesizesls3x3)
lmesizesls3x3F <- fitted(lmesizesls3x3)
plot(lmesizesls3x3F, lmesizesls3x3R)
abline(h=0, col=c("red"))
  #fairly homogeneous variation
qqnorm(lmesizesls3x3R, main="Q-Q plot for residuals") #tail ends are off, but bulk meets assumptions
boxplot(lmesizesls3x3R, poptls3x$Zone, xlab="Zone", ylab="Residuals")
  #Does NOT meet homogeneity assumptions!! NEED TO LOOK AT THIS!

#run model with {nlme} to include weights function
lmszls3x <- gls(logSIZE~1+Zone, data=poptls3xszno3)
lmszls3x2 <- gls(logSIZE~1+Zone, data=poptls3xszno3, weights=varIdent(form=~1|Zone*Site))
anova(lmszls3x2, lmszls3x) #weights are significant p=0.0019 lratio=14.8778
lmeszls3x <- lme(logSIZE~1+Zone, random=~1|Site, data=poptls3xszno3, weights=varIdent(form=~1|Zone*Site))
lmeszls3x2 <- lme(logSIZE~1+Zone, random=~1|Site/Zone, data=poptls3xszno3,  method="ML",weights=varIdent(form=~1|Zone*Site))
anova(lmszls3x2, lmeszls3x, lmeszls3x2) #lme2 is best, AIC: lme1=117.33, lme2=108.61
anova(lmszls3x2, lmeszls3x) #lme model 1 p=>0.05 lratio=1.35e-08
0.5*(1-pchisq(0.00000001, 1)) #boundary testing p=0.49999
anova(lmszls3x2, lmeszls3x2) #lme model 2 p=0.0047 lratio=10.7167
0.5*((1-pchisq(10.72, 1))+(1-pchisq(10.72, 2))) #boundary testing p=0.0029*
lmeszls3x2b <- lme(logSIZE~1, random=~1|Site/Zone, data=poptls3xszno3, method="ML", weights=varIdent(form=~1|Zone*Site))
anova(lmeszls3x2b, lmeszls3x2) #Zone not significant p=0.1545 Lratio=2.0273
summary(lmeszls3x2)
  #random effects stdev: Site=3.4748e-05, Site/Zone=0.3548, residual=0.5416
  #variance structure: LH1=1.00, LH2=0.9470, MNS1=0.5299, MNS2=1.2964
  #fixed effects: intercept=3.8968, zone est=-0.6103 tvalue=-1.5699

#check assumptions of lme()
lmeszls3x2R <- resid(lmeszls3x2)
lmeszls3x2F <- fitted(lmeszls3x2)
plot(lmeszls3x2F, lmeszls3x2R)
abline(h=0, col=c("red"))
  #bit less in one site/zone... better with log transformation, but accounted for with weights
qqnorm(lmeszls3x2R, main="Q-Q plot for residuals")
qqline(lmeszls3x2R) #not overly normal, try a transformation... better with log tranformation

#create plot using summarySE function output and logSize LS3
poptls3xsize <- summarySE(poptls3xszno3, measurevar="logSIZE", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xsize, aes(x=Zone, y=logSIZE, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=logSIZE-se, ymax=logSIZE+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(Log[10]~Plant~Size~ (cm^3)))) +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Plant Size by Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(2.3, 2.4,2.4, 2.3), label=paste("n=",sizen))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#subset data by site since looks like MNS has diff btwn zones
#run model with {nlme} to include weights function
lmszls3xM <- gls(logSIZE~1+Zone, data=poptls3xM, method="ML")
lmszls3xMb <- gls(logSIZE~1+Zone, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone))
lmszls3xM2 <- gls(logSIZE~1, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone))
anova(lmszls3xMb, lmszls3xM) #weights are significant p=0.0069 lratio=7.2871
anova(lmszls3xM2, lmszls3xMb) #Zone is significant p=<0.0001 Lratio=19.8850

#check assumptions
lmszls3xM2R <- resid(lmszls3xM2)
lmszls3xM2F <- fitted(lmszls3xM2)
plot(lmszls3xM2F, lmszls3xM2F)
abline(h=0, col=c("red"))
  #fairly homogeneous variation, bit less in one site/zone
qqnorm(lmszls3xM2R, main="Q-Q plot for residuals")
qqline(lmszls3xM2R)

#subset data by site, LH
#run model with {nlme} to include weights function
lmszls3xL <- gls(logSIZE~1+Zone, data=poptls3xL, method="ML")
lmszls3xLb <- gls(logSIZE~1+Zone, data=poptls3xL, method="ML", weights=varIdent(form=~1|Zone))
lmszls3xL2 <- gls(logSIZE~1, data=poptls3xL, method="ML")
anova(lmszls3xLb, lmszls3xL) #weights are not significant p=0.0914 lratio=2.8497
anova(lmszls3xL2, lmszls3xL) #Zone is not significant p=0.2443 Lratio=1.3557

#check assumptions
lmszls3xLR <- resid(lmszls3xL)
lmszls3xLF <- fitted(lmszls3xL)
plot(lmszls3xLF, lmszls3xLR)
abline(h=0, col=c("red"))
  #fairly homogeneous variation
qqnorm(lmszls3xLR, main="Q-Q plot for residuals")
qqline(lmszls3xLR) #good

#**********************************************
###Response Variable: Height
#create plot using summarySE function output and Height LS3
poptls3xhi <- summarySE(poptls3xhno, measurevar="Height", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xhi, aes(x=Zone, y=Height, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=Height-se, ymax=Height+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Plant Height (cm)") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Plant Height by Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(10.7, 10.7,10.2, 10.2), label=paste("n=",heinno))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #Shows the same trend as SIZE variable: plants on beach are taller


hein <- tapply(poptls3x$Height, list(poptls3x$Zone, poptls3x$Site), length)
heinno <- tapply(poptls3xhno$Height, list(poptls3xhno$Zone, poptls3xhno$Site), length)
heimean <- tapply(poptls3x$Height, list(poptls3x$Zone, poptls3x$Site), mean)
heisd <- tapply(poptls3x$Height, list(poptls3x$Zone, poptls3x$Site), sd)
heiCV <- (heisd/heimean)*100
(mean(poptls3x$Height))+(3*sd(poptls3x$Height))
(mean(poptls3x$Height))-(3*sd(poptls3x$Height))

poptls3xhno <- subset(poptls3x, Height < 33.62)
(mean(poptls3xhno$Height))+(3*sd(poptls3xhno$Height))
(mean(poptls3xhno$Height))-(3*sd(poptls3xhno$Height))
write.table(poptls3xhno, file = "PopTag13 ls3x hno.csv", sep = ",", col.names = TRUE, row.names = FALSE)

#histogram
hist(poptls3xhno$Height)
poptls3xhno$logHeight  <- log10(poptls3xhno$Height)
hist(poptls3xhno$logHeight) #okay
poptls3xhno$sqrtHeight  <- sqrt(poptls3xhno$Height)
hist(poptls3xhno$sqrtHeight) #worse
poptls3xhno$rankHeight  <- rank(poptls3xhno$Height)

#are there differences between zones? {nlme}
lmls3xh <- gls(Height~1+Zone, data=poptls3xhno)
lmls3xhb <- gls(Height~1+Zone, data=poptls3xhno, weights=varIdent(form=~1|Zone*Site))
anova(lmls3xh,lmls3xhb) #weights are not sig varIdent p=0.3877 lratio=3.0252
lmels3xh <- lme(Height~1+Zone, random=~1|Site, data=poptls3xhno, method="ML")
lmels3xh2 <- lme(Height~1+Zone, random=~1|Site/Zone, data=poptls3xhno)
anova(lmls3xh, lmels3xh, lmels3xh2) #random effects not sig, AIC: lme1=383.30 lme2=385.22
anova(lmls3xh, lmels3xh) #lme() model 1 p=0.6278 lratio=0.2351
0.5*(1-pchisq(0.2351, 1)) #boundary testing p=0.3139
anova(lmls3xh, lmels3xh2) #lme() model 2 p=0.8571 lratio=0.3083
0.5*((1-pchisq(0.3083, 1))+(1-pchisq(0.3083, 2))) #boundary testing p=0.7179
  #keep site random effects since analyzing wild populations
lmels3xhb <- lme(Height~1, random=~1|Site, data=poptls3xhno, method="ML")
anova(lmels3xhb, lmels3xh) #Zone is not sig p=0.2035 lratio=1.6168
summary(lmels3xh)
  #Random effect stdev: Site=0.0004, residual=5.4148
  #Fixed effect: intercept=16.4231, zone est=-1.7945 tvalue=-1.2589

#check assumptions
lmels3xhR <- resid(lmels3xh)
lmels3xhF <- fitted(lmels3xh)
plot(lmels3xhF, lmels3xhR)
abline(h=0, col=c("red"))
  #fairly homogeneous variation
qqnorm(lmels3xhR, main="Q-Q plot for residuals")
qqline(lmels3xhR) #okay, use raw



poptls3xhi <- summarySE(poptls3xhno, measurevar="Height", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xhi, aes(x=Zone, y=Height, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=Height-se, ymax=Height+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Plant Height (cm)") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Plant Height by Zone at LS3x") +
  annotate("text", x=c(1, 2, 1, 2), y=c(10.5, 10.5, 10, 10), label=paste("n=",heinno))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#subset data by site since MNS appears to have sig diff between zones
lmls3xhM <- gls(rankHeight~1+Zone, data=poptls3xM, method="ML")
lmls3xhM2 <- gls(rankHeight~1+Zone, data=poptls3xM, weights=varIdent(form=~1|Zone))
anova(lmls3xhM,lmls3xhM2) #weights are not sig varIdent p=0.3106 lratio=1.0281
lmls3xhMb <- gls(rankHeight~1, data=poptls3xM, method="ML")
anova(lmls3xhMb, lmls3xhM) #Zone is sig p=0.0074 lratio=7.1815

#check assumptions
lmls3xhMR <- resid(lmls3xhM)
lmls3xhMF <- fitted(lmls3xhM)
plot(lmls3xhMF, lmls3xhMR)
abline(h=0, col=c("red"))
  #fairly homogeneous variation
qqnorm(lmls3xhMR, main="Q-Q plot for residuals")
qqline(lmls3xhMR) #try transformation...rank is good

#subset data by site, LH
lmls3xhL <- gls(rankHeight~1+Zone, data=poptls3xL, method="ML")
lmls3xhL2 <- gls(rankHeight~1+Zone, data=poptls3xL,method="ML", weights=varIdent(form=~1|Zone))
anova(lmls3xhL,lmls3xhL2) #weights are not sig varIdent p=0.9751 lratio=0.0010
lmls3xhLb <- gls(rankHeight~1, data=poptls3xL, method="ML")
anova(lmls3xhLb, lmls3xhL) #Zone is not sig p=0.7387 lratio=0.1112

#check assumptions
lmels3xhL2R <- resid(lmels3xhL2)
lmels3xhL2F <- fitted(lmels3xhL2)
plot(lmels3xhL2F, lmels3xhL2R)
abline(h=0, col=c("red"))
  #fairly homogeneous variation
qqnorm(lmels3xhL2R, main="Q-Q plot for residuals")
qqline(lmels3xhL2R) #okay but not great... try transformation... rank is best


#*****************************************
###Response Variable: D2N

#create plot using summarySE function output and D2N LS3
poptls3xDd2n <- summarySE(poptls3x, measurevar="D2N", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xDd2n, aes(x=Zone, y=D2N, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=D2N-se, ymax=D2N+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Distance to Neighbour (cm)") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Distance to Neighbour by Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(-3.0, 2.2,2.2, -3.0), label=paste("n=",d2nn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #MNS and LH lines overlap. Z1 higher than Z2 and has more variation. Try transformation

d2nn <- tapply(poptls3x$D2N, list(poptls3x$Zone, poptls3x$Site), length)
d2nmean <- tapply(poptls3x$D2N, list(poptls3x$Zone, poptls3x$Site), mean)
d2nsd <- tapply(poptls3x$D2N, list(poptls3x$Zone, poptls3x$Site), sd)
d2nCV <- (d2nsd/d2nmean)*100
(mean(poptls3x$D2N))+(3*sd(poptls3x$D2N))
(mean(poptls3x$D2N))-(3*sd(poptls3x$D2N))
  #no outliers

#create plot using summarySE function output and D2N LS3 with no 150 values
poptls3xDd2n150 <- summarySE(poptls3x150, measurevar="D2N", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xDd2n150, aes(x=Zone, y=D2N, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=D2N-se, ymax=D2N+se), width=0.1) +
  geom_line() + geom_point(size=4)+
  xlab("Zone") + ylab("Mean Distance to Neighbour") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Distance to Neighbour by Zone at Senescence Life Stage") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.3, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #Same trend as when 150 values included


#Does Site need to be included as a random effect at LS3?
lmls3xd2nzs <- lm(logD2N~Zone, data=poptls3x)
lmls3xd2nzsR <- rstandard(lmls3xd2nzs) #for producing a plot against residuals
boxplot(lmls3xd2nzsR~Site, data=poptls3x, axes=FALSE, ylim=c(-3, 3), xlab="Site", ylab="Standardized Residuals")
abline(0,0, col=c("red"))
axis(2)
text(1:27, -2.75, levels(poptls3x$Site), cex=0.75, srt=65)
  #Both sites hover around zero line, with MNS slightly below line... may not need Site effect


#load package
library("lme4", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#comparing models
lmed2nsls3x <- lmer(D2N~1+(1|Site), data=poptls3x)
lmd2nzls3x <- lm(D2N~1, data=poptls3x)
x <- -2*logLik(lmd2nzls3x, REML=T) +2*logLik(lmed2nsls3x, REML=T)
x # logLik= 0
pchisq(x, df=2, lower.tail=F) #p=1
AIC(lmd2nzls3x) #= 91.7192
AIC(lmed2nsls3x) #= 97.4234
  #Therefore site does not need to be included in model

lmd2nzls3x2 <- lm(D2N~Zone, data=poptls3x)
anova(lmd2nzls3x, lmd2nzls3x2) # Zone is significant to model (p=<0.0001, f=38.351)
summary(lmd2nzls3x2)#Estimate=-0.66893, t=-7.099, 45% of variation, f=50.394[1,49DF]

#check assumptions
plot(lmd2nzls3x2) #NOT normal, and hetergeneous
boxplot(resid(lmd2nzls3x2),poptls3x$Zone, ylab="Residuals", xlab="Zone", main="log10[D2N]")
text(1:27, c(1, 0.5), levels(poptls3x$Zone), cex=0.75)
  #try removing ploints 226, 283, 165
lmd2nzls3x2 <- lm(logD2N~Zone, data=poptls3x)
  #log transformation was better than raw, but still not great

#dealing with heterogeneity and normality using {nlme}
lmd2nsls3x <- gls(rankD2N~1+Zone, data=poptls3x)
lmd2nsls3x2 <- gls(rankD2N~1+Zone, data=poptls3x, weights=varIdent(form=~1|Zone*Site))
anova(lmd2nsls3x2, lmd2nsls3x) #weights are not significant p=0.1349 lratio=5.5628
lmed2nsls3x <- lme(rankD2N~1+Zone, random=~1|Site, data=poptls3x, method="ML")
lmed2nsls3x2 <- lme(rankD2N~1+Zone, random=~1|Site/Zone, data=poptls3x)
anova(lmd2nsls3x, lmed2nsls3x, lmed2nsls3x2) #gls() model is best, AIC: lme1=490.04 lme2=491.81
anova(lmd2nsls3x, lmed2nsls3x) # Site random effect not sig p=0.9998 lratio=7.0681e-08
0.5*(1-pchisq(0.00000007, 1)) #boundary testing p=0.4999
anova(lmd2nsls3x, lmed2nsls3x2) # Site/Zone random effect not sig p=0.8913 lratio=0.2301, but keep in model
0.5*((1-pchisq(0.2301, 1))+(1-pchisq(0.2301, 2))) #boundary testing p=0.7614
lmed2nsls3xb <- lme(rankD2N~1, random=~1|Site, data=poptls3x, method="ML")
anova(lmed2nsls3x, lmed2nsls3xb) #Zone is significant to model p=<0.0001 lratio=44.1335
summary(lmed2nsls3x)
  #random effects stdev: Site=0.0005, residual=12.4859
  #fixed effect: Intercept=45.9815, zone est=-25.6529, t=-7.8907

#check assumptions
lmed2nsls3xR <- resid(lmed2nsls3x)
lmed2nsls3xF <- fitted(lmed2nsls3x)
plot(lmed2nsls3xF, lmed2nsls3xR)
abline(h=0, col=c("red"))
  #hetergenous variation... used variance structure to allow for this variation
qqnorm(lmed2nsls3xR, main="Q-Q plot for residuals")
qqline(lmed2nsls3xR) #not normal, try transformation...not much better, rank is best

#create plot using summarySE function output and rankD2N LS3
poptls3xd2n <- summarySE(poptls3x, measurevar="rankD2N", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xd2n, aes(x=Zone, y=rankD2N, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=rankD2N-se, ymax=rankD2N+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Ranked Distance to Neighbour (cm)") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Distance to Neighbour by Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(7, 10,10, 7), label=paste("n=",d2nn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#subset data by site since MNS appears to have sig diff between zones
lmls3xd2M <- gls(rankD2N~1+Zone, data=poptls3xM, method="ML")
lmls3xd2M2 <- gls(rankD2N~1+Zone, data=poptls3xM,  weights=varIdent(form=~1|Zone))
anova(lmls3xd2M,lmls3xd2M2) #weights are not sig varIdent p=0.298 lratio=1.0833
lmls3xd2Mb <- gls(rankD2N~1, data=poptls3xM, method="ML")
anova(lmls3xd2Mb, lmls3xd2M) #Zone is sig p<0.0001 lratio=27.9434

#check assumptions
lmls3xd2M2R <- resid(lmls3xd2M2)
lmls3xd2M2F <- fitted(lmls3xd2M2)
plot(lmls3xd2M2F, lmls3xd2M2R)
abline(h=0, col=c("red"))
  #not good, but weights accounts for this
qqnorm(lmls3xd2M2R, main="Q-Q plot for residuals")
qqline(lmls3xd2M2R) #not good, tray transformation...rank is okay

#subset data by site, LH
lmls3xd2L <- gls(rankD2N~1+Zone, data=poptls3xL, method="ML")
lmls3xd2L2 <- gls(rankD2N~1+Zone, data=poptls3xL, weights=varIdent(form=~1|Zone))
anova(lmls3xd2L,lmls3xd2L2) #weights are not sig varIdent p=0.1682 lratio=1.8987
lmls3xd2Lb <- gls(rankD2N~1, data=poptls3xL, method="ML")
anova(lmls3xd2Lb, lmls3xd2L) #Zone is not sig p=<0.0001 lratio=21.0185

#check assumptions
lmls3xd2LR <- resid(lmls3xd2L)
lmls3xd2LF <- fitted(lmls3xd2L)
plot(lmls3xd2LF, lmls3xd2LR)
abline(h=0, col=c("red"))
  #fairly homogeneous variation
qqnorm(lmls3xd2LR, main="Q-Q plot for residuals")
qqline(lmls3xd2LR) #not good, try transformation... rank is best

#************************************************
###Response Variable: DDFLWFR *** Do I want to look at Flowering duration this way  <- could also do 
  #proportion of days flowering (flwper) OR flowering duration between first flowers and senescence (DDFLWF)?? 
  #***Seems that I missed first flowers for a lot of plants.

#create plot using summarySE function output and DDFLWFR
poptls3xddflwfr <- summarySE(poptls3x, measurevar="DDFLWFR", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xddflwfr, aes(x=Zone, y=DDFLWFR, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=DDFLWFR-se, ymax=DDFLWFR+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Days to fruit after flowering") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean DDFLWFR \nby Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(2.4, 1.5, 1.5, 2.4), label=paste("n=",ddflfrn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #LH and MNS have about same DDFLWFR in Z1, but MNS has higher DDFLWFR in Z2 than Z1 and higher than LH
  #LH has lower DDFLWFR in Z2 than Z1

ddflfrn <- tapply(poptls3x$DDFLWFR, list(poptls3x$Zone, poptls3x$Site), length)
ddflfrmean <- tapply(poptls3x$DDFLWFR, list(poptls3x$Zone, poptls3x$Site), mean)
ddflfrsd <- tapply(poptls3x$DDFLWFR, list(poptls3x$Zone, poptls3x$Site), sd)
ddflfrCV <- (ddflfrsd/ddflfrmean)*100
(mean(poptls3x$DDFLWFR))+(3*sd(poptls3x$DDFLWFR))
(mean(poptls3x$DDFLWFR))-(3*sd(poptls3x$DDFLWFR))
  #no outliers

#plot DDFLWFR residuals to see if need to include site as a random effect at LS1
lmls3xddflwfrzs <- lm(DDFLWFR~Zone, data=poptls3x)
lmls3xddflwfrzsR <- rstandard(lmls3xddflwfrzs) #for producing a plot against residuals
boxplot(lmls3xddflwfrzsR~Site, data=poptls3x, axes=FALSE, ylim=c(-3, 3), xlab="Site", ylab="Standardized Residuals")
abline(0,0, col=c("red"))
axis(2)
text(1:27, -2.75, levels(poptls3x$Site), cex=0.75, srt=65)
  #Both sites hover on zero line. Thus site may not need to be included in model


#load packages
library("lme4", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#compare models
lmeddflfrsls3x <- lmer(rankDDFLWFR~(1|Site), data=poptls3x)
lmddflfrzls3x<- lm(rankDDFLWFR~1, data=poptls3x)
x <- -2*logLik(lmddflfrzls3x, REML=T)+2*logLik(lmeddflfrsls3x, REML=T)
x # logLik= 0.080882
pchisq(x, df=2, lower.tail=F) #p=0.96037
AIC(lmddflfrzls3x) #= 516.3591
AIC(lmeddflfrsls3x) #= 516.1334
  #removing random factor was not significant, but AIC is lower for lmer model

lmeddflfrsls3x2 <- lmer(rankDDFLWFR~Zone+(1|Site), data=poptls3x, REML=T)
lmeddflfrsls3x3 <- lmer(rankDDFLWFR~Zone+(1+Zone|Site), data=poptls3x)
anova(lmeddflfrsls3x, lmeddflfrsls3x2) #Zone not significant (p=0.8251, Chisq=0.0488, AIC=520.31)
anova(lmeddflfrsls3x, lmeddflfrsls3x3) #Zone not significant (p=0.9972, Chisq=0.0488, AIC=524.31)
summary(lmeddflfrsls3x) #Site variance=3.742, residual=229.218
#No effect of Zone on time between flowering and fruiting

#check assumptions
lmeddflfrsls3x2R <- resid(lmeddflfrsls3x2)
lmeddflfrsls3x2F <- fitted(lmeddflfrsls3x2)
plot(lmeddflfrsls3x2F, lmeddflfrsls3x2R)
abline(h=0, col=c("red"))
#fairly homogeneous variation
qqnorm(lmeddflfrsls3x2R, main="Q-Q plot for residuals") #not normal!!
boxplot(lmeddflfrsls3x2R, poptls3x$Zone, xlab="Zone", ylab="Residuals")
#Does NOT meet homogeneity assumptions!! NEED TO LOOK AT THIS!


#dealing with heterogeneity and normality using {nlme}
lmls3xdd <- gls(DDFLWFR~1+Zone, data=poptls3x)
lmls3xdd2 <- gls(DDFLWFR~1+Zone, data=poptls3x, weights=varIdent(form=~1|Zone*Site))
anova(lmls3xdd2, lmls3xdd) #weights not sig p=0.5879 lratio=1.9260
lmels3xdd <- lme(DDFLWFR~1+Zone, random=~1|Site, data=poptls3x, method="ML")
lmels3xdd2 <- lme(DDFLWFR~1+Zone, random=~1|Site/Zone, data=poptls3x)
anova(lmls3xdd, lmels3xdd, lmels3xdd2) #random variables not sig
anova(lmls3xdd, lmels3xdd) #lme model 1 p=0.9998 lratio=7.0654e-08
  #since assessing wild populations, keep random effects in model
lmels3xddb <- lme(DDFLWFR~1, random=~1|Site, data=poptls3x, method="ML")
anova(lmels3xddb, lmels3xdd) #Zone not sig p=0.9375 lratio=0.0061
summary(lmels3xddb)

#check assumptions
lmels3xddbR <- resid(lmels3xddb)
lmels3xddbF <- fitted(lmels3xddb)
plot(lmels3xddbF, lmels3xddbR) # a bit less variation in one Zone/Site than others
abline(h=0, col=c("red"))
  #has one group with less variation
qqnorm(lmels3xddbR, main="Q-Q plot for residuals")
qqline(lmels3xddbR) #
boxplot(lmels3xddbR, poptls3x$Zone, xlab="Zone", ylab="Residuals")

#************************************************
###Response Variable: DDFLWF ***

#create plot using summarySE function output and DDFLWF
poptdd <- summarySE(poptls3x, measurevar="DDFLWF", groupvars=c("Site", "Zone")) 
ggplot(data=poptdd, aes(x=Zone, y=DDFLWF, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=DDFLWF-se, ymax=DDFLWF+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Flowering Duration (days)") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean DDFLWF \nby Zone at LS3x") +
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))




#DNU **
#{nlme}
lmls3xddf <- gls(DDFLWF~1+Zone, data=poptls3x)
lmls3xddf2 <- gls(DDFLWF~1+Zone, data=poptls3x, weights=varIdent(form=~1|Zone*Site))
lmls3xddf3 <- gls(DDFLWF~1+Zone, data=poptls3x, weights=varIdent(form=~1|Zone))
anova(lmls3xddf2, lmls3xddf, lmls3xddf3) #weights not sig p=0.1934 lratio=4.7215, p=0.8885 lratio=0.0196
lmels3xddf <- lme(DDFLWF~1+Zone, random=~1|Site, data=poptls3x,  method="ML")
lmels3xddf2 <- lme(DDFLWF~1+Zone, random=~1|Site/Zone, data=poptls3x)
anova(lmls3xddf, lmels3xddf, lmels3xddf2) #random variables sig, AIC: lme1=533.4682, lme2=535.3877
anova(lmls3xddf, lmels3xddf) #lme model 1 p=0.0014 lratio=10.1739
0.5*(1-pchisq(10.17, 1)) #boundary testing p=0.0007
anova(lmls3xddf, lmels3xddf2) #lme model 2 p=0.0059 lratio=10.25
0.5*((1-pchisq(10.25, 1))+(1-pchisq(10.25, 2))) #boundary testing p=0.0037
lmels3xddfb <- lme(DDFLWF~1, random=~1|Site, data=poptls3x, method="ML")
anova(lmels3xddfb, lmels3xddf) #Zone not sig p=0.5697 lratio=0.3231
summary(lmels3xddf)
  #random effects stdev: Site=8.6656, residual=17.6671
  #fixed effects: intercept=32.1522, zone est=-2.5776

#check assumptions
lmels3xddfR <- resid(lmels3xddf)
lmels3xddfF <- fitted(lmels3xddf)
plot(lmels3xddfF, lmels3xddfR) # a bit less variation in two Zone/Site than others
abline(h=0, col=c("red"))
#has one group with less variation
qqnorm(lmels3xddfR, main="Q-Q plot for residuals")
qqline(lmels3xddfR) #pretty good...try transformation to see if can make bit better...raw is best
boxplot(lmels3xddfR, poptls3x$Zone, xlab="Zone", ylab="Residuals")


#{nlme} subset by site  <- MNS
(mean(poptls3xM$DDFLWF))+(3*sd(poptls3xM$DDFLWF))
(mean(poptls3xM$DDFLWF))-(3*sd(poptls3xM$DDFLWF))
  #no outliers
lmls3xddfM <- gls(rankDDFLWF~1+Zone, data=poptls3xM, method="ML")
lmls3xddfM2 <- gls(rankDDFLWF~1+Zone, data=poptls3xM, weights=varIdent(form=~1|Zone))
anova(lmls3xddfM2, lmls3xddfM) #weights not sig p=0.9621 lratio=0.0023
lmls3xddfMb <- gls(rankDDFLWF~1, data=poptls3xM, method="ML")
anova(lmls3xddfMb, lmls3xddfM) #Zone not sig p=0.1758 lratio=1.8330
summary(lmls3xddfM) #intercept=9.4444, zone est=3.4786 tvalue=1.3183

#check assumptions
lmls3xddfMR <- resid(lmls3xddfM)
lmls3xddfMF <- fitted(lmls3xddfM)
plot(lmls3xddfMF, lmls3xddfMR) 
abline(h=0, col=c("red"))
  #pretty good
qqnorm(lmls3xddfMR, main="Q-Q plot for residuals")
qqline(lmls3xddfMR) #not great...try transformation to see if can make bit better...rank is best
boxplot(lmls3xddfMR, poptls3x$Zone, xlab="Zone", ylab="Residuals")


#{nlme} subset by site  <- LH
(mean(poptls3xL$DDFLWF))+(3*sd(poptls3xL$DDFLWF))
(mean(poptls3xL$DDFLWF))-(3*sd(poptls3xL$DDFLWF))
  #no outliers
lmls3xddfL <- gls(DDFLWF~1+Zone, data=poptls3xL, method="ML")
lmls3xddfL2 <- gls(DDFLWF~1+Zone, data=poptls3xL, weights=varIdent(form=~1|Zone))
anova(lmls3xddfL2, lmls3xddfL) #weights not sig p=0.4318 lratio=0.6181
lmls3xddfLb <- gls(DDFLWF~1, data=poptls3xL, method="ML")
anova(lmls3xddfLb, lmls3xddfL) #Zone not sig p=0.2947 lratio=1.0981
summary(lmls3xddfL) #intercept=43.3333, zone est=-6.6515 tvalue=-1.0284

#check assumptions
lmls3xddfLR <- resid(lmls3xddfL)
lmls3xddfLF <- fitted(lmls3xddfL)
plot(lmls3xddfLF, lmls3xddfLR) 
abline(h=0, col=c("red"))
#pretty good
qqnorm(lmls3xddfLR, main="Q-Q plot for residuals")
qqline(lmls3xddfLR) #okay...try transformation to see if can make bit better...raw is best
boxplot(lmls3xddfLR, poptls3x$Zone, xlab="Zone", ylab="Residuals")
#**

#distribution
hist(poptls3x$DDFLWF) #not great
hist(poptls3x$sqrtDDFLWF) #sqrt better, but a lot of gaps in tails

#outliers
mean(poptls3x$DDFLWF)
sd(poptls3x$DDFLWF)
33.048 + (3*19.74) #=92.27, outliers= none

#lm vs lmer
lme3xdd <- lmer(sqrtDDFLWF~Zone+(1+Zone|Site), data=poptls3x)
lme3xdda <- lmer(sqrtDDFLWF~Zone+(1|Site), data=poptls3x)
anova(lme3xdd, lme3xdda) #Zone not sig p=0.51 chisq=1.35
lm3xdd <- lm(sqrtDDFLWF~Zone, data=poptls3x)
x <- -2*logLik(lm3xdd, REML=T) +2*logLik(lme3xdda, REML=T)
x
pchisq(x, df=3, lower.tail=F)
AIC(lm3xdd) #=271.12
AIC(lme3xdda) #=268.067
#logLik=5.32, p=0.15, random effect of site not sig
0.5*(1-pchisq(5.32, 3)) #=0.075
x <- -2*logLik(lm3xdd, REML=T) +2*logLik(lme3xdd, REML=T)
x
pchisq(x, df=3, lower.tail=F)
#logLik=6.83, p=0.077, random effect of zone|site not sig
0.5*(1-pchisq(6.83, 3)) #=0.039


#check assumptions of best model
lmeddR <- resid(lme3xdd) 
lmeddF <- fitted(lme3xdd)
plot(lmeddF, lmeddR) #not the best, but okay... sqrt okay
abline(h=0, col=c("red"))
hist(lmeddR) #okay... sqrt okay
qqnorm(lmeddR, main="Q-Q plot for residuals") 
qqline(lmeddR) #not great, but okay... sqrt the same

#lmer
lme3xdd <- lmer(sqrtDDFLWF~Zone+(1+Zone|Site), data=poptls3x)
lme3xdda2  <- update(lme3xdda,~.-Zone)
anova(lme3xdda2, lme3xdd) #Zone not sig p=0.65 chisq=1.66
summary(lme3xdd)
#random: site var=2.50, resid=0.83
#fixed: intercept=5.24, zone est= -0.084

tddn <- tapply(poptls3x$DDFLWF, list(poptls3x$Zone, poptls3x$Site), length)
tddn <- tapply(poptls3x$DDFLWF, list(poptls3x$Zone), length)
tddmean <- tapply(poptls3x$DDFLWF, list(poptls3x$Zone, poptls3x$Site), mean)
tddsd <- tapply(poptls3x$DDFLWF, list(poptls3x$Zone, poptls3x$Site), sd)
tddCV <- (tddsd/tddmean)*100

poptdd <- summarySE(poptls3x, measurevar="sqrtDDFLWF", groupvars=c("Site", "Zone")) 
poptdd2 <- summarySE(poptls3x, measurevar="sqrtDDFLWF", groupvars="Zone") 
ggplot(data=poptdd2, aes(x=Zone, y=sqrtDDFLWF)) +
  geom_errorbar(aes(ymin=sqrtDDFLWF-se, ymax=sqrtDDFLWF+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(sqrt(Flowering~Duration~(days))))) +
  ggtitle("Mean DDFLWF by Zone (LS3x)") +
  annotate("text", x=c(0.75, 2.25), y=c(5.6, 5.27), label=paste("n=",tddn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#************************************************
###Response Variable: DDRF *** = Reproductive Period (days)

#create plot using summarySE function output and DDRF
poptls3xddrf <- summarySE(poptls3xdrf, measurevar="DDRF", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xddrf, aes(x=Zone, y=DDRF, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=DDRF-se, ymax=DDRF+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Duration of Reproductive \nOrgans (days)") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean DDRF \nby Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(20.5, 20.5, 17.5, 17.5), label=paste("n=",ddrfn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

poptls3xdrf  <- subset(poptls3x, DDRF < 62) #to remove NA values

ddrfn <- tapply(poptls3xdrf$DDRF, list(poptls3xdrf$Zone, poptls3xdrf$Site), length)
ddrfmean <- tapply(poptls3xdrf$DDRF, list(poptls3xdrf$Zone, poptls3xdrf$Site), mean)
ddrfsd <- tapply(poptls3xdrf$DDRF, list(poptls3xdrf$Zone, poptls3xdrf$Site), sd)
ddrfCV <- (ddrfsd/ddrfmean)*100
(mean(poptls3xdrf$DDRF))+(3*sd(poptls3xdrf$DDRF))
(mean(poptls3xdrf$DDRF))-(3*sd(poptls3xdrf$DDRF))
  #no outliers


#{nlme}
lmls3xddrf <- gls(DDRF~1+Zone, data=poptls3x, na.action="na.omit")
lmls3xddrf2 <- gls(DDRF~1+Zone, data=poptls3x, weights=varIdent(form=~1|Zone*Site), na.action="na.omit")
lmls3xddrf3 <- gls(DDRF~1+Zone, data=poptls3x, weights=varIdent(form=~1|Zone), na.action="na.omit")
anova(lmls3xddrf2, lmls3xddrf, lmls3xddrf3) # zone*site weights not sig p=0.2548 lratio=4.0622
anova(lmls3xddrf, lmls3xddrf3) # zone weights marginally non-sig p=0.0922 lratio=2.8351
lmels3xddrf <- lme(DDRF~1+Zone, random=~1|Site, data=poptls3x,method="ML",na.action="na.omit")
lmels3xddrf2 <- lme(DDRF~1+Zone, random=~1|Site/Zone, data=poptls3x, na.action="na.omit")
anova(lmls3xddrf, lmels3xddrf, lmels3xddrf2) #random variables sig, AIC: lme1=452.72, lme2=454.72
anova(lmls3xddrf, lmels3xddrf) #lme model 1 p<0.0001 lratio=19.7056
anova(lmls3xddrf, lmels3xddrf2) #lme model 2 p=0.0001 lratio=19.7056
lmels3xddrfb <- lme(DDRF~1, random=~1|Site, data=poptls3x, method="ML", na.action="na.omit")
anova(lmels3xddrfb, lmels3xddrf) #Zone is sig p=0.0006 lratio=11.8149
summary(lmels3xddrf)
#random effects stdev: Site=8.5266, residual=11.6170
#fixed effects: intercept=49.6379, zone est=-11.1358, tvalue=-3.5591

#check assumptions
lmels3xddrfR <- resid(lmels3xddrf)
lmels3xddrfF <- fitted(lmels3xddrf)
plot(lmels3xddrfF, lmels3xddrfR) # a bit less variation in two Zone/Site than others
abline(h=0, col=c("red"))
qqnorm(lmels3xddrfR, main="Q-Q plot for residuals")
qqline(lmels3xddrfR) #okay...try transformation to see if can make bit better...raw is best
boxplot(lmels3xddrfR, poptls3x$Zone, xlab="Zone", ylab="Residuals")


#{nlme} subset by site  <- MNS
lmls3xddrfM <- gls(rankDDRF~1+Zone, data=poptls3xM, method="ML",  na.action="na.omit")
lmls3xddrfM2 <- gls(rankDDRF~1+Zone, data=poptls3xM, weights=varIdent(form=~1|Zone), na.action="na.omit")
anova(lmls3xddrfM2, lmls3xddrfM) #weights not sig p=0.187 lratio=1.7413
lmls3xddrfMb <- gls(rankDDRF~1, data=poptls3xM, method="ML", na.action="na.omit")
anova(lmls3xddrfMb, lmls3xddrfM) #Zone is sig p=0.0271 lratio=4.8836
summary(lmls3xddrfM) #intercept=14.78, zone est=-5.5470 tvalue=-2.2296

#check assumptions
lmls3xddrfMR <- resid(lmls3xddrfM)
lmls3xddrfMF <- fitted(lmls3xddrfM)
plot(lmls3xddrfMF, lmls3xddrfMR) 
abline(h=0, col=c("red"))
  #okay
qqnorm(lmls3xddrfMR, main="Q-Q plot for residuals")
qqline(lmls3xddrfMR) #not good...try transformation to see if can make bit better...rank is best, but not great

poptls3xM$logDDRF  <- log10(poptls3xM$DDRF+1)
poptls3xM$sqrtDDRF  <- sqrt(poptls3xM$DDRF+0.5)
poptls3xM$DDRFx  <- 1/(poptls3xM$DDRF)
poptls3xM$rankDDRF  <- rank(poptls3xM$DDRF)

#{nlme} subset by site  <- LH
lmls3xddrfL <- gls(rankDDRF~1+Zone, data=poptls3xL, na.action="na.omit")
lmls3xddrfL2 <- gls(rankDDRF~1+Zone, data=poptls3xL,  method="ML", weights=varIdent(form=~1|Zone), na.action="na.omit")
anova(lmls3xddrfL2, lmls3xddrfL) #weights are sig p=0.041 lratio=4.1753
lmls3xddrfL2b <- gls(rankDDRF~1, data=poptls3xL, method="ML", weights=varIdent(form=~1|Zone), na.action="na.omit")
anova(lmls3xddrfL2b, lmls3xddrfL2) #Zone marginally non-sig p=0.0632 lratio=3.4516
summary(lmls3xddrfL2) #intercept=23.56, zone est=-5.56 tvalue=-1.8540

#check assumptions
lmls3xddrfL2R <- resid(lmls3xddrfL2)
lmls3xddrfL2F <- fitted(lmls3xddrfL2)
plot(lmls3xddrfL2F, lmls3xddrfL2R) 
abline(h=0, col=c("red"))
#okay, not great... weights account for this 
qqnorm(lmls3xddrfL2R, main="Q-Q plot for residuals")
qqline(lmls3xddrfL2R) #not good...try transformation to see if can make bit better...rank is best, but not great

poptls3xL$logDDRF  <- log10(poptls3xL$DDRF+1)
poptls3xL$sqrtDDRF  <- sqrt(poptls3xL$DDRF+0.5)
poptls3xL$DDRFx  <- 1/(poptls3xL$DDRF)
poptls3xL$rankDDRF  <- rank(poptls3xL$DDRF)

#***********************
##Response Variable: Branches

#create plot using summarySE function output and Branhces LS3
poptls3xbr <- summarySE(poptls3x, measurevar="Branches", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xbr, aes(x=Zone, y=Branches, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=Branches-se, ymax=Branches+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Number of Branches") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Number of Branches \nby Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(1.0, 1.5, 1.5, 1.0), label=paste("n=",brn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
  #Zone 1 does better than Z2 at both sites, with LH doing better than MNS, but has less steep slope

brn <- tapply(poptls3x$Branches, list(poptls3x$Zone, poptls3x$Site), length)
brmean <- tapply(poptls3x$Branches, list(poptls3x$Zone, poptls3x$Site), mean)
brsd <- tapply(poptls3x$Branches, list(poptls3x$Zone, poptls3x$Site), sd)
brCV <- (brsd/brmean)*100
(mean(poptls3x$Branches))+(3*sd(poptls3x$Branches))
(mean(poptls3x$Branches))-(3*sd(poptls3x$Branches))
  #no outliers

#plot stndsize residuals to see if need to include site as a random effect
lmls3brzsx <- lm(Branches~Zone, data=poptls3x)
lmls3brzsxR <- rstandard(lmls3brzsx) #for producing a plot against residuals
boxplot(lmls3brzsxR~Site, data=poptls3x, axes=FALSE, ylim=c(-3, 3), xlab="Site", ylab="Standardized Residuals")
abline(0,0, col=c("red"))
axis(2)
text(1:27, -2.75, levels(poptls3x$Site), cex=0.75, srt=65)
  #MNS is below zero line, while LH hovers at line. Site may need to be included

#load packages
library("lme4", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#compare models
lmebrsls3x <- lmer(sqrtBranches~1+(1|Site), data=poptls3x)
lmbrsls3x<- lm(sqrtBranches~1, data=poptls3x)
x <- -2*logLik(lmbrsls3x, REML=T)+2*logLik(lmebrsls3x, REML=T)
x # logLik= 8.2215
pchisq(x, df=2, lower.tail=F) #p=0.0164
AIC(lmbrsls3x) #= 134.7139
AIC(lmebrsls3x) #= 131.5032
  #Therefore, site should be included in model

lmebrsls3x2 <- lmer(sqrtBranches~1+(1+Zone|Site), data=poptls3x)
anova(lmebrsls3x, lmebrsls3x2) #Zone|Site is significant p=<0.0001 chisq=22.645
lmebrsls3x2b<- lmer(sqrtBranches~Zone+(1+Zone|Site), data=poptls3x)
anova(lmebrsls3x2b, lmebrsls3x2) # Zone marginally non-significant p=0.07993 chisq=3.0662
summary(lmebrsls3x2b)
  #random effects stdev: site=0.0952, zone|site=0.5331, residual=0.5194
  #fixed effects: intercept=2.7271, zone est=-0.7745, tvalue=-1.935

#check assumptions
lmebrsls3x2bR <- resid(lmebrsls3x2b)
lmebrsls3x2bF <- fitted(lmebrsls3x2b)
plot(lmebrsls3x2bF, lmebrsls3x2bR) # a bit less variation in one Zone/Site than others
abline(h=0, col=c("red"))
  #fairly homogeneous variation <- one group has less variation
qqnorm(lmebrsls3x2bR, main="Q-Q plot for residuals") 
qqline(lmebrsls3x2bR) #Not great... try a transformation...sqrt was best
boxplot(lmebrsls3x2bR, poptls3x$Zone, xlab="Zone", ylab="Residuals")
    #slight heterogeneity

#{nlme}
lmbrsls3x<- gls(sqrtBranches~1+Zone, data=poptls3x)
lmbrsls3x2<- gls(sqrtBranches~1+Zone, data=poptls3x, weights=varIdent(form=~1|Zone*Site))
anova(lmbrsls3x2, lmbrsls3x) #weights are sig p=0.0009 lratio=16.4992
lmebrsls3x <- lme(sqrtBranches~1+Zone, random=~1|Site, data=poptls3x, method="ML", weights=varIdent(form=~1|Zone*Site))
lmebrsls3x2 <- lme(sqrtBranches~1+Zone, random=~1|Site/Zone, data=poptls3x,  weights=varIdent(form=~1|Zone*Site))
anova(lmbrsls3x2, lmebrsls3x, lmebrsls3x2) #lme 1 is best, AIC: lme1=113.11, lme2=111.90
anova(lmbrsls3x2, lmebrsls3x) #lme() model 1 p=0.0963 lratio=2.7664
0.5*(1-pchisq(2.7664, 1)) #boundary testing p=0.0481*
anova(lmbrsls3x2, lmebrsls3x2) #lme() model 2 p=0.0502 lratio=5.9824
0.5*((1-pchisq(5.9824, 1))+(1-pchisq(5.9824, 2))) #boundary testing p=0.0323*
lmebrsls3xb <- lme(sqrtBranches~1, random=~1|Site, data=poptls3x, method="ML", weights=varIdent(form=~1|Zone*Site))
anova(lmebrsls3xb, lmebrsls3x) #Zone is significant p=0.0004, lratio=12.5240
summary(lmebrsls3x)
  #random effects stdev: Site=0.1184, residual=0.5005
  #variance structure: LH1=1.00, LH2=1.0105, MNS1=0.4779, MNS2=1.7727
  #fixed effects: intercept=2.7194, zone est=-0.5763, tvalue=-4.3697


#check assumptions
lmebrsls3xR <- resid(lmebrsls3x)
lmebrsls3xF <- fitted(lmebrsls3x)
plot(lmebrsls3xF, lmebrsls3xR) # a bit less variation in one Zone/Site than others, but weights account for this
abline(h=0, col=c("red"))
  #still has one group with less variation
qqnorm(lmebrsls3xR, main="Q-Q plot for residuals")
qqline(lmebrsls3xR) #okay, majority on line...try tranformation...sqrt is best



#create plot using summarySE function output and sqrtBranches LS3
poptls3xbr <- summarySE(poptls3x, measurevar="sqrtBranches", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xbr, aes(x=Zone, y=sqrtBranches, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=sqrtBranches-se, ymax=sqrtBranches+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab(expression(bold(sqrt(Number~of~Branches)))) +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Number of Branches \nby Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(1.15, 1.15, 1.0, 1.0), label=paste("n=",brn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#{nlme} subset by site  <- MNS
(mean(poptls3xM$Branches))+(3*sd(poptls3xM$Branches))
(mean(poptls3xM$Branches))-(3*sd(poptls3xM$Branches))
  #no outliers
lmls3xbrM <- gls(sqrtBranches~1+Zone, data=poptls3xM,  na.action="na.omit")
lmls3xbrM2 <- gls(sqrtBranches~1+Zone, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone), na.action="na.omit")
anova(lmls3xbrM2, lmls3xbrM) #weights are sig p=0.0041 lratio=8.2281
lmls3xbrM2b <- gls(sqrtBranches~1, data=poptls3xM, method="ML", weights=varIdent(form=~1|Zone), na.action="na.omit")
anova(lmls3xbrM2b, lmls3xbrM2) #Zone is sig p=<0.0001 lratio=17.5089
summary(lmls3xbrM2) #intercept=2.7296, zone est=-1.0785 tvalue=-5.4616

#check assumptions
lmls3xbrM2R <- resid(lmls3xbrM2)
lmls3xbrM2F <- fitted(lmls3xbrM2)
plot(lmls3xbrM2F, lmls3xbrM2R) 
abline(h=0, col=c("red"))
#okay
qqnorm(lmls3xbrM2R, main="Q-Q plot for residuals")
qqline(lmls3xbrM2R) #not great... use transformation to see if better...sqrt is best, but not great

poptls3xM$logBranches  <- log10(poptls3xM$Branches+1)
poptls3xM$sqrtBranches  <- sqrt(poptls3xM$Branches+0.5)
poptls3xM$Branchesx  <- 1/(poptls3xM$Branches)
poptls3xM$rankBranches  <- rank(poptls3xM$Branches)

#{nlme} subset by site  <- LH
(mean(poptls3xL$Branches))+(3*sd(poptls3xL$Branches))
(mean(poptls3xL$Branches))-(3*sd(poptls3xL$Branches))
  #no outliers
lmls3xbrL <- gls(sqrtBranches~1+Zone, data=poptls3xL, method="ML", na.action="na.omit")
lmls3xbrL2 <- gls(sqrtBranches~1+Zone, data=poptls3xL,  weights=varIdent(form=~1|Zone), na.action="na.omit")
anova(lmls3xbrL2, lmls3xbrL) #weights are not sig p=0.9408 lratio=0.0055
lmls3xbrLb <- gls(sqrtBranches~1, data=poptls3xL, method="ML", na.action="na.omit")
anova(lmls3xbrLb, lmls3xbrL) #Zone are sig p=0.0081 lratio=7.0049
summary(lmls3xbrL) #intercept=2.7848, zone est=-0.4324 tvalue=-2.6968

#check assumptions
lmls3xbrLR <- resid(lmls3xbrL)
lmls3xbrLF <- fitted(lmls3xbrL)
plot(lmls3xbrLF, lmls3xbrLR) 
abline(h=0, col=c("red"))
  #good!
qqnorm(lmls3xbrLR, main="Q-Q plot for residuals")
qqline(lmls3xbrLR) #good... transformation to see if can make bit better...sqrt is best

poptls3xL$logBranches  <- log10(poptls3xL$Branches+1)
poptls3xL$sqrtBranches  <- sqrt(poptls3xL$Branches+0.5)
poptls3xL$Branchesx  <- 1/(poptls3xL$Branches)
poptls3xL$rankBranches  <- rank(poptls3xL$Branches)

#*******************************
##Response Variable: FlwPer
#create plot using summarySE function output and FlwPer
poptls3xflwp <- summarySE(poptls3xflwno2, measurevar="FlwPer", groupvars=c("Site", "Zone")) 
ggplot(data=poptls3xflwp, aes(x=Zone, y=FlwPer, group=Site, shape=Site)) +
  geom_errorbar(aes(ymin=FlwPer-se, ymax=FlwPer+se), width=0.1, position=position_dodge(0.1)) +
  geom_line(position=position_dodge(0.1)) + geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Proportion of Days Flowering") +
  scale_colour_hue(name="Site", l=40) + ggtitle("Mean Flowering Duration \nby Zone at Senescence Life Stage") +
  annotate("text", x=c(1, 2, 1, 2), y=c(0.935, 0.94, 0.94, 0.935), label=paste("n=",flwpn))+
  theme_bw() + theme(legend.justification=c(1,0), legend.position="top", 
                     legend.text=element_text(face="bold", size=18), 
                     legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

  #MNS had longer flowering period in z2 than z2, LH had opposite
  #But, z1 and z2 and site error bars overlap, so this difference is likely non-sig.
  #NOTE: FlwPer = Date Flw/Date Finished. Thus, the lower the value, the longer the flowering period.

flwpn <- tapply(poptls3xflwno2$FlwPer, list(poptls3xflwno2$Zone, poptls3xflwno2$Site), length)
flwpmean <- tapply(poptls3x$FlwPer, list(poptls3x$Zone, poptls3x$Site), mean)
flwpsd <- tapply(poptls3x$FlwPer, list(poptls3x$Zone, poptls3x$Site), sd)
flwpCV <- (flwpsd/flwpmean)*100
(mean(poptls3x$FlwPer))+(3*sd(poptls3x$FlwPer))
(mean(poptls3x$FlwPer))-(3*sd(poptls3x$FlwPer))
  #one outlier

poptls3xflwno <- subset(poptls3x, FlwPer > 0.817)
(mean(poptls3xflwno$FlwPer))+(3*sd(poptls3xflwno$FlwPer))
(mean(poptls3xflwno$FlwPer))-(3*sd(poptls3xflwno$FlwPer))
  #one outlier

poptls3xflwno2 <- subset(poptls3x, FlwPer > 0.841)
(mean(poptls3xflwno2$FlwPer))+(3*sd(poptls3xflwno2$FlwPer))
(mean(poptls3xflwno2$FlwPer))-(3*sd(poptls3xflwno2$FlwPer))
  #no more outliers
write.table(poptls3xflwno2, file = "PopTag13 ls3x fpno2.csv", sep = ",", col.names = TRUE, row.names = FALSE)

#{nlme} is there a difference between zones?
lmls3xflwp <- gls(FlwPer~1+Zone, data=poptls3xflwno2)
lmls3xflwp2 <- gls(FlwPer~1+Zone, data=poptls3xflwno2, weights=varIdent(form=~1|Zone*Site))
anova(lmls3xflwp2, lmls3xflwp) #weights not significant p=0.5505 lratio=2.1069
lmels3xflwp <- lme(FlwPer~1+Zone, random=~1|Site, data=poptls3xflwno2, method="ML")
lmels3xflwp2 <- lme(FlwPer~1+Zone, random=~1|Site/Zone, data=poptls3xflwno2)
anova(lmls3xflwp, lmels3xflwp2, lmels3xflwp) #random variables not significant
anova(lmls3xflwp, lmels3xflwp)
  #lme model 1 p=0.3416 lratio=0.9044
  #continue using lme() model 1 since dealing with wild populations
lmels3xflwpb <- lme(FlwPer~1, random=~1|Site, data=poptls3xflwno2, method="ML")
anova(lmels3xflwpb, lmels3xflwp) #Zone not significant p=0.944 lratio=0.0049
summary(lmels3xflwp)
  #random effects stdev: site=0.0053, residual=0.0392

#check assumptions
lmels3xflwpR <- resid(lmels3xflwp)
lmels3xflwpF <- fitted(lmels3xflwp)
plot(lmels3xflwpF, lmels3xflwpR)
abline(h=0, col=c("red"))
  #okay, but appears two zones have slightly less variation... varIdent was not sig therefore not an issue
qqnorm(lmels3xflwpR, main="Q-Q plot for residuals") 
qqline(lmels3xflwpR) #not normal...try transformation...no transformations fixed issue

poptls3xflwno2$logFlwPer  <- log10(poptls3xflwno2$FlwPer)
hist(poptls3xflwno2$logFlwPer) #not good
poptls3xflwno2$sqrtFlwPer  <- sqrt(poptls3xflwno2$FlwPer+0.5)
hist(poptls3xflwno2$sqrtFlwPer) #not good
poptls3xflwno2$asinFlwPer  <- asin(sqrt(poptls3xflwno2$FlwPer))*180/pi
hist(poptls3xflwno2$asinFlwPer) #not good
poptls3xflwno2$rankFlwPer  <- rank(poptls3xflwno2$FlwPer)



#**********************************************
###Response Variable: Seed Set (PrpnPD)
#create plot using summarySE function output and Branhces LS3
poptls3xLss <- summarySE(poptls3xL, measurevar="PrpnPD", groupvars=c("Zone")) 
ggplot(data=poptls3xLss, aes(x=Zone, y=PrpnPD)) +
  geom_errorbar(aes(ymin=PrpnPD-se, ymax=PrpnPD+se), width=0.1, position=position_dodge(0.1)) +
  geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Proportion Proximal to \nDistal Fruit with Seed") +
  ggtitle("Pprn Prox to Dist seed \nby Zone at Senescence Life Stage LH") +
  annotate("text", x=c(1, 2), y=c(0.43, 0.43), label=paste("n=",ppdn))+
  theme_bw() +
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


ppdn <- tapply(poptls3xL$PrpnPD, list(poptls3xL$Zone), length)
ppdmean <- tapply(poptls3xL$PrpnPD, list(poptls3xL$Zone, poptls3xL$Site), mean)
ppdsd <- tapply(poptls3xL$PrpnPD, list(poptls3xL$Zone, poptls3xL$Site), sd)
ppdCV <- (ppdsd/ppdmean)*100
(mean(poptls3xL$PrpnPD))+(3*sd(poptls3xL$PrpnPD))
(mean(poptls3xL$PrpnPD))-(3*sd(poptls3xL$PrpnPD))
  #no outliers

#do seed prpns vary between zones? {nlme}
lmls3xLss <- gls(rankPrpnPD~1+Zone, data=poptls3xL, method="ML")
lmls3xLss2 <- gls(rankPrpnPD~1+Zone, data=poptls3xL, weights=varIdent(form=~1|Zone))
anova(lmls3xLss2, lmls3xLss) #weights not sig p=0.8751 lratio=0.0247
lmls3xLssb <- gls(rankPrpnPD~1, data=poptls3xL, method="ML")
anova(lmls3xLssb, lmls3xLss) #Zone is significant p=0.0112 lratio=6.4407
summary(lmls3xLss)
  #fixed effects: intercept=25.3611, zone est=-8.8384, tvalue=-2.5766

#check assumptions
lmls3xLssR <- resid(lmls3xLss)
lmls3xLssF <- fitted(lmls3xLss)
plot(lmls3xLssF, lmls3xLssR)
abline(h=0, col=c("red"))
  #okay
qqnorm(lmls3xLssR, main="Q-Q plot for residuals") 
qqline(lmls3xLssR) #not very normal...try transformation...no trans were great, but rank was best

poptls3xL$logPrpnPD  <- log10(poptls3xL$PrpnPD+0.1)
hist(poptls3xL$logPrpnPD)
poptls3xL$sqrtPrpnPD  <- sqrt(poptls3xL$PrpnPD+0.5)
hist(poptls3xL$sqrtPrpnPD)
poptls3xL$rankPrpnPD  <- rank(poptls3xL$PrpnPD)


#create plot using summarySE function output and PrpnPD LS3
poptls3xLss <- summarySE(poptls3xL, measurevar="rankPrpnPD", groupvars=c("Zone")) 
ggplot(data=poptls3xLss, aes(x=Zone, y=rankPrpnPD)) +
  geom_errorbar(aes(ymin=rankPrpnPD-se, ymax=rankPrpnPD+se), width=0.1, position=position_dodge(0.1)) +
  geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Ranked Proportion Proximal to \nDistal Fruit with Seed") +
  ggtitle("Pprn Prox to Dist seed \nby Zone at Senescence Life Stage LH") +
  annotate("text", x=c(1, 2), y=c(13.5, 13.5), label=paste("n=",ppdn))+
  theme_bw() +
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

poptls3xLss <- summarySE(poptls3xL, measurevar="PrpnPD", groupvars=c("Zone")) 
ggplot(data=poptls3xLss, aes(x=Zone, y=PrpnPD)) +
  geom_errorbar(aes(ymin=PrpnPD-se, ymax=PrpnPD+se), width=0.1, position=position_dodge(0.1)) +
  geom_point(size=4, position=position_dodge(0.1))+
  xlab("Zone") + ylab("Proportion Proximal to \nDistal Fruit with Seed") +
  ggtitle("Pprn Prox to Dist seed \nby Zone at Senescence Life Stage LH") +
  annotate("text", x=c(1, 2), y=c(0.42, 0.42), label=paste("n=",ppdn))+
  theme_bw() +
  theme(plot.title = element_text(vjust=2))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=0.3, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  scale_x_discrete(labels=c("Beach", "Dune")) +
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#*************************************************************************
#Are there correlations (partial) between traits (fitness)?
#********************************************

#calculate cor. p-values in matrix  <-  only works if have no missing values in matrix  <- DNU
cor.prob <- function (X, dfr = nrow(X) - 2) {
  R <- cor(X, use="pairwise.complete.obs")
  above <- row(R) < col(R)
  r2 <- R[above]^2
  Fstat <- r2 * dfr/(1 - r2)
  R[above] <- 1 - pf(Fstat, 1, dfr)
  R[row(R) == col(R)] <- NA
  R
}

##LH
names(poptls3xL)
cor(poptls3xL[,c(21, 19, 16, 48, 28, 24, 50, 13, 59)], use="pairwise.complete.obs", method="spearman")
  #NAMES: Height=16 Size=19, GR=21, D2HT=24, Branches=28, DNU[TBuds.Flw=43], FR.ALL=48, D2N=50, DDFLWF=13, PrpnPD=59
  #SIZE and FR.ALL are highly positively correlated (0.8616)
  #Branches and FR.ALL are highly positively correlated (0.7615)
  #D2N and Height are moderately positively correlated to FR.ALL (0.5221, 0.6091)
  #PrpnPD and DDFLWF have low positive correlations with FR.ALL (0.4193, 0.4712)

  #Also note: Branches, Height, and GR are highly correlated with SIZE (0.7618, 0.8475, 0.9960)
    #DDFLWF and PrpnPD have low correlation with Size (0.3921, 0.3071)
    #Branches and GR are moderately correlated with Height (0.8484)
    #Branches and GR have high correlation (0.7551)
    #DDFLWF and GR have low correlation (0.3694)
    #D2HT and D2N are moderately correlated with Branches (-0.3698, 0.4046)
    #D2HT and D2N are moderately correlated (-0.3531)
    #PrpnPD has low correlations with Branches, D2N, and DDFLWF (0.3963, 0.4144, 0.3990)


cor.test(poptls3xL$SIZE, poptls3xL$Height, method="spearman", na.action="na.omit") #* rho=0.8475 p<0.0001
cor.test(poptls3xL$SIZE, poptls3xL$GR, method="spearman", na.action="na.omit") #* rho=0.9960 p<0.0001
cor.test(poptls3xL$SIZE, poptls3xL$D2HT, method="spearman", na.action="na.omit") #rho=-0.1119 p=0.4918
cor.test(poptls3xL$SIZE, poptls3xL$Branches, method="spearman", na.action="na.omit") #* rho=0.7618 p<0.0001
cor.test(poptls3xL$SIZE, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.7831 p<0.0001 DNU
cor.test(poptls3xL$SIZE, poptls3xL$FR.ALL, method="spearman", na.action="na.omit") #* rho=0.8616 p<0.0001
cor.test(poptls3xL$SIZE, poptls3xL$D2N, method="spearman", na.action="na.omit") #rho=0.2667 p=0.0962
cor.test(poptls3xL$SIZE, poptls3xL$DDFLWF, method="spearman", na.action="na.omit") #* rho=0.3921 p=0.0123
cor.test(poptls3xL$SIZE, poptls3xL$PrpnPD, method="spearman", na.action="na.omit") #* rho=0.3071, p=0.0539
cor.test(poptls3xL$D2HT, poptls3xL$Height, method="spearman", na.action="na.omit") #rho=0.0195 p=0.9047
cor.test(poptls3xL$D2HT, poptls3xL$GR, method="spearman", na.action="na.omit") #rho=-0.1148 p=0.4807
cor.test(poptls3xL$D2HT, poptls3xL$Branches, method="spearman", na.action="na.omit") #* rho=-0.3698 p=0.0188
cor.test(poptls3xL$D2HT, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #rho=-0.2199 p=0.1728 DNU
cor.test(poptls3xL$D2HT, poptls3xL$FR.ALL, method="spearman", na.action="na.omit") #rho=-0.2659 p=0.0972
cor.test(poptls3xL$D2HT, poptls3xL$D2N, method="spearman", na.action="na.omit") #* rho=-0.3531 p=0.0254
cor.test(poptls3xL$D2HT, poptls3xL$DDFLWF, method="spearman", na.action="na.omit") #rho=0.1065 p=0.5129
cor.test(poptls3xL$D2HT, poptls3xL$PrpnPD, method="spearman", na.action="na.omit") #rho=-0.1005 p=0.5373
cor.test(poptls3xL$Branches, poptls3xL$Height, method="spearman", na.action="na.omit") #* rho=0.6595 p<0.0001
cor.test(poptls3xL$Branches, poptls3xL$GR, method="spearman", na.action="na.omit") #* rho=0.7551 p<0.0001
cor.test(poptls3xL$Branches, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.6594 p<0.0001 DNU
cor.test(poptls3xL$Branches, poptls3xL$FR.ALL, method="spearman", na.action="na.omit") #* rho=0.7615 p<0.0001
cor.test(poptls3xL$Branches, poptls3xL$D2N, method="spearman", na.action="na.omit") #* rho=0.4046 p=0.0096
cor.test(poptls3xL$Branches, poptls3xL$DDFLWF, method="spearman", na.action="na.omit") #rho=0.2834 p=0.0764
cor.test(poptls3xL$Branches, poptls3xL$PrpnPD, method="spearman", na.action="na.omit") #* rho=0.3963 p=0.0114
cor.test(poptls3xL$FR.ALL, poptls3xL$Height, method="spearman", na.action="na.omit") #* rho=0.6091 p<0.0001
cor.test(poptls3xL$FR.ALL, poptls3xL$GR, method="spearman", na.action="na.omit") #* rho=0.8487 p<0.0001
cor.test(poptls3xL$FR.ALL, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.8227 p<0.0001 DNU
cor.test(poptls3xL$FR.ALL, poptls3xL$D2N, method="spearman", na.action="na.omit") #* rho=0.5221 p=0.0005
cor.test(poptls3xL$FR.ALL, poptls3xL$DDFLWF, method="spearman", na.action="na.omit") #* rho=0.4712 p=0.0021
cor.test(poptls3xL$FR.ALL, poptls3xL$PrpnPD, method="spearman", na.action="na.omit") #* rho=0.4193 p=0.0071
cor.test(poptls3xL$D2N, poptls3xL$DDFLWF, method="spearman", na.action="na.omit") #rho=0.2402 p=0.1354
cor.test(poptls3xL$D2N, poptls3xL$Height, method="spearman", na.action="na.omit") #rho=0.1695 p=0.2958
cor.test(poptls3xL$D2N, poptls3xL$GR, method="spearman", na.action="na.omit") #rho=0.2450 p=0.1275
cor.test(poptls3xL$D2N, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.4694 p=0.0022 DNU
cor.test(poptls3xL$D2N, poptls3xL$PrpnPD, method="spearman", na.action="na.omit") #* rho=0.4144 p=0.0079
cor.test(poptls3xL$DDFLWF, poptls3xL$Height, method="spearman", na.action="na.omit") #rho=0.2044 p=0.2058
cor.test(poptls3xL$DDFLWF, poptls3xL$GR, method="spearman", na.action="na.omit") #* rho=0.3694 p=0.0190
cor.test(poptls3xL$DDFLWF, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.5162 p=0.0006 DNU
cor.test(poptls3xL$DDFLWF, poptls3xL$PrpnPD, method="spearman", na.action="na.omit") #* rho=0.3990 p=0.0108
cor.test(poptls3xL$PrpnPD, poptls3xL$Height, method="spearman", na.action="na.omit") #rho=0.1635 p=0.3134
cor.test(poptls3xL$PrpnPD, poptls3xL$GR, method="spearman", na.action="na.omit") #rho=0.2689 p=0.0934
cor.test(poptls3xL$PrpnPD, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.5019 p=0.001 DNU
cor.test(poptls3xL$Height, poptls3xL$GR, method="spearman", na.action="na.omit") #* rho=0.8484 p<0.0001
cor.test(poptls3xL$Height, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.5051 p=0.0009 DNU
cor.test(poptls3xL$GR, poptls3xL$TBud.Flw, method="spearman", na.action="na.omit") #* rho=0.7691 p=<0.0001 DNU


#cor by zone
poptls3xL1  <- subset(poptls3xL, Zone == "1")
poptls3xL1$rankGR  <- rank(poptls3xL1$GR)
poptls3xL1$rankSIZE  <- rank(poptls3xL1$SIZE)
poptls3xL1$rankHeight <- rank(poptls3xL1$Height)
poptls3xL1$rankFR.ALL  <- rank(poptls3xL1$FR.ALL)
poptls3xL1$rankBranches  <- rank(poptls3xL1$Branches)
poptls3xL1$rankD2N  <- rank(poptls3xL1$D2N)
poptls3xL1$rankD2HT  <- rank(poptls3xL1$D2HT)
poptls3xL1$rankDDFLWF  <- rank(poptls3xL1$DDFLWF)
poptls3xL1$rankPrpnPD  <- rank(poptls3xL1$PrpnPD)
write.table(poptls3xL1, file = "PopTag13 all_indivLS_ls3x_LH_z1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
poptls3xL2 <- subset(poptls3xL, Zone == "2")
poptls3xL2$rankGR  <- rank(poptls3xL2$GR)
poptls3xL2$rankSIZE  <- rank(poptls3xL2$SIZE)
poptls3xL2$rankHeight <- rank(poptls3xL2$Height)
poptls3xL2$rankFR.ALL  <- rank(poptls3xL2$FR.ALL)
poptls3xL2$rankBranches  <- rank(poptls3xL2$Branches)
poptls3xL2$rankD2N  <- rank(poptls3xL2$D2N)
poptls3xL2$rankD2HT  <- rank(poptls3xL2$D2HT)
poptls3xL2$rankDDFLWF  <- rank(poptls3xL2$DDFLWF)
poptls3xL2$rankPrpnPD  <- rank(poptls3xL2$PrpnPD)
write.table(poptls3xL2, file = "PopTag13 all_indivLS_ls3x_LH_z2.csv", sep = ",", col.names = TRUE, row.names = FALSE)

names(poptls3xL1)
names(poptls3xL2)

cor(poptls3xL1[,c(21, 19, 16, 48, 28, 24, 50, 13, 59)], use="pairwise.complete.obs", method="spearman")
cor(poptls3xL2[,c(21, 19, 16, 48, 28, 24, 50, 13, 59)], use="pairwise.complete.obs", method="spearman")


cor.test(poptls3xL1$GR, poptls3xL1$SIZE, method="spearman", na.action="na.omit") #p = <0.0001 *
cor.test(poptls3xL1$GR, poptls3xL1$Height, method="spearman", na.action="na.omit") #p = <0.0001 *
cor.test(poptls3xL1$GR, poptls3xL1$FR.ALL, method="spearman", na.action="na.omit") #p = <0.0001 *
cor.test(poptls3xL1$GR, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = <0.0001 * DNU
cor.test(poptls3xL1$GR, poptls3xL1$Branches, method="spearman", na.action="na.omit") #p = <0.0001 *
cor.test(poptls3xL1$GR, poptls3xL1$D2HT, method="spearman", na.action="na.omit") #p = 0.02 *
cor.test(poptls3xL1$GR, poptls3xL1$D2N, method="spearman", na.action="na.omit") #p = 0.4361
cor.test(poptls3xL1$GR, poptls3xL1$DDFLWF, method="spearman", na.action="na.omit") #p = 0.1837
cor.test(poptls3xL1$GR, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit") #p = 0.6025
cor.test(poptls3xL1$SIZE, poptls3xL1$Height, method="spearman", na.action="na.omit") #p = <0.0001*
cor.test(poptls3xL1$SIZE, poptls3xL1$FR.ALL, method="spearman", na.action="na.omit") #p = <0.0001*
cor.test(poptls3xL1$SIZE, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = <0.0001 * DNU
cor.test(poptls3xL1$SIZE, poptls3xL1$Branches, method="spearman", na.action="na.omit")#p = <0.0001*
cor.test(poptls3xL1$SIZE, poptls3xL1$D2HT, method="spearman", na.action="na.omit")#p = 0.01998
cor.test(poptls3xL1$SIZE, poptls3xL1$D2N, method="spearman", na.action="na.omit")#p = 0.4261
cor.test(poptls3xL1$SIZE, poptls3xL1$DDFLWF, method="spearman", na.action="na.omit")#p = 0.1837
cor.test(poptls3xL1$SIZE, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit")#p = 0.6025
cor.test(poptls3xL1$Height, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = 0.0001 * DNU
cor.test(poptls3xL1$Height, poptls3xL1$FR.ALL, method="spearman", na.action="na.omit")#p = <0.0001 *
cor.test(poptls3xL1$Height, poptls3xL1$Branches, method="spearman", na.action="na.omit")#p = <0.0001 *
cor.test(poptls3xL1$Height, poptls3xL1$D2HT, method="spearman", na.action="na.omit")#p = 0.0265*
cor.test(poptls3xL1$Height, poptls3xL1$D2N, method="spearman", na.action="na.omit")#p = 0.1264
cor.test(poptls3xL1$Height, poptls3xL1$DDFLWF, method="spearman", na.action="na.omit")#p = 0.2601
cor.test(poptls3xL1$Height, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit")#p = 0.4425
cor.test(poptls3xL1$FR.ALL, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = 0.0002 * DNU
cor.test(poptls3xL1$FR.ALL, poptls3xL1$Branches, method="spearman", na.action="na.omit")#p = <0.0001*
cor.test(poptls3xL1$FR.ALL, poptls3xL1$D2HT, method="spearman", na.action="na.omit")#p = 0.0426*
cor.test(poptls3xL1$FR.ALL, poptls3xL1$D2N, method="spearman", na.action="na.omit")#p = 0.1143
cor.test(poptls3xL1$FR.ALL, poptls3xL1$DDFLWF, method="spearman", na.action="na.omit")#p = 0.3107
cor.test(poptls3xL1$FR.ALL, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit")#p = 0.5568
cor.test(poptls3xL1$Branches, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = <0.0001 * DNU
cor.test(poptls3xL1$Branches, poptls3xL1$D2HT, method="spearman", na.action="na.omit")#p = 0.0493*
cor.test(poptls3xL1$Branches, poptls3xL1$D2N, method="spearman", na.action="na.omit")#p = 0.593
cor.test(poptls3xL1$Branches, poptls3xL1$DDFLWF, method="spearman", na.action="na.omit")#p = 0.1272
cor.test(poptls3xL1$Branches, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit")#p = 0.616
cor.test(poptls3xL1$D2HT, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = 0.0622 DNU
cor.test(poptls3xL1$D2HT, poptls3xL1$D2N, method="spearman", na.action="na.omit")#p = 0.7786
cor.test(poptls3xL1$D2HT, poptls3xL1$DDFLWF, method="spearman", na.action="na.omit")#p = 0.263
cor.test(poptls3xL1$D2HT, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit")#p = 0.5204
cor.test(poptls3xL1$D2N, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = 0.5381 DNU
cor.test(poptls3xL1$D2N, poptls3xL1$DDFLWF, method="spearman", na.action="na.omit")#p = 0.8529
cor.test(poptls3xL1$D2N, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit")#p = 0.2067
cor.test(poptls3xL1$DDFLWF, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = 0.3912 DNU
cor.test(poptls3xL1$DDFLWF, poptls3xL1$PrpnPD, method="spearman", na.action="na.omit")#p = 0.9758
cor.test(poptls3xL1$PrpnPD, poptls3xL1$TBud.Flw, method="spearman", na.action="na.omit") #p = 0.4028 DNU



cor.test(poptls3xL2$GR, poptls3xL2$SIZE, method="spearman")#p = <0.0001*
cor.test(poptls3xL2$GR, poptls3xL2$Height, method="spearman")#p = 0.0003*
cor.test(poptls3xL2$GR, poptls3xL2$FR.ALL, method="spearman")#p = <0.0001*
cor.test(poptls3xL2$GR, poptls3xL2$TBud.Flw, method="spearman")#p = <0.0001* DNU
cor.test(poptls3xL2$GR, poptls3xL2$Branches, method="spearman")#p = 0.0010*
cor.test(poptls3xL2$GR, poptls3xL2$D2HT, method="spearman")#p = 0.7709
cor.test(poptls3xL2$GR, poptls3xL2$D2N, method="spearman")#p = 0.2876
cor.test(poptls3xL2$GR, poptls3xL2$DDFLWF, method="spearman")#p = 0.0201*
cor.test(poptls3xL2$GR, poptls3xL2$PrpnPD, method="spearman")#p = 0.0546
cor.test(poptls3xL2$SIZE, poptls3xL2$Height, method="spearman")#p = 0.0002*
cor.test(poptls3xL2$SIZE, poptls3xL2$FR.ALL, method="spearman")#p = <0.0001*
cor.test(poptls3xL2$SIZE, poptls3xL2$TBud.Flw, method="spearman")#p = <0.0001* DNU
cor.test(poptls3xL2$SIZE, poptls3xL2$Branches, method="spearman")#p = 0.0008*
cor.test(poptls3xL2$SIZE, poptls3xL2$D2HT, method="spearman")#p = 0.6969
cor.test(poptls3xL2$SIZE, poptls3xL2$D2N, method="spearman")#p = 0.2664
cor.test(poptls3xL2$SIZE, poptls3xL2$DDFLWF, method="spearman")#p = 0.0165*
cor.test(poptls3xL2$SIZE, poptls3xL2$PrpnPD, method="spearman")#p = 0.0576
cor.test(poptls3xL2$Height, poptls3xL2$FR.ALL, method="spearman")#p = 0.1214
cor.test(poptls3xL2$Height, poptls3xL2$TBud.Flw, method="spearman")#p = 0.1701 DNU
cor.test(poptls3xL2$Height, poptls3xL2$Branches, method="spearman")#p = 0.0156*
cor.test(poptls3xL2$Height, poptls3xL2$D2HT, method="spearman")#p = 0.2323
cor.test(poptls3xL2$Height, poptls3xL2$D2N, method="spearman")#p = 0.4807
cor.test(poptls3xL2$Height, poptls3xL2$DDFLWF, method="spearman")#p = 0.4834
cor.test(poptls3xL2$Height, poptls3xL2$PrpnPD, method="spearman")#p = 0.4914
cor.test(poptls3xL2$FR.ALL, poptls3xL2$TBud.Flw, method="spearman")#p = <0.0001* DNU
cor.test(poptls3xL2$FR.ALL, poptls3xL2$Branches, method="spearman")#p = 0.0026*
cor.test(poptls3xL2$FR.ALL, poptls3xL2$D2HT, method="spearman")#p = 0.6129
cor.test(poptls3xL2$FR.ALL, poptls3xL2$D2N, method="spearman")#p = 0.0698
cor.test(poptls3xL2$FR.ALL, poptls3xL2$DDFLWF, method="spearman")#p = 0.0023*
cor.test(poptls3xL2$FR.ALL, poptls3xL2$PrpnPD, method="spearman")#p = 0.0145*
cor.test(poptls3xL2$Branches, poptls3xL2$TBud.Flw, method="spearman")#p = 0.0539 DNU
cor.test(poptls3xL2$Branches, poptls3xL2$D2HT, method="spearman")#p = 0.221
cor.test(poptls3xL2$Branches, poptls3xL2$D2N, method="spearman")#p = 0.1902
cor.test(poptls3xL2$Branches, poptls3xL2$DDFLWF, method="spearman")#p = 0.5762
cor.test(poptls3xL2$Branches, poptls3xL2$PrpnPD, method="spearman")#p = 0.0909
cor.test(poptls3xL2$D2HT, poptls3xL2$TBud.Flw, method="spearman")#p = 0.96 DNU
cor.test(poptls3xL2$D2HT, poptls3xL2$D2N, method="spearman")#p = 0.2574
cor.test(poptls3xL2$D2HT, poptls3xL2$DDFLWF, method="spearman")#p = 0.6288
cor.test(poptls3xL2$D2HT, poptls3xL2$PrpnPD, method="spearman")#p = 0.4847
cor.test(poptls3xL2$D2N, poptls3xL2$TBud.Flw, method="spearman")#p = 0.0057* DNU
cor.test(poptls3xL2$D2N, poptls3xL2$DDFLWF, method="spearman")#p = 0.1007
cor.test(poptls3xL2$D2N, poptls3xL2$PrpnPD, method="spearman")#p = 0.2873
cor.test(poptls3xL2$DDFLWF, poptls3xL2$TBud.Flw, method="spearman")#p = 0.0002* DNU
cor.test(poptls3xL2$DDFLWF, poptls3xL2$PrpnPD, method="spearman")#p = 0.0027*
cor.test(poptls3xL2$PrpnPD, poptls3xL2$TBud.Flw, method="spearman")#p = 0.0026* DNU




#attach {pcor}
library("ppcor", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")


pcor(poptls3xL[,c(19, 16, 48, 28, 24, 50, 13, 59)], method="spearman") #without GR bc highly cor w size
  #NAMES: Height=16 Size=19, [GR=21], D2HT=24, Branches=28, DNU[TBuds.Flw=43], FR.ALL=48, D2N=50, DDFLWF=13, PrpnPD=59
  #Size and fruit have postive p.cor
  #D2N and fruit have positve p.cor
  #Height and Fruit have negative p.cor

pcor(poptls3xL[,c(19, 48, 28, 24, 50, 13, 59)], method="spearman") #without height and GR
  #DNU... use last pcor
  #NAMES: [Height=16] Size=19, [GR=21], D2HT=24, Branches=28, DNU[TBuds.Flw=43], FR.ALL=48, D2N=50, DDFLWF=13, PrpnPD=59


pcor(poptls3xL[,c(19, 16, 28, 24, 50, 13, 59)], method="spearman") #remove gr and fr.all to see if other pcors
  #NAMES: Height=16 Size=19, [GR=21], D2HT=24, Branches=28, DNU[TBuds.Flw=43], [FR.ALL=48], D2N=50, DDFLWF=13, PrpnPD=59


#subset by zone  <- fruit count association with fitness related traits
pcor(poptls3xL1[,c(19, 48, 24, 50, 13, 59)], method="spearman") #without GR and height, and branches

pcor(poptls3xL2[,c(19, 16, 48, 28, 24, 50, 13, 59)], method="spearman") #without GR 

#subset by zone  <- trait associations
pcor(poptls3xL1[,c(19, 28, 24, 50, 13, 59)], method="spearman") #without GR and height, and branches

pcor(poptls3xL2[,c(19, 16, 28, 24, 50, 13, 59)], method="spearman") #without GR 

lmfrls3xLfullx <- lm(rankFR.ALL~rankGR+rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
vif(lmfrls3xLfullx) #cut off at 5
#       rankGR   rankHeight     rankD2HT      rankD2N     rankSIZE rankBranches   rankDDFLWF   rankPrpnPD 
#     161.002497     4.348066     1.570273     1.464048   169.975772     3.383338     1.517714     1.675623 

#DNU lmfrls3xLfull <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
lmfrls3xLfull <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLfull)
#DNU lmfrls3xL1 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL1b <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL2 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL3 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL4 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL5 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL6 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL7 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL1 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
lmfrls3xL2 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
lmfrls3xL3 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
lmfrls3xL4 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
lmfrls3xL5 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL, na.action="na.omit")
lmfrls3xL6 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL, na.action="na.omit")
lmfrls3xL7 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
anova(lmfrls3xLfull, lmfrls3xL1) #height is sig p=0.0099 f=7.5184 *
#DNU anova(lmfrls3xLfull, lmfrls3xL1b) #buds.flw is sig p=0.9126 f=0.0122
anova(lmfrls3xLfull, lmfrls3xL2) #D2HT is not sig p=0.7478 f=0.1052
anova(lmfrls3xLfull, lmfrls3xL3) #D2N is isg p=0.0017 f-11.695 *
anova(lmfrls3xLfull, lmfrls3xL4) #Size is sig p=<0.0001 f=44.725 *
anova(lmfrls3xLfull, lmfrls3xL5) #Branches is non sig p=0.2455 f=1.3995
anova(lmfrls3xLfull, lmfrls3xL6) #DDFLWF is non sig p=0.323 f=1.0075 
anova(lmfrls3xLfull, lmfrls3xL7) #PrpnPD is not sig p=0.9458 f=0.0047

#remove prpnPD
#DNU lmfrls3xL7 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNUlmfrls3xL11 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNUlmfrls3xL11b <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNUlmfrls3xL22 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNUlmfrls3xL33 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNUlmfrls3xL44 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNUlmfrls3xL55 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNUlmfrls3xL66 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches, data=poptls3xL, na.action="na.omit")
lmfrls3xL7 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL11 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL22 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL33 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL44 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL55 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL66 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches, data=poptls3xL, na.action="na.omit")
anova(lmfrls3xL7, lmfrls3xL11) #height is sig p=0.0084 f=7.8598 *
#DNU anova(lmfrls3xL7, lmfrls3xL11b) #Bud.flw is sig p=0.9272 f=0.0085
anova(lmfrls3xL7, lmfrls3xL22) #D2HT is not sig p=0.7364 f=0.1152
anova(lmfrls3xL7, lmfrls3xL33) #D2N is isg p=0.00105 f-12.913 *
anova(lmfrls3xL7, lmfrls3xL44) #Size is sig p=<0.0001 f=46.183 *
anova(lmfrls3xL7, lmfrls3xL55) #Branches is non sig p=0.2317 f=1.4848
anova(lmfrls3xL7, lmfrls3xL66) #DDFLWF is non sig p=0.3099 f=1.0634 


#remove Bud.Flw  <- DNU
#DNU lmfrls3xL11b <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL11b1 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL11b2 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL11b3 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL11b4 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL11b5 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xL, na.action="na.omit")
#DNU lmfrls3xL11b6 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches, data=poptls3xL, na.action="na.omit")
#DNU anova(lmfrls3xL11b, lmfrls3xL11b1) #height is sig p=0.0084 f=7.8598 *
#DNU anova(lmfrls3xL11b, lmfrls3xL11b2) #D2HT is not sig p=0.7364 f=0.1152
#DNU anova(lmfrls3xL11b, lmfrls3xL11b3) #D2N is sig p=0.0001 f-12.913 *
#DNU anova(lmfrls3xL11b, lmfrls3xL11b4) #Size is sig p=<0.0001 f=46.183 *
#DNU anova(lmfrls3xL11b, lmfrls3xL11b5) #Branches is non sig p=0.2317 f=1.4848
#DNU anova(lmfrls3xL11b, lmfrls3xL11b6) #DDFLWF is non sig p=0.3099 f=1.0634 


#remove D2HT
lmfrls3xL22 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL111 <- lm(rankFR.ALL~rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL222 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL333 <- lm(rankFR.ALL~rankHeight+rankD2N+rankBranches+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL444 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xL, na.action="na.omit")
lmfrls3xL555 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches, data=poptls3xL, na.action="na.omit")
anova(lmfrls3xL22, lmfrls3xL111) #height is sig p=0.0039 f=9.6157 *
anova(lmfrls3xL22, lmfrls3xL222) #D2N is isg p=0.0005 f-14.835 *
anova(lmfrls3xL22, lmfrls3xL333) #Size is sig p=<0.0001 f=48.161 *
anova(lmfrls3xL22, lmfrls3xL444) #Branches is non sig p=0.144 f=2.2362
anova(lmfrls3xL22, lmfrls3xL555) #DDFLWF is non sig p=0.3304 f=0.9749
 
#remove DDFLWF
lmfrls3xL555 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches, data=poptls3xL, na.action="na.omit")
lmfrls3xL1111 <- lm(rankFR.ALL~rankD2N+rankSIZE+rankBranches, data=poptls3xL, na.action="na.omit")
lmfrls3xL2222 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches, data=poptls3xL, na.action="na.omit")
lmfrls3xL3333 <- lm(rankFR.ALL~rankHeight+rankD2N+rankBranches, data=poptls3xL, na.action="na.omit")
lmfrls3xL4444 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE, data=poptls3xL, na.action="na.omit")
anova(lmfrls3xL555, lmfrls3xL1111) #height is sig p=0.0015 f=11.89 *
anova(lmfrls3xL555, lmfrls3xL2222) #D2N is isg p=0.0003 f-16.28 *
anova(lmfrls3xL555, lmfrls3xL3333) #Size is sig p=<0.0001 f=62.28 *
anova(lmfrls3xL555, lmfrls3xL4444) #Branches is non sig p=0.1595 f=2.0657

#remove Branches
lmfrls3xL4444 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE, data=poptls3xL, na.action="na.omit")
lmfrls3xL11111 <- lm(rankFR.ALL~rankD2N+rankSIZE, data=poptls3xL, na.action="na.omit")
lmfrls3xL22222 <- lm(rankFR.ALL~rankHeight+rankSIZE, data=poptls3xL, na.action="na.omit")
lmfrls3xL33333 <- lm(rankFR.ALL~rankHeight+rankD2N, data=poptls3xL, na.action="na.omit")
anova(lmfrls3xL4444, lmfrls3xL11111) #height is sig p=0.0022 f=10.853 *
anova(lmfrls3xL4444, lmfrls3xL22222) #D2N is isg p=<0.0001 f-22.141 *
anova(lmfrls3xL4444, lmfrls3xL33333) #Size is sig p=<0.0001 f=90.845 *

#final model
lmfrls3xLfullF <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLfullF) #intercept=-0.3564, Height p=0.0022* est=-0.3744, D2N p=<0.0001* est=0.2937, 
  #Size p=<0.0001* est=1.0981 
  #model 86.2% f=82.3[3,36] p=<0.0001* 
#check assumptions
lmfrls3xLfullFR <- resid(lmfrls3xLfullF)
lmfrls3xLfullFF <- fitted(lmfrls3xLfullF)
plot(lmfrls3xLfullFF, lmfrls3xLfullFR) # good
abline(h=0, col=c("red"))
qqnorm(lmfrls3xLfullFR, main="Q-Q plot for residuals") #normal
qqline(lmfrls3xLfullFR) 
plot(poptls3xL$rankHeight, lmfrls3xLfullFR) #dist. is good
abline(h=0, col=c("red"))
plot(poptls3xL$rankSIZE, lmfrls3xLfullFR) #good dist.
abline(h=0, col=c("red"))
plot(poptls3xL$rankD2N, lmfrls3xLfullFR) #dist. is good
abline(h=0, col=c("red"))


#plot tree diagram to show relationship of explan. v with dependent v. in model
treefr  <- tree(lmfrls3xLfullF)
plot(treefr) 
text(treefr) #only shows SIZE and D2N has being important/influential variables
  #d2n is important in larger sized plants, with greater d2n associated with higher fruit counts
  #smaller plants are associated with lower fruit counts


#residual analysis for plotting pcor of fr.all with d2n
lmfrls3xLd <- lm(rankFR.ALL~rankHeight+rankSIZE, data=poptls3xL, na.action="na.omit")
lmfrls3xLdR <- resid(lmfrls3xLd)
lmfrls3xLd2 <- lm(lmfrls3xLdR~rankD2N, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLd2) # D2N significant p=<0.0001, estimate=0.2695
  #model p=<0.0001, f=20.41[1,38], model explains 33% of variation
plot(lmfrls3xLd2) #looks like it's meeting assumptions of lm
lmfrls3xLdR <- resid(lmfrls3xLd)
lmfrls3xLdF <- fitted(lmfrls3xLd)
plot(lmfrls3xLdF, lmfrls3xLdR) # fairly homogeneous
abline(h=0, col=c("red"))
qqnorm(lmfrls3xLdR, main="Q-Q plot for residuals")
qqline(lmfrls3xLdR) #okay
plot(poptls3xL$logHeight, lmfrls3xLdR) #dist. is fine.
abline(h=0, col=c("red"))
plot(poptls3xL$logSIZE, lmfrls3xLdR) #good dist.
abline(h=0, col=c("red"))


ggplot(data=poptls3xL, aes(x=rankD2N, y=lmfrls3xLdR)) +
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to Neighbour (cm)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Traits (Ranked)") +
  annotate("text", x=c(4.5), y=c(8), label=paste("n=",n.d2n))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

n.d2n <- length(poptls3xL$D2N)

#residual analysis for plotting pcor of fr.all with size
lmfrls3xLs <- lm(rankFR.ALL~rankHeight+rankD2N, data=poptls3xL, na.action="na.omit")
lmfrls3xLsR <- resid(lmfrls3xLs)
lmfrls3xLs2 <- lm(lmfrls3xLsR~rankSIZE, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLs2) # Size is significant p=0.0048, estimate=0.2923
  #model p=0.0048,f=8.95[1,38], model explains 17% of variation
plot(lmfrls3xLs2) #looks like meeting assumptions of lm. One point with more leverage.
lmfrls3xLsR <- resid(lmfrls3xLs)
lmfrls3xLsF <- fitted(lmfrls3xLs)
plot(lmfrls3xLsF, lmfrls3xLsR) # fairly homogeneous
abline(h=0, col=c("red"))
qqnorm(lmfrls3xLsR, main="Q-Q plot for residuals") #good
qqline(lmfrls3xLsR) 
plot(poptls3xL$rankHeight, lmfrls3xLsR)
abline(h=0, col=c("red"))
plot(poptls3xL$rankD2N, lmfrls3xLsR)
abline(h=0, col=c("red"))
  #all are fine

ggplot(data=poptls3xL, aes(x=rankSIZE, y=lmfrls3xLsR)) +
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous(expression(bold(Ranked~Plant~Size~(cm^3)))) + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Traits (Ranked)") +
  annotate("text", x=c(3), y=c(13), label=paste("n=",n.size))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

n.size <- length(poptls3xL$SIZE)

#residual analysis for plotting pcor of fr.all with height
lmfrls3xLh <- lm(rankFR.ALL~rankD2N+rankSIZE, data=poptls3xL, na.action="na.omit")
lmfrls3xLhR <- resid(lmfrls3xLh)
lmfrls3xLh2 <- lm(lmfrls3xLhR~rankHeight, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLh2) # Height is not significant p=0.114, estimate=-0.1042
  #model p=0.1139, f=2.619[1,38], model explains 4% of variation
plot(lmfrls3xLh2) #looks like meeting assumptions of lm. 
lmfrls3xLhF <- fitted(lmfrls3xLh)
plot(lmfrls3xLhF, lmfrls3xLhR) # fairly homogeneous
abline(h=0, col=c("red"))
qqnorm(lmfrls3xLhR, main="Q-Q plot for residuals")
qqline(lmfrls3xLhR) #pretty good
plot(poptls3xL$rankSIZE, lmfrls3xLhR)
abline(h=0, col=c("red"))
plot(poptls3xL$rankD2N, lmfrls3xLhR)
abline(h=0, col=c("red"))
  #all good

ggplot(data=poptls3xL, aes(x=rankHeight, y=lmfrls3xLhR)) +
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Plant Height (cm)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Traits (Ranked)") +
  annotate("text", x=c(3), y=c(11), label=paste("n=",n.height))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

n.height<- length(poptls3xL$Height)


#residual analysis for plotting pcor of branches with d2ht
lmfrls3xLbht <- lm(rankBranches~rankD2N+rankSIZE, data=poptls3xL, na.action="na.omit")
lmfrls3xLbhtR <- resid(lmfrls3xLbht)
lmfrls3xLbht2 <- lm(lmfrls3xLbhtR~rankD2HT, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLbht2) # D2HT is significant p=0.0269, estimate=-0.2129
#model p=0.0269, f=5.298[1,38], model explains 10% of variation
plot(lmfrls3xLbht2) #looks like meeting assumptions of lm. 
lmfrls3xLbhtF <- fitted(lmfrls3xLbht)
plot(lmfrls3xLbhtF, lmfrls3xLbhtR) # fairly homogeneous
abline(h=0, col=c("red"))
qqnorm(lmfrls3xLbhtR, main="Q-Q plot for residuals")
qqline(lmfrls3xLbhtR) #pretty good
plot(poptls3xL$rankSIZE, lmfrls3xLbhtR)
abline(h=0, col=c("red"))
plot(poptls3xL$rankD2N, lmfrls3xLbhtR)
abline(h=0, col=c("red"))
#all good

ggplot(data=poptls3xL, aes(x=rankD2HT, y=lmfrls3xLbhtR)) +
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to High Tide") + 
  scale_y_continuous("Residuals of Branches on \nFitness Related Traits (Ranked)") +
  annotate("text", x=c(3), y=c(11), label=paste("n=",n.ht))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

n.ht<- length(poptls3xL$D2HT)


ggplot(data=poptls3xL, aes(x=rankD2HT, y=rankBranches)) +
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to High Tide") + 
  scale_y_continuous("Ranked Number of Branches") +
  annotate("text", x=c(3), y=c(11), label=paste("n=",n.ht))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#subset by zone  <- beach
lmfrls3xL1fullx <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
vif(lmfrls3xL1fullx)
#  rankHeight     rankD2HT      rankD2N     rankSIZE rankBranches   rankDDFLWF   rankPrpnPD 
#   31.584940     2.219030     2.346779    29.140242     6.632226     1.823413     1.148397 
lmfrls3xL11 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
vif(lmfrls3xL11)
lmfrls3xL112x <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
vif(lmfrls3xL112x)
lmfrls3xL113x <- lm(rankFR.ALL~rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
vif(lmfrls3xL113x)

#DNU lmfrls3xL1full <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU summary(lmfrls3xL1full) 
#DNU lmfrls3xL11 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU lmfrls3xL11b <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU lmfrls3xL12 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU lmfrls3xL13 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU lmfrls3xL14 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU lmfrls3xL15 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU lmfrls3xL16 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
#DNU lmfrls3xL17 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1full <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
summary(lmfrls3xL1full) 
lmfrls3xL11 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL12 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL13 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL14 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL15 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL16 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL17 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL1, na.action="na.omit")
anova(lmfrls3xL1full, lmfrls3xL11) #Height non sig p=0.9043 f=0.0152
#DNU anova(lmfrls3xL1full, lmfrls3xL11b) #Bud.flw non sig p=0.7037 f=0.1542
anova(lmfrls3xL1full, lmfrls3xL12) #D2HT non sig p=0.3272 f=1.0614
anova(lmfrls3xL1full, lmfrls3xL13) #D2N marg non sig p=0.06277 f=4.3823 (.)
anova(lmfrls3xL1full, lmfrls3xL14) #SIZE sig p=0.03936 f=5.6113 *
anova(lmfrls3xL1full, lmfrls3xL15) #Branches non sig p=0.2979 f=1.2057
anova(lmfrls3xL1full, lmfrls3xL16) #DDFLWF non sig p=0.2428 f=1.5412
anova(lmfrls3xL1full, lmfrls3xL17) #PrpnPD non sig p=0.6201 f=0.2616

#DNU---
#remove height
lmfrls3xL11 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL111b <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL122 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL133 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL144 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL155 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL166 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL177 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL1, na.action="na.omit")
anova(lmfrls3xL11, lmfrls3xL111b) #Bud.Flw non sig p=0.7144 f=0.1417
anova(lmfrls3xL11, lmfrls3xL122) #D2HT non sig p=0.874 f=0.0265
anova(lmfrls3xL11, lmfrls3xL133) #D2N sig p=0.0217 f=7.3784 *
anova(lmfrls3xL11, lmfrls3xL144) #SIZE sig p=0.0047 f=13.117 *
anova(lmfrls3xL11, lmfrls3xL155) #Branches non sig p=0.8627 f=0.0315
anova(lmfrls3xL11, lmfrls3xL166) #DDFLWF non sig p=0.8067 f=0.0631
anova(lmfrls3xL11, lmfrls3xL177) #PrpnPD non sig p=0.7415 f=0.115

lmfrls3xL122 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1333 <- lm(rankFR.ALL~rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1444 <- lm(rankFR.ALL~rankBud.Flw+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1555 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1666 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1777 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1888 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL1, na.action="na.omit")
anova(lmfrls3xL122, lmfrls3xL1333) #Bud.Flw not sig p=0.693 f=0.1643
anova(lmfrls3xL122, lmfrls3xL1444) #D2N sig p=0.01299 f=8.7573 *
anova(lmfrls3xL122, lmfrls3xL1555) #SIZE sig p=0.0011 f=18.958 *
anova(lmfrls3xL122, lmfrls3xL1666) #Branches not sig p=0.8633 f=0.0311 
anova(lmfrls3xL122, lmfrls3xL1777) #DDFLWF non sig p=0.8432 f=0.041
anova(lmfrls3xL122, lmfrls3xL1888) #PrpnPD non sig p=0.7506 f=0.1062

lmfrls3xL1666 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL17777 <- lm(rankFR.ALL~rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL18888 <- lm(rankFR.ALL~rankBud.Flw+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL19999 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankDDFLWF+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL11010 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL11111 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xL1, na.action="na.omit")
anova(lmfrls3xL1666, lmfrls3xL17777) #D2N not sig p=0.7065 f=0.1488 
anova(lmfrls3xL1666, lmfrls3xL18888) #D2N sig p=0.0092 f=9.6107 *
anova(lmfrls3xL1666, lmfrls3xL19999) #Size sig p=<0.0001 f=44.831 *
anova(lmfrls3xL1666, lmfrls3xL11010) #DDFLWF non sig p=0.7787 f=0.0826
anova(lmfrls3xL1666, lmfrls3xL11111) #PrpnPD non sig p=0.7377 f=0.1175

lmfrls3xL11010 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL11010b <- lm(rankFR.ALL~rankD2N+rankSIZE+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL111111 <- lm(rankFR.ALL~rankBud.Flw+rankSIZE+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL112121 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankPrpnPD, data=poptls3xL1, na.action="na.omit")
lmfrls3xL113131 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE, data=poptls3xL1, na.action="na.omit")
anova(lmfrls3xL11010, lmfrls3xL11010b) #Bud.Flw not sig p=0.6805 f=0.1774 
anova(lmfrls3xL11010, lmfrls3xL111111) #D2N sig p=0.0069 f=10.265 *
anova(lmfrls3xL11010, lmfrls3xL112121) #SIZE sig p=<0.0001 f=51.403 *
anova(lmfrls3xL11010, lmfrls3xL113131) #PrpnPD non sig p=0.7366 f=0.1181


lmfrls3xL113131 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE, data=poptls3xL1, na.action="na.omit")
lmfrls3xL113131b <- lm(rankFR.ALL~rankD2N+rankSIZE, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1131313 <- lm(rankFR.ALL~rankBud.Flw+rankSIZE, data=poptls3xL1, na.action="na.omit")
lmfrls3xL1141414 <- lm(rankFR.ALL~rankBud.Flw+rankD2N, data=poptls3xL1, na.action="na.omit")
anova(lmfrls3xL113131, lmfrls3xL113131b) #Bud.flw not sig p=0.6447 f=0.2221 
anova(lmfrls3xL113131, lmfrls3xL1131313) #D2N sig p=0.0053 f=10.863 *
anova(lmfrls3xL113131, lmfrls3xL1141414) #SIZE sig p=<0.0001 f=54.976 *
#---

lmfrls3xL113131b <- lm(rankFR.ALL~rankD2N+rankSIZE, data=poptls3xL1, na.action="na.omit")
lmfrls3xL113131b1 <- lm(rankFR.ALL~rankSIZE, data=poptls3xL1, na.action="na.omit")
lmfrls3xL113131b2 <- lm(rankFR.ALL~rankD2N, data=poptls3xL1, na.action="na.omit")
anova(lmfrls3xL113131b, lmfrls3xL113131b1) #D2N sig p=0.0035 f=11.94 *
anova(lmfrls3xL113131b, lmfrls3xL113131b2) #SIZE sig p=<0.0001 f=232.48 *

lmfrls3xL1F <- lm(rankFR.ALL~rankD2N+rankSIZE, data=poptls3xL1, na.action="na.omit")
plot(lmfrls3xL1F)
  #meeting assumptions
summary(lmfrls3xL1F) #intercept=-0.41, d2n est=0.1529 p=0.0788, size est=0.9081, p=<0.0001
  #f=105.6 [2, 12] p=<0.0001, model explains 93.7% of variation


#subset by zone  <- dune
lmfrls3xL2full <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
vif(lmfrls3xL2full)
#rankHeight     rankD2HT      rankD2N     rankSIZE rankBranches   rankDDFLWF   rankPrpnPD 
# 3.198358     1.678437     1.609174     4.485506     3.600556     2.717714     2.229963 

#DNU lmfrls3xL2full <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU summary(lmfrls3xL2full) 
#DNU lmfrls3xL21b <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21 <- lm(rankFR.ALL~rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL22 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL23 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL24 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL25 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL26 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL27 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2full <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
summary(lmfrls3xL2full) 
lmfrls3xL21 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL22 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL23 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL24 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL25 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL26 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL27 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU anova(lmfrls3xL2full, lmfrls3xL21b) #Bud.Flw non sig p=0.1319 f=2.5848 
anova(lmfrls3xL2full, lmfrls3xL21) #Height sig p=0.01504 f=7.6737 *
anova(lmfrls3xL2full, lmfrls3xL22) #D2HT non sig p=0.9393 f=0.006
anova(lmfrls3xL2full, lmfrls3xL23) #D2N non sig p=0.9531 f=0.0036
anova(lmfrls3xL2full, lmfrls3xL24) #SIZE sig p=0.0008 f=17.915 *
anova(lmfrls3xL2full, lmfrls3xL25) #Branches non sig p=0.1313 f=2.5695
anova(lmfrls3xL2full, lmfrls3xL26) #DDFLWF non sig p=0.1753 f=2.0382
anova(lmfrls3xL2full, lmfrls3xL27) #PrpnPD non sig p=0.7253 f=0.1285

#DNU lmfrls3xL22 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL22b <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL233 <- lm(rankFR.ALL~rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL244 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL255 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL266 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL277 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL288 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
lmfrls3xL22 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL233 <- lm(rankFR.ALL~rankD2N+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL244 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL255 <- lm(rankFR.ALL~rankHeight+rankD2N+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL266 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL277 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL288 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU anova(lmfrls3xL22, lmfrls3xL22b) #Bud.Flw sig p=0.1342 f=2.5277
anova(lmfrls3xL22, lmfrls3xL233) #Height sig p=0.0081 f=9.2917 *
anova(lmfrls3xL22, lmfrls3xL244) #D2N non sig p=0.9523 f=0.0037
anova(lmfrls3xL22, lmfrls3xL255) #SIZE marg non sig p=0.0005 f=19.619 * 
anova(lmfrls3xL22, lmfrls3xL266) #Branches marg non sig p=0.0757 f=3.6407
anova(lmfrls3xL22, lmfrls3xL277) #DDFLWF non sig p=0.1597 f=2.1894
anova(lmfrls3xL22, lmfrls3xL288) #PrpnPD non sig p=0.7163 f=0.1371

#DNU lmfrls3xL244 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL244b <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL2666 <- lm(rankFR.ALL~rankBud.Flw+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL2777 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL2888 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL2999 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL2101 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
lmfrls3xL244 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2666 <- lm(rankFR.ALL~rankSIZE+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2777 <- lm(rankFR.ALL~rankHeight+rankBranches+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2888 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankDDFLWF+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2999 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankPrpnPD, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2101 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU anova(lmfrls3xL244, lmfrls3xL244b) #BudFlw non sig p=0.2226 f=1.6192 
anova(lmfrls3xL244, lmfrls3xL2666) #Height non sig p=0.0038 f=11.452 *
anova(lmfrls3xL244, lmfrls3xL2777) #SIZE sig p=0.0003 f=21.256 *
anova(lmfrls3xL244, lmfrls3xL2888) #Branches marg non sig p=0.05601  f=4.2453
anova(lmfrls3xL244, lmfrls3xL2999) #DDFLWF non sig p=0.1354 f=2.4723
anova(lmfrls3xL244, lmfrls3xL2101) #PrpnPD non sig p=0.7098 f=0.1435

#DNU lmfrls3xL2101 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL2101b <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21111 <- lm(rankFR.ALL~rankBud.Flw+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21212 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21313 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21414 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2101 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
lmfrls3xL21111 <- lm(rankFR.ALL~rankSIZE+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
lmfrls3xL21212 <- lm(rankFR.ALL~rankHeight+rankBranches+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
lmfrls3xL21313 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankDDFLWF, data=poptls3xL2, na.action="na.omit")
lmfrls3xL21414 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU anova(lmfrls3xL2101, lmfrls3xL2101b) #Budflw sig p=0.3077 f=1.1101 
anova(lmfrls3xL2101, lmfrls3xL21111) #Height sig p=0.00304 f=11.922 *
anova(lmfrls3xL2101, lmfrls3xL21212) #SIZE sig p=0.0002 f=22.688 *
anova(lmfrls3xL2101, lmfrls3xL21313) #Branches sig p=0.0465 f=4.6102 * 
anova(lmfrls3xL2101, lmfrls3xL21414) #DDFLWF non sig p=0.1112 f=2.8227

#DNU lmfrls3xL21414 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21414b <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL215151 <- lm(rankFR.ALL~rankBud.Flw+rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL216161 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL217171 <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankSIZE, data=poptls3xL2, na.action="na.omit")
lmfrls3xL21414 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
lmfrls3xL215151 <- lm(rankFR.ALL~rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
lmfrls3xL216161 <- lm(rankFR.ALL~rankHeight+rankBranches, data=poptls3xL2, na.action="na.omit")
lmfrls3xL217171 <- lm(rankFR.ALL~rankHeight+rankSIZE, data=poptls3xL2, na.action="na.omit")
#DNU anova(lmfrls3xL21414, lmfrls3xL21414b) #Bud.flw sig p=0.08796 f=3.2772
anova(lmfrls3xL21414, lmfrls3xL215151) #Height sig p=0.0008 f=16.199 *
anova(lmfrls3xL21414, lmfrls3xL216161) #SIZE sig p<0.0001 f=45.459 *
anova(lmfrls3xL21414, lmfrls3xL217171) #Branches non sig p=0.1014 f=2.9798

#DNU lmfrls3xL21414b <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21414b1 <- lm(rankFR.ALL~rankSIZE+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21414b2 <- lm(rankFR.ALL~rankHeight+rankBranches, data=poptls3xL2, na.action="na.omit")
#DNU lmfrls3xL21414b3 <- lm(rankFR.ALL~rankHeight+rankSIZE, data=poptls3xL2, na.action="na.omit")
#DNU anova(lmfrls3xL21414b, lmfrls3xL21414b1) #Height sig p=0.0008 f=16.199 *
#DNU anova(lmfrls3xL21414b, lmfrls3xL21414b2) #Size sig p=<0.0001 f=45.459 *
#DNU anova(lmfrls3xL21414b, lmfrls3xL21414b3) #Branches sig p=0.1014 f=2.98

lmfrls3xL21414b3 <- lm(rankFR.ALL~rankHeight+rankSIZE, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2181818 <- lm(rankFR.ALL~rankSIZE, data=poptls3xL2, na.action="na.omit")
lmfrls3xL2191919 <- lm(rankFR.ALL~rankHeight, data=poptls3xL2, na.action="na.omit")
anova(lmfrls3xL21414b3, lmfrls3xL2181818) #Height sig p=0.0015 f=13.689 *
anova(lmfrls3xL21414b3, lmfrls3xL2191919) #SIZE sig p=<0.0001 f=63.449 *


lmfrls3xL2F <- lm(rankFR.ALL~rankHeight+rankSIZE, data=poptls3xL2, na.action="na.omit")
plot(lmfrls3xL2F) 
#meeting assumptions
summary(lmfrls3xL2F) #intercept=3.1049, Height est=-0.5349 p=0.0015, size est=1.2895, p=<0.0001
#f=37.24 [2, 19] p=<0.0001, model explains 77% of variation

#****************************
##MNS
names(poptls3xM)
cor(poptls3xM[,c(21, 19, 16, 48, 28, 24, 50, 13)], use="pairwise.complete.obs", method="spearman")
  #NAMES: Height=16 Size=19, GR=21, D2HT=24, Branches=28, DNU[TBud.Flw=43], FR.ALL=48, D2N=50, DDFLWF=13
  #SIZE and FR.ALL are highly positively correlated (0.8985)
  #Branches and FR.ALL are highly positively correlated (0.9286)
  #D2N and FR.ALL are moderately positively correlated (0.6754)
  #Height and FR.ALL are moderately positively correlated (0.6845)

#Also note: Branches and Height are highly correlated with SIZE (0.9216, 0.7824)
  #Branches and height are moderately correlated (0.6770)
  #D2HT and D2N are low and moderately correlated with Branches (-0.2964, 0.6554)
  #D2HT and D2N are low and moderately correlated with Height (-0.2377, 0.5975)
  #Size and D2N are moderately correlated (0.7631)
  #Size and D2HT have low correlation (-0.2903)
  #FlwPer and D2N are low correlated (0.3304)

cor.test(poptls3xM$SIZE, poptls3xM$GR, method="spearman") #* rho=0.9989 p=<0.0001
cor.test(poptls3xM$SIZE, poptls3xM$Height, method="spearman") #* rho=0.8327 p=<0.0001
#DNU cor.test(poptls3xM$SIZE, poptls3xM$TBud.Flw, method="spearman") #* rho=0.7497 p=<0.0001
cor.test(poptls3xM$SIZE, poptls3xM$FR.ALL, method="spearman") #* rho=0.9236 p=<0.0001
cor.test(poptls3xM$SIZE, poptls3xM$Branches, method="spearman") #* rho=0.9379 p=<0.0001
cor.test(poptls3xM$SIZE, poptls3xM$D2HT, method="spearman") #rho=-0.1654 p=0.4618
cor.test(poptls3xM$SIZE, poptls3xM$D2N, method="spearman") #* rho=0.7195 p=0.0001
cor.test(poptls3xM$SIZE, poptls3xM$DDFLWF, method="spearman") #rho=0.0762 p=0.7414
cor.test(poptls3xM$D2HT, poptls3xM$GR, method="spearman") #rho=-0.1764 p=0.4324
cor.test(poptls3xM$D2HT, poptls3xM$Height, method="spearman") #rho=-0.2603 p=0.2419
cor.test(poptls3xM$D2HT, poptls3xM$FR.ALL, method="spearman") #rho=-0.1651 p=0.4627
#DNU cor.test(poptls3xM$D2HT, poptls3xM$TBud.Flw, method="spearman") #rho= -0.3868 p=0.0753
cor.test(poptls3xM$D2HT, poptls3xM$Branches, method="spearman") #rho=-0.1945 p=0.3858
cor.test(poptls3xM$D2HT, poptls3xM$D2N, method="spearman") #rho=-0.2432 p=0.2753
cor.test(poptls3xM$D2HT, poptls3xM$DDFLWF, method="spearman") #rho=-0.2018 p=0.3677
cor.test(poptls3xM$Branches, poptls3xM$GR, method="spearman") #* rho=0.9379 p=<0.0001
cor.test(poptls3xM$Branches, poptls3xM$Height, method="spearman") #* rho=0.7875 p=<0.0001
cor.test(poptls3xM$Branches, poptls3xM$FR.ALL, method="spearman") #* rho=0.9253 p=<0.0001
#DNU cor.test(poptls3xM$Branches, poptls3xM$TBud.Flw, method="spearman") #* rho=0.7367 p=<0.0001
cor.test(poptls3xM$Branches, poptls3xM$D2N, method="spearman") #* rho=0.6464 p=0.0011
cor.test(poptls3xM$Branches, poptls3xM$DDFLWF, method="spearman") #rho=0.1584 p=0.4814
cor.test(poptls3xM$FR.ALL, poptls3xM$GR, method="spearman") #* rho=0.9185 p=<0.0001
cor.test(poptls3xM$FR.ALL, poptls3xM$Height, method="spearman") #* rho=0.7545 p=<0.0001
#DNU cor.test(poptls3xM$FR.ALL, poptls3xM$TBud.Flw, method="spearman") #* rho=0.6347 p=0.0015
cor.test(poptls3xM$FR.ALL, poptls3xM$D2N, method="spearman") #* rho=0.6510 p=0.0010
cor.test(poptls3xM$FR.ALL, poptls3xM$DDFLWF, method="spearman") #rho=-0.0113 p=0.9603
cor.test(poptls3xM$D2N, poptls3xM$GR, method="spearman") #* rho=0.7258 p=0.0001
cor.test(poptls3xM$D2N, poptls3xM$Height, method="spearman") #* rho=0.5785 p=0.0048
#DNU cor.test(poptls3xM$D2N, poptls3xM$TBud.Flw, method="spearman") #* rho=0.6111 p=0.0025
cor.test(poptls3xM$D2N, poptls3xM$DDFLWF, method="spearman") #rho=-0.2130 p=0.3412
cor.test(poptls3xM$DDFLWF, poptls3xM$GR, method="spearman") #rho=0.0882 p=0.6962
cor.test(poptls3xM$DDFLWF, poptls3xM$Height, method="spearman") #rho=0.2216 p=0.3216
#DNU cor.test(poptls3xM$DDFLWF, poptls3xM$TBud.Flw, method="spearman") #rho=0.3241 p=0.1411
cor.test(poptls3xM$Height, poptls3xM$GR, method="spearman") #* rho=0.8305 p=<0.0001
#DNU cor.test(poptls3xM$Height, poptls3xM$TBud.Flw, method="spearman") #* rho=0.8034 p=<0.0001
#DNU cor.test(poptls3xM$GR, poptls3xM$TBud.Flw, method="spearman") #* rho=0.7525 p=<0.0001


#subset by zone
poptls3xM1  <- subset(poptls3xM, Zone =="1")
poptls3xM1$rankGR  <- rank(poptls3xM1$GR)
poptls3xM1$rankHeight  <- rank(poptls3xM1$Height)
poptls3xM1$rankSIZE  <- rank(poptls3xM1$SIZE)
poptls3xM1$rankFR.ALL  <- rank(poptls3xM1$FR.ALL)
poptls3xM1$rankBud.Flw  <- rank(poptls3xM1$TBud.Flw)
poptls3xM1$rankBranches  <- rank(poptls3xM1$Branches)
poptls3xM1$rankD2HT  <- rank(poptls3xM1$D2HT)
poptls3xM1$rankD2N  <- rank(poptls3xM1$D2N)
poptls3xM1$rankDDFLWF  <- rank(poptls3xM1$DDFLWF)
poptls3xM2  <- subset(poptls3xM, Zone =="2")
poptls3xM2$rankGR  <- rank(poptls3xM2$GR)
poptls3xM2$rankHeight  <- rank(poptls3xM2$Height)
poptls3xM2$rankSIZE  <- rank(poptls3xM2$SIZE)
poptls3xM2$rankFR.ALL  <- rank(poptls3xM2$FR.ALL)
poptls3xM2$rankBud.Flw  <- rank(poptls3xM2$TBud.Flw)
poptls3xM2$rankBranches  <- rank(poptls3xM2$Branches)
poptls3xM2$rankD2HT  <- rank(poptls3xM2$D2HT)
poptls3xM2$rankD2N  <- rank(poptls3xM2$D2N)
poptls3xM2$rankDDFLWF  <- rank(poptls3xM2$DDFLWF)
write.table(poptls3xM1, file = "PopTag13 all_indivLS_ls3x_MNS_z1.csv", sep = ",", col.names = TRUE, row.names = FALSE)
write.table(poptls3xM2, file = "PopTag13 all_indivLS_ls3x_MNS_z2.csv", sep = ",", col.names = TRUE, row.names = FALSE)

names(poptls3xM)
#NAMES: Height=16 Size=19, GR=21, D2HT=24, Branches=28, DNU[TBud.Flw=43], FR.ALL=48, D2N=50, DDFLWF=13
cor(poptls3xM1[,c(21, 19, 16, 48, 28, 24, 50, 13)], use="pairwise.complete.obs", method="spearman")
cor(poptls3xM2[,c(21, 19, 16, 48, 28, 24, 50, 13)], use="pairwise.complete.obs", method="spearman")

cor.test(poptls3xM1$GR, poptls3xM1$SIZE, method="spearman") #p=<0.0001*
cor.test(poptls3xM1$GR, poptls3xM1$Height, method="spearman") #p=0.152
cor.test(poptls3xM1$GR, poptls3xM1$FR.ALL, method="spearman")#p=0.1618
#DNU cor.test(poptls3xM1$GR, poptls3xM1$TBud.Flw, method="spearman")#p=0.2696
cor.test(poptls3xM1$GR, poptls3xM1$Branches, method="spearman")#p=0.0272*
cor.test(poptls3xM1$GR, poptls3xM1$D2HT, method="spearman")#p=0.7302
cor.test(poptls3xM1$GR, poptls3xM1$D2N, method="spearman")#p=0.3206
cor.test(poptls3xM1$GR, poptls3xM1$DDFLWF, method="spearman")#p=0.6711
cor.test(poptls3xM1$SIZE, poptls3xM1$Height, method="spearman")#p=0.152
cor.test(poptls3xM1$SIZE, poptls3xM1$FR.ALL, method="spearman")#p=0.1618
#DNU cor.test(poptls3xM1$SIZE, poptls3xM1$TBud.Flw, method="spearman")#p=0.2696
cor.test(poptls3xM1$SIZE, poptls3xM1$Branches, method="spearman")#p=0.0272*
cor.test(poptls3xM1$SIZE, poptls3xM1$D2HT, method="spearman")#p=0.7302
cor.test(poptls3xM1$SIZE, poptls3xM1$D2N, method="spearman")#p=0.3206
cor.test(poptls3xM1$SIZE, poptls3xM1$DDFLWF, method="spearman")#p=0.6711
cor.test(poptls3xM1$Height, poptls3xM1$FR.ALL, method="spearman")#p=0.4926
#DNU cor.test(poptls3xM1$Height, poptls3xM1$TBud.Flw, method="spearman")#p=0.0249*
cor.test(poptls3xM1$Height, poptls3xM1$Branches, method="spearman")#p=0.4406
cor.test(poptls3xM1$Height, poptls3xM1$D2HT, method="spearman")#p=0.1683
cor.test(poptls3xM1$Height, poptls3xM1$D2N, method="spearman")#p=0.3463
cor.test(poptls3xM1$Height, poptls3xM1$DDFLWF, method="spearman")#p=0.396
#DNU cor.test(poptls3xM1$FR.ALL, poptls3xM1$TBud.Flw, method="spearman")#p=0.6436
cor.test(poptls3xM1$FR.ALL, poptls3xM1$Branches, method="spearman")#p=0.0484*
cor.test(poptls3xM1$FR.ALL, poptls3xM1$D2HT, method="spearman")#p=0.7631
cor.test(poptls3xM1$FR.ALL, poptls3xM1$D2N, method="spearman")#p=0.879
cor.test(poptls3xM1$FR.ALL, poptls3xM1$DDFLWF, method="spearman")#p=0.8881
#DNU cor.test(poptls3xM1$Branches, poptls3xM1$TBud.Flw, method="spearman")#p=0.8144
cor.test(poptls3xM1$Branches, poptls3xM1$D2HT, method="spearman")#p=0.8499
cor.test(poptls3xM1$Branches, poptls3xM1$D2N, method="spearman")#p=0.7826
cor.test(poptls3xM1$Branches, poptls3xM1$DDFLWF, method="spearman")#p=0.6682
#DNU cor.test(poptls3xM1$D2HT, poptls3xM1$TBud.Flw, method="spearman")#p=0.9145
cor.test(poptls3xM1$D2HT, poptls3xM1$D2N, method="spearman")#p=0.6832
cor.test(poptls3xM1$D2HT, poptls3xM1$DDFLWF, method="spearman")#p=0.3401
#DNU cor.test(poptls3xM1$D2N, poptls3xM1$TBud.Flw, method="spearman")#p=0.1154
cor.test(poptls3xM1$D2N, poptls3xM1$DDFLWF, method="spearman")#p=0.6644
#DNU cor.test(poptls3xM1$DDFLWF, poptls3xM1$TBud.Flw, method="spearman")#p=0.3444


cor.test(poptls3xM2$GR, poptls3xM2$SIZE, method="spearman")#p=<0.0001*
cor.test(poptls3xM2$GR, poptls3xM2$Height, method="spearman")#p=0.0020*
cor.test(poptls3xM2$GR, poptls3xM2$FR.ALL, method="spearman")#p=0.0005*
#DNU cor.test(poptls3xM2$GR, poptls3xM2$TBud.Flw, method="spearman")#p=0.0004*
cor.test(poptls3xM2$GR, poptls3xM2$Branches, method="spearman")#p=0.0011*
cor.test(poptls3xM2$GR, poptls3xM2$D2HT, method="spearman")#p=0.7577
cor.test(poptls3xM2$GR, poptls3xM2$D2N, method="spearman")#p=0.4387
cor.test(poptls3xM2$GR, poptls3xM2$DDFLWF, method="spearman")#p=0.0015*
cor.test(poptls3xM2$SIZE, poptls3xM2$Height, method="spearman")#p=0.0016*
cor.test(poptls3xM2$SIZE, poptls3xM2$FR.ALL, method="spearman")#p=0.0002*
#DNU cor.test(poptls3xM2$SIZE, poptls3xM2$TBud.Flw, method="spearman")#p=0.0006*
cor.test(poptls3xM2$SIZE, poptls3xM2$Branches, method="spearman")#p=0.0011*
cor.test(poptls3xM2$SIZE, poptls3xM2$D2HT, method="spearman")#p=0.8666
cor.test(poptls3xM2$SIZE, poptls3xM2$D2N, method="spearman")#p=0.5017
cor.test(poptls3xM2$SIZE, poptls3xM2$DDFLWF, method="spearman")#p=0.0030*
cor.test(poptls3xM2$Height, poptls3xM2$FR.ALL, method="spearman")#p=0.0105*
#DNU cor.test(poptls3xM2$Height, poptls3xM2$TBud.Flw, method="spearman")#p=0.0011*
cor.test(poptls3xM2$Height, poptls3xM2$Branches, method="spearman")#p=0.0063*
cor.test(poptls3xM2$Height, poptls3xM2$D2HT, method="spearman")#p=0.6656
cor.test(poptls3xM2$Height, poptls3xM2$D2N, method="spearman")#p=0.5213
cor.test(poptls3xM2$Height, poptls3xM2$DDFLWF, method="spearman")#p=0.0407*
#DNU cor.test(poptls3xM2$FR.ALL, poptls3xM2$TBud.Flw, method="spearman")#p=0.0089*
cor.test(poptls3xM2$FR.ALL, poptls3xM2$Branches, method="spearman")#p=0.0032*
cor.test(poptls3xM2$FR.ALL, poptls3xM2$D2HT, method="spearman")#p=0.7993
cor.test(poptls3xM2$FR.ALL, poptls3xM2$D2N, method="spearman")#p=0.8776
cor.test(poptls3xM2$FR.ALL, poptls3xM2$DDFLWF, method="spearman")#p=0.0992
#DNU cor.test(poptls3xM2$Branches, poptls3xM2$TBud.Flw, method="spearman")#p=<0.0001*
cor.test(poptls3xM2$Branches, poptls3xM2$D2HT, method="spearman")#p=0.5181
cor.test(poptls3xM2$Branches, poptls3xM2$D2N, method="spearman")#p=0.961
cor.test(poptls3xM2$Branches, poptls3xM2$DDFLWF, method="spearman")#p=0.0002*
#DNU cor.test(poptls3xM2$D2HT, poptls3xM2$TBud.Flw, method="spearman")#p=0.2411
cor.test(poptls3xM2$D2HT, poptls3xM2$D2N, method="spearman")#p=0.3808
cor.test(poptls3xM2$D2HT, poptls3xM2$DDFLWF, method="spearman")#p=0.2297
#DNU cor.test(poptls3xM2$D2N, poptls3xM2$TBud.Flw, method="spearman")#p=0.4893
cor.test(poptls3xM2$D2N, poptls3xM2$DDFLWF, method="spearman")#p=0.632
#DNU cor.test(poptls3xM2$DDFLWF, poptls3xM2$TBud.Flw, method="spearman")#p=0.0004*



#attach {pcor}
library("ppcor", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")

pcor(poptls3xM[,c(16, 48, 28, 24, 50, 13)], method="spearman") #without GR and Size bc highly correlated with branches
  #NAMES: Height=16, [Size=19], [GR=21], D2HT=24, Branches=28, DNU[TBud.Flw=43], FR.ALL=48, D2N=50, DDFLWF=13
  #Branches has positive pcor w FR.ALL (0.7856)

pcor(poptls3xM[,c(16, 28, 24, 50, 13)], method="spearman") #without GR, size, and FR.ALL to see other pcor
  #NAMES: Height=16, [Size=19], [GR=21], D2HT=24, Branches=28, DNU[TBud.Flw=43], [FR.ALL=48], D2N=50, DDFLWF=13


pcor(poptls3xM[,c(21, 19, 16, 28, 24, 50, 13)], method="spearman") #without FR.ALL to see other pcor
  #NAMES: Height=16, Size=19, GR=21, D2HT=24, Branches=28, DNU[TBud.Flw=43], [FR.ALL=48], D2N=50, DDFLWF=13


#subset by zone  <- fruit count association with fitness related traits
pcor(poptls3xM1[,c(19, 16, 48, 28, 24, 50, 13)], method="spearman") #without GR 
pcor(poptls3xM2[,c(19, 16, 48, 28, 24, 50, 13)], method="spearman") #without GR 

#subset by zone  <- traits associations
pcor(poptls3xM1[,c(19, 16, 28, 24, 50, 13)], method="spearman") #without GR and frall
pcor(poptls3xM2[,c(19, 16, 28, 24, 50, 13)], method="spearman") #without GR  and frall



#DNU lmfrls3xMfull <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU summary(lmfrls3xMfull)
#DNU lmfrls3xM1a <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM1b <- lm(rankFR.ALL~rankSIZE+rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM1 <- lm(rankFR.ALL~rankSIZE+rankBud.Flw+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM2 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM3 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM5 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM6 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2HT+rankD2N+rankBranches, data=poptls3xM, na.action="na.omit")
lmfrls3xMfull <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMfull)
lmfrls3xM1 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM2 <- lm(rankFR.ALL~rankHeight+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM3 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM5 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM6 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches, data=poptls3xM, na.action="na.omit")
#DNU anova(lmfrls3xMfull, lmfrls3xM1a) #size is not sig p=0.1461 f=2.3505
#DNU anova(lmfrls3xMfull, lmfrls3xM1b) #bud.flw is not sig p=0.3802 f=0.821
anova(lmfrls3xMfull, lmfrls3xM1) #height is not sig p=0.4267 f=0.6651
anova(lmfrls3xMfull, lmfrls3xM2) #D2HT is not sig p=0.9408 f=0.0057
anova(lmfrls3xMfull, lmfrls3xM3) #D2N is not sig p=0.8586 f=0.0328
anova(lmfrls3xMfull, lmfrls3xM5) #Branches is sig p=<0.0001 f=33.863 *
anova(lmfrls3xMfull, lmfrls3xM6) #DDFLWF marg not sig p=0.0866 f=3.3328 

#DNU lmfrls3xM3 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM33a <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM33b <- lm(rankFR.ALL~rankSIZE+rankHeight+rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM33 <- lm(rankFR.ALL~rankSIZE+rankBud.Flw+rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM44 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM55 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2HT+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM66 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankD2HT+rankBranches, data=poptls3xM, na.action="na.omit")
lmfrls3xM2 <- lm(rankFR.ALL~rankHeight+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM33 <- lm(rankFR.ALL~rankHeight+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM44 <- lm(rankFR.ALL~rankD2N+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM55 <- lm(rankFR.ALL~rankD2N+rankHeight+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM66 <- lm(rankFR.ALL~rankD2N+rankHeight+rankBranches, data=poptls3xM, na.action="na.omit")
#DNU anova(lmfrls3xM3, lmfrls3xM33a) #Size marg not sig p=0.0892 f=3.2745
#DNU anova(lmfrls3xM3, lmfrls3xM33b) #Bud.Flw is not sig p=0.2816 f=1.2477
anova(lmfrls3xM3, lmfrls3xM44) #Height is not sig p=0.4156 f=0.6963
#DNU anova(lmfrls3xM3, lmfrls3xM44) #D2HT is not sig p=0.7013 f=0.1525
anova(lmfrls3xM3, lmfrls3xM33) #D2N is not sig p=0.972 f=0.0013
anova(lmfrls3xM3, lmfrls3xM55) #Branches is sig p=<0.0001 f=36.206 *
anova(lmfrls3xM3, lmfrls3xM66) #DDFLWF marg not sig p=0.0731 f=3.6499 

#DNU lmfrls3xM44 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM44a <- lm(rankFR.ALL~rankHeight+rankBud.Flw+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM44b <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM555 <- lm(rankFR.ALL~rankSIZE+rankBud.Flw+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM666 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM777 <- lm(rankFR.ALL~rankSIZE+rankHeight+rankBud.Flw+rankBranches, data=poptls3xM, na.action="na.omit")
lmfrls3xM33 <- lm(rankFR.ALL~rankHeight+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM555 <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM666 <- lm(rankFR.ALL~rankHeight+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM777 <- lm(rankFR.ALL~rankHeight+rankBranches, data=poptls3xM, na.action="na.omit")
#DNU anova(lmfrls3xM44, lmfrls3xM44a) #Size marg not sig p=0.0863 f=3.3155
#DNU anova(lmfrls3xM44, lmfrls3xM44b) #Bud.flw is not sig p=0.3202 f=1.0526
anova(lmfrls3xM44, lmfrls3xM555) #Height is not sig p=0.9751 f=0.001
#DNU anova(lmfrls3xM44, lmfrls3xM555) #D2N not sig p=0.5167 f=0.4385
anova(lmfrls3xM44, lmfrls3xM666) #Branches is sig p=<0.0001 f=42.465 *
anova(lmfrls3xM44, lmfrls3xM777) #DDFLWF marg non sig p=0.0731 f=3.6232  

#DNU lmfrls3xM555 <- lm(rankFR.ALL~rankSIZE+rankBud.Flw+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM555a <- lm(rankFR.ALL~rankBud.Flw+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM555b <- lm(rankFR.ALL~rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM6666 <- lm(rankFR.ALL~rankSIZE+rankBud.Flw+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM7777 <- lm(rankFR.ALL~rankSIZE+rankBud.Flw+rankBranches, data=poptls3xM, na.action="na.omit")
lmfrls3xM555 <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM6666 <- lm(rankFR.ALL~rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xM7777 <- lm(rankFR.ALL~rankBranches, data=poptls3xM, na.action="na.omit")
#DNU anova(lmfrls3xM555, lmfrls3xM555a) #Size not sig p=0.1019 f=2.9709 
#DNU anova(lmfrls3xM555, lmfrls3xM555b) #Bud.Flw is sig p=0.3706 f=0.8458 
anova(lmfrls3xM555, lmfrls3xM6666) #Branches is sig p=<0.0001 f=141.64 *
anova(lmfrls3xM555, lmfrls3xM7777) #DDFLWF marg not sig p=0.05703 f=4.105


#DNU lmfrls3xM555b <- lm(rankFR.ALL~rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM66666 <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM77777 <- lm(rankFR.ALL~rankSIZE+rankDDFLWF, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM88888 <- lm(rankFR.ALL~rankSIZE+rankBranches, data=poptls3xM, na.action="na.omit")
#DNU anova(lmfrls3xM555b, lmfrls3xM66666) #Size is sig p=0.1019 f=2.9709 
#DNU anova(lmfrls3xM555b, lmfrls3xM77777) #Branches is sig p=0.0171 f=6.8985 * 
#DNU anova(lmfrls3xM555b, lmfrls3xM88888) #DDFLWF is sig p=0.1051 f=2.9119


#DNU lmfrls3xM88888 <- lm(rankFR.ALL~rankSIZE+rankBranches, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM888889 <- lm(rankFR.ALL~rankBranches, data=poptls3xM, na.action="na.omit")
#DNU lmfrls3xM888881 <- lm(rankFR.ALL~rankSIZE, data=poptls3xM, na.action="na.omit")
#DNU anova(lmfrls3xM88888, lmfrls3xM888889) #Size marg non sig p=0.0553 f=4.1702 
#DNU anova(lmfrls3xM88888, lmfrls3xM888881) #Branches is sig p=0.0438 f=4.664 * 


lmfrls3xMfullF <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMfullF) #intercept=2.2833, Branches est=0.9709, ddflwf est= -0.1695
#model 87% f=70.83 [2,19] p=<0.0001* 
#check assumptions
plot(lmfrls3xMfullF) #okay... slightly off on Q-Q plot, but acceptable
hatvalues(lmfrls3xMfullF) #point 662 has slightly higher leverage, but not concerned
lmfrls3xMfullFR  <- resid(lmfrls3xMfullF)
plot(poptls3xM$rankBranches, lmfrls3xMfullFR)
abline(h=0, col=c("red")) #good
plot(poptls3xM$rankDDFLWF, lmfrls3xMfullFR)
abline(h=0, col=c("red")) #good


#plot tree diagram to show relationship of explan. v with dependent v. in model
treeMfr  <- tree(lmfrls3xMfullF)
plot(treeMfr) 
text(treeMfr) #only shows Branches and height as being important/influential variables
  #more branches assocaited with more fruit
  #height important in plants with fewer branches with taller plants associated with more fruit


#residual analysis for p.correlation of fr.all with Branches after accounting for variation
  #due to ddflwf
lmfrls3xMbr <- lm(rankFR.ALL~rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xMbrR <- resid(lmfrls3xMbr)
lmfrls3xMbr2 <- lm(lmfrls3xMbrR~rankBranches, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMbr2) # Branches significant p=<0.0001 est=0.9466 intercept=-10.8858
  #model explains 85% of variation, model p=<0.0001, f=122.4 [1,20]
plot(lmfrls3xMbr2) #not the best, but acceptable
hatvalues(lmfrls3xMbr2)
cooks.distance(lmfrls3xMbr2)
#check other assumptions
lmfrls3xMbrF <- fitted(lmfrls3xMbr)
plot(lmfrls3xMbrF, lmfrls3xMbrR)
abline(h=0, col=c("red"))
qqnorm(lmfrls3xMbrR, main="Q-Q plot for residuals") 
qqline(lmfrls3xMbrR) #okay


ggplot(data=poptls3xM, aes(x=rankBranches, y=lmfrls3xMbrR)) + geom_point(size=4)+
  scale_x_continuous("Ranked Number of Branches") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Traits (Ranked)") +
  annotate("text", x=5, y=8, label=paste("n=",n.Mbr))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.8, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

n.Mbr <- length(poptls3xM$Branches)


#DNU #residual analysis for p.correlation of fr.all with Height after accounting for variation
#DNU #due to branches and ddflwf
lmfrls3xMh <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xMhR <- resid(lmfrls3xMh)
lmfrls3xMh2 <- lm(lmfrls3xMhR~rankHeight, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMh2) # Height not significant p=0.593 est=0.04167 intercept=-0.4792
#model explains  -3% of variation, model p=0.5927, f=0.2955 [1,20]
plot(lmfrls3xMh2) #not the best, but acceptable
hatvalues(lmfrls3xMh2)
cooks.distance(lmfrls3xMh2)
#check other assumptions
lmfrls3xMhF <- fitted(lmfrls3xMh)
plot(lmfrls3xMhF, lmfrls3xMhR)
abline(h=0, col=c("red"))
qqnorm(lmfrls3xMhR, main="Q-Q plot for residuals") 
qqline(lmfrls3xMhR) #okay

#DNU 
ggplot(data=poptls3xM, aes(x=rankHeight, y=lmfrls3xMhR)) + geom_point(size=4)+
  scale_x_continuous("Ranked Plant Height (cm)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Traits (Ranked)") +
  annotate("text", x=3, y=3.5, label=paste("n=",n.Mhi))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.8, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

n.Mhi <- length(poptls3xM$Height)


#residual analysis for p.correlation of fr.all with DDFLWF after accounting for variation
#due to branches
lmfrls3xMdd <- lm(rankFR.ALL~rankBranches, data=poptls3xM, na.action="na.omit")
lmfrls3xMddR <- resid(lmfrls3xMdd)
lmfrls3xMdd2 <- lm(lmfrls3xMddR~rankDDFLWF, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMdd2) # DDFLWF marg non significant p=0.054 est=-0.1652 intercept=1.9004
#model explains  13% of variation, model p=0.054, f=4.19 [1,20]
plot(lmfrls3xMdd2) #okay, acceptable
hatvalues(lmfrls3xMdd2)
cooks.distance(lmfrls3xMdd2)
#check other assumptions
lmfrls3xMddF <- fitted(lmfrls3xMdd)
plot(lmfrls3xMddF, lmfrls3xMddR)
abline(h=0, col=c("red"))
qqnorm(lmfrls3xMddR, main="Q-Q plot for residuals") 
qqline(lmfrls3xMddR) #okay


ggplot(data=poptls3xM, aes(x=rankDDFLWF, y=lmfrls3xMddR)) + geom_point(size=4)+
  scale_x_continuous("Ranked Flowering Duration (days)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Traits (Ranked)") +
  annotate("text", x=17, y=3.5, label=paste("n=",n.Mdd))+
  theme_bw() +
  theme(axis.title.x = element_text(vjust=-0.8, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=0.8, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

n.Mdd <- length(poptls3xM$DDFLWF)


#subset by zone  <-  beach ###CANNOT DO THIS... have too few samples
lmfrls3xM1full <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
summary(lmfrls3xM1full) #cannot run this model since have too few DF
lmfrls3xM11 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM12 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM13 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM14 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM15 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM16 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches, data=poptls3xM1, na.action="na.omit")
anova(lmfrls3xM1full, lmfrls3xM11) #height is not sig  p=0.9848 f=0.0005
anova(lmfrls3xM1full, lmfrls3xM12) #D2HT is not sig p=0.6631 f=0.2561
anova(lmfrls3xM1full, lmfrls3xM13) #D2N is not sig p=0.6711 f=0.2426
anova(lmfrls3xM1full, lmfrls3xM14) #Size is not sig p=0.7777 f=0.104
anova(lmfrls3xM1full, lmfrls3xM15) #Branches is not sig p=0.3797 f=1.2507 *
anova(lmfrls3xM1full, lmfrls3xM16) #DDFLWF is not sig p=0.6311 f=0.3151

lmfrls3xM11 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM122 <- lm(rankFR.ALL~rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM133 <- lm(rankFR.ALL~rankD2HT+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM144 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM155 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM166 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches, data=poptls3xM1, na.action="na.omit")
anova(lmfrls3xM11, lmfrls3xM122) #D2HT is not sig p=0.4837 f=0.6352
anova(lmfrls3xM11, lmfrls3xM133) #D2N is not sig p=0.582 f=0.3784
anova(lmfrls3xM11, lmfrls3xM144) #Size is not sig p=0.6524 f=0.2485
anova(lmfrls3xM11, lmfrls3xM155) #Branches is not sig p=0.2511 f=2.0121
anova(lmfrls3xM11, lmfrls3xM166) #DDFLWF is not sig p=0.4825 f=0.639 

lmfrls3xM144 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM1555 <- lm(rankFR.ALL~rankD2N+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM1666 <- lm(rankFR.ALL~rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM1777 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM1888 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankBranches, data=poptls3xM1, na.action="na.omit")
anova(lmfrls3xM144, lmfrls3xM1555) #D2HT is not sig p=0.4687 f=0.6396
anova(lmfrls3xM144, lmfrls3xM1666) #D2N is not sig p=0.697 f=0.1752
anova(lmfrls3xM144, lmfrls3xM1777) #Branches is sig p=0.0934 f=4.8096 
anova(lmfrls3xM144, lmfrls3xM1888) #DDFLWF is sig p=0.5154 f=0.5079

lmfrls3xM1666 <- lm(rankFR.ALL~rankD2HT+rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM17777 <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM18888 <- lm(rankFR.ALL~rankD2HT+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM19999 <- lm(rankFR.ALL~rankD2HT+rankBranches, data=poptls3xM1, na.action="na.omit")
anova(lmfrls3xM1666, lmfrls3xM17777) #D2HT is not sig p=0.4464 f=0.6824 
anova(lmfrls3xM1666, lmfrls3xM18888) #Branches is not sig p=0.06423 f=5.5988 
anova(lmfrls3xM1666, lmfrls3xM19999) #DDFLWF is not sig p=0.4448 f=0.6874


lmfrls3xM17777 <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM188888 <- lm(rankFR.ALL~rankDDFLWF, data=poptls3xM1, na.action="na.omit")
lmfrls3xM199999 <- lm(rankFR.ALL~rankBranches, data=poptls3xM1, na.action="na.omit")
anova(lmfrls3xM17777, lmfrls3xM188888) #branches are not sig p=0.0584 f=5.4406
anova(lmfrls3xM17777, lmfrls3xM199999) #DDFLWF is not sig p=0.5877 f=0.3279

lmfrls3xM199999 <- lm(rankFR.ALL~rankBranches, data=poptls3xM1, na.action="na.omit")
lmfrls3xM1101010 <- lm(rankFR.ALL~1, data=poptls3xM1, na.action="na.omit")
anova(lmfrls3xM199999, lmfrls3xM1101010) #Branches is sig p=0.0484 f=5.6942 *


lmfrls3xM1F <- lm(rankFR.ALL~rankBranches, data=poptls3xM1, na.action="na.omit")
plot(lmfrls3xM1F) #not great, but so few points to judge
summary(lmfrls3xM1F) #intercept=1.3131, Branches p=0.0484* est=0.7374
#model 37% f=5.694 [1,7] p=0.0484* 

 
#subset by zone  <-  dune ###CANNOT DO THIS... have too few samples
lmfrls3xM2full <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
summary(lmfrls3xM2full)
lmfrls3xM21 <- lm(rankFR.ALL~rankD2HT+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM22 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM23 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM24 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM25 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM26 <- lm(rankFR.ALL~rankHeight+rankD2HT+rankD2N+rankSIZE+rankBranches, data=poptls3xM2, na.action="na.omit")
anova(lmfrls3xM2full, lmfrls3xM21) #height is not sig  p=0.3517 f=1.0192
anova(lmfrls3xM2full, lmfrls3xM22) #D2HT is not sig p=0.5077 f=0.4959
anova(lmfrls3xM2full, lmfrls3xM23) #D2N is not sig p=0.412 f=0.7769
anova(lmfrls3xM2full, lmfrls3xM24) #Size is sig p=0.0039 f=20.658 *
anova(lmfrls3xM2full, lmfrls3xM25) #Branches is sig p=0.0242 f=8.9703 *
anova(lmfrls3xM2full, lmfrls3xM26) #DDFLWF is sig p=0.0098 f=13.842 *

lmfrls3xM22 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM233 <- lm(rankFR.ALL~rankD2N+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM244 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM255 <- lm(rankFR.ALL~rankHeight+rankD2N+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM266 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM277 <- lm(rankFR.ALL~rankHeight+rankD2N+rankSIZE+rankBranches, data=poptls3xM2, na.action="na.omit")
anova(lmfrls3xM22, lmfrls3xM233) #Height is not sig p=0.3825 f=0.868
anova(lmfrls3xM22, lmfrls3xM244) #D2N is not sig p=0.4779 f=0.5619
anova(lmfrls3xM22, lmfrls3xM255) #Size is not sig p=0.0019 f=23.427 *
anova(lmfrls3xM22, lmfrls3xM266) #Branches is not sig p=0.0176 f=9.541 *
anova(lmfrls3xM22, lmfrls3xM277) #DDFLWF is not sig p=0.0058 f=15.269 * 

lmfrls3xM244 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM2555 <- lm(rankFR.ALL~rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM2666 <- lm(rankFR.ALL~rankHeight+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM2777 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM2888 <- lm(rankFR.ALL~rankHeight+rankSIZE+rankBranches, data=poptls3xM2, na.action="na.omit")
anova(lmfrls3xM244, lmfrls3xM2555) #Height is not sig p=0.2825 f=1.3277
anova(lmfrls3xM244, lmfrls3xM2666) #Size is not sig p=0.0012 f=24.189 *
anova(lmfrls3xM244, lmfrls3xM2777) #Branches is sig p=0.0047 f=15.025 * 
anova(lmfrls3xM244, lmfrls3xM2888) #DDFLWF is sig p=0.0022 f=19.712 *

lmfrls3xM2555 <- lm(rankFR.ALL~rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM26666 <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM27777 <- lm(rankFR.ALL~rankSIZE+rankDDFLWF, data=poptls3xM2, na.action="na.omit")
lmfrls3xM28888 <- lm(rankFR.ALL~rankSIZE+rankBranches, data=poptls3xM2, na.action="na.omit")
anova(lmfrls3xM2555, lmfrls3xM26666) #D2HT is not sig p=0.0007 f=25.318 
anova(lmfrls3xM2555, lmfrls3xM27777) #Branches is not sig p=0.0054 f=13.249 
anova(lmfrls3xM2555, lmfrls3xM28888) #DDFLWF is not sig p=0.0023 f=17.739


lmfrls3xM2F <- lm(rankFR.ALL~rankSIZE+rankBranches+rankDDFLWF, data=poptls3xM2[-5,], na.action="na.omit")
plot(lmfrls3xM2F) #okay... remove pt 761
summary(lmfrls3xM2F) #intercept=1.5499, Size p=0.0021* est=1.0495, branches p=0.1281 est=0.5549
#ddflwf p-0.0049 est=-0.7974
#model 89% f=32.43 [3,8] p=<0.0001* 

#***************************************************************
#Covariation between zones
#***************************
##LH
#cov: fr and d2n partial correlation between zones after accounting for variation 
  #due to height and size
lmfrls3xLd <- lm(rankFR.ALL~rankHeight+rankSIZE, data=poptls3xL, na.action="na.omit")
lmfrls3xLdR <- resid(lmfrls3xLd)

lmfrls3xLcovd2 <- lm(lmfrls3xLdR~Zone*rankD2N, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovd2) #non significant interaction
lmfrls3xLcovd22 <- update(lmfrls3xLcovd2,~.-Zone:rankD2N)
anova(lmfrls3xLcovd22, lmfrls3xLcovd2) #interaction not sig p=0.2601 f=1.3092
lmfrls3xLcovd23 <- update(lmfrls3xLcovd22,~.-Zone)
lmfrls3xLcovd23b <- update(lmfrls3xLcovd22,~.-rankD2N)
anova(lmfrls3xLcovd23, lmfrls3xLcovd22) # zone not sig p=0.7287 f=0.1221
anova(lmfrls3xLcovd23b, lmfrls3xLcovd22) #d2n sig p=0.0027 f=10.304
lmfrls3xLcovd23 <- lm(lmfrls3xLdR~Zone+rankD2N, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovd23)
  #D2N est=0.2519 p=0.0027*, Zone est=-0.6327 p=0.7287, intercept=-4.8155

d2nnz <- tapply(poptls3xL$D2N, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankD2N, y=lmfrls3xLdR, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to Neighbour (cm)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Traits (Ranked)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("Residfrall vs d2n by Zone at ls3x LH") +
  geom_abline(intercept=-4.8155, slope=0.2519, col="#990000") +
  geom_abline(intercept=-4.8155-0.6327, slope=0.2519, col="#009999") +
  annotate("text", x=c(5, 5), y=c(10, 8.5), label=paste("n=",d2nnz))+
  theme_bw() +  theme(legend.justification=c(1,0), legend.position="top",
                      legend.text=element_text(face="bold", size=18),
                      legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))
 

#cov: fr and size partial correlation btwn zones after accounting for variation 
  #due to height and d2n
lmfrls3xLs <- lm(rankFR.ALL~rankHeight+rankD2N, data=poptls3xL, na.action="na.omit")
lmfrls3xLsR <- resid(lmfrls3xLs)

lmfrls3xLcovs <- lm(lmfrls3xLsR~Zone*rankSIZE, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovs) #remove interaction term
lmfrls3xLcovs2 <- update(lmfrls3xLcovs,~.-Zone:rankSIZE)
anova(lmfrls3xLcovs2, lmfrls3xLcovs) #interaction not sig p=0.8344 f=0.0444
lmfrls3xLcovs2a <- update(lmfrls3xLcovs2,~.-Zone)
lmfrls3xLcovs2b <- update(lmfrls3xLcovs2,~.-rankSIZE)
anova(lmfrls3xLcovs2a, lmfrls3xLcovs2) # Zone not sig p=0.8455 f=0.0385
anova(lmfrls3xLcovs2b, lmfrls3xLcovs2) #Size is sig p=0.0054 f=8.7282
lmfrls3xLcovs3 <- lm(lmfrls3xLsR~Zone+rankSIZE, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovs3)
  #SIZE p=0.0054, estimate=0.2948
  #Zone p=0.8455, estimate=0.4543, intercept=-6.2934
  #F=4.381 [2,37], p=0.0196, model explains 15% of variation

sizenz <- tapply(poptls3xL$SIZE, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankSIZE, y=lmfrls3xLsR, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous(expression(bold(Ranked~Plant~Size~(cm^3)))) + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Trait (Ranked)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("Residfrall vs size by Zone at ls3x LH") +
  geom_abline(intercept=-6.2934, slope=0.2948, col="#990000") +
  geom_abline(intercept=-6.2934+0.4543, slope=0.2948, col="#009999") +
  annotate("text", x=c(3, 3), y=c(15, 12), label=paste("n=",sizenz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
                      legend.text=element_text(face="bold", size=18),
                      legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))



#cov: fr and height partial correlation after accounting for variation 
  #due to size and d2n
lmfrls3xLh <- lm(rankFR.ALL~rankSIZE+rankD2N, data=poptls3xL, na.action="na.omit")
lmfrls3xLhR <- resid(lmfrls3xLh)

lmfrls3xLcovh2 <- lm(lmfrls3xLhR~Zone*rankHeight, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovh2) #non significant interaction
lmfrls3xLcovh22 <- update(lmfrls3xLcovh2,~.-Zone:rankHeight)
anova(lmfrls3xLcovh22, lmfrls3xLcovh2) #interaction not sig p=0.2594 f=1.3132
lmfrls3xLcovh23 <- update(lmfrls3xLcovh22,~.-Zone)
lmfrls3xLcovh23b <- update(lmfrls3xLcovh22,~.-rankHeight)
anova(lmfrls3xLcovh23, lmfrls3xLcovh22) # zone non sig p=0.6819 f=0.1706
anova(lmfrls3xLcovh23b, lmfrls3xLcovh22) #height non sig p=0.1137 f=2.6246
lmfrls3xLcovh23 <- lm(lmfrls3xLhR~Zone+rankHeight, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovh23)
#Height est=-0.1056 p=0.114, Zone est=-0.6195 p=0.682, intercept=2.5062

hinz <- tapply(poptls3xL$Height, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankHeight, y=lmfrls3xLhR, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Plant Height (cm)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Trait (Ranked)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("Residfrall vs height by Zone at ls3x LH") +
  geom_abline(intercept=2.5062, slope=-0.1056, col="#990000") +
  geom_abline(intercept=2.5062-0.6195, slope=-0.1056, col="#009999") +
  annotate("text", x=c(3, 3), y=c(15, 12), label=paste("n=",hinz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#cov: fr and ddflwf partial correlation after accounting for variation 
#due to size, height and d2n
lmfrls3xLdd <- lm(rankFR.ALL~rankSIZE+rankHeight+rankD2N, data=poptls3xL, na.action="na.omit")
lmfrls3xLddR <- resid(lmfrls3xLdd)

lmfrls3xLcovdd2 <- lm(lmfrls3xLddR~Zone*rankDDFLWF, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovdd2) #non significant interaction
lmfrls3xLcovdd22 <- update(lmfrls3xLcovdd2,~.-Zone:rankDDFLWF)
anova(lmfrls3xLcovdd22, lmfrls3xLcovdd2) #interaction not sig p=0.655 f=0.203
lmfrls3xLcovdd23 <- update(lmfrls3xLcovdd22,~.-Zone)
lmfrls3xLcovdd23b <- update(lmfrls3xLcovdd22,~.-rankDDFLWF)
anova(lmfrls3xLcovdd23, lmfrls3xLcovdd22) # zone non sig p=0.4495 f=0.5842
anova(lmfrls3xLcovdd23b, lmfrls3xLcovdd22) #DDFLWF non sig p=0.4495 f=0.5842
lmfrls3xLcovdd23 <- lm(lmfrls3xLddR~Zone+rankDDFLWF, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovdd23)
#DDFLWF est=0.0468 p=0.450, Zone est=-0.1363 p=0.921, intercept=-0.8837


#cov: fr and branches partial correlation after accounting for variation 
#due to height and d2n
lmfrls3xLbr <- lm(rankFR.ALL~rankHeight+rankD2N, data=poptls3xL, na.action="na.omit")
lmfrls3xLbrR <- resid(lmfrls3xLbr)

lmfrls3xLcovbr2 <- lm(lmfrls3xLbrR~Zone*rankBranches, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovbr2) #non significant interaction
lmfrls3xLcovbr22 <- update(lmfrls3xLcovbr2,~.-Zone:rankBranches)
anova(lmfrls3xLcovbr22, lmfrls3xLcovbr2) #interaction not sig p=0.6907 f=0.1609
lmfrls3xLcovbr23 <- update(lmfrls3xLcovbr22,~.-Zone)
lmfrls3xLcovbr23b <- update(lmfrls3xLcovbr22,~.-rankBranches)
anova(lmfrls3xLcovbr23, lmfrls3xLcovbr22) # zone non sig p=0.5138 f=0.4347
anova(lmfrls3xLcovbr23b, lmfrls3xLcovbr22) #branches non sig p=0.0234 f=5.5866 *
lmfrls3xLcovbr23 <- lm(lmfrls3xLbrR~Zone+rankBranches, data=poptls3xL, na.action="na.omit")
summary(lmfrls3xLcovbr23)
#Branches est=0.2613 p=0.0235, Zone est=1.6743 p=0.5138, intercept=-6.2778

brnz <- tapply(poptls3xL$Branches, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankBranches, y=lmfrls3xLbrR, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Number of Branches") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Trait (Ranked)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("Residfrall vs branches by Zone at ls3x LH") +
  geom_abline(intercept=-6.2778, slope=0.2613, col="#990000") +
  geom_abline(intercept=-6.2778+1.6743, slope=0.2613, col="#009999") +
  annotate("text", x=c(3, 3), y=c(15, 12), label=paste("n=",brnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov fr and Branches
lmfrls3xLcovbrx <- lm(rankFR.ALL~Zone*rankBranches, data=poptls3xL, na.action="na.omit")
lmfrls3xLcovbrx2 <- update(lmfrls3xLcovbrx,~.-Zone:rankBranches)
anova(lmfrls3xLcovbrx2, lmfrls3xLcovbrx) #interaction sig P=0.1501 F=2.1621
lmfrls3xLcovbrx2a <- update(lmfrls3xLcovbrx2,~.-Zone)
lmfrls3xLcovbrx2b <- update(lmfrls3xLcovbrx2,~.-rankBranches)
anova(lmfrls3xLcovbrx2a, lmfrls3xLcovbrx2) #Zone not sig P=0.5765 F=0.3175
anova(lmfrls3xLcovbrx2b, lmfrls3xLcovbrx2) #Branches sig P=<0.0001 F=42.608
summary(lmfrls3xLcovbrx2) # zone p=0.5765 est=-1.4801, intercept=6.0109
  #branches p=<0.0001 est=0.7465

brnz <- tapply(poptls3xL$Branches, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankBranches, y=rankFR.ALL, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Number of Branches") + 
  scale_y_continuous("Ranked Fruit Count") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("frall vs branches by Zone at ls3x LH") +
  geom_abline(intercept=6.0109, slope=0.7465, col="#990000") +
  geom_abline(intercept=6.0109-1.4801, slope=0.7465, col="#009999") +
  annotate("text", x=c(3, 3), y=c(36, 33), label=paste("n=",brnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#cov fr and ddflwf
lmfrls3xLcovddx <- lm(rankFR.ALL~Zone*rankDDFLWF, data=poptls3xL, na.action="na.omit")
plot(lmfrls3xLcovddx) #spread is good
qqnorm(lmfrls3xLcovddx, main="Q-Q plot for residuals") 
qqline(lmfrls3xLcovddx) #a bit off, but acceptable given sample size
lmfrls3xLcovddx2 <- update(lmfrls3xLcovddx,~.-Zone:rankDDFLWF)
anova(lmfrls3xLcovddx2, lmfrls3xLcovddx) #interaction sig P=0.3122 F=1.0507
lmfrls3xLcovddx2a <- update(lmfrls3xLcovddx2,~.-Zone)
lmfrls3xLcovddx2b <- update(lmfrls3xLcovddx2,~.-rankDDFLWF)
anova(lmfrls3xLcovddx2a, lmfrls3xLcovddx2) #Zone not sig P=0.092 F=2.9916
anova(lmfrls3xLcovddx2b, lmfrls3xLcovddx2) #DDFLWF sig P=0.0047 F=9.066
summary(lmfrls3xLcovddx2) # zone p=0.092 est=-5.6892, intercept=14.5698
#DDFLWF p=0.0047 est=0.4419

ddnz <- tapply(poptls3xL$DDFLWF, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankDDFLWF, y=rankFR.ALL, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Flowering Duration (days)") + 
  scale_y_continuous("Ranked Fruit Count") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("frall vs ddflwf by Zone at ls3x LH") +
  geom_abline(intercept=14.5698, slope=0.4419, col="#990000") +
  geom_abline(intercept=14.5698-5.6892, slope=0.4419, col="#009999") +
  annotate("text", x=c(5, 5), y=c(40, 37.5), label=paste("n=",ddnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#cov fr and PrpnPD
lmfrls3xLcovppx <- lm(rankFR.ALL~Zone*rankPrpnPD, data=poptls3xL, na.action="na.omit")
plot(lmfrls3xLcovppx) #spread is good
qqnorm(lmfrls3xLcovppx, main="Q-Q plot for residuals") 
qqline(lmfrls3xLcovppx) #a bit off, but acceptable given sample size
lmfrls3xLcovppx2 <- update(lmfrls3xLcovppx,~.-Zone:rankPrpnPD)
anova(lmfrls3xLcovppx2, lmfrls3xLcovppx) #interaction sig P=0.2732 F=1.238
lmfrls3xLcovppx2a <- update(lmfrls3xLcovppx2,~.-Zone)
lmfrls3xLcovppx2b <- update(lmfrls3xLcovppx2,~.-rankPrpnPD)
anova(lmfrls3xLcovppx2a, lmfrls3xLcovppx2) #Zone not sig P=0.2425 F=1.411
anova(lmfrls3xLcovppx2b, lmfrls3xLcovppx2) #PrpnPD sig P=0.0355 F=4.7648
summary(lmfrls3xLcovppx2) # zone p=0.2425 est=-4.3746, intercept=15.7153
#PrpnPD p=0.0355 est=0.3508

ppnz <- tapply(poptls3xL$PrpnPD, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankPrpnPD, y=rankFR.ALL, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Seed Ratio") + 
  scale_y_continuous("Ranked Fruit Count") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("frall vs prpnpd by Zone at ls3x LH") +
  geom_abline(intercept=15.7153, slope=0.3508, col="#990000") +
  geom_abline(intercept=15.7153-4.3746, slope=0.3508, col="#009999") +
  annotate("text", x=c(8, 8), y=c(40, 37.5), label=paste("n=",ppnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov Branches and D2HT
lmfrls3xLcovbht <- lm(Branches~Zone*rankD2HT, data=poptls3xL, na.action="na.omit")
plot(lmfrls3xLcovbht) #spread is good
  #normqq is s-shaped when both var's ranked. Good when branches is raw
lmfrls3xLcovbht2 <- update(lmfrls3xLcovbht,~.-Zone:rankD2HT)
anova(lmfrls3xLcovbht2, lmfrls3xLcovbht) #interaction sig P=0.168 F=1.9796
lmfrls3xLcovbht2a <- update(lmfrls3xLcovbht2,~.-Zone)
lmfrls3xLcovbht2b <- update(lmfrls3xLcovbht2,~.-rankD2HT)
anova(lmfrls3xLcovbht2a, lmfrls3xLcovbht2) #Zone not sig P=0.097 F=2.9033
anova(lmfrls3xLcovbht2b, lmfrls3xLcovbht2) #D2HT sig P=0.1689 F=1.9688
summary(lmfrls3xLcovbht2) # zone p=0.0968 est=-1.5982, intercept=8.82
#D2HT p=0.1689 est=-0.0569

htnz <- tapply(poptls3xL$D2HT, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankD2HT, y=Branches, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to High Tide (m)") + 
  scale_y_continuous("Number of Branches") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("frall vs prpnpd by Zone at ls3x LH") +
  geom_abline(intercept=8.82, slope=-0.0569, col="#990000") +
  geom_abline(intercept=8.82-1.5982, slope=-0.0569, col="#009999") +
  annotate("text", x=c(5, 5), y=c(17, 16), label=paste("n=",htnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov Size and DDFLWF
lmfrls3xLcovsdd <- lm(rankSIZE~Zone*rankDDFLWF, data=poptls3xL, na.action="na.omit")
plot(lmfrls3xLcovsdd) #spread is good
  #a bit off, but acceptable given sample size
lmfrls3xLcovsdd2 <- update(lmfrls3xLcovsdd,~.-Zone:rankDDFLWF)
anova(lmfrls3xLcovsdd2, lmfrls3xLcovsdd) #interaction sig P=0.7134 F=0.1371
lmfrls3xLcovsdd2a <- update(lmfrls3xLcovsdd2,~.-Zone)
lmfrls3xLcovsdd2b <- update(lmfrls3xLcovsdd2,~.-rankDDFLWF)
anova(lmfrls3xLcovsdd2a, lmfrls3xLcovsdd2) #Zone not sig P=0.6996 F=0.1513
anova(lmfrls3xLcovsdd2b, lmfrls3xLcovsdd2) #DDFLWF sig P=0.018 F=6.1766
summary(lmfrls3xLcovsdd2) # zone p=0.6995 est=-1.3847, intercept=13.1683
#DDFLWF p=0.018 est=0.3948

ddnz <- tapply(poptls3xL$DDFLWF, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankDDFLWF, y=rankSIZE, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Flowering Duration (days)") + 
  scale_y_continuous("Ranked Plant Size") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("frall vs prpnpd by Zone at ls3x LH") +
  geom_abline(intercept=13.1683, slope=0.3948, col="#990000") +
  geom_abline(intercept=13.1683-1.3847, slope=0.3948, col="#009999") +
  annotate("text", x=c(5, 5), y=c(40, 37.5), label=paste("n=",ddnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov Height and High tide
lmfrls3xLcovhht <- lm(Height~Zone*rankD2HT, data=poptls3xL, na.action="na.omit")
plot(lmfrls3xLcovhht) #spread is good
  #normqq is s-shaped with ranked vars... better when height raw
lmfrls3xLcovhht2 <- update(lmfrls3xLcovhht,~.-Zone:rankD2HT)
anova(lmfrls3xLcovhht2, lmfrls3xLcovhht) #interaction sig P=0.0043 F=9.28338
lmfrls3xLcovhht2a <- update(lmfrls3xLcovhht2,~.-Zone)
lmfrls3xLcovhht2b <- update(lmfrls3xLcovhht2,~.-rankD2HT)
anova(lmfrls3xLcovhht2a, lmfrls3xLcovhht2) #Zone not sig P=0.6995 F=0.1514
anova(lmfrls3xLcovhht2b, lmfrls3xLcovhht2) #D2HT sig P=0.8977 F=0.0167
summary(lmfrls3xLcovhht) # zone:d2ht p=0.0043 est=0.7057, zone p=0.0068 est=-12.703, intercept=25.45
#D2HT p=0.0118 est=-0.5479

htnz <- tapply(poptls3xL$D2HT, poptls3xL$Zone, length)

ggplot(data=poptls3xL, aes(x=rankD2HT, y=Height, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to High Tide (m)") + 
  scale_y_continuous("Plant Height (cm)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("hight vs d2ht by Zone at ls3x LH") +
  geom_abline(intercept=25.45, slope=-0.5479, col="#990000") +
  geom_abline(intercept=25.45-12.703, slope=-0.5479+0.7057, col="#009999") +
  annotate("text", x=c(5, 5), y=c(40, 37.5), label=paste("n=",htnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#***********************
##MNS
#cov: fr and ddflwf partial corr after accounting for variation due to branches
lmfrls3xMdd <- lm(rankFR.ALL~rankBranches, data=poptls3xM, na.action="na.omit")
lmfrls3xMddR <- resid(lmfrls3xMdd)

lmfrls3xMcovdd <- lm(lmfrls3xMddR~Zone*rankDDFLWF, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovdd) #remove interaction
lmfrls3xMcovdd2 <- update(lmfrls3xMcovdd,~.-Zone:rankDDFLWF)
anova(lmfrls3xMcovdd2, lmfrls3xMcovdd) #interaction not sig p=0.4691 f=0.5469
lmfrls3xMcovdd2a <- update(lmfrls3xMcovdd2,~.-Zone)
lmfrls3xMcovdd2b <- update(lmfrls3xMcovdd2,~.-rankDDFLWF)
anova(lmfrls3xMcovdd2a, lmfrls3xMcovdd2) #zone not sig p=0.7499 f=0.1046
anova(lmfrls3xMcovdd2b, lmfrls3xMcovdd2) #ddflwf marginally not sig p=0.08337 f=3.3398 (.)
lmfrls3xMcovdd3 <- lm(lmfrls3xMddR~Zone+rankDDFLWF, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovdd3) #ddflwf p=0.0834 est=-0.1574, zone p=0.7499 est=-0.3426, intercept=2.0123

ddMnz <- tapply(poptls3xM$DDFLWF, poptls3xM$Zone, length)

ggplot(data=poptls3xM, aes(x=rankDDFLWF, y=lmfrls3xMddR, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Flowering Duration (days)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Trait (Ranked)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("Residfrall vs ddflwf by Zone at ls3x MNS") +
  geom_abline(intercept=2.0123, slope=-0.1574, col="#990000") +
  geom_abline(intercept=2.0123-0.3426, slope=-0.1574, col="#009999") +
  annotate("text", x=c(3, 3), y=c(7, 5), label=paste("n=",ddMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov: fr and branches partial corr after accounting for variation due to ddflwf and height
lmfrls3xMbr <- lm(rankFR.ALL~rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xMbrR <- resid(lmfrls3xMbr)

lmfrls3xMcovbr <- lm(lmfrls3xMbrR~Zone*rankBranches, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovbr) #remove interaction
lmfrls3xMcovbr2 <- update(lmfrls3xMcovbr,~.-Zone:rankBranches)
anova(lmfrls3xMcovbr2, lmfrls3xMcovbr) #interaction not sig p=0.9585 f=0.0028
lmfrls3xMcovbr2a <- update(lmfrls3xMcovbr2,~.-Zone)
lmfrls3xMcovbr2b <- update(lmfrls3xMcovbr2,~.-rankBranches)
anova(lmfrls3xMcovbr2a, lmfrls3xMcovbr2) #zone not sig p=0.2639 f=1.3256
anova(lmfrls3xMcovbr2b, lmfrls3xMcovbr2) #branches not sig p=<0.0001 f=44.64
lmfrls3xMcovbr3 <- lm(lmfrls3xMbrR~Zone+rankBranches, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovbr3) #branches p=<0.0001 est=0.8398, zone p=0.2639 est=-1.8259, intercept=-8.5791

brMnz <- tapply(poptls3xM$Branches, poptls3xM$Zone, length)

ggplot(data=poptls3xM, aes(x=rankBranches, y=lmfrls3xMbrR, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Number of Branches") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Trait (Ranked)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("Residfrall vs branches by Zone at ls3x MNS") +
  geom_abline(intercept=-8.5791, slope=0.8398, col="#990000") +
  geom_abline(intercept=-8.5791-1.8259, slope=0.8398, col="#009999") +
  annotate("text", x=c(5, 5), y=c(7, 5), label=paste("n=",brMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#DNU #cov: fr and height partial corr after accounting for variation due to branches and ddflwf
lmfrls3xMh <- lm(rankFR.ALL~rankBranches+rankDDFLWF, data=poptls3xM, na.action="na.omit")
lmfrls3xMhR <- resid(lmfrls3xMh)

lmfrls3xMcovh <- lm(lmfrls3xMhR~Zone*rankHeight, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovh) #remove interaction
lmfrls3xMcovh2 <- update(lmfrls3xMcovh,~.-Zone:rankHeight)
anova(lmfrls3xMcovh2, lmfrls3xMcovh) #interaction not sig p=0.8741 f=0.0258
lmfrls3xMcovh2a <- update(lmfrls3xMcovh2,~.-Zone)
lmfrls3xMcovh2b <- update(lmfrls3xMcovh2,~.-rankHeight)
anova(lmfrls3xMcovh2a, lmfrls3xMcovh2) #zone not sig p=0.7951 f=0.0694
anova(lmfrls3xMcovh2b, lmfrls3xMcovh2) #height not sig p=0.5622 f=0.348
lmfrls3xMcovh3 <- lm(lmfrls3xMhR~Zone+rankHeight, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovh3) #height p=0.562 est=0.05352, zone p=0.795 est=0.3123, intercept=-0.8115

hiMnz <- tapply(poptls3xM$Height, poptls3xM$Zone, length)
#DNU
ggplot(data=poptls3xM, aes(x=rankHeight, y=lmfrls3xMbrR, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Plant Height (cm)") + 
  scale_y_continuous("Residuals of Fruit Count on \nFitness Related Trait (Ranked)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("Residfrall vs height by Zone at ls3x MNS") +
  geom_abline(intercept=-0.8115, slope=0.05352, col="#990000") +
  geom_abline(intercept=-0.8115+0.3123, slope=0.05352, col="#009999") +
  annotate("text", x=c(3, 3), y=c(6, 5), label=paste("n=",hiMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))



#cov: fr and d2n 
lmfrls3xMcovd2 <- lm(rankFR.ALL~Zone*rankD2N, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovd2) #remove interaction
lmfrls3xMcovd22 <- update(lmfrls3xMcovd2,~.-Zone:rankD2N)
anova(lmfrls3xMcovd22, lmfrls3xMcovd2) #interaction not sig p=0.9537 f=0.0035
lmfrls3xMcovd22a <- update(lmfrls3xMcovd22,~.-Zone)
lmfrls3xMcovd22b <- update(lmfrls3xMcovd22,~.-rankD2N)
anova(lmfrls3xMcovd22a, lmfrls3xMcovd22) #zone sig p=0.0221 f=6.2132
anova(lmfrls3xMcovd22b, lmfrls3xMcovd22) #d2n not sig p=0.8685 f=0.0282
lmfrls3xMcovd23 <- lm(rankFR.ALL~Zone+rankD2N, data=poptls3xM, na.action="na.omit")
summary(lmfrls3xMcovd23) #d2n p=0.8685 est=0.0479, zone p=0.0221 est=-9.1608, intercept=16.3617

d2Mnz <- tapply(poptls3xM$D2N, poptls3xM$Zone, length)

ggplot(data=poptls3xM, aes(x=rankD2N, y=rankFR.ALL, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to Neighbour (cm)") + 
  scale_y_continuous("Ranked Fruit Count") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("frall vs d2n by Zone at ls3x MNS") +
  geom_abline(intercept=16.3617, slope=0.0479, col="#990000") +
  geom_abline(intercept=16.3617-9.1608, slope=0.0479, col="#009999") +
  annotate("text", x=c(3, 3), y=c(20, 18), label=paste("n=",d2Mnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov: branches and d2n 
lmbrls3xMcovd2 <- lm(rankBranches~Zone*rankD2N, data=poptls3xM, na.action="na.omit")
summary(lmbrls3xMcovd2) #remove interaction
lmbrls3xMcovd22 <- update(lmbrls3xMcovd2,~.-Zone:rankD2N)
anova(lmbrls3xMcovd22, lmbrls3xMcovd2) #interaction not sig p=0.7721 f=0.0865
lmbrls3xMcovd22a <- update(lmbrls3xMcovd22,~.-Zone)
lmbrls3xMcovd22b <- update(lmbrls3xMcovd22,~.-rankD2N)
anova(lmbrls3xMcovd22a, lmbrls3xMcovd22) #zone sig p=0.0320 f=5.3531
anova(lmbrls3xMcovd22b, lmbrls3xMcovd22) #d2n not sig p=0.8028 f=0.0641
lmbrls3xMcovd23 <- lm(rankBranches~Zone+rankD2N, data=poptls3xM, na.action="na.omit")
summary(lmbrls3xMcovd23) #d2n p=0.8028 est=0.0725, zone p=0.0320 est=-8.5170, intercept=15.6990

d2Mnz <- tapply(poptls3xM$D2N, poptls3xM$Zone, length)

ggplot(data=poptls3xM, aes(x=rankD2N, y=rankBranches, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Distance to Neighbour (cm)") + 
  scale_y_continuous("Ranked Number of Branches") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("branches vs d2n by Zone at ls3x MNS") +
  geom_abline(intercept=15.6990, slope=0.0725, col="#990000") +
  geom_abline(intercept=15.6990-8.5170, slope=0.0725, col="#009999") +
  annotate("text", x=c(3, 3), y=c(20, 18), label=paste("n=",d2Mnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#cov: branches and height 
lmbrls3xMcovhi <- lm(rankBranches~Zone*rankHeight, data=poptls3xM, na.action="na.omit")
summary(lmbrls3xMcovhi) #remove interaction
lmbrls3xMcovhi2 <- update(lmbrls3xMcovhi,~.-Zone:rankHeight)
anova(lmbrls3xMcovhi2, lmbrls3xMcovhi) #interaction marginally not sig p=0.0959 f=3.0963 
lmbrls3xMcovhi2a <- update(lmbrls3xMcovhi2,~.-Zone)
lmbrls3xMcovhi2b <- update(lmbrls3xMcovhi2,~.-rankHeight)
anova(lmbrls3xMcovhi2a, lmbrls3xMcovhi2) #zone sig p=0.0030 f=11.581
anova(lmbrls3xMcovhi2b, lmbrls3xMcovhi2) #height is sig p=0.0005 f=17.691
lmbrls3xMcovhi3 <- lm(rankBranches~Zone+rankHeight, data=poptls3xM, na.action="na.omit")
summary(lmbrls3xMcovhi3) #height p=0.0005 est=0.5428, zone p=0.0030 est=-5.6334, intercept=8.5866

hiMnz <- tapply(poptls3xM$Height, poptls3xM$Zone, length)

ggplot(data=poptls3xM, aes(x=rankHeight, y=rankBranches, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Plant Height (cm)") + 
  scale_y_continuous("Ranked Number of Branches") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("branches vs d2n by Zone at ls3x MNS") +
  geom_abline(intercept=8.5866, slope=0.5428, col="#990000") +
  geom_abline(intercept=8.5866-5.6334, slope=0.5428, col="#009999") +
  annotate("text", x=c(3, 3), y=c(20, 18), label=paste("n=",hiMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov: branches and Size 
lmbrls3xMcovs <- lm(rankBranches~Zone*rankSIZE, data=poptls3xM[c(-4,-15),], na.action="na.omit")
plot(lmbrls3xMcovs) #remove pt 772 and 686... better
summary(lmbrls3xMcovs) #remove interaction
lmbrls3xMcovs2 <- update(lmbrls3xMcovs,~.-Zone:rankSIZE)
anova(lmbrls3xMcovs2, lmbrls3xMcovs) #interaction marginally not sig p=0.6426 f=0.2237 
lmbrls3xMcovs2a <- update(lmbrls3xMcovs2,~.-Zone)
lmbrls3xMcovs2b <- update(lmbrls3xMcovs2,~.-rankSIZE)
anova(lmbrls3xMcovs2a, lmbrls3xMcovs2) #zone sig p=0.075 f=3.6029
anova(lmbrls3xMcovs2b, lmbrls3xMcovs2) #size is sig p=0.0003 f=20.97
lmbrls3xMcovs3 <- lm(rankBranches~Zone+rankSIZE, data=poptls3xM[c(-4,-15),], na.action="na.omit")
summary(lmbrls3xMcovs3) #size p=0.0003 est=0.6973, zone p=0.075 est=-3.4020, intercept=5.3696

sMnz <- tapply(poptls3xM[c(-4,-15),]$SIZE, poptls3xM[c(-4,-15),]$Zone, length)

ggplot(data=poptls3xM[c(-4,-15),], aes(x=rankSIZE, y=rankBranches, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous(expression(bold(Ranked~Plant~Size~(cm^3)))) + 
  scale_y_continuous("Ranked Number of Branches") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("branches vs size by Zone at ls3x MNS") +
  geom_abline(intercept=5.3696, slope=0.6973, col="#990000") +
  geom_abline(intercept=5.3696-3.4020, slope=0.6973, col="#009999") +
  annotate("text", x=c(3, 3), y=c(20, 18), label=paste("n=",sMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov: branches and ddflwf 
lmbrls3xMcovdd <- lm(rankBranches~Zone*rankDDFLWF, data=poptls3xM[c(-1,-15),], na.action="na.omit")
plot(lmbrls3xMcovdd) #remove pt 772 and 662... better
summary(lmbrls3xMcovdd) #remove interaction
lmbrls3xMcovdd2 <- update(lmbrls3xMcovdd,~.-Zone:rankDDFLWF)
anova(lmbrls3xMcovdd2, lmbrls3xMcovdd) #interaction marginally not sig p=0.4289 f=0.6589 
lmbrls3xMcovdd2a <- update(lmbrls3xMcovdd2,~.-Zone)
lmbrls3xMcovdd2b <- update(lmbrls3xMcovdd2,~.-rankDDFLWF)
anova(lmbrls3xMcovdd2a, lmbrls3xMcovdd2) #zone sig p<0.0001 f=157.9
anova(lmbrls3xMcovdd2b, lmbrls3xMcovdd2) #ddflwf is sig p=<0.0001 f=26.495
lmbrls3xMcovdd3 <- lm(rankBranches~Zone+rankDDFLWF, data=poptls3xM[c(-1,-15),], na.action="na.omit")
summary(lmbrls3xMcovdd3) #ddflwf p=<0.0001 est=0.3812, zone p=<0.0001 est=-10.8170, intercept=12.5835

ddMnz <- tapply(poptls3xM[c(-1,-15),]$DDFLWF, poptls3xM[c(-1,-15),]$Zone, length)

ggplot(data=poptls3xM[c(-1,-15),], aes(x=rankDDFLWF, y=rankBranches, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Flowering Duration (days)") + 
  scale_y_continuous("Ranked Number of Branches") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("branches vs ddflwf by Zone at ls3x MNS") +
  geom_abline(intercept=12.5835, slope=0.3812, col="#990000") +
  geom_abline(intercept=12.5835-10.8170, slope=0.3812, col="#009999") +
  annotate("text", x=c(3, 3), y=c(20, 18), label=paste("n=",ddMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))


#cov: size and ddflwf 
lmbrls3xMcovsdd <- lm(rankSIZE~Zone*rankDDFLWF, data=poptls3xM, na.action="na.omit")
plot(lmbrls3xMcovsdd) 
summary(lmbrls3xMcovsdd) #remove interaction
lmbrls3xMcovsdd2 <- update(lmbrls3xMcovsdd,~.-Zone:rankDDFLWF)
anova(lmbrls3xMcovsdd2, lmbrls3xMcovsdd) #interaction sig p=0.045 f=4.6254 
lmbrls3xMcovsdd2a <- update(lmbrls3xMcovsdd2,~.-Zone)
lmbrls3xMcovsdd2b <- update(lmbrls3xMcovsdd2,~.-rankDDFLWF)
anova(lmbrls3xMcovsdd2a, lmbrls3xMcovsdd2) #zone sig p<0.0001 f=31.845
anova(lmbrls3xMcovsdd2b, lmbrls3xMcovsdd2) #ddflwf is sig p=0.0486 f=4.4409
summary(lmbrls3xMcovsdd) #ddflwf p=0.8531 est=-0.04124, zone p=0.0001 est=-17.2788, intercept=17.5006
  #zone:ddflwf p=0.04534 est=0.61336

ddMnz <- tapply(poptls3xM$DDFLWF, poptls3xM$Zone, length)

ggplot(data=poptls3xM, aes(x=rankDDFLWF, y=rankSIZE, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Flowering Duration (days)") + 
  scale_y_continuous(expression(bold(Ranked~Plant~Size~(cm^3)))) +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("size vs ddflwf by Zone at ls3x MNS") +
  geom_abline(intercept=17.5006, slope=-0.04124, col="#990000") +
  geom_abline(intercept=17.5006-17.2788, slope=-0.04124+0.61336, col="#009999") +
  annotate("text", x=c(3, 3), y=c(22.5, 21), label=paste("n=",ddMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))

#cov: height and ddflwf 
lmbrls3xMcovhdd <- lm(rankHeight~Zone*rankDDFLWF, data=poptls3xM, na.action="na.omit")
plot(lmbrls3xMcovhdd) 
summary(lmbrls3xMcovhdd) #remove interaction
lmbrls3xMcovhdd2 <- update(lmbrls3xMcovhdd,~.-Zone:rankDDFLWF)
anova(lmbrls3xMcovhdd2, lmbrls3xMcovhdd) #interaction sig p=0.2894 f=1.1914 
lmbrls3xMcovhdd2a <- update(lmbrls3xMcovhdd2,~.-Zone)
lmbrls3xMcovhdd2b <- update(lmbrls3xMcovhdd2,~.-rankDDFLWF)
anova(lmbrls3xMcovhdd2a, lmbrls3xMcovhdd2) #zone sig p=0.0021 f=12.584
anova(lmbrls3xMcovhdd2b, lmbrls3xMcovhdd2) #ddflwf is sig p=0.038 f=4.96
summary(lmbrls3xMcovhdd2) #ddflwf p=0.038 est=0.4202, zone p=0.0021 est=-8.2310, intercept=11.5313

ddMnz <- tapply(poptls3xM$DDFLWF, poptls3xM$Zone, length)

ggplot(data=poptls3xM, aes(x=rankDDFLWF, y=rankHeight, group=Zone, col=Zone)) + 
  geom_point(size=4, position=position_dodge(0.1))+
  scale_x_continuous("Ranked Flowering Duration (days)") + 
  scale_y_continuous("Ranked Plant Height (cm)") +
  scale_colour_discrete(labels=c("Beach", "Dune"), l=40) +
  ggtitle("height vs ddflwf by Zone at ls3x MNS") +
  geom_abline(intercept=11.5313, slope=0.4202, col="#990000") +
  geom_abline(intercept=11.5313-8.2310, slope=0.4202, col="#009999") +
  annotate("text", x=c(3, 3), y=c(22.5, 21), label=paste("n=",ddMnz))+
  theme_bw() +  
  theme(legend.justification=c(1,0), legend.position="top",
        legend.text=element_text(face="bold", size=18),
        legend.title=element_text(face="bold", size=18))+
  theme(strip.text.x = element_text(size=20, face="bold"))+
  theme(strip.text.y = element_text(size=20, face="bold")) +
  theme(axis.title.x = element_text(vjust=-0.7, hjust=0.5, face="bold", size=20), 
        axis.text.x  = element_text(vjust=0.3, hjust=0.5, size=18, face="bold"))+
  theme(axis.title.y = element_text(vjust=1.5, face="bold", size=20),
        axis.text.y  = element_text(size=18, face="bold"))