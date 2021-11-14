#Install packages
install.packages("tidyverse")
install.packages("skimr")
install.packages("Hmisc")
install.packages("gmodels")
install.packages("lsr")
install.packages("ResourceSelection")
install.packages("fmsb")
install.packages("BaylorEdPsych")
install.packages("formattable")
install.packages("moments")

pkgs <- c("tidyverse","skimr","Hmisc","gmodels","lsr","ResourceSelection",
          "fmsb","BaylorEdPsych","formattable","moments")

new.packages <- pkgs[!(pkgs %in%
                        installed.packages()[,"Package"])]
if(length(new.packages))install.packages(new.packages)

sapply(pkgs, library, character.only = T)

# call on the various packages
library(plyr)
library(tidyverse)
library(skimr)
library(Hmisc)
library(ggplot2)
library(gmodels)
library(lsr)
library(nnet)
library(ResourceSelection)
library(fmsb)
library(BaylorEdPsych)
library(data.table)
library(formattable)
library(tidyr)
library(moments)
as.numeric.factor <- function(x){as.numeric(levels(x))[x]}

# set up working directory
setwd(choose.dir())

# Use read.delim() function to read the crash data in .xls format
crashData2015<-read.delim("Crash2015.xls",header=TRUE,stringsAsFactors = FALSE,na.strings = c("NA","","-999"))
crashData2016<-read.delim("Crash2016.xls",header=TRUE,stringsAsFactors = FALSE,na.strings = c("NA","","-999"))
crashData2017<-read.delim("Crash2017.xls",header=TRUE, stringsAsFactors = FALSE,na.strings = c("NA","","-999"))
crashData2018<-read.delim("Crash2018.xls",header=TRUE, stringsAsFactors = FALSE,na.strings = c("NA","","-999"))
crashData2019<-read.delim("Crash2019.xls",header=TRUE, stringsAsFactors = FALSE,na.strings = c("NA","","-999"))
crashData2020<-read.delim("Crash2020.xls",header=TRUE, stringsAsFactors = FALSE,na.strings = c("NA","","-999"))

#combine the five data set into one data frame

crashData1520<-rbind(crashData2015,crashData2016,crashData2017,crashData2018,crashData2019,crashData2020)

#Cleaning data
#Filter drivers age to be less 120
crashData<-crashData1520[crashData1520$Driver.Age<120,]


# Filter total number of occupants

crashData1<-crashData[crashData$Vehicle.Occupants<777,]


# Group crash severity into fatality, injury, and property damage only
crashData2<-factor(crashData1$Crash.Severity,levels = c("Fatal Crash","Possible/Unknown Injury Crash",
                                                        "Suspected Minor Injury Crash","Suspected Serious Injury Crash",
                                                        "Property Damage Only"),
                   labels=c("FC","In","In","In","PDO"))

crashData3<-cbind(crashData1,C_severity=as.character(crashData2))

#Convert days of the week to a dummy variable

crashData4<-factor(crashData3$Day.of.Week, levels=c("Friday","Monday","Saturday",
                                                    "Sunday","Thursday",
                                                    "Tuesday","Wednesday"),
                   labels=c(1,1,0,0,1,1,1))


crashData4<-as.data.frame(crashData4)
crashData4a<-as.numeric.factor(crashData4$crashData4)

crashData4c<-data.frame(c(crashData4a))


crashData5<-cbind(crashData3,day_week=crashData4c$c.crashData4a.)


# convert weather into a dummy variable

crashData6<-factor(crashData5$Weather.Conditions.1,levels = c("Blowing sand, soil, dirt",
                                                              "Clear","Fog, smoke, smog",
                                                              "Not reported","Severe winds",
                                                              "Snow","Blowing snow", "Cloudy",
                                                              "Freezing rain/drizzle","Rain",
                                                              "Sleet, hail","Unknown"),
                   labels=as.numeric(c("1","0","1","0","1","1","1","0","1","1","1","0")))


crashData6<-as.data.frame(crashData6)

crashData6<-as.numeric.factor(crashData6$crashData6)

crashData6a<-data.frame(c(crashData6))


crashData6b<-cbind(crashData5,weather=(crashData6a$c.crashData6.))

#Testing for outliers
hist(crashData6b$Amount.of.Property.Damage)

# removing outliers
crashData6b<-crashData6b[crashData6b$Amount.of.Property.Damage<18000,]
hist(crashData6b$Amount.of.Property.Damage)

