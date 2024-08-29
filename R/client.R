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
    snapshot = NULL,
    #' @description
    #' ...
    #' @param url string. URL ...
    #' @param api_key
    #'
    initialize = function(url, api_key = NULL) {
      checkmate::assertString(url, min.chars = 1L)
      private$.url <- url
      private$.req <- httr2::request(url)
      if (!checkmate::test_null(api_key)) {
        private$.req <- private$.req |>
          httr2::req_headers("api-key" = api_key)
      }
      self$collection <- Collection$new(private$.req)
      self$snapshot <- Snapshot$new(private$.req)
    },
    #' @description
    #' ...
    #'
    aliases = function() {
      private$.req |>
        httr2::req_url_path_append("aliases") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #'
    collections = function() {
      private$.req |>
        httr2::req_url_path_append("collections") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #'
    snapshots = function() {
      private$.req |>
        httr2::req_url_path_append("snapshots") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #'
    cluster = function() {
      private$.req |>
        httr2::req_url_path_append("cluster") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #'
    info = function() {
      private$.req |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #'
    telemetry = function() {
      private$.req |>
        httr2::req_url_path_append("telemetry") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #'
    metrics = function() {
      private$.req |>
        httr2::req_url_path_append("metrics") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
    },
    #' @description
    #' ...
    #'
    # Add SET POST option
    locks = function() {
      private$.req |>
        httr2::req_url_path_append("locks") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #'
    healthz = function() {
      private$.req |>
        httr2::req_url_path_append("healthz") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
    },
    #' @description
    #' ...
    #'
    livez = function() {
      private$.req |>
        httr2::req_url_path_append("livez") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
    },
    #' @description
    #' ...
    #'
    readyz = function() {
      private$.req |>
        httr2::req_url_path_append("readyz") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
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
