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
    collection = NULL,
    initialize = function(url) {
      checkmate::assertString(url, min.chars = 1L)
      private$.url <- url
      private$.req <- httr2::request(url)
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
