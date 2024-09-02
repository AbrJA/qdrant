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
    #' This is the constructor method, automatically called when a new object of the Client class is created.
    
    #' @param url string. A parameter that takes the base URL for interacting with the API.
    #' @param api_key string. An optional parameter for providing an API key if needed.
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
    #' Retrieves a list of aliases from the API.
    #'
    aliases = function() {
      private$.req |>
        httr2::req_url_path_append("aliases") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' Retrieves a list of collections from the API.
    #'
    collections = function() {
      private$.req |>
        httr2::req_url_path_append("collections") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' Retrieves a list of snapshots from the API.
    #'
    snapshots = function() {
      private$.req |>
        httr2::req_url_path_append("snapshots") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' Retrieves information about the cluster.
    #'
    cluster = function() {
      private$.req |>
        httr2::req_url_path_append("cluster") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' Retrieves general server information.
    #'
    info = function() {
      private$.req |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' Retrieves telemetry data.
    #' ...
    #'
    telemetry = function() {
      private$.req |>
        httr2::req_url_path_append("telemetry") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' Retrieves metrics in a text format.
    #'
    metrics = function() {
      private$.req |>
        httr2::req_url_path_append("metrics") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
    },
    #' @description
    #' Retrieves information about locks.
    #'
    # Add SET POST option
    locks = function() {
      private$.req |>
        httr2::req_url_path_append("locks") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #'  Checks the health status of the server.
    #'
    healthz = function() {
      private$.req |>
        httr2::req_url_path_append("healthz") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
    },
    #' @description
    #' Checks if the server is live.
    #'
    livez = function() {
      private$.req |>
        httr2::req_url_path_append("livez") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
    },
    #' @description
    #' Checks if the server is ready.
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
