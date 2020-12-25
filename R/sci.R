#' @name sci
#' @title Install scholR environment
#' @author Nicolas Mangin
#' @description sci format scientifically.
#' @param x Double or Integer. Number to be properly formatted.
#' @param digits Integer. Number of digits.
#' @return Character. Number under scientific notation.
#' @export

sci <- function(x, digits = 2) {
  
  stopifnot(
    is.numeric(x),
    is.numeric(digits),
    digits >= 0
  )
  
  format(
    x,
    big.mark = ",",
    decimal.mark = ".",
    scientific = T,
    digits = digits+1,
    nsmall = 2
  )
} 