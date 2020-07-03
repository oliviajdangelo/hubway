# Import hubway data
stations <- read.csv("hubway_stations.csv")
trips <- read.csv("hubway_trips.csv")

# 1. What are the column names? Find out using R.
colnames(stations)
# 
# 2. How many stations are there? Find out using R.
length(unique(stations$station))
# 
# Here is the dictionary for this file:
# id: station id assigned by MAPC; corresponds to strt_statn and end_statn in trips table
# terminal: Hubway-assigned station identifier
# station: station name
# municipal: Municipality
# lat: station latitude
# lng: station longitude
# status: Existing station locations and ones that have been removed or relocated
# 
# 3. Look at the summary of this data frame with Hubway station information. 
# Some of these bike stations don't exist anymore; 
# create a data frame with only those that still exist. How many are left?

summary(stations)


# subsetting into a dataframe: [rows, columns]
stations_e <- stations[stations$status == "Existing",]


# B. Explore the trip data
# 
# 0. Read in hubway_trips.csv to R
# 
# 1. This file is quite large. (And we've already removed move than 75% of the data!) How many rows and columns does it have?
#                               
#                               Below is the data dictionary:
#                               seq_id: unique record ID
#                               hubway_id: trip id
#                               status: trip status; "closed" indicates a trip has terminated
#                               duration: time of trip in seconds
#                               start_date: start date of trip with date and time, in EST
#                               strt_statn: id of start station
#                               end_date: end date of trip with date and time, in EST
#                               end_statn: station id of end station
#                               bike_nr: id of bicycle used
#                               subsc_type: subscription type - "Registered" is user with membership; "Casual" is user without membership
#                               zip_code: ZIP code of user (only available for registered users) 
#                               **data includes an apostrophe(') prefix**
# birth_date: birth year of user
# gender: gender of user

ncol(trips)
nrow(trips)
# 
# Let’s do #2-4 together
# 
# 2. How many unique user zip codes are in this dataset?
# 
length(unique(trips$zip_code))
# 
# 
# 3. How many unique bicycles are in this dataset?
# 
length(unique(trips$bike_nr))
# 
# 
# 4. Calculate the count of rides for each unique bicycle. 
# 
bike_rides <- table(trips$bike_nr)
# 
#
# 5. Which bicycle is ridden most frequently? 

bike_rides <- as.data.frame(bike_rides)

bike_rides[which.max(bike_rides$Freq),1] #B00401

#   
#   6. Which bicycle is ridden least frequently?
#   
#   
#   
#   7. Calculate the total duration of all rides for each bicycle. Hint: tapply() or aggregate()
total_duration <- aggregate(trips$duration, by = list(trips$bike_nr), FUN = sum)
