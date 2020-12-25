#' @name report_estimate
#' @title Format Estimated Coefficients for Reporting
#' @author Nicolas Mangin
#' @description Format in-text the reporting of confidence intervals or p-values around an estimate.
#' @param symbol     Character. Name or identifier of the coefficient.
#' @param estimate   Numeric. Estimate of the coefficient.
#' @param std_error  Numeric. Standard error around the estimate.
#' @param threshold  Numeric. Probability of 0 contained in the confidence interval (e.g. 0.05 for a 95% confidence interval).
#' @param digits     Integer. Number of digits for rounding.
#' @param statistics Character vector. Statistics to report: "cf" for the coefficient, "ci" for the confidence internal, "pv" for the p-value.
#' @return Character with specified statistics between parentheses.
#' @importFrom dplyr case_when
#' @importFrom stats qnorm
#' @importFrom stats pnorm
#' @export


report_estimate <- function(symbol = "$\beta$",
                            estimate = NULL,
                            std_error = NULL,
                            threshold = 0.05,
                            digits = 3,
                            statistics = c("cf", "ci", "pv")) {
  
  # If the coefficient is requested, store it properly formatted in cf.
  if ("cf" %in% statistics) {
    cf <- paste0(symbol, " = ", round(estimate, digits))
  } else {
    cf <- ""
  }

  # If the confidence interval is requested, store it properly formatted in ci
  if ("ci" %in% statistics) {
    ci <- dplyr::case_when(
      threshold == 0.01 ~ "99% CI ",
      threshold == 0.05 ~ "95% CI ",
      threshold == 0.10 ~ "90% CI ",
      TRUE ~ ""
    )

    ll <- round(estimate - qnorm(1 - threshold / 2) * std_error, digits)
    ul <- round(estimate + qnorm(1 - threshold / 2) * std_error, digits)

    ci <- paste0(ci, "[", ll, ", ", ul, "]")
  } else {
    ci <- ""
  }


  # If the p-value is requested, store it properly formatted in ci
  if ("pv" %in% statistics) {
    pval <- 2 * pnorm(-abs((estimate - 0) / (std_error)))

    pv <- dplyr::case_when(
      pval <= 0.01 ~ "P < 0.01",
      pval <= 0.05 ~ "P < 0.05",
      pval <= 0.1 ~ "P < 0.1",
      TRUE ~ "n.s."
    )
  } else {
    pv <- ""
  }

  
  # Concatenate the requested statistics.
  report <- dplyr::case_when(
    "cf" %in% statistics & "ci" %in% statistics & "pv" %in% statistics ~
      paste0("(", cf, ", ", ci, ", ", pv, ")"),
    "ci" %in% statistics & "pv" %in% statistics ~
      paste0("(", ci, ", ", pv, ")"),
    "cf" %in% statistics & "pv" %in% statistics ~
      paste0("(", cf, ", ", pv, ")"),
    "cf" %in% statistics & "ci" %in% statistics ~
      paste0("(", cf, ", ", ci, ")"),
    "cf" %in% statistics ~ paste0("(", cf, ")"),
    "ci" %in% statistics ~ paste0("(", ci, ")"),
    "pv" %in% statistics ~ paste0("(", pv, ")")
  )

  return(report)
}
