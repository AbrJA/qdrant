#' @export
#'
sparse_index <- function(full_scan_threshold = NULL,
                         on_disk = NULL,
                         datatype = NULL) {
  params <- list()

  if (!checkmate::test_null(full_scan_threshold)) {
    checkmate::assert_int(full_scan_threshold, lower = 0L)
    params$full_scan_threshold <- as.integer(full_scan_threshold)
  }

  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    params$on_disk <- on_disk
  }

  if (!checkmate::test_null(datatype)) {
    checkmate::assert_choice(datatype, choices = c("float32", "uint8", "float16"))
    params$datatype <- datatype
  }

  structure(params, class = c("params", "sparse_index"))
}

#' @export
#'
modifier <- function(modifier = NULL) {
  params <- list()

  if (!checkmate::test_null(modifier)) {
    checkmate::assert_choice(modifier, choices = c("none", "idf"))
    params$modifier <- modifier
  }

  structure(params, class = c("params", "modifier"))
}

#' @export
#'
sparse_vector <- function(sparse_index = NULL, modifier = NULL) {
  params <- list()

  if (!checkmate::test_null(sparse_index)) {
    checkmate::assert_class(product, classes = c("params", "sparse_index"))
    params$index <- params
  }

  if (!checkmate::test_null(modifier)) {
    checkmate::assert_class(product, classes = c("params", "modifier"))
    params$modifier <- params
  }

  structure(params, class = c("params", "sparse"))
}


#' @export
#'
vector <- function(size,
                   distance = c("Cosine", "Euclid", "Dot", "Manhattan"),
                   hnsw_config = NULL,
                   quantization_config = NULL,
                   on_disk = NULL,
                   datatype = NULL,
                   multivector_config = NULL) {
  params <- list()

  # Validación del tamaño del vector
  checkmate::assert_int(size, lower = 1L)
  params$size <- as.integer(size)

  # Validación del tipo de distancia
  checkmate::assert_choice(distance, choices = c("Cosine", "Euclid", "Dot", "Manhattan"))
  params$distance <- distance

  # Configuración HNSW opcional
  if (!checkmate::test_null(hnsw_config)) {
    checkmate::assert_class(hnsw_config, classes = c("config", "hnsw"))
    params$hnsw_config <- hnsw_config
  }

  # Configuración de cuantización opcional
  if (!checkmate::test_null(quantization_config)) {
    checkmate::assert_class(quantization_config, classes = c("config", "quantization"))
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
    checkmate::assert_class(multivector_config, classes = c("config", "multivector"))
    params$multivector_config <- multivector_config
  }

  structure(params, class = c("params", "vector"))
}

collection <- function(vectors,
                       shard_number = NULL,
                       sharding_method = NULL,
                       replication_factor = NULL,
                       write_consistency_factor = NULL,
                       read_fan_out_factor = NULL,
                       on_disk_payload = NULL,
                       sparse_vectors = NULL) {
  params <- list()

  # Validación de la configuración de vectores
  checkmate::assert_class(vectors, classes = c("config", "vectors"))
  params$vectors <- vectors

  # Validación del número de shards
  if (!checkmate::test_null(shard_number)) {
    checkmate::assert_int(shard_number, lower = 1L)
    params$shard_number <- as.integer(shard_number)
  }

  # Configuración del método de sharding (opcional)
  if (!checkmate::test_null(sharding_method)) {
    checkmate::assert_choice(sharding_method, choices = c("auto", "custom"))
    params$sharding_method <- sharding_method
  }

  # Validación del factor de replicación
  if (!checkmate::test_null(replication_factor)) {
    checkmate::assert_int(replication_factor, lower = 1L)
    params$replication_factor <- as.integer(replication_factor)
  }

  # Validación del factor de consistencia de escritura
  if (!checkmate::test_null(write_consistency_factor)) {
    checkmate::assert_int(write_consistency_factor, lower = 1L)
    params$write_consistency_factor <- as.integer(write_consistency_factor)
  }

  # Configuración del factor de fan-out de lectura (opcional)
  if (!checkmate::test_null(read_fan_out_factor)) {
    checkmate::assert_int(read_fan_out_factor, lower = 0L)
    params$read_fan_out_factor <- as.integer(read_fan_out_factor)
  }

  # Configuración del payload en disco
  if (!checkmate::test_null(on_disk_payload)) {
    checkmate::assert_flag(on_disk_payload)
    params$on_disk_payload <- on_disk_payload
  }

  # Configuración de vectores dispersos (opcional)
  if (!checkmate::test_null(sparse_vectors)) {
    checkmate::assert_class(multivector_config, classes = c("params", "sparse"))
    params$sparse_vectors <- sparse_vectors
  }

  structure(params, class = c("params", "collection"))
}


print.params <- function(object) {
  cat("<Params>\n")
  yyjsonr::write_json_str(object, opts = list(auto_unbox = TRUE, pretty = TRUE)) |>
    cat()
}

