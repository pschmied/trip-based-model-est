# This file includes code to read and prepare the various data sources for estimation in R

# Libraries
# An example of loading the updated emme2 package from source; will not be needed after changes rolled upstream
#remove.packages("emme2")
#install.packages("/Users/peter/Developer/emme2-r/", repos = NULL, type="source")

require(emme2)
require(RODBC)
require(sqldf)
require(car)

FetchSkims <- function () {
  # Read relevant variables from each emme databank
  # Non-motor times (not actually time-of-day specific)
  nonmotor <- "./data/Skims/NonMotorized/AM/emmebank"
  nonmotor_mat <- c("awlktm", "abketm")
  nonmotor_df <- MFBatchFetch(nonmotor, nonmotor_mat)
  
  # Bi-directional time
  bidirectional <- "./data/Skims/BiDirectional/Time/emmebank"
  bidirectional_mat <- c("ah1btm", "ah2btm", "ah3btm", "ah4btm")
  bidirectional_df <- MFBatchFetch(bidirectional, bidirectional_mat)
  
  # Merge our data.frames
  emme_df <- merge(x=nonmotor_df, y=bidirectional_df, by=c("orig", "dest"))
  
  return(emme_df)
}

FetchTrips <- function() {
 # db <- odbcDriverConnect('Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=R:/CHRIS/Development/HHSurvey2006/HHSurveyFinal.mdb')
  trip1loc <- "./data/Trips/Trip1.csv"
  trip2loc <-"./data/Trips/Trip2.csv"
  
  trip1 <- read.csv(trip1loc, header=TRUE,
           stringsAsFactors=FALSE,
           row.names = NULL)
  trip2 <- read.csv(trip2loc, header=TRUE,
                    stringsAsFactors=FALSE,
                    row.names = NULL)
  
  trips <- merge(x=trip1, y=trip2,
                 by=intersect(names(trip1), names(trip2)),
                 all.x=TRUE)
  
  trips <-trips[!duplicated(trips$recid), ] # purge non-unique
  
  return(trips)
}

ProcessTrips <- function() {
  ## Long function; CONSIDER BREAKING UP
  # Call trips t while inside this function
  tr <- FetchTrips()
  
  ## Filter out unneeded records
  # exclude vanpool, other and missing modes
  tr <- tr[tr$mmode != 4 & tr$mmode !=9 & ! is.na(tr$mmode), ]
  # exclude drive transit trips where the park and ride lot is not coded
  tr <- tr[! (tr$mmode == 6 & (tr$parkwha==9999 | is.na(tr$parkwha))), ]
  
  ## Process into Production / Attraction format
  # 1. Get all trips Production to Attraction,
  # 2. Label production and attraction zone
  tr_pa <- sqldf("SELECT tr.recid, tr.qno, tr.trptype2,
                         tr.taz1 AS production_zone, tr.taz2 AS attraction_zone, 
                         tr.mode4, tr.expfacgps, tr.mode2, tr.mode3,
                         tr.mode4, tr.mmode, tr.cnty,
                         tr.city, tr.zip, tr.triptype,
                         tr.trptype1, tr.trptype2, tr.trptype3,
                         tr.hhnumppl, tr.hhnumwkr, tr.hhnumveh,
                         tr.totalinc, tr.expfac2
                  FROM tr
                  WHERE (((tr.trptype2)=11 or
                          (tr.trptype2)=21 or
                          (tr.trptype2)=31 or
                          (tr.trptype2)=41 or
                          (tr.trptype2)=51 or
                          (tr.trptype2)=66 or
                          (tr.trptype2)=77));")
  
  # get all trips Attraction to Production,  and label production and
  # attraction zone
  tr_ap <- sqldf("SELECT tr.recid, tr.qno, tr.trptype2,
                         tr.taz1 as attraction_zone, tr.taz2 as production_zone, 
                         tr.mode4, tr.expfacgps, tr.mode2, tr.mode3,
                         tr.mode4, tr.mmode, tr.cnty,
                         tr.city, tr.zip, tr.triptype,
                         tr.trptype1, tr.trptype2, tr.trptype3,
                         tr.hhnumppl, tr.hhnumwkr, tr.hhnumveh,
                         tr.totalinc, tr.expfac2
                  FROM tr
                  WHERE (((tr.trptype2)=12 or
                          (tr.trptype2)=22 or
                          (tr.trptype2)=32 or
                          (tr.trptype2)=42 or
                          (tr.trptype2)=52));")
  
  #  put P-A and A-P trips back together
  tr <- rbind(tr_pa, tr_ap)

  
  ## Recode mode variables
  tr$mode <- recode(tr$mmode,
                    "1='SOV'; 2='HOV2';
                     3='HOV3'; 5='WalkTransit';
                     6='DriveTransit'; 7='Walk'; 8='Bike'")
  
  modes <- c("SOV", "HOV2",
             "HOV3", "WalkTransit",
             "DriveTransit", "Walk", "Bike")
  
  ## Replicate records to include unchosen alternatives
  # All existing records represent chosen alternatives
  tr$choice <- TRUE
  
  merged <- tr
  for(x in modes) {
    new <- tr[tr$mode != x, ]
    new$mode <- x
    new$choice <- FALSE # all new records were NOT chosen
    merged <- rbind(merged, new)
  }
  
  return(merged)
  }

JoinData <- function() {
  skims <- FetchSkims()
  trips <- ProcessTrips()
  
  joined <- merge(x=skims, y=trips,
                  by.x=c("orig","dest"),
                  by.y=c("production_zone", "attraction_zone"))
  
  return(joined)
}

ProcessJoined <- function() {
  joined <- JoinData()
  
  # set non walk,non bike alternative's time equal to zero
  joined[joined$mode != "Walk", ]$am_walk_time <- 0
  joined[joined$mode != "Bike", ]$am_bike_time <- 0
  
  joined$zerocar <- 0
  joined[joined$hhnumveh == 0 , ]$zerocar <- 1
  
  joined$carsltwrkrs <- 0
  joined[joined$hhnumveh != 0 & joined$hhnumveh < joined$hhnumwkr, ]$carsltwrkrs <- 1
  
  joined$crmrwrks <- 0
  joined[joined$hhnumveh > joined$hhnumwkr, ]$crmrwrks <- 1

  return(joined)
}
  

FetchZonal <- function() {
  zonal_df <- read.csv("./data/zones.csv", header=TRUE)
}