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
    alias = NULL,
    initialize = function(req) {
      private$.req <- req |>
        httr2::req_url_path_append("collections")
      self$alias <- Alias$new(private$.req)
    },
    #' @description
    #' List the collection alias
    #' @param name string. Collection name
    #'
    aliases = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_url_path_append("aliases") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #' @param name string. Collection name
    #'
    create = function(name,
                      ...,
                      shard_number = NULL,
                      sharding_method = NULL,
                      replication_factor = NULL,
                      write_consistency_factor = NULL,
                      read_fan_out_factor = NULL,
                      on_disk_payload = NULL,
                      sparse_vectors = NULL,
                      hnsw_config = NULL,
                      optimizer_config = NULL,
                      wal_config = NULL,
                      quantization_config = NULL,
                      init_from = NULL,
                      timeout = 10L) {

      config <- list()

      vectors <- list(...)
      vectors <- lapply(vectors, checkmate::assert_class, classes = c("params", "vector"))

      if (checkmate::test_list(vectors, names = "unnamed", len = 1L)) {
        config$vectors <- vectors[[1]]
      } else {
        checkmate::assert_list(vectors, names = "named")
        config$vectors <- vectors
      }

      if (!checkmate::test_null(shard_number)) {
        checkmate::assert_int(shard_number, lower = 1L)
        config$shard_number <- as.integer(shard_number)
      }

      if (!checkmate::test_null(sharding_method)) {
        checkmate::assert_choice(sharding_method, choices = c("auto", "custom"))
        config$sharding_method <- sharding_method
      }

      if (!checkmate::test_null(replication_factor)) {
        checkmate::assert_int(replication_factor, lower = 1L)
        config$replication_factor <- as.integer(replication_factor)
      }

      if (!checkmate::test_null(write_consistency_factor)) {
        checkmate::assert_int(write_consistency_factor, lower = 1L)
        config$write_consistency_factor <- as.integer(write_consistency_factor)
      }

      if (!checkmate::test_null(read_fan_out_factor)) {
        checkmate::assert_int(read_fan_out_factor, lower = 0L)
        config$read_fan_out_factor <- as.integer(read_fan_out_factor)
      }

      if (!checkmate::test_null(on_disk_payload)) {
        checkmate::assert_flag(on_disk_payload)
        config$on_disk_payload <- on_disk_payload
      }

      if (!checkmate::test_null(sparse_vectors)) {
        checkmate::assert_class(multivector_config, classes = c("config", "sparse"))
        config$sparse_vectors <- sparse_vectors
      }

      if (!checkmate::test_null(hnsw_config)) {
        checkmate::assert_class(hnsw_config, classes = c("config", "hnsw"))
        config$hnsw_config <- hnsw_config
      }

      if (!checkmate::test_null(optimizer_config)) {
        checkmate::assert_class(optimizer_config, classes = c("config", "optimizer"))
        config$optimizer_config <- optimizer_config
      }

      if (!checkmate::test_null(wal_config)) {
        checkmate::assert_class(wal_config, classes = c("config", "wal"))
        config$wal_config <- wal_config
      }

      if (!checkmate::test_null(quantization_config)) {
        checkmate::assert_class(quantization_config, classes = c("config", "quantization"))
        config$quantization_config <- quantization_config
      }

      if (!checkmate::test_null(init_from)) {
        checkmate::assert_string(init_from, min.chars = 1L)
        config$init_from <- init_from
      }

      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_url_query(timeout = timeout) |>
        httr2::req_body_json(config, force = TRUE) |>
        httr2::req_method("PUT") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
      # |> _$result
    },
    #' @description
    #' ...
    #' @param name string. Collection name
    #'
    update = function(name,
                      ...,
                      params = NULL,
                      sparse_vectors = NULL,
                      hnsw_config = NULL,
                      optimizer_config = NULL,
                      quantization_config = NULL,
                      timeout = 10L) {
      # private$.req |>
      #   httr2::req_url_path_append(name) |>
      #   httr2::req_url_query(timeout = timeout) |>
      #   httr2::req_body_json(config, force = TRUE) |>
      #   httr2::req_method("PATCH") |>
      #   httr2::req_perform() |>
      #   httr2::resp_body_json()
      stop("Not implemented yet!")
    },
    #' @description
    #' ...
    #' @param name string. Collection name
    #'
    delete = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_method("DELETE") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #' @param name string. Collection name
    #'
    exists = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_url_path_append("exists") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    },
    #' @description
    #' ...
    #' @param name string. Collection name
    #'
    info = function(name) {
      checkmate::assert_string(name, min.chars = 1L)
      private$.req |>
        httr2::req_url_path_append(name) |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }
  ),
  private = list(
    .req = NULL
  )
)

Alias <- R6::R6Class(
  classname = "Alias",
  public = list(
    initialize = function(req) {
      private$.req <- req |>
        httr2::req_url_path_append("aliases")
      },
    update = function(...) {
      actions <- list(...)
      actions <- lapply(actions, checkmate::assert_class, classes = c("operation", "alias"))

      private$.req |>
        httr2::req_body_json(list(actions = actions), force = TRUE) |>
        httr2::req_method("POST") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
      }
    ),
    private = list(
      .req = NULL
    )
)

Cluster <- R6::R6Class(
  classname = "Cluster",
  public = list(

  ),
  private = list(

  )
)

Index <- R6::R6Class(
  classname = "Index",
  public = list(

  ),
  private = list(

  )
)
