#' Downloads GLDAS pressure data
#' @description This function downloads GLDAS pressure for a given Latitude and Longitude
#' @param save_dir The save directory for files to be placed in. For example, "C:/myfolder
#' @param Site The site name, for example "FL_ICHE2700"
#' @param Lat The site Latitude
#' @param Lon The site Longitude
#' @param startDate The starting date for the download (YYYY-MM-DD)
#'
#' @return Returns a time series of barometric pressure from the start
#' date to the most recent available data
#' @export

#===============================================================================
#Function for downloading GLDAS pressure data from 2000 - 2022 via data rods
#https://disc.gsfc.nasa.gov/information/tools?title=Hydrology%20Data%20Rods
#Created 12 December 2022
#===============================================================================

DL_GLDAS <- function(save_dir, Site, Lat, Lon, startDate){
#The initial string to build the URL
      http_string <- paste("https://hydro1.gesdisc.eosdis.nasa.gov/daac-bin/access/timeseries.cgi?variable=GLDAS2:GLDAS_NOAH025_3H_v2.1:Psurf_f_inst&startDate=2000-01-01T00&endDate=2022-12-31T23&location=GEOM:POINT(-119,%2050)&type=asc2")
      
    #Separating the date information
      start_split <- strsplit(startDate, "-")[[1]]
      #end_split <- strsplit(endDate, "-")[[1]]

    #Generating the URL
     # url <- paste(http_string, "&startDate=",
     #              start_split[1], "-",start_split[2], "-", start_split[3], "T00",
     #              "&endDate=",
     #              end_split[1], "-",end_split[2], "-", end_split[3], "T23",
     #              "&location=GEOM:POINT(", -119, ", %2050", 
     #              ")&type=asc2", sep = "")
      url <- paste(http_string, Lon, ", ", Lat, ")&startDate=", start_split[1], "-",
                   start_split[2], "-", start_split[3], "T00", "&type=asc2", sep = "")
      url2 <- "https://hydro1.gesdisc.eosdis.nasa.gov/daac-bin/access/timeseries.cgi?variable=GLDAS2:GLDAS_NOAH025_3H_v2.1:Psurf_f_inst&startDate=2000-01-01T00&endDate=2022-12-31T23&location=GEOM:POINT(-119,%2050)&type=asc2"


      #Downloading the data
      destfile <- paste(save_dir,"/", Site, "_GLDAS.asc", sep = "")

      
      
    #Error catch in case the page is inaccessible. A little inelegant at present...
      try_result <- try(download.file(url2, destfile), silent = FALSE)

      if(class(try_result) == "try-error") {file.remove(destfile)}

  } #End DL_NLDAS function
  
## use function here; be sure to set your directory (first command)
## this will download data for the Reno area. Adjust the coordinates
## accordingly for your area of interest!

DL_GLDAS("C:/Users/leonk/Dropbox/Blaszczak-Lab-Metabolism-Code-Working-Files",
         "Reno",
         39.52963, -119.8138,
         "2022-01-01")
