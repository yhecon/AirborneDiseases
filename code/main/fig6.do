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

use "$data/master_japan.dta", clear

replace gflu = gflu * 100

xtset pref_id time
drop if year == 2009

egen mean_flu = mean(flu), by(week)

collapse (sum) flu mean_flu (mean) month day time, by(year week)

replace flu = flu/1000
replace mean_flu = mean_flu/1000

graph twoway ///
line flu week if year == 2010, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2011, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2012, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2013, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2014, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2015, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2016, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2017, lcolor(gs11) lstyle(solid) || ///
line flu week if year == 2018, lcolor(gs11) lstyle(solid) || ///
line mean_flu week if year == 2010, lcolor(gs4) lstyle(solid) lwidth(thick) || ///
, scheme(plotplain) ///
legend(order(10 1) label(10 "Mean: 2010-2018") label(1 "Each year") ring(0) pos(2) rowgap(0.5)) ///
title("A", position(11) ring(30) span size(large)) ///
ylabel(0 "   0" 50 100 150 200 250 300, nogrid) ///
xtitle("Year-by-week") ytitle("Number of Influenza (thousands)", axis(1)) ///
xscale(range(-2 55) extend) xlabel(0 "Jan 1" 9 "Mar 1" 18 "May 1" 27 "Jul 1" 36 "Sep 1" 45 "Nov 1" 53 "Dec 28",  nogrid) 

graph save "$figure/figure6/Figure6_A",replace

********************************************************************************

use "$data/master_japan.dta", clear

replace gflu = gflu * 100

xtset pref_id time
drop if year == 2009

* winsorize at 99%
foreach i in spm pm so2 no2 co ox {
	egen `i'1 = pctile(`i'), p(1)
	egen `i'99 = pctile(`i'), p(99)	
	replace `i' = . if `i' > `i'99 & `i' < .
	drop `i'1 `i'99
}			

egen mean_gflu = mean(gflu), by(week)

collapse (mean) gflu mean_gflu (mean) month day time, by(year week)

graph twoway ///
line gflu week if year == 2010, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2011, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2012, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2013, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2014, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2015, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2016, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2017, lcolor(gs11) lstyle(solid) || ///
line gflu week if year == 2018, lcolor(gs11) lstyle(solid) || ///
line mean_gflu week if year == 2010, lcolor(gs4) lstyle(solid) lwidth(thick) || ///
, scheme(plotplain) ///
legend(order(10 1) label(10 "Mean: 2010-2018") label(1 "Each year") ring(0) pos(2) rowgap(0.5)) ///
title("B", position(11) ring(30) span size(large)) ///
ylabel(-150 -100 -50 0 "   0" 50 100 150, nogrid) ///
yline(0) ///
xtitle("Year-by-week") ytitle("Average growth rate (%)", axis(1)) ///
xscale(range(-2 55) extend) xlabel(0 "Jan 1" 9 "Mar 1" 18 "May 1" 27 "Jul 1" 36 "Sep 1" 45 "Nov 1" 53 "Dec 28",  nogrid) 

graph save "$figure/figure6/Figure6_B",replace

********************************************************************************

use "$data/master_japan.dta", clear

replace gflu = gflu * 100

xtset pref_id time
drop if year == 2009

* winsorize at 99%
foreach i in spm pm so2 no2 co ox {
	egen `i'1 = pctile(`i'), p(1)
	egen `i'99 = pctile(`i'), p(99)	
	replace `i' = . if `i' > `i'99 & `i' < .
	drop `i'1 `i'99
}			

egen mean_spm = mean(spm), by(week)

collapse (mean) spm mean_spm (mean) month day time, by(year week)

graph twoway ///
line spm week if year == 2010, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2011, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2012, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2013, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2014, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2015, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2016, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2017, lcolor(gs11) lstyle(solid) || ///
line spm week if year == 2018, lcolor(gs11) lstyle(solid) || ///
line mean_spm week if year == 2010, lcolor(gs4) lstyle(solid) lwidth(thick) || ///
, scheme(plotplain) ///
legend(order(10 1) label(10 "Mean: 2010-2018") label(1 "Each year") ring(0) pos(2) rowgap(0.5)) ///
title("C", position(11) ring(30) span size(large)) ///
ylabel(0 "   0" 10 20 30 40 50, nogrid) ///
xtitle("Year-by-week") ytitle("Average SPM (ppm)", axis(1)) ///
xscale(range(-2 55) extend) xlabel(0 "Jan 1" 9 "Mar 1" 18 "May 1" 27 "Jul 1" 36 "Sep 1" 45 "Nov 1" 53 "Dec 28",  nogrid) 

graph save "$figure/figure6/Figure6_C",replace

********************************************************************************
			
	graph combine "$figure/figure6/Figure6_A" "$figure/figure6/Figure6_B" "$figure/figure6/Figure6_C", col(2) row(2) xsize(16) ysize(12) imargin(3 3 3) graphregion(margin(none) fcolor(white) lcolor(white)) iscale(0.65)
			
	graph save "$figure/figure6/Figure6",replace
	graph export "$figure/figure_png/Figure6.png", replace width(3000)
	graph export "$figure/figure_eps/Figure6.eps", replace
	graph export "$figure/figure_pdf/Figure6.pdf", replace
