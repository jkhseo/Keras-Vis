#' visualize_saliency
#'
#' To do
#' @param model Keras NN object
#' @param selected_filters List of lists that contain the filter numbers that you want to visualize.
#' @param layer_names List of layer names of the NN that you want to visualize.
#' @param save_folder The name of the folder you want to save the images in. "Filter_Vis" is the default.
#' @param num_iterations The number of iterations in the gradient ascent step.
#' @export
#' @examples
#' visualize_saliency()




visualize_saliency <- function(model, img, save_folder = "Saliency_Map") {
  if (!dir.exists(save_folder)) { 
    dir.create(save_folder)
  }
  linear_activation <- activations$linear
  layer_idx <- length(model$layers)-1L
  temp_model <- visutils$utils$apply_modifications(model)
  temp_layer <- temp_model$get_layer(index = layer_idx)
  last_layer_num_filters <- temp_layer$output_shape[[2]]
  temp_layer$activation <- linear_activation
  for(filter in seq(from = 0L, to=last_layer_num_filters, by=70L)){
    grads <- kerasvis$visualize_saliency(temp_model, layer_idx, filter_indices= filter, seed_input = img3, backprop_modifier = "guided")
    filter_name <- paste(save_folder, "/", "filter_num_", filter , sep = "")
    plt$axis("off")
    plt$title("Saliency Prac")
    plt$imshow(grads, cmap = "jet")
    plt$savefig(filter_name, bbox_inches = "tight")
    }

}

