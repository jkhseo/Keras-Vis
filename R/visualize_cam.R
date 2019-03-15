#' visualize_cam
#'
#' To do
#' @param model Keras NN object
#' @param img The image of the file you want to test
#' @param save_folder The name of the folder you want to save the images in. "Saliency_Map" is the default.
#' @export
#' @examples
#' visualize_cam()




visualize_cam <- function(model, img_directory = "", img, save_folder = "Class Activation Map") {
  if (!dir.exists(save_folder)) { 
    dir.create(save_folder)
  }
  if(img_directory  != ""){
    input_layer = model$get_layer(index = 0L)
    input_shape = input_layer$input_shape[2:3]
    imgs <- vector(("list"), length(img_directory))
    for(index in seq(1, length(img_directory), 1)){
      imgs[[index]] <- visutils$utils$load_img(img_directory[[index]], target_size = input_shape)
    }
   
  }
  
  )
  
  linear_activation <- activations$linear
  layer_idx <- length(model$layers)-1L
  temp_model <- visutils$utils$apply_modifications(model)
  temp_layer <- temp_model$get_layer(index = layer_idx)
  last_layer_num_filters <- temp_layer$output_shape[[2]]
  temp_layer$activation <- linear_activation
  for(filter in seq(from = 0L, to=last_layer_num_filters, by=70L)){
    grads <- kerasvis$visualize_cam(temp_model, layer_idx, filter_indices= filter, seed_input = img3, backprop_modifier = "guided")
    filter_name <- paste(save_folder, "/", "filter_num_", filter , sep = "")
    plt$axis("off")
    plt$title("CAM Prac")
    plt$imshow(grads, cmap = "jet")
    plt$savefig(filter_name, bbox_inches = "tight")
    }

}

