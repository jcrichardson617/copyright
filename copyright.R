#get license
library("vegan")

package_license <- function(package, dataset, filename){
  licensetype <- packageDescription(package, fields ="License")
  licensetype[grep("*GPL*", licensetype)] <- "GPL"
  if(licensetype == "GPL") {
    if(dl <- readline(prompt="Download data? ")=="Y"){
      env <- new.env()
      set <- data(dataset, envir = env)[1]
      x <- env[[set]]
        write.table(x, file = filename)
    } else {
      print("not downloaded")
    }
  } else {
    test <- print("Closed")
  }
}

#examples
package_license("vegan", varespec, "test.txt")


env <- new.env()
set <- data(varechem, envir = env)[1]
x <- env[[set]]


