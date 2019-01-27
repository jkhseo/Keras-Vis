#' Check and install package
#'
#' This function checks whether a package has been installed or not. If it hasn't it will install it.
#' @param packageName Name of the package
#' @export
#' @examples
#' check_and_install_package()


#Function that checks if the R package exists and installs if it isn't installed
check_and_install_package <- function(packageName){
  if (!is.element(packageName, installed.packages()[,1])){
    install.packages(packageName)
    x <- paste(packageName, "successfully installed.")
  }
  else{
    x <- paste(packageName, "is already installed")
    print(x)
  }
}
