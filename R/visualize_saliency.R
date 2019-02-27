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




visualize_saliency <- function(model, selected_filters, layer_names, save_folder = "Filter_Vis", num_iterations = 150L) {
  summary(model)
  layer_idx <- visutils$utils$find_layer_idx(model, ler_names[[r_index]])
  img <- visutils$utils$load_img("/Users/kyungseo/Desktop/CSAFE/KerasVis/saliencytest1.jpg", target_size = c(224L,224L))
  linear_activation <- activations$linear
  temp_model <- visutils$utils$apply_modifications(model)
  temp_layer <- temp_model$get_layer("fc1000") 
  temp_layer$activation <- linear_activation
  temp_layer$activation
  model$get_layer("fc1000")$activation
  layer_idx <- visutils$utils$find_layer_idx(temp_model, "fc1000")
  grads <- kerasvis$visualize_saliency(model, layer_idx, filter_indices=0L, seed_input = img, backprop_modifier = "guided")
  mpl$use('Agg')
  plt$imshow(grads, cmap = "jet")
  plt$show()
  plt$close()
}

