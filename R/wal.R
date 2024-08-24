wal <- function(wal_capacity_mb, wal_segments_ahead) {
  config <- list()

  checkmate::assert_int(wal_capacity_mb, lower = 1L)
  config$wal_capacity_mb <- wal_capacity_mb

  checkmate::assert_int(wal_segments_ahead, lower = 0L)
  config$wal_segments_ahead <- wal_segments_ahead

  structure(list(wal_config = config), class = c("config", "wal"))
}
