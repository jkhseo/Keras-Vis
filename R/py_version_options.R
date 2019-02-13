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
