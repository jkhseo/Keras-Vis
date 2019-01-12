library(reticulate)
reticulate::use_python(python = '/anaconda3/bin/python3', required = T)
sys <- import("sys")
sys$version

library(keras)
model <- application_vgg16(weights = 'imagenet', include_top = TRUE)

#source_python("kerasvis.py")

kerasvis <- import("vis.visualization")
visutils <- import("vis.utils")
plt <-import("matplotlib.pyplot")
collections <- import("collections")
images = collections$deque()
i <- 0
j <- 1
selected_filters <- list(list(2L, 4L), list(2L, 7L))
layer_names <- list("block1_conv2", "predictions")
#Looping through the layers

visualize_filter <- function(model, selected_filters, layer_names){
  images = collections$deque()
  i <- 0
  j <- 1
  for(layer_name in layer_names){
    img = collections$deque()
    images$append(img)
    layer_idx <- visutils$utils$find_layer_idx(model, layer_names[[j]])
    for(filter_num in selected_filters[[j]]){
      temp_img <- kerasvis$visualize_activation(model, layer_idx, filter_indices=filter_num, tv_weight=0L,  max_iter=1L)
      filter_name <- paste(layer_names[j], filter_num, sep="_")
      plt$imshow(temp_img)
      plt$savefig(filter_name ,bbox_inches='tight')
      img$append(temp_img)


    }

    #x <- visualize_layer(model, selected_filters,layer_names )
    stitched <- visutils$utils$stitch_images(images[i], cols=2L)
    plt$figure(figsize=c(20,30))
    plt$title(layer_idx)
    name <- paste(layer_names[j], "",  sep="")
    plt$axis('off')
    plt$imshow(stitched)
    plt$savefig(name ,bbox_inches='tight')
    plt$show()

    i = i + 1
    j = j + 1

  }
}
visualize_filter(model, selected_filters, layer_names)
