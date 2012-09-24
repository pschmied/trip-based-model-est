# Estimate our models

# Packages
require(mlogit)

source("./code/data-import.R")


EstimateModeChoice <- function() {
  
  joined_data <- ProcessJoined()
  logit_data <- mlogit.data(data=joined_data,
                            choice="choice",
                            shape="long",
                            alt.var="mode",
                            chid.var="recid",
                            drop.index=TRUE)
  
# logit_data <- mlogit.data(data=joined_data,
#                            choice="choice",
#                           shape="wide",
#                          alt.var="mode",
#                          chid.var="recid",
#                          drop.index=TRUE)
  
  mc <-mlogit(formula = choice ~ am_walk_time + am_bike_time
              + hbw_income_1_sov_bidirectional_time
              | hhnumveh, 
              data = logit_data)


  
  
  return(mc)
}