#crashData6b<-crashData6b[crashData6b$Number.of.Injuries>0,]

g<-factor(crashData6b$Major.Cause)

levels(g)
#Generate summary statistics
summary(crashData6b)
skim(crashData6b)

# Create histogram using driver.age and amount of property.damage

D_age=na.omit(crashData6b$Driver.Age)

driverAge1<-as.data.frame(D_age)

ggplot(driverAge1, aes(x=D_age)) + geom_histogram(binwidth=5)

# Generate frequency and use bar plot to create graph
severity<-na.omit(crashData6b$C_severity)

severity1<-as.data.frame(severity)

crashS<-plyr::count(severity1$severity)

n<-sum(crashS$freq)
relativeF<-(crashS$freq/n)*100

barplot(relativeF,names.arg = crashS$x, main="Frequency Table of Crash Severity",
        xlab="Crash Severity", ylab="Relative Feq (%)",font.main = 2, cex.main=0.8,
        cex.lab=0.8,cex.axis = 0.8,col="red")

# Create bar graphs for crash frequency by days of the week

day_week<-na.omit(crashData6b$Day.of.Week)
day_week1<-as.data.frame(day_week)

day_week2<-plyr::count(day_week1$day_week)

n<-sum(day_week2$freq)

day_week2$Relative_Percent<-(day_week2$freq/n)*100


ggplot(data=day_week2, mapping =aes(x=x,fill=Relative_Percent))+
  geom_bar()+labs(title="Crash Freq. by Day of the Week",
                                          x="Day of the Week",y="")


#Plot a scattered diagram between number of vehicle and number of injuries

nInjuries1<-na.omit(crashData6b$Number.of.Injuries)
nInjuries1<-as.data.frame(nInjuries1)

propD<-na.omit(crashData6b$Amount.of.Property.Damage)
propD<-as.data.frame(propD)

plotData<-cbind(nInjuries1,propD)

plotData$log<-log(plotData$nInjuries1+1)
plotData$lognv<-log(plotData$propD+1)


ggplot(data=plotData, mapping =aes(x=lognv,y=log))+
  geom_point()+geom_smooth(se=FALSE)+labs(title="Amount of Property Damage vs Number of injuries",
                                          x="Log of Amunt of Property Damage",y="Log of Number of Injuries")+
  scale_y_continuous(breaks=seq(1,40, by=5))+scale_x_continuous(breaks=seq(1,40,by=5))

################################################################################
#test for associations between crash severity and driver's age,weather condition
#days of the week,number of vehicles,number of occupants, and amount of property
#damage

#Preparing variables for test of association, multi-linear and multinomial logistic regression
assData<-cbind(severity1,age=driverAge1$D_age)
assData$D_age <- cut(assData$age, breaks=seq(0,110,20))


weather<-na.omit(crashData6b$weather)
weather<-as.data.frame(weather)
weekday<-na.omit(crashData6b$day_week)
weekday<-as.data.frame(weekday)
alcoResult<-na.omit(crashData6b$Alcohol.Test.Results)
alcoResult<-as.data.frame(alcoResult)
nVehicle1<-na.omit(crashData6b$Number.of.Vehicles)
nVehicle1<-as.data.frame(nVehicle1)
nVehicle<-na.omit(crashData6b$Vehicle.Occupants)
nVehicle<-as.data.frame(nVehicle)
mannerC<-na.omit(crashData6b$Manner.of.Crash.Collision)
mannerC<-as.data.frame(mannerC)

dataVariables<-cbind(assData,weather,weekday,nVehicle,alcoResult,nVehicle1,nInjuries1,mannerC,propD)

dataVariables$nVehicl3<- cut(dataVariables$nVehicle1, breaks=seq(0,16,4))
dataVariables$nVehicl2<- cut(dataVariables$nVehicle, breaks=seq(0,99,18))
plotData$group <- cut(plotData$lognv, breaks=seq(0,15,5))



#testing association between crash Severity and Driver's age
CrossTable(assData$severity, assData$D_age,
           expected = T, prop.r = F, prop.c = F,prop.t = F,
           prop.chisq = F)

#testing association between crash severity and weather condition
CrossTable(assData$severity, dataVariables$weather,
           expected = T, prop.r = F, prop.c = F,prop.t = F,
           prop.chisq = F)
#testing association between crash severity and day of week 
CrossTable(assData$severity, dataVariables$weekday,
           expected = T, prop.r = F, prop.c = F,prop.t = F,
           prop.chisq = F)

