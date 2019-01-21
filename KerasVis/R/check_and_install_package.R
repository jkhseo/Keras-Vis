#Function that checks if the R package exists and installs if it isn't installed
check_and_install_package <- function(packageName){
  print("hi")
  if (!is.element(packageName, installed.packages()[,1])){

    install.packages(packageName)
  }
  else{
    x <- paste(packageName, "is already installed")
  }
}
