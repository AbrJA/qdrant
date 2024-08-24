sparse_index <- function(full_scan_threshold = NULL,
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

  structure(list(index = params), class = c("params", "sparse_index"))
}

modifier <- function(modifier = NULL) {
  params <- list()

  if (!checkmate::test_null(modifier)) {
    checkmate::assert_choice(modifier, choices = c("none", "idf"))
    params$modifier <- modifier
  }

  structure(list(index = params), class = c("params", "modifier"))
}

sparse_vector <- function(sparse_index = NULL, modifier = NULL) {
  params <- list()

  if (!checkmate::test_null(sparse_index)) {
    checkmate::assert_class(product, classes = c("params", "sparse_index"))
    params <- append(params, sparse_index)
  }

  if (!checkmate::test_null(modifier)) {
    checkmate::assert_class(product, classes = c("params", "modifier"))
    params <- append(params, sparse_index)
  }

  structure(list(index = params), class = c("params", "sparse"))
}