#testing association between crash severity and Number of vehicles
CrossTable(assData$severity, dataVariables$nVehicl3,
           expected = T, prop.r = F, prop.c = F,prop.t = F,
           prop.chisq = F)

#testing association between crash severity and vehicle occupants

CrossTable(assData$severity, dataVariables$nVehicl2,
           expected = T, prop.r = F, prop.c = F,prop.t = F,
           prop.chisq = F)

#testing association between crash severity and amount of property damage
CrossTable(assData$severity, plotData$group,
           expected = T, prop.r = F, prop.c = F,prop.t = F,
           prop.chisq = F)


#############################################################################
# Multinomial Logistic Regression & Multi-linear regression

############################################################################

#transforming the data used for multi-linear regression
skewness(dataVariables$nInjuries1,na.rm = TRUE)

View(dataVariables)

hist(dataVariables$nInjuries1)

View(dataVariables)
dataVariables1<-dataVariables[dataVariables$nInjuries1>0,]


dataVariables1$lognAge10<-sqrt(dataVariables1$age)
dataVariables1$Prop10<-sqrt(dataVariables1$propD)
dataVariables1$nVeh<-sqrt(dataVariables1$nVehicle)
dataVariables1$nVeh1<-sqrt(dataVariables1$nVehicle1)
dataVariables1$nInjuries1log<-sqrt(dataVariables1$nInjuries1)
dataVariables1$Alco<-sqrt(dataVariables1$alcoResult)

View(dataVariables1)
hist(dataVariables1$nInjuries1)
#Run multi-linear regression
fit<-lm(nInjuries1log~lognAge10+weekday+weather+Prop10+nVeh+nVeh1+Alco, data=dataVariables1)
summary(fit)

res <- residuals(fit)

## residuals against the fitted (predicted) test score values
# Get the predicted values of the response variable

pred<-fitted(fit)

# create a new data frame with the r
dat <- data.frame(pred, res)

# build the chart
ggplot()+geom_point(data=dat, aes(x=pred, y=res))


#Multi-normial Logistic Regression
# Cleaning data for multi-normial logistic regression

dataVariables$lognAge10<-sqrt(dataVariables$age)
dataVariables$Prop10<-sqrt(dataVariables$propD)
dataVariables$nVeh<-sqrt(dataVariables$nVehicle)
dataVariables$nVeh1<-sqrt(dataVariables$nVehicle1)
dataVariables$nInjuries1log<-sqrt(dataVariables$nInjuries1)
dataVariables$Alco<-sqrt(dataVariables$alcoResult)

dataVarables1a<-dataVariables[dataVariables$mannerC!="Other"&dataVariables$mannerC!="Unknown"&dataVariables$mannerC!="Not reported"
                             &dataVariables$mannerC!="Non-collision (single vehicle)",]


#Run multi-normial logistic regression

model <- multinom(severity~lognAge10+weekday+weather+Prop10+Alco+nVeh+nVeh1+mannerC, data = dataVarables1a)

summ<-summary(model)
print(summ)

## Compute the z scores 
z <- summ$coefficients/summ$standard.errors
z
## Genearte the p values of the z scores (two-tailed)
pv <- pnorm(abs(z), lower.tail = F)*2

print(pv)

#compute the antilogarithms of the coefficeints

expb <- exp(coef(model))

print(expb)

# compute the confidence intervals for the coefficients
ci <- confint(model, level = 0.95)

print(ci)

#compute the confidence intervals for the antilogarithms

expci <- exp(ci)

print(expci)

#compute the predicted probabilities

pred <- fitted(model)

View(pred)

#Multinomial logistic regression - goodness of fit measures
#Create the null model (without explainers)

model0 <- multinom(severity~1, data = dataVarables1a)

#compute the log-likelihoods for both models
LL1 <- logLik(model)
LL0 <- logLik(model0)

#McFadden pseudo R square
mcfadden <- 1 - (LL1 / LL0)

print(mcfadden)

#Cox-Snell pseudo R square

n <- nrow(dataVarables1a)

coxsnell <- 1 - exp((2/n) * (LL0 - LL1))

print(coxsnell)

# Nagelkerke pseudo R square
nagel <- (1 - exp((2/n) * (LL0 - LL1))) / (1 - exp(LL0)^(2/n))

print(nagel)

#get the deviance
deviance(model)

res <- residuals(model)

