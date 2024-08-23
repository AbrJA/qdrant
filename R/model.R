hnsw_config_diff <- function(m = NULL,
                             ef_construct = NULL,
                             full_scan_threshold = NULL,
                             max_indexing_threads = NULL,
                             on_disk = NULL,
                             payload_m = NULL) {
  params <- list()

  if (!checkmate::test_null(m)) {
    checkmate::assert_int(m, lower = 0L)
    params$m <- m
  }

  if (!checkmate::test_null(ef_construct)) {
    checkmate::assert_int(ef_construct, lower = 4L)
    params$ef_construct <- ef_construct
  }

  if (!checkmate::test_null(full_scan_threshold)) {
    checkmate::assert_int(full_scan_threshold, lower = 10L)
    params$full_scan_threshold <- full_scan_threshold
  }

  if (!checkmate::test_null(max_indexing_threads)) {
    checkmate::assert_int(max_indexing_threads, lower = 0L)
    params$max_indexing_threads <- max_indexing_threads
  }

  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    params$on_disk <- on_disk
  }

  if (!checkmate::test_null(payload_m)) {
    checkmate::assert_int(payload_m, lower = 0L)
    params$payload_m <- payload_m
  }

  params
}


hnsw_config <- function(m,
                        ef_construct,
                        full_scan_threshold,
                        max_indexing_threads = 0L,
                        on_disk = NULL,
                        payload_m = NULL) {
  params <- list()

  checkmate::assert_int(m, lower = 0L)
  params$m <- m

  checkmate::assert_int(ef_construct, lower = 4L)
  params$ef_construct <- ef_construct

  checkmate::assert_int(full_scan_threshold, lower = 0L)
  params$full_scan_threshold <- full_scan_threshold

  checkmate::assert_int(max_indexing_threads, lower = 0L)
  params$max_indexing_threads <- max_indexing_threads

  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    params$on_disk <- on_disk
  }

  if (!checkmate::test_null(payload_m)) {
    checkmate::assert_int(payload_m, lower = 0L)
    params$payload_m <- payload_m
  }

  params
}

scalar_quantization <- function(type, quantile = NULL, always_ram = NULL) {
  params <- list()

  checkmate::assert_choice(type, choices = c("int8"))
  params$type <- type

  if (!checkmate::test_null(quantile)) {
    checkmate::assert_number(quantile, lower = 0.5, upper = 1.0)
    params$quantile <- quantile
  }

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    params$always_ram <- always_ram
  }

  params
}

product_quantization <- function(compression, always_ram = NULL) {
  params <- list()

  checkmate::assert_choice(compression, choices = c("x4", "x8", "x16", "x32", "x64"))
  params$compression <- compression

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    params$always_ram <- always_ram
  }

  params
}

binary_quantization <- function(always_ram = NULL) {
  params <- list()

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    params$always_ram <- always_ram
  }

  params
}

optimizers_config <- function(deleted_threshold,
                              vacuum_min_vector_number,
                              default_segment_number,
                              flush_interval_sec,
                              max_segment_size = NULL,
                              memmap_threshold = NULL,
                              indexing_threshold = NULL,
                              max_optimization_threads = NULL) {
  params <- list()

  checkmate::assert_number(deleted_threshold, lower = 0.0, upper = 1.0)
  params$deleted_threshold <- deleted_threshold

  checkmate::assert_int(vacuum_min_vector_number, lower = 100L)
  params$vacuum_min_vector_number <- vacuum_min_vector_number

  checkmate::assert_int(default_segment_number, lower = 0L)
  params$default_segment_number <- default_segment_number

  checkmate::assert_int(flush_interval_sec, lower = 0L)
  params$flush_interval_sec <- flush_interval_sec

  if (!checkmate::test_null(max_segment_size)) {
    checkmate::assert_int(max_segment_size, lower = 0L)
    params$max_segment_size <- max_segment_size
  }

  if (!checkmate::test_null(memmap_threshold)) {
    checkmate::assert_int(memmap_threshold, lower = 0L)
    params$memmap_threshold <- memmap_threshold
  }

  if (!checkmate::test_null(indexing_threshold)) {
    checkmate::assert_int(indexing_threshold, lower = 0L)
    params$indexing_threshold <- indexing_threshold
  }

  if (!checkmate::test_null(max_optimization_threads)) {
    checkmate::assert_int(max_optimization_threads, lower = 0L)
    params$max_optimization_threads <- max_optimization_threads
  }

  params
}

wal_config <- function(wal_capacity_mb, wal_segments_ahead) {
  params <- list()

  checkmate::assert_int(wal_capacity_mb, lower = 1L)
  params$wal_capacity_mb <- wal_capacity_mb

  checkmate::assert_int(wal_segments_ahead, lower = 0L)
  params$wal_segments_ahead <- wal_segments_ahead

  params
}

sparse_index_params <- function(full_scan_threshold = NULL,
                                on_disk = NULL,
                                datatype = NULL) {
  params <- list()

  if (!checkmate::test_null(full_scan_threshold)) {
    checkmate::assert_int(full_scan_threshold, lower = 0L)
    params$full_scan_threshold <- full_scan_threshold
  }

  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    params$on_disk <- on_disk
  }

  if (!checkmate::test_null(datatype)) {
    checkmate::assert_choice(datatype, choices = c("float32", "uint8", "float16"))
    params$datatype <- datatype
  }

  params
}

multi_vector_config <- function(comparator) {
  params <- list()

  checkmate::assert_choice(comparator, choices = c("max_sim"))
  params$comparator <- comparator

  params
}

