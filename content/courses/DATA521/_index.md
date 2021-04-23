+++
title = "DATA 521"
date = 2021-01-15
math = true
highlight = true

# Optional featured image (relative to `static/img/` folder).
[header]
image = "headers/bubbles-wide.jpg"
caption = "DATA 521: Time Series Analysis and Forecasting"

+++

DATA 521 is Time Series and Forecasting

Forecasting is predicting the future.  That's hard.  There is a certain science to forecasting that we can make use of all the while recognizing that we have to assume that things are similar in relevant ways to the past to get leverage on them **by using the past**.  This point should never be lost.

We follow the general outlined workflow of Rob J Hyndman and George Athanasopoulos in Forecasting: Principles and Practice.  The key is the workflow.  Tidying data to organize with around an `index` ... a proper date/time something that can be understand as appropriately sequential [with this sequence denotable] and a `key` that describes some set of distinct time series that are [potentially] stored with the same or similar index of time.  Time is central to time series and to the `tsibble`.  With this resolved, there is graphical, decomposition, and feature understanding, before the application of models.  Almost all the action is in adding models to the toolbox.  Basic time series regressions, ETS models of varying forms, ARIMA, Dynamic regressions and their integration with ARMA, using STL for seasonal adjustment and ARMA or ETS models as `STL+`, and advances including aggregation and hierarchical and grouped times series and forecast reconciliation, prophet, VAR, tbats, NNets, and others. 

The core issue remains the criteria for evaluation.  Model fit tells us how well we do in the data **that we have used to fit the model.**.  That's important to know.  But we often really want to know what what model is best over a given forecast horizon.  We can use `stretch_tsibble(.init, .step)` to decide how much data is required to get a credible forecast to start and over steps of what size to repeat it.  This allows us to average over a whole bunch of future forecasts that are implications **of that model**.  Using `accuracy(original_tsibble)` with it, allows us to evaluate the question, which model has been best at forecasting (h periods out with steps of .step size) over the determined horizon.  Because we only have one time series and cannot explicitly re-run time [but bootstrapping/bagging]; we can at least know which has best performed in our fixed time horizon task.

The course textbook:

+ [Forecasting Policy and Practice, 3rd Edition](https://otexts.com/fpp3/)

Software:
+ [RStudio](https://www.rstudio.com)
+ [R](https://cran.r-project.org)
+ [tidyverts](https://tidyverts.org/)

---

# Slides


complete week 4 data for week 5:
```
load(url("https://github.com/robertwwalker/DADMStuff/raw/master/Ch4HA.RData"))
```

+ [Slides for Week 12](https://rww.science/xaringan/CH13HA/index.html) 
+ [Slides for Week 11](https://rww.science/xaringan/CH11HA/index.html) 
+ [Slides for Week 10](https://rww.science/xaringan/CH10HA/index.html) 
+ [Slides for Week 9](https://rww.science/xaringan/CH9HA/index.html) 
+ [Slides for Week 8](https://rww.science/xaringan/CH8HA/index.html) 
+ [Slides for Week 7](https://rww.science/xaringan/CH7HA/index.html) 
+ [Slides for Week 6](https://rww.science/xaringan/CH6HA/index.html) 
+ [Slides for Week 5](https://rww.science/xaringan/CH5HA/index.html)  
+ [Slides for Week 4](https://rww.science/xaringan/CH4HA/index.html)  
+ [Slides for Week 3](https://rww.science/xaringan/CH3HA/index.html)  
+ [Partial slides for Week 1](https://rww.science/xaringan/tidyDS/tidy.html)  

## COVID-19 Forecasting

The [summary page](https://rww.science/courses/DATA521/forecasting/index.html)

+ [tbats for COVID-19](https://rww.science/courses/DATA521/forecasting/tbats/index.html)
+ [Aggregate Forecasting for COVID-19](https://rww.science/courses/DATA521/forecasting/aggfore/index.html)
+ [Aggregate Box-Cox Forecasting for COVID-19](https://rww.science/courses/DATA521/forecasting/aggforeBC/index.html)
+ [Aggregate log Forecasting for COVID-19](https://rww.science/courses/DATA521/forecasting/aggforelog/index.html)
+ [weather](https://rww.science/courses/DATA521/forecasting/weather/index.html)

## Some Resources:


+ [Basic Time Series](https://rww.science/courses/DATA521/Basic-TS/Basic-TS.html)
+ [Equities](https://rww.science/courses/DATA521/Equities/Equities.html)
+ [FRED](https://rww.science/courses/DATA521/FRED/fred-2.html)
+ [fredr-employment](https://rww.science/courses/DATA521/fredr-employment/fredr-employment.html)
+ [Spurious Regressions](https://rww.science/courses/DATA521/Spurious-Regressions/Spurious.html)
 
