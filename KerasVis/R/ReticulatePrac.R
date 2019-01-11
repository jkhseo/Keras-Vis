library(reticulate)
reticulate::use_python(python = '/anaconda3/bin/python3', required = T)
sys <- import("sys")
sys$version

library(keras)
model <- application_vgg16(weights = 'imagenet', include_top = TRUE)

source_python("kerasvis.py")

os <- import("os")
os$listdir(".")

selected_filters <- list(list(2L, 7L), list(2L, 7L))
layer_names <- list("block1_conv2", "predictions")

x <- visualize_layer(model, selected_filters,layer_names )




