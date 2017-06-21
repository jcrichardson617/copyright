#' Data framing
#'
#' Converts data built-in to a package into a dataframe.
#' @param ... name of data from package. Note that package must already be loaded (see example)
#' @keywords package data
#' 
#' @examples
#' \dontrun{
#' library(datasets)
#' dataframe <- frameit("cars")
#' }
#' @export
frameit <- function(...){
  xy <- new.env()
  make <- data(..., envir = xy)[1]
  theframe <- xy[[make]]
  return(theframe)
}

#' Data download
#'
#' Checks to see if a packages license is open use. If it is, gives the option to download data. Enter "Y" to initiate download
#' @param package Name of package where desired data come from
#' @param dataframe Dataframe from 'frameit' 
#' @param filename Name of the file to save data to
#' @keywords license checking data download
#' @importFrom utils data packageDescription write.table
#' @examples
#' \dontrun{
#' library(datasets)
#' dataframe <- frameit("cars")
#' data_download("datasets", dataframe, "cars.txt")
#' }
#' @export
data_download <- function(package, dataframe, filename){
  licensetype <- packageDescription(package, fields ="License")
  licensetype[grep("*GPL*", licensetype)] <- "free"
  licensetype[grep("*CC0*", licensetype)] <- "free"
  licensetype[grep("*BSD*", licensetype)] <- "free"
  licensetype[grep("*MIT*", licensetype)] <- "free"

  if(licensetype == "free") {
    if(dl <- readline(prompt="Download data? ")=="Y"){
      write.table(dataframe, file = filename)
    } else {
      print("Not downloaded")
    }
  } else {
    test <- print("License not of type GPL, CC0, BSD, or MIT")
  }
}
