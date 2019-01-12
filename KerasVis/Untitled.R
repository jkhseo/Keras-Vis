library(reticulate)
reticulate::use_python(python = '/anaconda3/bin/python3', required = T)
sys <- import("sys")
sys$version
img = []
library(keras)
collections = import("collections")
list = collections$deque(collections$deque())
model <- application_vgg16(weights = 'imagenet', include_top = TRUE)
layer_names <- list("block1_conv2", "predictions")
paste()
kerasvis <- import("vis.visualization")
visutils <- import("vis.utils")
plt <-import("matplotlib.pyplot")
img <- pd$DataFrame
i <- 1
img <- c(c(), c())
temp_img <- kerasvis$visualize_activation(model, 1L, filter_indices=2L, tv_weight=0L,  max_iter=1L)
temp_img2 <- kerasvis$visualize_activation(model, 1L, filter_indices=3L, tv_weight=0L,  max_iter=1L)
list$append(temp_img)
list$append(temp_img2)
img <- visutils$utils$stitch_images(list, cols=2L)
plt$imshow(img)
plt$show()
