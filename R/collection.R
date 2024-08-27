#' @title Collection
#'
#' @description
#' Creates an Collection class
#'
#' @export
#'
Collection <- R6::R6Class(
  classname = "Collection",
  public = list(
    initialize = function(req) {
      private$.req <- req |>
        httr2::req_url_path_append("collections")
    },
    aliases = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_url_path_append("aliases")
    },
    create = function(name, config, init_from = NULL) {
      checkmate::assert_multi_class(config, classes = c("config", "params"))
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_body_json(config, force = TRUE) |>
        httr2::req_method("PUT") |>
        httr2::req_perform()
    },
    delete = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_method("DELETE") |>
        httr2::req_perform()
    },
    exists = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_url_path_append("exists") |>
        httr2::req_perform()
    },
    info = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_perform()
    },
    list = function() {
      private$.req |>
        httr2::req_perform()
    }
  ),
  private = list(
    .req = NULL
  )
)

Alias <- R6::R6Class(
  classname = "Alias",
  public = list(

  )
)

Snapshot <- R6::R6Class(
  classname = "Snapshot",
  public = list(
    list = function() {
      private$.req |>
        httr2::req_perform()
    }
  )
)
