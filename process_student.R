library(stringr)
library(plyr)
library(dplyr)
library(lubridate)
library("pastecs")
library("oce")
library(tidyverse)
library(readxl)
library(tidyr)

# Macrozooplankton data ----
#read in  data
z <- read.csv(file = "195101-201404_Zoop.csv")
z = as.data.frame(z)
z <- z[,which(unlist(lapply(z, function(x)!all(is.na(x)))))] #using the "lapply" function from the "dplyr" package, remove fields which contain all "NA" values

#convert latitude to decimal format
z$Lat_DecMin <- (z$Lat_Min/60)
z$lat = (z$Lat_Deg + z$Lat_DecMin)
# repeat for longitude
z$Lon_DecMin = (z$Lon_Min/60)
z$lon = (z$Lon_Deg + z$Lon_DecMin) * -1

# create a date-time field
z$dateTime <- str_c(z$Tow_Date, " ", z$Tow_Time, ":00")
z$dateTime <- as.POSIXct(strptime(z$dateTime, "%m/%d/%Y %H:%M:%S", tz = "America/Los_Angeles")) #Hint: look up input time formats for the 'strptime' function
z$tow_date <- NULL; z$tow_time <- NULL

# keep only certain columns
z <- z[,c("ID", "Cruise","CruiseAlias", "lat", "lon", "Sta_ID", "Cruz_Sta", "Ship_Code", "Order_Occ", "Cruz_Code", "St_Line", "St_Station", 
          "Tow_Type", "Net_Loc", "End_Time", "Vol_StrM3", "Tow_DpthM", "Ttl_PVolC3", "Sml_PVolC3", "HaulFact", "dateTime")]

#export data as tab delimited file
z = write.table(z, "macrozooplankton.txt", sep="\t")



#Egg data Set-----

#read in data set
e <- read.csv(file = "erdCalCOFIcufes_bb4a_5c83_ad3a.csv")
e = as.data.frame(e)

#turn these character fields into date-time field
e$stop_time_UTC <- e$time_UTC
e$time_UTC <- gsub(x = e$time_UTC, pattern = "T", replacement = " ")
e$time_UTC <- gsub(x = e$time_UTC, pattern = "Z", replacement = " ")

e <- e[,c(1:26)]

#export data
e = write.table(e, "eggs.txt", sep="\t")