vector_params <- function(size,
                          distance,
                          hnsw_config = NULL,
                          quantization_config = NULL,
                          on_disk = NULL,
                          datatype = NULL,
                          multivector_config = NULL) {
  params <- list()

  # Validación del tamaño del vector
  checkmate::assert_int(size, lower = 1L)
  params$size <- size

  # Validación del tipo de distancia
  checkmate::assert_choice(distance, choices = c("Cosine", "Euclid", "Dot", "Manhattan"))
  params$distance <- distance

  # Configuración HNSW opcional
  if (!checkmate::test_null(hnsw_config)) {
    checkmate::assert_list(hnsw_config, names = "named")
    params$hnsw_config <- hnsw_config
  }

  # Configuración de cuantización opcional
  if (!checkmate::test_null(quantization_config)) {
    checkmate::assert_list(quantization_config, names = "named")
    params$quantization_config <- quantization_config
  }

  # Configuración de almacenamiento en disco
  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    params$on_disk <- on_disk
  }

  # Configuración de tipo de dato opcional
  if (!checkmate::test_null(datatype)) {
    checkmate::assert_choice(datatype, choices = c("float32", "float16", "uint8"))
    params$datatype <- datatype
  }

  # Configuración de multi-vector opcional
  if (!checkmate::test_null(multivector_config)) {
    checkmate::assert_list(multivector_config, names = "named")
    params$multivector_config <- multivector_config
  }

  params
}

vector_config <- function(...) {
  params <- list()
  args <- list(...)

  if (!checkmate::test_list(args, names = "named")) {
    checkmate::assert_list(args, len = 1L)
    params$vectors <- unlist(args, recursive = FALSE)
    return(params)
  }

  params$vectors <- args

  params
}

vector_config(image = vector_params(4, "Dot"), text = vector_params(8, "Cosine")) |>
  jsonlite::toJSON(auto_unbox = TRUE, pretty = TRUE)

vector_config(uno = vector_params(256, "Cosine"), dos = vector_params(256, "Cosine")) |>
  yyjsonr::write_json_str(opts = list(auto_unbox = TRUE, pretty = TRUE))

VectorParams <- R6::R6Class(
  classname = "VectorParams",
  public = list(
    initialize = function(size, distance) {
      checkmate::assert_int(size)
      private$.params$size <- size
      checkmate::assert_choice(distance, choices = c("Cosine", "Dot", "Euclidean", "Manhatan"))
      private$.params$distance <- distance
      invisible(self)
    },
    hnsw = function(m = NULL,
                    ef_construct = NULL,
                    full_scan_threshold = NULL,
                    max_indexing_threads = NULL,
                    on_disk = NULL,
                    payload_m = NULL) {
      if (!checkmate::test_null(m)) {
        checkmate::assert_int(m, lower = 0L)
        private$.params$m <- m
      }
      if (!checkmate::test_null(ef_construct)) {
        checkmate::assert_int(ef_construct, lower = 4L)
        private$.params$ef_construct <- ef_construct
      }
      if (!checkmate::test_null(full_scan_threshold)) {
        checkmate::assert_int(full_scan_threshold, lower = 10L)
        private$.params$full_scan_threshold <- full_scan_threshold
      }
      if (!checkmate::test_null(max_indexing_threads)) {
        checkmate::assert_int(max_indexing_threads, lower = 0L)
        private$.params$max_indexing_threads <- max_indexing_threads
      }
      if (!checkmate::test_null(on_disk)) {
        checkmate::assert_flag(on_disk)
        private$.params$on_disk <- on_disk
      }
      if (!checkmate::test_null(payload_m)) {
        checkmate::assert_int(payload_m, lower = 0L)
        private$.params$payload_m <- payload_m
      }
      invisible(self)
    }
  ),
  active = list(
    params = function() private$.params
  ),
  private = list(
    .params = list()
  )
)


Quantization <- R6::R6Class(
  classname = "Quantization",
  public = list(
    scalar = function(type, quantile = NULL, always_ram = NULL) {
      checkmate::assert_choice(type, choices = c("int8"))
      private$.params$scalar$type <- type
      if (!checkmate::test_null(quantile)) {
        checkmate::assert_number(quantile, lower = 0.5, upper = 1.0)
        private$.params$scalar$quantile <- quantile
      }
      if (!checkmate::test_null(always_ram)) {
        checkmate::assert_flag(always_ram)
        private$.params$scalar$always_ram <- always_ram
      }
      invisible(self)
    },
    product = function(compression, always_ram = NULL) {
      checkmate::assert_choice(compression, choices = c("x4", "x8", "x16", "x32", "x64"))
      private$.params$product$compression <- compression
      if (!checkmate::test_null(always_ram)) {
        checkmate::assert_flag(always_ram)
        private$.params$product$always_ram <- always_ram
      }
      invisible(self)
    },
    binary = function(always_ram = NULL) {
      if (!checkmate::test_null(always_ram)) {
        checkmate::assert_flag(always_ram)
        private$.params$binary$always_ram <- always_ram
      }
      invisible(self)
    }
  ),
  active = list(
    params = function() private$.params
  ),
  private = list(
    .params = list()
  )
)

# Build function and make the assignment with the return after the validations

test <- function(x, y) list(x, y)
self <- new.env(parent = emptyenv(), hash = TRUE)
self$test <- test
self$test(1, 2)


q <- Quantization$new()
q$scalar(type = "int8")$params
q$binary(TRUE)$params
q$params |>
  jsonlite::toJSON(, auto_unbox = TRUE, pretty = TRUE)

vector <- VectorParams$new(8, "Dot")
vector$hnsw()
vector$params

