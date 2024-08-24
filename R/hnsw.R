hnsw_diff <- function(m = NULL,
                 ef_construct = NULL,
                 full_scan_threshold = NULL,
                 max_indexing_threads = NULL,
                 on_disk = NULL,
                 payload_m = NULL) {
  config <- list()
  if (!checkmate::test_null(m)) {
    checkmate::assert_int(m, lower = 0L)
    config$m <- m
  }
  if (!checkmate::test_null(ef_construct)) {
    checkmate::assert_int(ef_construct, lower = 4L)
    config$ef_construct <- ef_construct
  }
  if (!checkmate::test_null(full_scan_threshold)) {
    checkmate::assert_int(full_scan_threshold, lower = 10L)
    config$full_scan_threshold <- full_scan_threshold
  }
  if (!checkmate::test_null(max_indexing_threads)) {
    checkmate::assert_int(max_indexing_threads, lower = 0L)
    config$max_indexing_threads <- max_indexing_threads
  }
  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    config$on_disk <- on_disk
  }
  if (!checkmate::test_null(payload_m)) {
    checkmate::assert_int(payload_m, lower = 0L)
    config$payload_m <- payload_m
  }
  structure(list(hnsw = config), class = c("config", "hnsw_diff"))
}

hnsw <- function(m,
         ef_construct,
         full_scan_threshold,
         max_indexing_threads = 0L,
         on_disk = NULL,
         payload_m = NULL) {
  config <- list()

  checkmate::assert_int(m, lower = 0L)
  config$m <- m

  checkmate::assert_int(ef_construct, lower = 4L)
  config$ef_construct <- ef_construct

  checkmate::assert_int(full_scan_threshold, lower = 0L)
  config$full_scan_threshold <- full_scan_threshold

  checkmate::assert_int(max_indexing_threads, lower = 0L)
  config$max_indexing_threads <- max_indexing_threads

  if (!checkmate::test_null(on_disk)) {
    checkmate::assert_flag(on_disk)
    config$on_disk <- on_disk
  }

  if (!checkmate::test_null(payload_m)) {
    checkmate::assert_int(payload_m, lower = 0L)
    config$payload_m <- payload_m
  }

  structure(list(hnsw = config), class = c("config", "hnsw"))
}
