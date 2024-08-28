#' @title Client
#'
#' @description
#' Creates an Client class
#'
#' @export
#'
Client <- R6::R6Class(
  classname = "Client",
  public = list(
    alias = NULL,
    collection = NULL,
    initialize = function(url, api_key = NULL) {
      checkmate::assertString(url, min.chars = 1L)
      private$.url <- url
      private$.req <- httr2::request(url)
      if (!checkmate::test_null(api_key)) {
        private$.req <- private$.req |>
          httr2::req_headers("api-key" = api_key)
      }
      self$collection <- Collection$new(private$.req)
    },
    aliases = function() {
      private$.req |>
        httr2::req_url_path_append("aliases") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    collections = function() {
      private$.req |>
        httr2::req_url_path_append("collections") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }
  ),
  active = list(
    url = function(url) {
      if (missing(url)) {
        private$.url
      } else {
        checkmate::assert_string(url, min.chars = 1L)
        private$.url <- url
      }
    }
  ),
  private = list(
    .req = NULL,
    .url = NULL
  )
)
