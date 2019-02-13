#' Import keras-vis dependencies
#'
#' Creates module objects for kerasvis, matplotlib, os, and collections
import_all_dependendices <- function(){
  
  kerasvis <<- reticulate::import("vis.visualization")
  visutils <<- reticulate::import("vis.utils")
  im <<- reticulate::import("vis.input_modifiers")
  plt <<- reticulate::import("matplotlib.pyplot")
  collections <<- reticulate::import("collections")
  os <<- reticulate::import("os")
}