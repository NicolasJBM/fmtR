#' @name int
#' @title Install scholR environment
#' @author Nicolas Mangin
#' @description int formats as an integer.
#' @param x   Double or Integer. Number to be properly formatted.
#' @param tie Character. Rounding 0.5, "up", "down", or to "even".
#' @return Character. Formatted number.
#' @importFrom dplyr case_when
#' @export

int <- function(x, tie = "up") {
  
  stopifnot(
    is.numeric(x),
    tie %in% c("up","down","even")
  )
  
  if (x - floor(x) == 0.5){
    x <- dplyr::case_when(
      tie == "up" ~ ceiling(x),
      tie == "down" ~ floor(x),
      TRUE ~ round(x)
      )
  } else x <- round(x,0)
  
  format(
    x,
    big.mark = ",",
    decimal.mark = ".",
    scientific = F,
    digits = 0
  )
}