# This file includes code to read and prepare the various data sources for estimation in R

# Libraries
# An example of loading the updated emme2 package from source; will not be needed after changes rolled upstream
#remove.packages("emme2")
#install.packages("/Users/peter/Developer/emme2-r/", repos = NULL, type="source")

require(emme2)

fetchSkims <- function () {
  # Emme databank
  databank <- "./data/emmebank"
  
  matrixlist <- c("aau1tm", "aau2tm", "aau3tm", "aa1tm1", "aa1tm2", "aa1tm3", "aa1tm4", "aau1cs", "aau2cs", "aau3cs", "aa1cs1", "aa1cs2", "aa1cs3", "aa1cs4", "aau1ds", "aau2ds", "aau3ds", "aa1ds1", "aa1ds2", "aa1ds3", "aa1ds4", "izdist", "izatim", "termtm", "abrdwa", "atrtwa", "aivtwa", "atwtwa", "aiwtwa", "anbdwa", "aauxwa", "axfrwa", "walkac", "afarwa", "awlkdc", "awlktc", "abkeds", "abketm", "ivtda1", "auxda1", "twtda1", "nbdda1", "xfrda1", "ivtda2", "auxda2", "twtda2", "nbdda2", "xfrda2", "ivtda2", "ivtda3", "auxda3", "twtda3", "nbdda3", "xfrda3", "ivtda4", "auxda4", "twtda4", "iwtda4", "nbdda4", "xfrda4", "farda1", "farda2", "farda3", "farda4", "brdda4", "brdda3", "brdda2", "brdda1", "aa1tt1", "aa1tt2", "aa1tt3", "aa1tt4", "au2btm", "au3btm", "ah1btm", "ah2btm", "ah3btm", "ah4btm", "au2bcs", "au3bcs", "ah1bcs", "ah2bcs", "ah3bcs", "ah4bcs", "trtda1", "trtda2", "trtda3", "trtda4")
  
  emme.df <- MFBatchFetch(databank, matrixlist)
  
  return(emme.df)
}

fetchZonal <- function() {
  zonal.df <- read.csv("./data/zonaldata.csv", header=TRUE)
}