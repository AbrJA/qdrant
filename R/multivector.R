multivector <- function(comparator = c("max_sim")) {
  config <- list()

  checkmate::assert_choice(comparator, choices = c("max_sim"))
  config$comparator <- comparator

  structure(list(multivector_config = config), class = c("config", "multivector"))
}
