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

	use "$temp/figureA2/by_lagday_estimate_matrixs.dta", clear
	
	keep if type == "IV"
	gen x = _n - 1
		
	graph twoway (line estimate days if reg == 1, lcolor(blue%60) lpattern(solid) lwidth(1)) ///
				(line estimate days if reg == 2, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 3, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 4, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 5, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 6, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 7, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 8, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 9, lcolor(gs6) lpattern(solid)) ///
				,xlabel(0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 24 "t-24", nogrid labsize(2.5))  ///
				xscale(range(-0.5 24)) ///
				ylabel(-.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1", nogrid labsize(2.5)) ///
				legend(ring(0) pos(4) order(1 2) label(1 "Baseline estimate (21 days)") lab(2 "Different lags (16~24 days)") size(2.5) rowgap(0.6)) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("A", position(11) ring(30) span size(large)) ///
				text(.1 0.5 "IV", size(4.2) place(e)) ///
				scheme(plotplain)
				
		graph save "$appendix_figure/figureA2/FigureA2_A", replace
	
********************************************************************************

	use "$temp/figureA2/by_lagday_estimate_matrixs.dta", clear
	
	keep if type == "OLS"
	gen x = _n - 1
		
	graph twoway (line estimate days if reg == 1, lcolor(blue) lpattern(solid) lwidth(1)) ///
				(line estimate days if reg == 2, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 3, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 4, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 5, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 6, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 7, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 8, lcolor(gs6) lpattern(solid)) ///
				(line estimate days if reg == 9, lcolor(gs6) lpattern(solid)) ///
				,xlabel(0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 24 "t-24", nogrid labsize(2.5))  ///
				xscale(range(-0.5 24)) ///
				ylabel(-.02 "-.02" -.01 "-.01" 0 "0" .01 ".01" .0199999 "     ." .02 ".02", nogrid labsize(2.5)) ///
				legend(ring(0) pos(4) order(1 2) label(1 "Baseline estimate (21 days)") lab(2 "Different lags (16~24 days)") size(2.5) rowgap(0.6)) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("B", position(11) ring(30) span size(large)) ///
				text(.02 0.5 "OLS", size(4.2) place(e)) ///
				scheme(plotplain)
	
		graph save "$appendix_figure/figureA2/FigureA2_B", replace
	
	
********************************************************************************
			
	graph combine "$appendix_figure/figureA2/FigureA2_A" "$appendix_figure/figureA2/FigureA2_B", col(2) xsize(12) ysize(4) imargin(3 3) graphregion(margin(vtiny) fcolor(white) lcolor(white)) iscale(1)
			
		graph save "$appendix_figure/figureA2/FigureA2",replace
		graph export "$appendix_figure/figureA_png/FigureA2.png", replace width(3000)
		graph export "$appendix_figure/figureA_eps/FigureA2.eps", replace
		graph export "$appendix_figure/figureA_pdf/FigureA2.pdf", replace
