*==============================================================================* 
* Project: COVID and Air Pollution					    			           *   
* Date:   2020 Mar                                                             *
* Author: Guojun, Yuhang, Tanaka                                               *    
*==============================================================================* 

clear all
set maxvar  30000
set matsize 11000 
set more off
cap log close


********************************************************************************

	use "$data/master_china.dta",replace
		
	* Summary of Statistic
	
		drop if city_code == 4201

		local sum_aqi = "aqi"
		local sum_wth = "temp prec snow it"
		local sum_covid = "cur"
		local sum_aq = "pm pm10 so2 no2 co o3"
		
		format `sum_aqi' `sum_wth' `sum_covid' `sum_aq' %9.3g
		sum `sum_covid' `sum_aqi' `sum_wth' `sum_aq', format			
	
				
** trend ***********************************************************************

	* Covid case
	
	use "$data/master_china.dta",replace
	
	drop if city_code == 4201
	
	egen rank = rank(daynum) if treat == 1, by(city_code)
	gen first = 0
	replace first = rank if rank == 1
		
	collapse (sum) cur death c_cure case (sum) first, by(daynum)
	
	gen shade = 90000
	replace first = first * 1000
	
	graph  twoway (area cur daynum, fcolor(blue%40) lcolor(blue%5)) ///
			  (area c_cure daynum, fcolor(orange%40) lcolor(orange%5)) ///
			  (area death daynum, fcolor(red%70) lcolor(red%5)) ///
			  (line case daynum, lcolor(blue%80) lpattern(dash_dot)) ///
			 , xlabel(8398 " " 8401 "Jan 1" 8423 "Jan 23" 8432 "Feb 1" 8461 "Mar 1" 8492 "Apr 1" 8495 " ", nogrid) ///
			 ylabel(0 10000 20000 29999.9999  "        ." 30000 35000 " ", nogrid) ///
			 legend(order(1 2 3 4) label(1 "Active") label(2 "Recovered") label(3 "Deaths") label(4 "Confirmed") ring(0) pos(11) rowgap(0.5)) ///
			 title("A", position(11) ring(30) span size(large)) ///
			 xline(8423) ///
			 text(5000 8410 "Wuhan" "Lockdown", place(e) size(2.5) color(black)) ///
			 xtitle("") ytitle("Number of COVID-19", axis(1))  scheme(plotplain) 

			graph save "$figure/figure2/Figure2_A",replace
	
	

** growth rate *****************************************************************
		
	
	use "$data/master_china.dta",replace
	
	drop if city_code == 4201
			 
	collapse (mean) gcur gcase, by(daynum)
			
	graph twoway (connected gcur daynum if daynum >= 8424, mcolor(white) msymbol(circle) lcolor(white) msize(0.6)) ///
			(connected gcur daynum if daynum >= 8424, lcolor(gs8) mcolor(gs4) msymbol(circle) msize(0.6)) ///
			,xlabel(8398 " " 8401 "Jan 1" 8423 "Jan 23" 8432 "Feb 1" 8461 "Mar 1" 8492 "Apr 1" 8495 " ", nogrid) ///
			 title("B", position(11) ring(30) span size(large)) ///
			 ylabel(-20 "-20" 0 "0" 20 "20" 39.999999 "        ." 40 "40",nogrid) ///
			 xtitle("") ///
			 legend(order(2) ring(0) pos(2) label(2 "Average growth rate of active cases")) ///
			 xline(8423, lcolor(gs10) lpattern(shortdash)) ///
			 text(-15 8410 "Wuhan" "Lockdown", place(e) size(2.5) color(black)) ///
			 yline(0, lcolor(gs10) lpattern(shortdash)) ///
			 ytitle("Growth Rate (%)") scheme(plotplain) 
			
			graph save "$figure/figure2/Figure2_B",replace
			
			

** air pollution ***************************************************************
			
	use "$data/master_china.dta",replace
	
	drop if city_code == 4201
	
	collapse (mean) aqi it month day, by(daynum)
	
	tsset daynum
					 	
	graph  twoway (connected aqi daynum, lcolor(white) mcolor(white) msymbol(circle) msize(0.6) lpattern(dash_dot)) ///
			(connected aqi daynum, lcolor(gs8) mcolor(gs4) msymbol(circle) msize(0.6) lpattern(dash_dot)) ///
			 , xlabel(8398 " " 8401 "Jan 1" 8423 "Jan 23" 8432 "Feb 1" 8461 "Mar 1" 8492 "Apr 1" 8495 " ",nogrid) ///
			 ylabel(0 "0" 30 "30" 60 "60" 90 "90" 119.99999999 "        ." 120 "120",nogrid) ///
			 xline(8423) ///
			 text(15 8410 "Wuhan" "Lockdown", place(e) size(2.5) color(black)) ///
			 title("C", position(11) ring(30) span size(large)) ///
			 legend(order(2) label(2 "AQI") pos(2) ring(0)) ///
			 ytitle("Average AQI") ///
			 xtitle("") ///
			 scheme(plotplain) 
						
			graph save "$figure/figure2/Figure2_C",replace
		


** combine *****************************************************************

			
	graph combine "$figure/figure2/Figure2_A" "$figure/figure2/Figure2_B" "$figure/figure2/Figure2_C", col(2) row(2) xsize(19) ysize(12) imargin(3 3 3) graphregion(margin(none) fcolor(white) lcolor(white)) iscale(0.65)
			
	graph save "$figure/figure2/Figure2",replace
	graph export "$figure/figure_png/Figure2.png", replace width(3000)
	graph export "$figure/figure_eps/Figure2.eps", replace
	graph export "$figure/figure_pdf/Figure2.pdf", replace
