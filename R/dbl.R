#' @name dbl
#' @title Install scholR environment
#' @author Nicolas Mangin
#' @description dbl format as a number with two digits.
#' @param x Double or Integer. Number to be properly formatted.
#' @param digits Integer. Number of digits.
#' @return Character. Formatted number.
#' @export

dbl <- function(x, digits = 2) {
  
  stopifnot(
    is.numeric(x),
    is.numeric(digits),
    digits >= 0
  )
  
  format(
    x, big.mark = ",",
    decimal.mark = ".",
    scientific = F,
    digits = digits,
    nsmall = 2
  )
}
  
