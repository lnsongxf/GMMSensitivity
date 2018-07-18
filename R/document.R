#' Dataset from Berry, Levinsohn, and Pakes (1995)
#'
#' Subset of data from Berry, Levinsohn, and Pakes (1995) that is used to
#' illustrate the confidence intervals implemented in this package
#' @format A list, consisting 11 objects:
#'
#' \describe{
#'
#' \item{G}{Matrix with 31 rows and 17 columns, estimate of derivative of the moment condition}
#'
#' \item{H}{Vector of lenght 17, estimate of derivative of h(theta) }
#'
#' \item{W}{Weight matrix used to obtain the estimate of theta}
#'
#' \item{g_init}{Average moment condition, evaluated at estimate of theta}
#'
#' \item{h_init}{h(hattheta)}
#'
#' \item{names}{Two lists, one for names of the moment conditions, and one for elements of theta}
#'
#' \item{OmZZ}{?}
#'
#' \item{Sig}{Variance of moment condition}
#'
#' \item{sdZ}{}
#'
#' \item{perturb}{}
#'
#' \item{n}{Sample size}
#' }
#'
#'
#' @source Replication files for Andrews, Gentzkow, and Shapiro (2017), available at
#' \url{https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/LLARSN/2KFPRA&version=1.1}
#' @references{
#'
#' \cite{Berry, S. T., J. Levinsohn, and A. Pakes (1995): "Automobile Prices in
#' Market Equilibrium," Econometrica, 63, 841–890.}
#'
#' \cite{Andrews, I., M. Gentzkow, and J. M. Shapiro (2017): “Measuring the
#' Sensitivity of Parameter Estimates to Sample Statistics,” Quarterly Journal
#' of Economics, 132, 1553–1592.}
#'
#' }
"blp"