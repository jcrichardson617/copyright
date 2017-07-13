#' Name it
#'
#' Assigns built-in package data to a named variable.
#' @param ... name of data from package. Note that package must already be loaded (see example)
#' @keywords package data
#'
#' @examples
#' \dontrun{
#' library(datasets)
#' dataframe <- nameit("cars")
#' }
#' @export
nameit <- function(...){
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
#' cars_named <- nameit("cars")
#' data_writer("datasets", cars_named, "cars.txt")
#' }
#' @export
data_writer <- function(package, dataframe, filename){
  licensetype <- packageDescription(package, fields ="License")
  if(grepl("*GNU|*Artistic|*GPL|*CC0|*BSD|*MIT|*Creative|*Part", licensetype) == TRUE) {
    if(dl <- readline(prompt="Write data to file? ")=="yes"){
      write.table(dataframe, file = filename)
    } else {
      print("Not saved")
    }
  } else {
    print(cat("License is: ", licensetype))
  }
}

#' Read online csv extended
#'
#' Description
#' @param url address url address of desired dataset
#' @keywords read csv public data
#' @examples
#' \dontrun{
#' read.URL("http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat")
#' }
#' @export
read.URL <- function(urladdress){
  df <-  read.csv(url(urladdress))
  return(list(df,print("Make sure these data are public before using them.")))
}

#' Read online csv2 extended
#'
#' Description
#' @param url address url address of desired dataset
#' @keywords read csv2 public data
#' @examples
#' \dontrun{
#' read.csv2_cr("http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat")
#' }
#' @export
read.csv2_cr <- function(urladdress){
  df <-  read.csv2(url(urladdress))
  return(list(df,print("Make sure these data are public before using them.")))
}

#' Read online delim extended
#'
#' Description
#' @param url address url address of desired dataset
#' @keywords read delim public data
#' @examples
#' \dontrun{
#' read.delim_cr("http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat")
#' }
#' @export
read.delim_cr <- function(urladdress){
  df <-  read.delim(url(urladdress))
  return(list(df,print("Make sure these data are public before using them.")))
}

#' Read online delim2 extended
#'
#' Description
#' @param url address url address of desired dataset
#' @keywords read delim2 public data
#' @examples
#' \dontrun{
#' read.delim2_cr("http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat")
#' }
#' @export
read.delim_cr <- function(urladdress){
  df <-  read.delim2(url(urladdress))
  return(list(df,print("Make sure these data are public before using them.")))
}

#' Read locked file extended
#'
#' Description
#' @param url address url address of desired dataset
#' @keywords read csv public data
#' @examples
#' \dontrun{
#' read.csv_cr("http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat")
#' }
#' @export
#' Description
#' @param url address url address of desired dataset
#' @keywords read csv public data
#' @imports RDCOMClient (>= 0.93-0.2)
#' @examples
#' \dontrun{
#' lockedXL_ext("locked_file.xlsx","passcode")
#' }
#' @export
lockedXL_ext <- function(your_file, your_password){
  library(RDCOMClient)
  eApp <- COMCreate("Excel.Application")
  wk <- eApp$Workbooks()$Open(Filename=your_file,Password=your_password)
  tf <- tempfile()
  wk$Sheets(1)$SaveAs(tf, 3)
  df <- read.table(sprintf("%s.txt", tf), header = TRUE, sep = "\t")
  return(list(df,print("Make sure these data are public before using them.")))
}
