## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo=TRUE, fig.width=6.7, fig.height=5.2)

## ---- message=FALSE, warning=FALSE--------------------------------------------
library(ggplot2)
library(adjustedCurves)

set.seed(42)

data <- sim_confounded_surv(n=250, max_t=1.3)
data$group <- as.factor(data$group)

## -----------------------------------------------------------------------------
s_iptw <- adjustedsurv(data=data,
                       variable="group",
                       ev_time="time",
                       event="event",
                       method="iptw_km",
                       treatment_model=group ~ x1 + x3 + x5 + x6,
                       weight_method="glm",
                       conf_int=TRUE,
                       stabilize=TRUE)

## -----------------------------------------------------------------------------
plot(s_iptw)

## -----------------------------------------------------------------------------
plot(s_iptw, linetype=TRUE, color=FALSE)

## -----------------------------------------------------------------------------
plot(s_iptw, custom_colors=c("red", "blue"))

## -----------------------------------------------------------------------------
plot(s_iptw, linetype=TRUE, custom_linetypes=c("dotdash", "solid"))

## -----------------------------------------------------------------------------
plot(s_iptw, xlab="Time in Years", ylab="S(t)",
     title="This is the title", subtitle="This is the subtitle",
     legend.title="Sex")

## -----------------------------------------------------------------------------
plot(s_iptw, conf_int=TRUE)

## -----------------------------------------------------------------------------
plot(s_iptw, median_surv_lines=TRUE)

## -----------------------------------------------------------------------------
plot(s_iptw, median_surv_lines=TRUE, median_surv_linetype="dotdash",
     median_surv_size=0.7, median_surv_color="grey")

## -----------------------------------------------------------------------------
plot(s_iptw, median_surv_lines=TRUE, median_surv_quantile=0.4)

## -----------------------------------------------------------------------------
plot(s_iptw, censoring_ind="lines")

## -----------------------------------------------------------------------------
plot(s_iptw, censoring_ind="points", censoring_ind_shape=3,
     censoring_ind_size=2)

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE)

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_type="n_events")

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_type="n_cens")

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE)

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0)

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0, x_n_breaks=10)

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0, x_n_breaks=10, risk_table_size=3,
     risk_table_family="serif", risk_table_fontface="italic")

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0, x_n_breaks=10,
     risk_table_stratify_color=FALSE)

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0, x_n_breaks=10,
     risk_table_custom_colors=c("brown", "orange"))

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0, x_n_breaks=10,
     risk_table_title="Weighted Number of people at risk",
     risk_table_title_size=10, risk_table_title_position="middle",
     risk_table_ylab=NULL)

## -----------------------------------------------------------------------------
plot(s_iptw, risk_table=TRUE, risk_table_stratify=TRUE,
     risk_table_digits=0, x_n_breaks=10,
     risk_table_theme=ggplot2::theme_classic(),
     gg_theme=ggplot2::theme_minimal())

## -----------------------------------------------------------------------------
# legend is successfully put at the top
plot(s_iptw) +
  theme(legend.position="top")

## -----------------------------------------------------------------------------
# legend remains at the right side
plot(s_iptw, risk_table=TRUE) +
  theme(legend.position="top")

## -----------------------------------------------------------------------------
more_stuff <- list(theme(legend.position="top"))
plot(s_iptw, risk_table=TRUE, additional_layers=more_stuff)

## -----------------------------------------------------------------------------
more_stuff <- list(geom_hline(yintercept=0.7))
plot(s_iptw, risk_table=TRUE, additional_layers=more_stuff)

## -----------------------------------------------------------------------------
# remove x-axis ticks from risk table for some reason
more_stuff <- list(theme(axis.ticks.x=element_blank()))
plot(s_iptw, risk_table=TRUE, risk_table_additional_layers=more_stuff)

## -----------------------------------------------------------------------------
plot(s_iptw, conf_int=TRUE, censoring_ind="lines", risk_table=TRUE,
     risk_table_stratify=TRUE, risk_table_digits=0, x_n_breaks=10,
     risk_table_title_size=11, median_surv_lines=TRUE,
     gg_theme=theme_bw(), risk_table_theme=theme_classic(),
     legend.position="top", custom_colors=c("blue", "red"),
     xlab="Time in Years")

