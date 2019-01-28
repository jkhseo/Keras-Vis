import_all_dependendices <- function(){
  check_and_install_package("keras")
  library(keras)
  check_and_install_package("reticulate")
  library(reticulate)
  #Changing reticulate to use python 3
  try(reticulate::use_python(python = '/anaconda3/bin/python3', required = T))
  kerasvis <<- import("vis.visualization")
  visutils <<- import("vis.utils")
  im <<- import("vis.input_modifiers")
  plt <<-import("matplotlib.pyplot")
  collections <<- import("collections")
  os <<- import("os")

}
