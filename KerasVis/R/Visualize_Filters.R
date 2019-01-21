#' Visualize Filter
#'
#' This function allows you to visualize the filters of a trained keras NN.
#' @param model Keras NN object
#' @param selected_filters List of lists that contain the filter numbers that you want to visualize.
#' @param layer_names List of layer names of the NN that you want to visualize.
#' @export
#' @examples
#' visualize_filter()


#Function that takes the trained keras NN, list of layer names, and list of lists
# that contain the respective filter number that we want to visualize

visualize_filter <- function(model, selected_filters, layer_names){
  jitter <- list(im$Jitter(.05))

  #Using python's deque to store the filter images
  old_images = collections$deque()
  python_index <- 0
  r_index <- 1

  #Generating the visualization for all the selected filters in the selected layers
  for(layer_name in layer_names){
    img = collections$deque()
    old_images$append(img)
    layer_idx <- visutils$utils$find_layer_idx(model, layer_names[[r_index]])
    for(filter_num in selected_filters[[r_index]]){
      old_filter <- kerasvis$visualize_activation(model, layer_idx, filter_indices=filter_num, tv_weight=0L, input_modifiers=jitter, max_iter=150L)
      filter_name <- paste(layer_names[r_index], "pre_Filter", filter_num, sep="_")
      plt$axis('off')
      plt$title(filter_name)
      plt$imshow(old_filter)
      plt$savefig(filter_name ,bbox_inches='tight')
      img$append(old_filter)


    }
    python_index = python_index + 1
    r_index = r_index + 1
  }

  #Generating a better visualization for all the selected filters in the selected layers
  # through increased iterations, regularization, and using the old visualization as a starting point.
  python_index <- 0
  r_index <- 1
  jitter2 <- list(im$Jitter(.05))
  new_images = collections$deque()
  for(layer_name in layer_names){
    temp_layer = old_images$popleft()
    img = collections$deque()
    new_images$append(img)
    layer_idx <- visutils$utils$find_layer_idx(model, layer_names[[r_index]])
    for(filter_num in selected_filters[[r_index]]){
      new_filter <- kerasvis$visualize_activation(model, layer_idx, filter_indices=filter_num, seed_input=temp_layer$popleft() , input_modifiers=jitter2)
      filter_name <- paste(layer_names[r_index], "post_Filter", filter_num, sep="_")
      plt$axis('off')
      plt$title(filter_name)
      plt$imshow(new_filter)
      plt$savefig(filter_name ,bbox_inches='tight')
      img$append(new_filter)


    }

    #Generating a image pallete with 4 columns for all the layers
    stitched <- visutils$utils$stitch_images(new_images[python_index], cols=4L)
    plt$figure(figsize=c(20,30))
    name <- paste(layer_names[r_index], "",  sep="")
    plt$axis('off')
    plt$title(name)
    plt$imshow(stitched)
    plt$savefig(name ,bbox_inches='tight')
    plt$show()

    python_index = python_index + 1
    r_index = r_index + 1

  }
}

