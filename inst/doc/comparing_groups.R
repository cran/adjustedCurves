## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo=TRUE, fig.width=6.7, fig.height=4.6)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(adjustedCurves)
library(survival)
library(ggplot2)
library(pammtools)
library(cowplot)

set.seed(34253)

data <- sim_confounded_surv(n=500, group_beta=0)
data$group <- factor(data$group)

## -----------------------------------------------------------------------------
adjsurv <- adjustedsurv(data=data,
                        variable="group",
                        ev_time="time",
                        event="event",
                        method="iptw_km",
                        treatment_model=group ~ x2 + x5,
                        conf_int=TRUE,
                        bootstrap=TRUE,
                        n_boot=100,
                        stabilize=TRUE)

## -----------------------------------------------------------------------------
plot(adjsurv, conf_int=TRUE, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0, x_n_breaks=10)

## ----echo=FALSE---------------------------------------------------------------
adjsurv07 <- update(adjsurv, times=0.7, bootstrap=FALSE)
plotdata <- data.frame(x=0.7, xend=0.7, y=min(adjsurv07$adj$surv),
                       yend=max(adjsurv07$adj$surv))

plot(adjsurv, max_t=1) +
  geom_vline(xintercept=0.7, linetype="dashed") +
  geom_segment(data=plotdata, aes(x=x, xend=xend, y=y, yend=yend),
               inherit.aes=FALSE, linetype="solid", color="blue",
               linewidth=1)

## -----------------------------------------------------------------------------
adjusted_curve_diff(adjsurv, times=0.7, conf_int=TRUE)

## -----------------------------------------------------------------------------
adjusted_curve_ratio(adjsurv, times=0.7, conf_int=TRUE)

## -----------------------------------------------------------------------------
plot_curve_diff(adjsurv, conf_int=TRUE, max_t=0.7)

## -----------------------------------------------------------------------------
plot_curve_ratio(adjsurv, conf_int=TRUE, max_t=0.7)

## -----------------------------------------------------------------------------
adjusted_surv_quantile(adjsurv, p=0.5, conf_int=TRUE)

## ----echo=FALSE---------------------------------------------------------------
adjmed <- adjusted_surv_quantile(adjsurv, p=0.5)
plotdata <- data.frame(x=min(adjmed$q_surv), xend=max(adjmed$q_surv),
                       y=0.5, yend=0.5)

plot(adjsurv, max_t=1) +
  geom_hline(yintercept=0.5, linetype="dashed") +
  geom_segment(data=plotdata, aes(x=x, xend=xend, y=y, yend=yend),
               inherit.aes=FALSE, linetype="solid", color="blue", linewidth=1)

## -----------------------------------------------------------------------------
adjusted_surv_quantile(adjsurv, p=0.5, conf_int=TRUE, contrast="diff")

## -----------------------------------------------------------------------------
adjusted_surv_quantile(adjsurv, p=0.5, conf_int=TRUE, contrast="ratio")

## ----fig.width=6.5, fig.heigth=4, echo=FALSE----------------------------------
adjsurv07 <- update(adjsurv, times=seq(0, 0.7, 0.001), bootstrap=FALSE)

plotdata <- data.frame(ymin=0,
                       ymax=adjsurv07$adj$surv,
                       surv=adjsurv07$adj$surv,
                       time=adjsurv07$adj$time,
                       group=adjsurv07$adj$group)

plot(adjsurv, facet=TRUE, legend.position="none", max_t=1) +
  geom_stepribbon(data=plotdata, aes(x=time, ymin=ymin, ymax=ymax, fill=group),
                  alpha=0.4, inherit.aes=FALSE)

## -----------------------------------------------------------------------------
adjusted_rmst(adjsurv, to=0.7, conf_int=TRUE)

## -----------------------------------------------------------------------------
adjusted_rmst(adjsurv, to=0.7, conf_int=TRUE, contrast="diff")

## -----------------------------------------------------------------------------
adjusted_rmst(adjsurv, to=0.7, conf_int=TRUE, contrast="ratio")

## -----------------------------------------------------------------------------
plot_rmst_curve(adjsurv, conf_int=TRUE)

## -----------------------------------------------------------------------------
plot_rmst_curve(adjsurv, conf_int=TRUE, contrast="diff")

## -----------------------------------------------------------------------------
plot_rmst_curve(adjsurv, conf_int=TRUE, contrast="ratio")

## -----------------------------------------------------------------------------
plot_curve_diff(adjsurv, fill_area=TRUE, integral=TRUE, integral_to=0.7,
                max_t=1, text_pos_x="right")

## -----------------------------------------------------------------------------
adjtest <- adjusted_curve_test(adjsurv, from=0, to=0.7)
adjtest

## ---- warning=FALSE-----------------------------------------------------------
plot(adjtest, type="curves")

