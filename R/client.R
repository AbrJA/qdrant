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
      self$alias <- AliasClient$new(private$.req)
      self$collection <- Collection$new(private$.req)
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


AliasClient <- R6::R6Class(
  classname = "Alias",
  public = list(
    initialize = function(req) {
      private$.req <- req |>
        httr2::req_url_path_append("aliases")
    },
    list = function() {
      private$.req |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }
  ),
  private = list(
    .req = NULL
  )
)
