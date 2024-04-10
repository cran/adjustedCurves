## ----echo=FALSE---------------------------------------------------------------
tab <- data.frame(
  method=c('"direct"', '"direct_pseudo"', '"iptw_km"', '"iptw_cox"',
           '"iptw_pseudo"', '"matching"', '"emp_lik"', '"aiptw"',
           '"aiptw_pseudo"', '"tmle"', '"strat_amato"', '"strat_nieto"',
           '"strat_cupples"', '"iv_2SRIF"', '"prox_iptw"', '"prox_aiptw"',
           '"km"'),
  supp_unmeasured=c(rep("no", 13), rep("yes", 3), "no"),
  supp_categorical=c(rep("yes", 5), rep("no", 3), "yes", "no", rep("yes", 3),
                     "no", "no", "no", "yes"),
  supp_continuous_conf=c(rep("yes", 10), rep("no", 3), rep("yes", 3), "no"),
  supp_approx_var=c("yes", "no", "yes", "no", "yes", "no", "no", "yes", "yes",
                    "yes", "no", "yes", "no", "no", "yes", "yes", "yes"),
  bounds=c(rep("yes", 4), "no", "yes", "yes", "no", "no", "yes", "yes",
           "yes", "yes", "yes", "no", "no", "yes"),
  monotonic=c("yes", "no", "yes", "yes", "no", "yes", "yes", "no", "no", "yes",
              "yes", "yes", "yes", "yes", "no", "no", "yes"),
  doubly_robust=c(rep("no", 7), "yes", "yes", "yes", rep("no", 5), "yes", "no"),
  dependent_censoring=c("no", "yes", "(no)", "(no)", "yes", "no", "no", "yes",
                        "yes", "yes", "no", "no", "no", "no", "no", "no", "no"),
  type=c("outcome", "outcome", "treatment", "treatment", "treatment",
         "treatment", "treatment", "both", "both", "both", "-",
         "-", "-", "-", "treatment", "both", "none"),
  nonpara=c("no", "no", "depends", "depends", "depends", "depends", "yes",
            "no", "no", "no", "yes", "yes", "yes", "no", "no", "no", "yes"),
  speed=c("+", "- -", "++", "++", "-", "-", "+", "-", "- -", "- - -",
          "+++", "+++", "+++", "+", "- -", "- -", "+++"),
  dependencies=c("riskRegression", "geepack, prodlim", "-", "-",
                 "prodlim", "Matching", "MASS", "riskRegression",
                 "geepack, prodlim", "concrete", "-", "-", "-", "-",
                 "numDeriv", "numDeriv", "-")
)

cnames <- c("Method", "Supports Unmeasured Confounding",
            "Supports Categorical Treatments",
            "Supports Continuous Confounders",
            "Approximate SE available", "Always in Bounds",
            "Always non-increasing", "Doubly-Robust",
            "Supports Dependent Censoring", "Type of Adjustment",
            "Is Nonparametric",
            "Computation Speed", "Dependencies")

tab <- subset(tab, method!='"tmle"')

knitr::kable(tab, col.names=cnames)

## ----echo=FALSE---------------------------------------------------------------
tab <- data.frame(
  method=c('"iptw_km"', '"iptw_cox"', '"iptw_pseudo"', '"matching"',
           '"aiptw"', '"aiptw_pseudo"', '"tmle"'),
  allows=c("glm or multinom object, weights, formula for weightit()",
           "glm or multinom object, weights, formula for weightit()",
           "glm or multinom object, weights, formula for weightit()",
           "glm object or propensity scores",
           "glm object",
           "glm or multinom object or propensity scores",
           "vector of SuperLearner libraries")
)

tab <- subset(tab, method!='"tmle"')

knitr::kable(tab, col.names=c("Method", "Allowed Input to treatment_model argument"))

## ----echo=FALSE---------------------------------------------------------------
tab <- data.frame(
  method=c('"direct"', '"direct_pseudo"', '"iptw"', '"iptw_pseudo"',
           '"matching"', '"aiptw"', '"aiptw_pseudo"', '"tmle"',
           '"aalen_johansen"'),
  supp_unmeasured="no",
  supp_categorical=c("yes", "yes", "yes", "yes", "no", "no", "yes", "no",
                     "yes"),
  supp_continuous_conf=c(rep("yes", 8), "no"),
  supp_approx_var=c("yes", "no", "yes", "yes", "no", "yes", "yes", "yes",
                    "yes"),
  bounds=c("yes", "yes", "yes", "no", "yes", "no", "no", "yes", "yes"),
  monotonic=c("yes", "no", "yes", "no", "yes", "no", "no", "yes", "yes"),
  doubly_robust=c("no", "no", "no", "no", "no", "yes", "yes", "yes", "no"),
  dependent_censoring=c("no", "no", "yes", "no", "no", "yes", "no", "yes",
                        "no"),
  type=c("outcome", "outcome", "treatment", "treatment", "treatment", "both",
         "both", "both", "none"),
  non_parametric=c("no", "no", "no", "depends", "depends", "no", "no", "no",
                   "yes"),
  speed=c("+", "- -", "+", "+", "-", "-", "- -", "- - -", "++"),
  dependencies=c("riskRegression", "geepack, prodlim", "riskRegression",
                 "prodlim", "Matching", "riskRegression", "geepack, prodlim",
                 "concrete", "cmprsk")
)

cnames <- c("Method", "Supports Unmeasured Confounding",
            "Supports Categorical Treatments",
            "Supports Continuous Confounders",
            "Approximate SE available", "Always in Bounds",
            "Always non-increasing", "Doubly-Robust",
            "Supports Dependent Censoring", "Type of Adjustment",
            "Is Nonparametric",
            "Computation Speed", "Dependencies")

tab <- subset(tab, method!='"tmle"')

knitr::kable(tab, col.names=cnames)

## ----echo=FALSE---------------------------------------------------------------
tab <- data.frame(
  method=c('"iptw"', '"iptw_pseudo"', '"matching"',
           '"aiptw"', '"aiptw_pseudo"', '"tmle"'),
  allows=c("glm or multinom object",
           "glm or multinom object, weights, formula for weightit()",
           "glm object or propensity scores",
           "glm object",
           "glm or multinom object or propensity scores",
           "vector of SuperLearner libraries")
)

tab <- subset(tab, method!='"tmle"')
knitr::kable(tab, col.names=c("Method", "Allowed Input to treatment_model argument"))

