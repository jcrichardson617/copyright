#' Data framing
#'
#' Converts built-in package data into a dataframe.
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

#' Data writer
#'
#' Checks to see if a packages license is open use. If it is, gives the option to write data to a file. Enter "Y" to initiate download
#' @param package Name of package where desired data come from
#' @param dataframe Dataframe from 'frameit' 
#' @param filename Name of the file to save data to
#' @keywords license checking data download
#' @importFrom utils data packageDescription write.table
#' @examples
#' \dontrun{
#' library(datasets)
#' dataframe <- frameit("cars")
#' data_writer("datasets", dataframe, "cars.txt")
#' }
#' @export
data_writer <- function(package, dataframe, filename){
  licensetype <- packageDescription(package, fields ="License")
  if(grepl("*GNU|*Artistic|*GPL|*CC0|*BSD|*MIT|*Creative|*Part", licensetype) == TRUE) {
    if(dl <- readline(prompt="Write data to file? ")=="Y"){
      write.table(dataframe, file = filename)
    } else {
      print("Not downloaded")
    }
  } else {
    print(cat("License is: ", licensetype))
  }
}
