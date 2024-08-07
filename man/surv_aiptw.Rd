\name{surv_aiptw}
\alias{surv_aiptw}

\title{
Augmented Inverse Probability of Treatment Weighted Survival Curves
}
\description{

This page explains the details of estimating augmented inverse probability of treatment weighted survival curves for single event time-to-event data (\code{method="aiptw"} in the \code{\link[=adjustedsurv]{adjustedsurv}} function). All regular arguments of the \code{adjustedsurv} function can be used. Additionally, the \code{outcome_model} argument and the \code{treatment_model} argument have to be specified in the \code{adjustedsurv} call. Further arguments specific to this method are listed below.

}

\arguments{
  \item{outcome_model}{
[\strong{required}] Must be a \code{coxph} model object, modeling the time-to-event mechanism. See details and examples.
}
  \item{treatment_model}{
[\strong{required}] Must be a \code{glm} model object with \code{variable} as response variable. See details and examples.
}
  \item{censoring_model}{
Must be a \code{coxph} model object, modeling the censoring mechanism or \code{NULL}. If \code{NULL} (default) independent censoring is assumed. See details and examples.
}
  \item{verbose}{
Whether to print estimation information of the \code{\link[riskRegression]{ate}} function in the \pkg{riskRegression} package. Defaults to \code{FALSE}.
}
  \item{...}{
Further arguments passed to \code{\link[riskRegression]{ate}}.
  }
}
\details{

\itemize{
\item{\strong{Type of Adjustment:} Requires both a treatment assignment model (\code{\link{glm}}) and a outcome model (\code{\link[survival]{coxph}}). Also allows, but does not rely on, an additional model describing the censoring mechanism (also a \code{\link[survival]{coxph}} object).}
\item{\strong{Doubly-Robust:} Estimates are Doubly-Robust.}
\item{\strong{Categorical groups:} Currently only two groups in \code{variable} are allowed. Must still be a factor variable.}
\item{\strong{Approximate Variance:} Calculations to approximate the variance and confidence intervals are available.}
\item{\strong{Allowed Time Values:} Allows both continuous and integer time.}
\item{\strong{Bounded Estimates:} Estimates are not guaranteed to be bounded in the 0 to 1 probability range.}
\item{\strong{Monotone Function:} Estimates are not guaranteed to be monotone.}
\item{\strong{Dependencies:} This method relies on the \pkg{riskRegression} package.}
}

Instead of only modeling the outcome mechanism or the treatment assignment mechanism, both kind of models are required to use this method. If either of those models are correctly specified, unbiased estimates will be obtained. Can also be used to adjust for dependent censoring using another Cox-Regression model. An obvious advantage of this method is it's doubly robust property. This however comes at the price of some efficiency. It is also possible that some estimates fall outside the 0 and 1 probability bounds, particularly if the time is near 0 or the maximal observed event time. There is also no guarantee that the estimated survival curves will be monotonically decreasing. For more information on the methods the user is referred to the literature listed in the references.

This function is basically just a wrapper around the \code{\link[riskRegression]{ate}} function from the \pkg{riskRegression} package. Additional arguments may be passed to that function using the \code{...} syntax. It is however recommended to use \code{\link[riskRegression]{ate}} directly in these cases.

}
\value{
Adds the following additional objects to the output of the \code{adjustedsurv} function:

\itemize{
\item \code{ate_object}: The object returned by the \code{ate} function.
}
}
\references{
James M. Robins and Andrea Rotnitzky (1992). "Recovery of Information and Adjustment for Dependent Censoring Using Surrogate Markers". In: AIDS Epidemiology: Methodological Issues. Ed. by Nicholas P. Jewell, Klaus Dietz, and Vernon T. Farewell. New York: Springer Science + Business Media, pp. 297-331

Alan E. Hubbard, Mark J. van der Laan, and James M. Robins (2000). "Nonparametric Locally Efficient Estimation of the Treatment Specific Survival Distribution with Right Censored Data and Covariates in Observational Studies". In: Statistical Models in Epidemiology, the Environment, and Clinical Trials. Ed. by M. Elizabeth Halloran and Donald Berry. New York: Springer Science + Business Media, pp. 135-177

Min Zhang and Douglas E. Schaubel (2012). "Contrasting Treatment-Specific Survival Using Double-Robust Estimators". In: Statistics in Medicine 31.30, pp. 4255-4268

Xiaofei Bai, Anastasios A. Tsiatis, and Sean M. O’Brien (2013). "Doubly-Robust Estimators of Treatment-Specific Survival Distributions in Observational Studies with Stratified Sampling". In: Biometrics 69, pp. 830–839

Brice Maxime Hugues Ozenne, Thomas Harder Scheike, and Laila Staerk (2020). "On the Estimation of Average Treatment Effects with Right-Censored Time to Event Outcome and Competing Risks". In: Biometrical Journal 62, pp. 751–763

}
\author{
The wrapper function was written by Robin Denz, the \code{ate} function (which this wrapper is build around) was written by other people. See \code{?ate} for more details.
}

\seealso{
\code{\link[riskRegression]{ate}}, \code{\link[survival]{coxph}}, \code{\link{glm}}
}
\examples{
library(adjustedCurves)
library(survival)

if (requireNamespace("riskRegression")) {

library(riskRegression)

set.seed(42)

# simulate some data as example
sim_dat <- sim_confounded_surv(n=50, max_t=1.2)
sim_dat$group <- as.factor(sim_dat$group)

# estimate a cox-regression for the outcome
cox_mod <- coxph(Surv(time, event) ~ x1 + x2 + x3 + x4 + x5 + x6 + group,
                 data=sim_dat, x=TRUE)

# estimate a treatment assignment model
glm_mod <- glm(group ~ x1 + x3 + x5 + x6, data=sim_dat, family="binomial")

# use it to calculate adjusted survival curves
adjsurv <- adjustedsurv(data=sim_dat,
                        variable="group",
                        ev_time="time",
                        event="event",
                        method="aiptw",
                        outcome_model=cox_mod,
                        treatment_model=glm_mod,
                        conf_int=FALSE)

# plot the curves
plot(adjsurv)
}
}
