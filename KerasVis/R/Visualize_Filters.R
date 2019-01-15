library(reticulate)
reticulate::use_python(python = '/anaconda3/bin/python3', required = T)
library(keras)
model <- application_vgg16(weights = 'imagenet', include_top = TRUE)
kerasvis <- import("vis.visualization")
im <- import("vis.input_modifiers")
visutils <- import("vis.utils")
plt <-import("matplotlib.pyplot")
collections <- import("collections")
visualize_filter <- function(model, selected_filters, layer_names){
  jitter <- list(im$Jitter(.05))
  images = collections$deque()
  i <- 0
  j <- 1
  for(layer_name in layer_names){
    img = collections$deque()
    images$append(img)
    layer_idx <- visutils$utils$find_layer_idx(model, layer_names[[j]])
    for(filter_num in selected_filters[[j]]){
      temp_img <- kerasvis$visualize_activation(model, layer_idx, filter_indices=filter_num, tv_weight=0L, input_modifiers=jitter, max_iter=1L)
      filter_name <- paste(layer_names[j], filter_num, sep="_")
      plt$axis('off')
      plt$title(filter_name)
      plt$imshow(temp_img)
      plt$savefig(filter_name ,bbox_inches='tight')
      img$append(temp_img)


    }
    i = i + 1
    j = j + 1
  }
  i <- 0
  j <- 1
  jitter2 <- list(im$Jitter(.05))

  new_images = collections$deque()
  for(layer_name in layer_names){
    temp_layer = images$popleft()
    img = collections$deque()
    new_images$append(img)
    layer_idx <- visutils$utils$find_layer_idx(model, layer_names[[j]])
    for(filter_num in selected_filters[[j]]){
      temp_img <- kerasvis$visualize_activation(model, layer_idx, filter_indices=filter_num, seed_input=temp_layer$popleft() , input_modifiers=jitter2,max_iter=1L)
      filter_name <- paste(layer_names[j], filter_num, sep="_new")
      plt$axis('off')
      plt$title(filter_name)
      plt$imshow(temp_img)
      plt$savefig(filter_name ,bbox_inches='tight')
      img$append(temp_img)


    }

    stitched <- visutils$utils$stitch_images(new_images[i], cols=2L)
    plt$figure(figsize=c(20,30))
    name <- paste(layer_names[j], "",  sep="")
    plt$axis('off')
    plt$title(name)
    plt$imshow(stitched)
    plt$savefig(name ,bbox_inches='tight')
    plt$show()

    i = i + 1
    j = j + 1

  }
}
model <- application_vgg16(weights = 'imagenet', include_top = TRUE)
images = collections$deque()
selected_filters <- list(list(41L))#, list(200L))
layer_names <- list("block5_conv3")#, "predictions")
visualize_filter(model, selected_filters, layer_names)
