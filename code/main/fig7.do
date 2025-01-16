********************************************************************************

	* Project: Pollution and Infectious Diseases	
	* Author: G. He, Y. Pan, and T. Tanaka                                              

	* set directories 
		clear all
		set maxvar  30000
		set matsize 11000 
		set more off
		cap log close
	
	* This code is for 
	* Setting the repository

********************************************************************************

use "$data/master_japan.dta", replace

replace gflu = gflu * 100

xtset pref_id time
drop if year == 2009
		
**** IV first stage

	foreach n of numlist 0(1)7{
		gen inv_days`n' = 0
		replace inv_days`n' = 1 if invs_mean == `n'
	}
	
**** 
	foreach n of numlist 0(1)7{
		sum inv_days`n'
		local mean_`n' = r(mean)
	}
	
	reg spm temp prec wind i.pref_id i.time
	predict res, residual
	
	
	reg res inv_days1-inv_days7, cluster(pref_id)	
	parmest , saving($temp/figure7/first_stage.dta, replace)

*** IV figure

use "$temp/figure7/first_stage.dta", clear
foreach i in temp prec wind {
	drop if parm == "`i'"
}
replace parm = "inv_days0" if parm == "_cons"
replace estimate = 0 if parm == "inv_days0"
replace min95 = 0 if parm == "inv_days0"
replace max95 = 0 if parm == "inv_days0"

sort parm
gen n = _n
replace n = n-1
gen count = .


foreach n of numlist 0(1)7{
	replace count = `mean_`n'' if parm == "inv_days`n'" 
}
egen sum = sum(count)
gen share = count/sum*100
drop sum count

	
	graph twoway (bar share n, lcolor(white) fcolor(blue*0.40) yaxis(2) yscale(range(0 300) axis(2)) barwidth(1)) ///
			(lfit estimate n, lpattern(dash) yaxis(1) lcolor(gs4)) ///
			(rspike min95 max95 n, yaxis(1)) ///
			(scatter estimate n, yscale(alt) yscale(alt axis(2)) msymbol(circle) mcolor(gs4)) ///
			, legend(ring(0) pos(11) order(1 4 3) label(1 "Distribution") lab(4 "Average Residual") lab(3 "95% CI") rowgap(0.8)) ///
			xlabel(0 (1) 7, nogrid) ylabel(, nogrid) ///
			xscale(range(-0.5 7.5) extend) ///
			ylabel(-4 (2) 6, nogrid axis(1)) ///
			yline(0) ///
			ylabel(none, nogrid axis(2)) ///
			ytitle("Average Residual in SPM", axis(1)) ///
			title("A", position(11) ring(30) span size(large)) ///
			ytitle("", axis(2)) ///
			xtitle("Temperature Inversion Days") ///
			scheme(plotplain)
	
	graph save "$figure/figure7/Figure7_A.gph",replace

********************************************************************************

use "$data/master_japan.dta", replace

replace gflu = gflu * 100

xtset pref_id time
drop if year == 2009
	
	forvalues i = 1/1000{
		shufflevar invs_mean, cluster(pref_id)
		rename invs_mean_shuffled pref_shuffled_`i'
		reghdfe spm pref_shuffled_`i' temp prec wind, absorb(i.pref_id i.time) cluster(pref_id)	
		gen pref_coef_placebo`i' = _b[pref_shuffled_`i']
	}
		
	forvalues i = 1/1000{
		shufflevar invs_mean, cluster(time)
		rename invs_mean_shuffled time_shuffled_`i'
		reghdfe spm time_shuffled_`i' temp prec wind, absorb(i.time i.time) cluster(time)	
		gen time_coef_placebo`i' = _b[time_shuffled_`i']
	}

reghdfe spm invs_mean temp prec wind, absorb(i.pref_id i.time) cluster(pref_id)	
gen true_coef = _b[invs_mean]

keep pref_coef_placebo* time_coef_placebo* true_coef
gen n= _n
keep if n == 1

reshape long pref_coef_placebo time_coef_placebo, i(n) 	

save "$temp/figure7/first_stage_placebo_data.dta",replace

***
use "$temp/figure7/first_stage_placebo_data.dta", clear

sum true_coef
local true_coef = r(mean)

graph twoway histogram pref_coef_placebo, fcolor(blue%40) start(-.4) bin(30) lcolor(white) lwidth(vthin) || ///
histogram time_coef_placebo, fcolor(orange%60) start(-.4) bin(30) lcolor(white) lwidth(vthin) ///
	xline(`true_coef', lcolor(red*1.2) lwidth(medthick) lpattern(shortdash)) xlabel(-.4 (.2) .8, nogrid) ylabel(0(3)15, nogrid) ///
	legend(ring(0) pos(11) order(1 2) label(1 "Randomized Over Space") lab(2 "Randomized Over Time") rowgap(0.8)) ///
	text(12 0.62 "Coefficient" "in True Sample" "0.45 (95*0.CI: 0.27-0.63)", place(c) size(2.5) color(black) linegap(0.8)) ///
	title("B", position(11) ring(30) span size(large)) ///
	xtitle("Estimated Coefficients") ///
	ytitle("Share of Estimates") ///
	scheme(plotplain)

	graph save "$figure/figure7/Figure7_B.gph", replace
	
********************************************************************************

	graph combine "$figure/figure7/Figure7_A.gph" "$figure/figure7/Figure7_B.gph", col(2) xsize(12) ysize(4) imargin(3 3) graphregion(margin(vtiny) fcolor(white) lcolor(white)) iscale(1)
			
	graph save "$figure/figure7/Figure7", replace
	graph export "$figure/figure_png/Figure7.png", replace width(3000)
	graph export "$figure/figure_eps/Figure7.eps", replace
	graph export "$figure/figure_pdf/Figure7.pdf", replace
