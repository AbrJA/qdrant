#' @title Snapshot
#'
#' @description
#' Creates an Snapshot class
#'
#' @export
#'
Snapshot <- R6::R6Class(
  classname = "Snapshot",
  public = list(
    initialize = function(req) {

      private$.req <- req |>
        httr2::req_url_path_append("snapshots")
    },
    create = function(wait = TRUE) {

      checkmate::assert_flag(wait)

      private$.req |>
        # tolower used because bug with httr2
        httr2::req_url_query(wait = tolower(wait)) |>
        httr2::req_method("POST") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    download = function(name, path) {

      checkmate::assert_string(name, min.chars = 1L)
      checkmate::assert_string(path, min.chars = 1L)

      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_progress() |>
        httr2::req_perform(path = path)
    },
    delete = function(name, wait = TRUE) {

      checkmate::assert_string(name, min.chars = 1L)
      checkmate::assert_flag(wait)

      private$.req |>
        httr2::req_url_path_append(name) |>
        # tolower used because bug with httr2
        httr2::req_url_query(wait = tolower(wait)) |>
        httr2::req_method("DELETE") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }
  ),
  private = list(
    .req = NULL
  )
)
