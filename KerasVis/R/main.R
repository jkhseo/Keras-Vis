check_and_install_package("keras")
check_and_install_package("reticulate")
library(reticulate)
library(keras)


#Changing reticulate to use python 3
reticulate::use_python(python = '/anaconda3/bin/python3', required = T)

kerasvis <- import("vis.visualization")
im <- import("vis.input_modifiers")
visutils <- import("vis.utils")
plt <-import("matplotlib.pyplot")
collections <- import("collections")

dir.create("/images", showWarnings=FALSE)
model <- application_vgg16(weights = 'imagenet', include_top = TRUE)




#model <- application_vgg16(weights = 'imagenet', include_top = TRUE)
images = collections$deque()
selected_filters <- list(list(41L))#, 42L), list(5L,200L))
layer_names <- list("block5_conv3")#, "predictions")
visualize_filter(model, selected_filters, layer_names)
