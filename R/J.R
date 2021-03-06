tol <- .Machine$double.eps^0.75

## Find interval containing zero of a function, then find the zero
##
## Given function \code{f} find \code{x0} such that \code{f(x0)==0}
## @param f function whose root we're looking for
## @param ival upper endpoint of initial interval in which to search
## @param negative logical: should the lower endpoint be \code{1/ival} (if the
##     root is guaranteed to be positive), or \code{-ival}?
FindZero <- function(f, ival=1.1, negative=TRUE) {
    minval <- function(ival) if (negative==TRUE) -ival else min(1/ival, 1e-3)

    while(sign(f(ival))==sign(f(minval(ival))))
            ival <- 2*ival
    stats::uniroot(f, c(minval(ival), ival), tol=tol)$root
}

#' J-test of overidentifying restrictions under local misspecification
#'
#' Computes J-test of overidentifying restrictions with critical value adjusted
#' to allow for local misspecification, when the parameter \eqn{c} takes the
#' form \eqn{c=B\gamma}{c=B*gamma} with the \eqn{\ell_p}{lp} norm of
#' \eqn{\gamma}{gamma} bounded by \eqn{M}. Assumes initial estimator in
#' \code{eo} is optimal under correct specification.
#' @inheritParams OptEstimator
#' @return List with three elements: \describe{
#'
#' \item{J}{Value of J statistic}
#'
#' \item{p0}{P-value of usual J test}
#'
#' \item{pC}{P-value for J-test that  allows for local misspecification}
#'
#' \item{Mmin}{Minimum value of \eqn{M} for which the J-test would not reject} }
#' @export
Jtest <- function(eo, B, M, p=2, alpha=0.05) {
    J <- eo$n*drop(crossprod(eo$g_init, solve(eo$Sig, eo$g_init)))
    ## Sigma^{-1/2}
    e <- eigen(eo$Sig)
    Sig12 <- e$vectors %*% diag(1/sqrt(e$values)) %*% t(e$vectors)
    SG <- Sig12 %*% eo$G
    R <- diag(nrow(eo$G))-SG %*% solve(crossprod(SG), t(SG))
    A <- R %*% Sig12 %*% B

    kbar <- if(p==2)
                max(eigen(crossprod(A))$values)
            else if (p==1)
                max(colSums(A^2))
            else
                -stats::optim(par=rep(1, ncol(A)), function(x)
                    -drop(crossprod(A%*%x))/max(x^2), method="BFGS")$value

    ## p-value under correct specification
    p0 <- 1-stats::pchisq(q=J, df=nrow(eo$G)-ncol(eo$G), ncp=0)

    ## Value of M for which p-value is 0.05
    M0 <- if (p0<=alpha) {
              FindZero(function(M)
                  0.95-stats::pchisq(q=J, df=nrow(eo$G)-ncol(eo$G),
                                     ncp=M^2*kbar),
                  ival=2, negative=FALSE)
          } else {
              0
          }

    list(J=J, p0=p0,
         pC=1-stats::pchisq(q=J, df=nrow(eo$G)-ncol(eo$G), ncp=M^2*kbar),
         Mmin=M0)
}
