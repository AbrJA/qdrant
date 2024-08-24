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

  structure(list(scalar = config), class = c("config", "scalar"))
}

product <- function(compression = c("x4", "x8", "x16", "x32", "x64"), always_ram = NULL) {
  config <- list()

  checkmate::assert_choice(compression, choices = c("x4", "x8", "x16", "x32", "x64"))
  config$compression <- compression

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    config$always_ram <- always_ram
  }

  structure(list(product = config), class = c("config", "product"))
}

binary <- function(always_ram = NULL) {
  config <- list()

  if (!checkmate::test_null(always_ram)) {
    checkmate::assert_flag(always_ram)
    config$always_ram <- always_ram
  }

  structure(list(binary = config), class = c("config", "binary"))
}

quantization <- function(binary = NULL, product = NULL, scalar = NULL) {
  config <- list()

  if (!checkmate::test_null(binary)) {
    checkmate::assert_class(binary, classes = c("config", "binary"))
    config <- append(config, binary)
  }

  if (!checkmate::test_null(product)) {
    checkmate::assert_class(product, classes = c("config", "product"))
    config <- append(config, product)
  }

  if (!checkmate::test_null(scalar)) {
    checkmate::assert_class(scalar, classes = c("config", "scalar"))
    config <- append(config, scalar)
  }

  structure(list(quantization_config = config), class = c("config", "quantization"))
}

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
