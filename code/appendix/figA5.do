*==============================================================================* 
* Project: COVID and Air Pollution					    			           *   
* Date:   2020 Mar                                                             *
* Author: Guojun, Yuhang, Tanaka                                               *    
*==============================================================================* 

* set directories 
clear all
set maxvar  30000
set matsize 11000 
set more off
cap log close


********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "pm"
	keep if type == "IV"
		
	graph twoway  (rarea max95 min95 days, fcolor(blue*0.2) lcolor(blue*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.4 -.2 0 .2 .4 .399999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("A1", position(11) ring(30) span size(large)) ///
				text(.35 0.5 "PM{sub:2.5}", size(3.5) place(e)) ///
				text(.5 0.5 "IV", size(large) place(e) color(blue*1.2)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_A1", replace

********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "pm10"
	keep if type == "IV"
		
	graph twoway  (rarea max95 min95 days, fcolor(blue*0.2) lcolor(blue*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.6 -.4 -.2 0 .2 .4 .399999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("A2", position(11) ring(30) span size(large)) ///
				text(.4 0.5 "PM{sub:10}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_A2", replace

********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "so2"
	keep if type == "IV"
		
	graph twoway  (rarea max95 min95 days, fcolor(blue*0.2) lcolor(blue*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-1.5 -1 -.5 0 .5 1 .999999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("A3", position(11) ring(30) span size(large)) ///
				text(1 0.5 "SO{sub:2}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_A3", replace
	
********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "no2"
	keep if type == "IV"
		
	graph twoway  (rarea max95 min95 days, fcolor(blue*0.2) lcolor(blue*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-1 -.5 0 .5 .499999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("A4", position(11) ring(30) span size(large)) ///
				text(.5 0.5 "NO{sub:2}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_A4", replace
		
********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "co"
	keep if type == "IV"
		
	graph twoway  (rarea max95 min95 days, fcolor(blue*0.2) lcolor(blue*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-30 -20 -10 0 10 20 19.99999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("A5", position(11) ring(30) span size(large)) ///
				text(20 0.5 "CO", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_A5", replace
			
********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "o3"
	keep if type == "IV"
		
	graph twoway  (rarea max95 min95 days, fcolor(blue*0.2) lcolor(blue*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-1 -.5 0 .5 1 1.5 1.499999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("A6", position(11) ring(30) span size(large)) ///
				text(1.5 0.5 "O{sub:3}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_A6", replace
	
********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "pm"
	keep if type == "OLS"
		
	graph twoway  (rarea max95 min95 days, fcolor(red*0.2) lcolor(red*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(red*1) lcolor(red*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.03 -.02 -.01 0 .01 .02 .0199999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("B1", position(11) ring(30) span size(large)) ///
				text(.015 0.5 "PM{sub:2.5}", size(3.5) place(e)) ///
				text(.026 0.5 "OLS", size(large) place(e) color(red*1.2)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_B1", replace

********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "pm10"
	keep if type == "OLS"
		
	graph twoway  (rarea max95 min95 days, fcolor(red*0.2) lcolor(red*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(red*1) lcolor(red*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.01 -.005 0 .005 .01 .00999999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("B2", position(11) ring(30) span size(large)) ///
				text(.01 0.5 "PM{sub:10}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_B2", replace

********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "so2"
	keep if type == "OLS"
		
	graph twoway  (rarea max95 min95 days, fcolor(red*0.2) lcolor(red*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(red*1) lcolor(red*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 -.1 -.05 0 .05 .0499999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("B3", position(11) ring(30) span size(large)) ///
				text(.05 0.5 "SO{sub:2}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_B3", replace
	
********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "no2"
	keep if type == "OLS"
		
	graph twoway  (rarea max95 min95 days, fcolor(red*0.2) lcolor(red*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(red*1) lcolor(red*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 -.1 -.05 0 .05 .1 .0999999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("B4", position(11) ring(30) span size(large)) ///
				text(.1 0.5 "NO{sub:2}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_B4", replace
		
********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "co"
	keep if type == "OLS"
		
	graph twoway  (rarea max95 min95 days, fcolor(red*0.2) lcolor(red*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(red*1) lcolor(red*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-3 -2 -1 0 1 2 1.999999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("B5", position(11) ring(30) span size(large)) ///
				text(2 0.5 "CO", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_B5", replace
			
********************************************************************************

	use "$temp/figureA5/byday_pollutant_estimate_matrixs.dta", clear
	
	keep if specification == "o3"
	keep if type == "OLS"
		
	graph twoway  (rarea max95 min95 days, fcolor(red*0.2) lcolor(red*0.1)) ///
				(connected estimate days, msymbol(circle) lpattern(solid) lwidth(med) mcolor(red*1) lcolor(red*0.6) msize(0.6)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.06 -.04 -.02 0 .02 .04 .0399999 "       .", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(gs11)) ///
				xtitle("") ///
				ytitle("") ///
				title("B6", position(11) ring(30) span size(large)) ///
				text(.04 0.5 "O{sub:3}", size(3.5) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA5/FigureA5_B6", replace
		
		
********************************************************************************
								
	graph combine "$appendix_figure/figureA5/FigureA5_A1" "$appendix_figure/figureA5/FigureA5_A2" "$appendix_figure/figureA5/FigureA5_A3" "$appendix_figure/figureA5/FigureA5_A4" "$appendix_figure/figureA5/FigureA5_A5" "$appendix_figure/figureA5/FigureA5_A6" "$appendix_figure/figureA5/FigureA5_B1" "$appendix_figure/figureA5/FigureA5_B2" "$appendix_figure/figureA5/FigureA5_B3" "$appendix_figure/figureA5/FigureA5_B4" "$appendix_figure/figureA5/FigureA5_B5" "$appendix_figure/figureA5/FigureA5_B6", col(3) row(4) xsize(12) ysize(10) imargin(3 3 3 3 3 3 3 3 3 3 3 3 3) graphregion(margin(tiny) fcolor(white) lcolor(white)) iscale(0.4)
			

		graph save "$appendix_figure/figureA5/FigureA5",replace
		graph export "$appendix_figure/figureA_png/FigureA5.png", replace width(3000)
		graph export "$appendix_figure/figureA_eps/FigureA5.eps", replace
		graph export "$appendix_figure/figureA_pdf/FigureA5.pdf", replace
