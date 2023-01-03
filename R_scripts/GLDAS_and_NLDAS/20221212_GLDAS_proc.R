#' Processes downloaded NLDAS light data
#' @description This function processes downloaded NLDAS incoming shortwave radiation
#' data (w m-2) for a given Latitude and Longitude. Processing steps include:
#'
#' \itemize{
#'   \item Converting UTC time to local time
#'   \item Converting incoming shotwave radiation (w m-2) to PPFD (umol m-2 s-1)
#' }
#'
#' @param read_dir The read directory for downloaded files. For example, "C:/myfolder
#' @param save_dir The save directory for files to be placed in. For example, "C:/myfolder
#' @param Site The site name, for example "FL_ICHE2700"
#' @param Lat The site Latitude
#' @param Lon The site Longitude
#'
#' @return Returns a time series of incoming light data
#' @export

#===============================================================================
#Function for processing the downloaded data
#Updated 12/12/2022
#===============================================================================
  GLDAS_proc <- function(read_dir, save_dir, Site, Lat, Lon){
    #Reading in the table, skipping the first 13 lines of header information
      setwd(read_dir)
      file_name <- paste(Site, "_GLDAS.asc", sep = "")
      gldas <- read.table(file_name, skip = 13, nrows = length(readLines(file_name))- 14)
          #colnames(gldas) <- c("Date", "hour_raw", "pressure")

          #file_name <- read.table(file.choose(),skip = 13)
          #gldas <- file_name
          
          colnames(gldas) <- c("DateTime", "Pressure")
          
          library(anytime)
          gldas$date2<-strptime(gldas$DateTime, format = '%Y-%m-%dT%H:%M:%S')
          
          #Adding in Year, DOY, and hour information
          gldas[, "Year"] <- as.numeric(format(gldas[, "date2"], format = "%Y", tz = "UTC"))
          gldas[, "DOY"] <- as.numeric(format(gldas[, "date2"], format = "%j", tz = "UTC"))
          gldas[, "Hour"] <- as.numeric(format(gldas[, "date2"], format = "%H", tz = "UTC"))
          
          #Selecting the final column
          final <- gldas[, c("DateTime", "Year", "DOY", "Hour", "Pressure")]
          
          #Writing the final output
          setwd(save_dir)
          write.csv(final, paste(Site, "_GLDAS_Pressure.csv", sep = ""), quote = FALSE, row.names = FALSE)
          
  } #End GLDAS_proc
  
### Below is a general Reno processing example
### Be sure to change the directories accordingly! Consider whether you want
### to save the processed data in a different folder/directory   
  
 GLDAS_proc("C:/Users/leonk/Dropbox/Blaszczak-Lab-Metabolism-Code-Working-Files",
            "C:/Users/leonk/Dropbox/Blaszczak-Lab-Metabolism-Code-Working-Files",
            "Reno",
            39.52963, 
            -119.8138)

