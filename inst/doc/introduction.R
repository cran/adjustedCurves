## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo=TRUE)

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=FALSE----------------------
#  install.packages("adjustedCurves")

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=FALSE----------------------
#  remotes::install_github("RobinDenz1/adjustedCurves")

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
library(survival)
library(ggplot2)
library(riskRegression)
library(pammtools)
library(adjustedCurves)

# set random number generator seed to make this reproducible
set.seed(44)

# simulate standard survival data with 300 rows
data_1 <- sim_confounded_surv(n=300, max_t=1.1, group_beta=-0.6)
# code the grouping variable as a factor
data_1$group <- as.factor(data_1$group)

# take a look at the first few rows
head(data_1)

## ----echo=TRUE----------------------------------------------------------------
# it is important to use X=TRUE in the coxph function call
outcome_model <- survival::coxph(Surv(time, event) ~ x1 + x2 + x3 + x4 + x5 + 
                                   x6 + group, data=data_1, x=TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
adjsurv <- adjustedsurv(data=data_1,
                        variable="group",
                        ev_time="time",
                        event="event",
                        method="direct",
                        outcome_model=outcome_model,
                        conf_int=TRUE)

## ----echo=TRUE----------------------------------------------------------------
head(adjsurv$adj)

## ----echo=TRUE, fig.show=TRUE, fig.width=7, fig.height=5----------------------
plot(adjsurv)

## ----echo=TRUE, fig.show=TRUE, fig.width=7, fig.height=5----------------------
plot(adjsurv, conf_int=TRUE)

## ----echo=TRUE----------------------------------------------------------------
treatment_model <- glm(group ~ x1 + x2 + x3 + x4 + x5 + x6,
                       data=data_1, family="binomial"(link="logit"))

adjsurv <- adjustedsurv(data=data_1,
                        variable="group",
                        ev_time="time",
                        event="event",
                        method="iptw_km",
                        treatment_model=treatment_model,
                        conf_int=TRUE)

## ----echo=TRUE, fig.show=TRUE, fig.width=7, fig.height=5----------------------
plot(adjsurv, conf_int=TRUE)

## ----echo=TRUE, fig.width=7, fig.height=5-------------------------------------
adjsurv <- adjustedsurv(data=data_1,
                        variable="group",
                        ev_time="time",
                        event="event",
                        method="aiptw",
                        treatment_model=treatment_model,
                        outcome_model=outcome_model,
                        conf_int=TRUE)

plot(adjsurv, conf_int=TRUE)

## ----echo=TRUE----------------------------------------------------------------
# simulate the data
data_2 <- sim_confounded_crisk(n=300)
data_2$group <- as.factor(data_2$group)

head(data_2)

## ----echo=TRUE----------------------------------------------------------------
outcome_model <- riskRegression::CSC(Hist(time, event) ~ x1 + x2 + x3 + x4 + 
                                       x5 + x6 + group, data=data_2)

## ----echo=TRUE, message=FALSE, fig.show=TRUE, fig.width=7, fig.height=5-------
adjcif <- adjustedcif(data=data_2,
                      variable="group",
                      ev_time="time",
                      event="event",
                      method="direct",
                      outcome_model=outcome_model,
                      cause=1,
                      conf_int=TRUE)
plot(adjcif, conf_int=TRUE)

## ----echo=TRUE, message=FALSE, fig.show=TRUE, fig.width=7, fig.height=5-------
adjcif <- adjustedcif(data=data_2,
                      variable="group",
                      ev_time="time",
                      event="event",
                      method="direct",
                      outcome_model=outcome_model,
                      cause=2,
                      conf_int=TRUE)
plot(adjcif, conf_int=TRUE)

## ----echo=TRUE, fig.show=TRUE, fig.width=7, fig.height=5----------------------
treatment_model <- glm(group ~ x1 + x2 + x3 + x4 + x5 + x6,
                       data=data_2, family="binomial"(link="logit"))

adjcif <- adjustedcif(data=data_2,
                      variable="group",
                      ev_time="time",
                      event="event",
                      method="iptw",
                      treatment_model=treatment_model,
                      cause=1,
                      conf_int=TRUE)
plot(adjcif, conf_int=TRUE)

## ----echo=TRUE----------------------------------------------------------------
# add another group
# NOTE: this is done only to showcase the method and does not
#       reflect what should be done in real situations
data_1$group <- factor(data_1$group, levels=c("0", "1", "2"))
data_1$group[data_1$group=="1"] <- sample(c("1", "2"), replace=TRUE,
                                          size=nrow(data_1[data_1$group=="1",]))

## ----echo=TRUE, fig.show=TRUE, fig.width=7, fig.height=5----------------------
outcome_model <- survival::coxph(Surv(time, event) ~ x1 + x2 + x3 + x4 + 
                                   x5 + x6 + group, data=data_1, x=TRUE)

adjsurv <- adjustedsurv(data=data_1,
                        variable="group",
                        ev_time="time",
                        event="event",
                        method="direct",
                        outcome_model=outcome_model,
                        conf_int=TRUE)
plot(adjsurv)

## ----echo=TRUE, message=FALSE, warning=FALSE, fig.show=TRUE, fig.width=7, fig.height=5----
treatment_model <- nnet::multinom(group ~ x1 + x2 + x3 + x4 + x5 + x6,
                                  data=data_1)

adjsurv <- adjustedsurv(data=data_1,
                        variable="group",
                        ev_time="time",
                        event="event",
                        method="iptw_km",
                        treatment_model=treatment_model,
                        conf_int=TRUE)
plot(adjsurv, conf_int=TRUE)

