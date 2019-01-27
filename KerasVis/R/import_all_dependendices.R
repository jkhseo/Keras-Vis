
import_all_dependendices <- function(){
  check_and_install_package("keras")
  library(keras)
  check_and_install_package("reticulate")
  library(reticulate)
  #Changing reticulate to use python 3
  try(reticulate::use_python(python = '/anaconda3/bin/python3', required = T))
  # python 'scipy' module I want to use in my package

  kerasvis <<- import("vis.visualization")
  visutils <<- import("vis.utils")
  im <<- import("vis.input_modifiers")
  plt <<-import("matplotlib.pyplot")
  collections <<- import("collections")
  model <- application_vgg16(weights = 'imagenet', include_top = TRUE)
}
#selected_filters <- list(list(41L))#, 42L), list(5L,200L))
#layer_names <- list("block5_conv3")#, "predictions")
#model <- application_vgg16(weights = 'imagenet', include_top = TRUE)
#visualize_filter(model, selected_filters, layer_names)
