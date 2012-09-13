# This file includes code to read and prepare the various data sources for estimation in R

# Libraries
require(emme2)
require(reshape2)

# Emme databank
databank <- "/Users/peter/Developer/trip-based-model-est/data/emmebank"


### Emme convenience functions -- these could probably be rolled into a package or offered upstream to the emme2 package


# Batch read a list of emme matrix names (short version), and return a merged data.frame
# DANGER: This function is not exactly memory-efficient. Don't attempt on low-memory systems without refactoring.
MBatchFetch <- function(databank, matrices) {
  # Fetch the first matrix off the list
  # (assumes first matrix is representative of the those following)
  df <- MFFetch(databank, matrices[1])
  
  for(m in matrices[-1]) {
    tryCatch((new <- MFFetch(databank, m)
              df <- merge(df, new, by=intersect(names(df), names(new)))),
             finally = print(paste(m, " failed to read")))
  }
  return(df)
}

# Return the named matrix as a neatly-formatted dataframe
MFFetch <- function(databank, matrixname, varlongname=NULL, valsonly=NULL) {
  file0 <- read.file0(databank)
  file1 <- read.file1(databank, file0)
  mat.dir <- read.matdir(databank, file0, file1$global["mmat"])
  mf <- read.mf(matrixname, databank, file0, file1$global["mcent"], mat.dir)
  mf <- melt(mf,)
  
  if(is.null(varlongname)) {
    # Convert this to a dataframe to avoid breaking my brain
    dirdf <- data.frame(mat.dir$mf, stringsAsFactors=FALSE)
    varlongname <- dirdf[dirdf$name==matrixname, 2]
  }
  
  names(mf) <- c("orig", "dest", varlongname)
  
  if(is.null(valsonly)) {
    mf
  } else {
    mf[-c(1,2)]
  }
}


MFDir <- function(databank) {
  # Boilerplate file index reading
  file0 <- read.file0(databank)
  file1 <- read.file1(databank, file0)
  # Return a more useful data type and filter out null entries
  mat.dir <- data.frame(read.matdir(databank, file0, file1$global["mmat"])$mf, stringsAsFactors=FALSE)
  mat.dir <- mat.dir[mat.dir$name != "", ]

  return(mat.dir)
}
