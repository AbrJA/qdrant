#' @description Config of HNSW index
#' @param m integer. Number of edges per node in the index graph. Larger the value - more accurate the search, more space required. Default to NULL.
#' @param ef_construct
#' @param full_scan_threshold max_indexing_threads
#' @param on_disk
#' @param payload_m
#'
#' @export
#'
hnsw <- function(m,
                 ef_construct,
                 full_scan_threshold,
                 max_indexing_threads = 0L,
                 on_disk = NULL,
                 payload_m = NULL) {
  config <- list()

  checkmate::assert_int(m, lower = 0L)
  config$m <- as.integer(m)

  checkmate::assert_int(ef_construct, lower = 4L)
  config$ef_construct <- as.integer(ef_construct)
  # Comment: Bigger than 10
  checkmate::assert_int(full_scan_threshold, lower = 10L)
  config$full_scan_threshold <- as.integer(full_scan_threshold)

  checkmate::assert_int(max_indexing_threads, lower = 0L)
  config$max_indexing_threads <- as.integer(max_indexing_threads)

  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    config$on_disk <- on_disk
  }

  if (!checkmate::test_null(payload_m)) {
    checkmate::assert_int(payload_m, lower = 0L)
    config$payload_m <- as.integer(payload_m)
  }

  structure(config, class = c("config", "hnsw"))
}

#' @export
#'
scalar <- function(type = c("int8"), quantile = NULL, always_ram = NULL) {
  config <- list()

  checkmate::assert_choice(type, choices = c("int8"))
  config$type <- type

  if (!checkmate::test_null(quantile)) {
    checkmate::assert_number(quantile, lower = 0.5, upper = 1.0)
    config$quantile <- quantile
  }

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    config$always_ram <- always_ram
  }

  structure(list(scalar = config), class = c("config", "quantization"))
}

#' @export
#'
product <- function(compression = c("x4", "x8", "x16", "x32", "x64"), always_ram = NULL) {
  config <- list()

  checkmate::assert_choice(compression, choices = c("x4", "x8", "x16", "x32", "x64"))
  config$compression <- compression

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    config$always_ram <- always_ram
  }

  structure(list(product = config), class = c("config", "quantization"))
}

#' @export
#'
binary <- function(always_ram = NULL) {
  config <- list()

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    config$always_ram <- always_ram
  }

  structure(list(binary = config), class = c("config", "quantization"))
}

#' @export
#'
optimizer <- function(deleted_threshold,
                      vacuum_min_vector_number,
                      default_segment_number,
                      max_segment_size = NULL,
                      memmap_threshold = NULL,
                      indexing_threshold = NULL,
                      flush_interval_sec,
                      max_optimization_threads = NULL) {
  config <- list()

  checkmate::assert_number(deleted_threshold, lower = 0.0, upper = 1.0)
  config$deleted_threshold <- deleted_threshold

  checkmate::assert_int(vacuum_min_vector_number, lower = 100L)
  config$vacuum_min_vector_number <- as.integer(vacuum_min_vector_number)

  checkmate::assert_int(default_segment_number, lower = 0L)
  config$default_segment_number <- as.integer(default_segment_number)

  if (!checkmate::test_null(max_segment_size)) {
    checkmate::assert_int(max_segment_size, lower = 0L)
    config$max_segment_size <- as.integer(max_segment_size)
  }

  if (!checkmate::test_null(memmap_threshold)) {
    checkmate::assert_int(memmap_threshold, lower = 0L)
    config$memmap_threshold <- as.integer(memmap_threshold)
  }

  if (!checkmate::test_null(indexing_threshold)) {
    checkmate::assert_int(indexing_threshold, lower = 0L)
    config$indexing_threshold <- as.integer(indexing_threshold)
  }

  checkmate::assert_int(flush_interval_sec, lower = 0L)
  config$flush_interval_sec <- as.integer(flush_interval_sec)

  if (!checkmate::test_null(max_optimization_threads)) {
    checkmate::assert_int(max_optimization_threads, lower = 0L)
    config$max_optimization_threads <- as.integer(max_optimization_threads)
  }

  structure(config, class = c("config", "optimizer"))
}

#' @export
#'
wal <- function(wal_capacity_mb, wal_segments_ahead) {
  config <- list()

  checkmate::assert_int(wal_capacity_mb, lower = 1L)
  config$wal_capacity_mb <- as.integer(wal_capacity_mb)

  checkmate::assert_int(wal_segments_ahead, lower = 0L)
  config$wal_segments_ahead <- as.integer(wal_segments_ahead)

  structure(config, class = c("config", "wal"))
}

#' @export
#'
multivector <- function(comparator = c("max_sim")) {
  config <- list()

  checkmate::assert_choice(comparator, choices = c("max_sim"))
  config$comparator <- comparator

  structure(config, class = c("config", "multivector"))
}

#' @export
#'
print.config <- function(object, indent = 1L, first = TRUE) {
  if (first) {
    cat("<Config>\n")
  }
  str_indent <- strrep("  ", indent)
  for (name in names(object)) {
    if (is.list(object[[name]])) {
      cat(str_indent, name, "\n", sep = "")
      print.config(object[[name]], indent + 1L, FALSE)
    } else {
      cat(str_indent, name, ": ", object[[name]], "\n", sep = "")
    }
  }
}
