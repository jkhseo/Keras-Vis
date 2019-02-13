#' Import keras-vis dependencies
#'
#' Creates module objects for kerasvis, matplotlib, os, and collections
import_all_dependendices <- function(){
  kerasvis <<- reticulate::import("vis.visualization")
  visutils <<- reticulate::import("vis.utils")
  im <<- reticulate::import("vis.input_modifiers")
  plt <<- reticulate::import("matplotlib.pyplot")
  collections <<- reticulate::import("collections")
  os <<- reticulate::import("os")
}


#' List all python versions
#'
#' @param regex regular expression to use on path
#' @param ... additional arguments to py_discover_config
#' @return character vector of python paths that are available and match regex
py_version_options <- function(regex = ".*", ...) {

  callfns <- c("py_discover_config", )
  dots <- list(...)

  pyconfig_args <- names(formals(py_discover_config))
  versions <- do.call(py_discover_config, dots[names(dots) %in% pyconfig_args])$python_versions
  versions(grepl(regex, versions))
}

