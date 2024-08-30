Point <- R6::R6Class(
  classname = "Point",
  public = list(
    initialize = function() {

    },
    point = function(id, consistency = NULL, timeout = 10L) {

      checkmate::assert(
        checkmate::check_int(id),
        checkmate::check_string(id, min.chars = 1L)
      )

      if (!checkmate::test_null(consistency)) {
        checkmate::assert(
          checkmate::check_int(consistency),
          checkmate::check_choice(consistency, choices = c("majority", "quorum", "all"))
        )
        req <- private$.req |>
          httr2::req_url_query(consistency = consistency)
      }

      req |>
        # Use asInt
        httr2::req_url_query(id = id, timeout = checkmate::asInt(timeout)) |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    # Check orden here
    points = function(ids, with_payload, with_vector, shard_key, consistency, timeout = 10L) {

      checkmate::assert(
        checkmate::check_int(id),
        checkmate::check_string(id, min.chars = 1L)
      )

      if (!checkmate::test_null(consistency)) {
        checkmate::assert(
          checkmate::check_int(consistency),
          checkmate::check_choice(consistency, choices = c("majority", "quorum", "all"))
        )
        req <- private$.req |>
          httr2::req_url_query(consistency = consistency)
      }

      req |>
        # Use asInt
        httr2::req_url_query(id = id, timeout = checkmate::asInt(timeout)) |>
        httr2::req_body_json(ids, force = TRUE) |>
        httr2::req_method("POST") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }
  ),
  private = list(
    .req = NULL
  )
)
