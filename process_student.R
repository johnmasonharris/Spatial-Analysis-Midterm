library(stringr)
library(plyr)
library(dplyr)
library(lubridate)

# Macrozooplankton data ----
#read in  data
z <- read.csv()
z <- z[,which(unlist(lapply(z, function(x)!all(is.na(x)))))] #using the "lapply" function from the "dplyr" package, remove fields which contain all "NA" values

#create new fields with decimal degree latitude and longitude values
z$Lat_DecDeg <-

# create a date-time field
z$dateTime <- str_c(z$tow_date," ",z$tow_time,":00")
z$dateTime <- as.POSIXct(strptime(z$dateTime, tz = "America/Los_Angeles")) #Hint: look up input time formats for the 'strptime' function
z$tow_date <- NULL; z$tow_time <- NULL

#export data as tab delimited file


#Egg data Set-----

#read in data set
e <-

#turn these character fields into date-time field
e$stop_time_UTC <-
e$time_UTC <- gsub(x = e$time_UTC, pattern = "T", replacement = " ")
e$time_UTC <-

e <- e[,c(1:4,29,5:26)]

#export data