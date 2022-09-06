* These code are designed to accomplish the following three objectives:
* 1) An introduction to simulating autoregressive processes in STATA
* 2) An introduction to simulating moving averages in STATA
* 3) An introduction to STATA's ARIMA diagnostic procedures
* Code comes from Guy Whitten, Texas A&M University
* Relating this to course slides, rhos are his phis, theta is still theta

* We'll start with some housekeeping and the creation of a time variable:
clear
set seed 12344
set obs 100
egen time=fill(0 1 2)
tsset time

**************************************************************************
* Step 1) An introduction to simulating autoregressive processes in STATA*
**************************************************************************

* First we need to create a set of well-behaved disturbance terms:
drawnorm r1
drawnorm r2
drawnorm r3
drawnorm r4
drawnorm r5
drawnorm r6

* Here is a unit root process.  y_{t} = y_{t-1} + e_{t}
* y has perfect memory.
gen y1ur=.
replace y1ur=r1 if time==0
replace y1ur=y1ur[_n-1]+r1 if time>0

* Now let's create an AR1 process with phi equal to .7
gen y1=.
replace y1=r1 if time==0
replace y1=.7*L.y1+r1 if time>0

twoway line y1 time, yline(0) 

* We can create an AR2 or higher-order AR processes by adding additional terms.
* Here is an AR2 process with phi1=.4 and phi2=.3
gen y2=.
replace y2=r2 if time==0
replace y2=.4*L.y2+r2 if time==1
replace y2=.4*L.y2+.3*L2.y2+r2 if time>1

* Let's take a look at this:
twoway line y2 time, yline(0)

*****************************************************************
* Step 2) An introduction to simulating moving averages in STATA*
*****************************************************************

* Moving averages are created by theta coefficients on the lagged error process. 
* So an MA1 process with theta=.4 would be created by:

gen y3=.7*L.r3+r3

twoway line y3 time, yline(0)

* An MA2 processes with theta1=.3 and theta2=.1 would be created by:
gen y4=.3*L.r4+.1*L2.r4+r4

twoway line y4 time, yline(0)

******************************************************************
* Step 3) An introduction to STATA's ARIMA diagnostic proceedures*
******************************************************************

* The basic diagnostic suite for autocorrelations in STATA is contained in the
* "corrgram" command.  For instance, if we use this command with y1 (an AR1 
* process with phi=7):
corrgram y1

* The "ac" command (help and options for this command can be found under "corrgram")
* plots a graph of autocorrelations with confidence intervals:
ac y1

* The "pac" command (help and options for this command can also be found under 
* "corrgram") plots partial autocorrelations with confidence intervals:
pac y1


ac y2
pac y2

ac y3
pac y3

* Now let's run an ARIMA model of y1 using our pdq=(1,0,0)
arima y1, arima(1,0,0)

* saving the residuals:
predict y1_res, resid
corrgram y1_res

arima y2, arima(2,0,0)
* Now it's your turn:
* 1) Try to create some different types of AR processes
* 2) Try to create some different types of MA processes
* 3) Run some autocorrelation diagnostics on the series that you create