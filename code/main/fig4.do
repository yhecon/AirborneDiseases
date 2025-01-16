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

	use "$temp/figure4/baseline_IV", clear
	
	gen x = _n - 1
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15) lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1", nogrid labsize(2.5)) ///
				legend(ring(0) pos(4) order(2 1) label(2 "Point Estimate") lab(3 "95*0. CI") size(2.5) rowgap(0.6)) ///
				yline(0, lcolor(black*0.30)) ///
				xtitle("") ///
				ytitle("Estimated Coefficient", size(3)) ///
				title("A", position(11) ring(30) span size(large)) ///
				text(.1 0.5 "IV", size(3.2)) ///
				scheme(plotplain)
				
		graph save "$figure/figure4/Figure4_A", replace
		
********************************************************************************

	use "$temp/figure4/baseline_OLS", clear
	
	gen x = _n - 1
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15) lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.02 "-.02" -.01 "-.01" 0 "0" .01 ".01" .0199999 "     ." .02 ".02", nogrid labsize(2.5)) ///
				legend(ring(0) pos(2) order(2 1) label(2 "Point Estimate") lab(3 "95*0. CI") size(2.5) rowgap(0.6)) ///
				yline(0, lcolor(black*0.30)) ///
				xtitle("") ///
				ytitle("Estimated Coefficient", size(3)) ///
				title("B", position(11) ring(30) span size(large)) ///
				text(.02 0.5 "OLS", size(3.2)) ///
				scheme(plotplain)				
				
		graph save "$figure/figure4/Figure4_B", replace
		
********************************************************************************
	
	cd "$temp/figure4/"
	openall
	
	keep if reg == 1 | reg == 8
	
	gen x = 15- _n 
	replace x = x + 2 if x >= 8
	
	gen ols = 0
	replace ols = 1 if x <= 7
	gen iv = 0
	replace iv = 1 if x > 7		
	
	label define xlabel   ///
				17 "{it: IV Results} " ///
				16 "{it:Total Effects (Lag 2-13 days)} " ///
				15 "up to lag 1 day " ///
				14 "lag 2-5 days " ///
				13 "lag 6-9 days " ///
				12 "lag 10-13 days " ///
				11 "lag 14-17 days " ///
				10 "lag 18-21 days" ///
				8 "{it: OLS Results} " ///
				7 "{it:Total Effects (Lag 2-13 days)} " ///
				6 "up to lag 1 day " ///
				5 "lag 2-5 days " ///
				4 "lag 6-9 days " ///
				3 "lag 10-13 days " ///
				2 "lag 14-17 days " ///
				1 "lag 18-21 days" ///
				
			label values x xlabel	
	
	graph twoway (rspike min95 max95 x, horizontal lwidth(med) lcolor(black)) ///
			(scatter x estimate, msymbol(X) mcolor(gs6) msize(2)) ///
			, ylabel(1/8 10/17,nogrid valuelabel labsize(2.5)) ///
			yscale(range (0.5 17)) ///
			xlabel(-0.2 (0.2) 0.6, nogrid labsize(2.5)) ///
			xscale(range(-.2 1.2)) ///
			xline(0) ///
			title("C", position(11) ring(30) span size(large)) ///
			ytitle("") ///
			text(16.75 .95 "Coefficient (95*0. CI)", place(c) size(2.5)) ///
			text(16 0.95 ".293 (.087 .500)", place(c) size(2.5)) ///
			text(15 0.95 "-.059 (-.155 .036)", place(c) size(2.5)) ///
			text(14 0.95 ".153 (.061 .245)", place(c) size(2.5)) ///
			text(13 0.95 ".072 (-.025 .170)", place(c) size(2.5)) ///
			text(12 0.95 ".068 (-.040 .175)", place(c) size(2.5)) ///
			text(11 0.95 ".059 (-.092 .211)", place(c) size(2.5)) ///
			text(10 0.95 ".018 (-.139 .174)", place(c) size(2.5)) ///
			text(7 0.95 ".082 (.061 .104)", place(c) size(2.5)) ///
			text(6 0.95 "-.012 (-.027 .003)", place(c) size(2.5)) ///
			text(5 0.95 ".027 (.016 .039)", place(c) size(2.5)) ///
			text(4 0.95 ".027 (.017 .037)", place(c) size(2.5)) ///
			text(3 0.95 ".028 (.019 .037)", place(c) size(2.5)) ///
			text(2 0.95 ".016 (.006 .025)", place(c) size(2.5)) ///
			text(1 0.95 "-.008 (-.019 .003)", place(c) size(2.5)) ///
			yline(9, lwidth(vthin) lcol(gs12) lpattern(shortdash)) ///
			xsize(10) ysize(12) ///
			fxsize(80) fysize(140) ///
			xtitle("") ///
			legend(off) ///
			scheme(plotplain)	
						
		graph save "$figure/figure4/Figure4_C", replace
		
	
********************************************************************************
		
	graph combine "$figure/figure4/Figure4_A" "$figure/figure4/Figure4_B", col(1) imargin(3 3) graphregion(margin(vtiny) fcolor(white) lcolor(white)) iscale(1) fxsize(80) fysize(120)
	graph save "$figure/figure4/Figure4_AB", replace
			
			
	graph combine "$figure/figure4/Figure4_AB" "$figure/figure4/Figure4_C", col(2) xsize(12) ysize(8) imargin(3 3) graphregion(margin(vtiny) fcolor(white) lcolor(white)) iscale(0.7)
	graph save "$figure/figure4/Figure4", replace

	graph export "$figure/figure_png/Figure4.png", replace width(3000)
	graph export "$figure/figure_eps/Figure4.eps", replace
	graph export "$figure/figure_pdf/Figure4.pdf", replace
