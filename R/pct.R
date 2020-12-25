#' @name pct
#' @title Install scholR environment
#' @author Nicolas Mangin
#' @description pct transforms numbers between 0 and 1 in percentages.
#' @param x Double or Integer. Number to be properly formatted.
#' @param digits Integer. Number of digits.
#' @return Character. Formated number.
#' @export

pct <- function(x, digits = 2) {
  
  stopifnot(
    is.numeric(x),
    x >=-1,
    x <= 1,
    is.numeric(digits),
    digits >= 0
  )
  
  format(
    x * 100,
    big.mark = ",",
    decimal.mark = ".",
    scientific = F,
    digits = digits,
    nsmall = 2
  )
} 