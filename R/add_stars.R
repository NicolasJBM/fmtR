#' @name add_stars
#' @title Add Stars to Estimates
#' @author Nicolas Mangin
#' @description Add stars to a vector of coefficients based on the corresponding p-values and specified thresholds.
#' @param estimates  Numeric vector. Coefficients.
#' @param pvalues    Numeric vector. Corresponding p-values.
#' @param thresholds Numeric vector. Three cut-off points for p-values.
#' @param digits     Integer. Number of digits for rounding.
#' @return Character vector with significance levels associated with coefficients.
#' @importFrom dplyr mutate
#' @importFrom dplyr case_when
#' @importFrom dplyr %>%
#' @importFrom tibble tibble
#' @export

add_stars <- function(estimates = NULL,
                      pvalues = NULL,
                      thresholds = c(0.01, 0.05, 0.10),
                      digits = 3) {

  # Check entries
  stopifnot(
    !is.null(estimates),
    !is.null(pvalues),
    length(estimates) == length(pvalues)
  )

  # Create a visible binding
  festimates <- NULL
  stars <- NULL

  # Identify the number of stars to append and
  # merge properly formatted estimate and corresponding stars.
  x <- tibble(estimates = estimates, pvalues = pvalues) %>%
    mutate(stars = "   ") %>%
    mutate(
      stars = case_when(
        pvalues < thresholds[[1]] ~ "***",
        pvalues >= thresholds[[1]] & pvalues < thresholds[[2]] ~ "** ",
        pvalues >= thresholds[[2]] & pvalues < thresholds[[3]] ~ "*  ",
        TRUE ~ "   "
      )
    ) %>%
    mutate(estimates = format(
      round(estimates, digits = digits),
      nsmall = digits
    )) %>%
    mutate(festimates = case_when(
      estimates >= 0 ~ paste0(" ", estimates),
      TRUE ~ paste0("", estimates)
    )) %>%
    mutate(festimates = paste0(festimates, stars))

  return(x$festimates)
}
