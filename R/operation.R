create_alias <- function(collection_name, alias_name) {
  checkmate::assert_string(collection_name, min.chars = 1L)
  checkmate::assert_string(alias_name, min.chars = 1L)

  structure(list(create_alias = list(collection_name = collection_name, alias_name = alias_name)),
            class = c("operation", "alias"))
}

delete_alias <- function(alias_name) {
  checkmate::assert_string(alias_name, min.chars = 1L)

  structure(list(delete_alias = list(alias_name = alias_name)), class = c("operation", "alias"))
}

rename_alias <- function(old_alias_name, new_alias_name) {
  checkmate::assert_string(old_alias_name, min.chars = 1L)
  checkmate::assert_string(new_alias_name, min.chars = 1L)

  structure(list(rename_alias = list(old_alias_name = old_alias_name, new_alias_name = new_alias_name)),
            class = c("operation", "alias"))
}
