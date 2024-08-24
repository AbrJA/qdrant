optimizer <- function(deleted_threshold,
                      vacuum_min_vector_number,
                      default_segment_number,
                      flush_interval_sec,
                      max_segment_size = NULL,
                      memmap_threshold = NULL,
                      indexing_threshold = NULL,
                      max_optimization_threads = NULL) {
  config <- list()

  checkmate::assert_number(deleted_threshold, lower = 0.0, upper = 1.0)
  config$deleted_threshold <- deleted_threshold

  checkmate::assert_int(vacuum_min_vector_number, lower = 100L)
  config$vacuum_min_vector_number <- vacuum_min_vector_number

  checkmate::assert_int(default_segment_number, lower = 0L)
  config$default_segment_number <- default_segment_number

  checkmate::assert_int(flush_interval_sec, lower = 0L)
  config$flush_interval_sec <- flush_interval_sec

  if (!checkmate::test_null(max_segment_size)) {
    checkmate::assert_int(max_segment_size, lower = 0L)
    config$max_segment_size <- max_segment_size
  }

  if (!checkmate::test_null(memmap_threshold)) {
    checkmate::assert_int(memmap_threshold, lower = 0L)
    config$memmap_threshold <- memmap_threshold
  }

  if (!checkmate::test_null(indexing_threshold)) {
    checkmate::assert_int(indexing_threshold, lower = 0L)
    config$indexing_threshold <- indexing_threshold
  }

  if (!checkmate::test_null(max_optimization_threads)) {
    checkmate::assert_int(max_optimization_threads, lower = 0L)
    config$max_optimization_threads <- max_optimization_threads
  }

  structure(list(optimizer_config = config), class = c("config", "optimizer"))
}
