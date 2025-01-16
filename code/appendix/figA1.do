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

	use "$temp/figureA1/by_day_estimate_matrixs.dta", clear
	
	keep if reg == 2
	gen x = _n - 1
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(ring(0) pos(4) order(2 1) label(2 "Point Estimate") lab(3 "95% CI") size(2.5) rowgap(0.6)) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("A", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "Add Policy Control", size(3.2) place(e)) ///
				scheme(plotplain)
	
		graph save "$appendix_figure/figureA1/FigureA1_A", replace
		
	
********************************************************************************

	use "$temp/figureA1/by_day_estimate_matrixs.dta", clear
	
	keep if reg == 4
	gen x = _n - 1
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("B", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "Add Policy Control" "+ Days Since Outbreak", size(3.2) place(e)) ///
				scheme(plotplain)	
		
		graph save "$appendix_figure/figureA1/FigureA1_B", replace
	
********************************************************************************

	use "$temp/figureA1/by_day_estimate_matrixs.dta", clear
	
	keep if reg == 9
	gen x = _n - 1
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("C", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "Include Wuhan", size(3.2) place(e)) ///
				scheme(plotplain)	
		
		graph save "$appendix_figure/figureA1/FigureA1_C", replace
				
********************************************************************************

	use "$temp/figureA1/by_day_estimate_matrixs.dta", clear
	
	keep if reg == 16
	gen x = _n - 1
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("D", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "z=2 for segments" "for FDLM", size(3.2) place(e)) ///
				scheme(plotplain)
			
		graph save "$appendix_figure/figureA1/FigureA1_D", replace
				
********************************************************************************

	use "$temp/figureA1/by_day_estimate_matrixs.dta", clear
	
	keep if reg == 17
	gen x = _n - 1
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("E", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "z=4 for segments" "for FDLM", size(3.2) place(e)) ///
				scheme(plotplain)
	
		
		graph save "$appendix_figure/figureA1/FigureA1_E", replace
		
********************************************************************************
/* nouse files 
clear
	use "$figure/figA4/by_day_estimate_matrixs_1228.dta", clear
	
	keep if reg == 6 | reg == 7 | reg == 8

		
	graph twoway (rarea max95 min95 days if reg == 6, fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate days if reg == 6, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel( -1.5 " " -1 "t+1~t+3" 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("F", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "Add 3 days Leads", size(3.2) place(e)) ///
				scheme(plotplain)	
				
		graph save "$appendix_figure/figA4/figA4_F_1228", replace

	graph twoway (connected estimate days if reg == 6, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				(connected estimate days if reg == 7, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				(connected estimate days if reg == 8, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel( -3.5 " " -3 "t+7~t+9" -2 "t+4~t+6" -1 "t+1~t+3" 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("F", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "Add 3 days Leads", size(3.2) place(e)) ///
				scheme(plotplain)
				
	***** Old - original one by TT with old results
	use "$figure/figA4/by_day_estimate_matrixs.dta", clear
	
	keep if reg == 6
	gen x = _n - 4
	drop if x < 0
		
	graph twoway (rarea max95 min95 x, fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate x, msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-0.5 " " 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("F", position(11) ring(30) span size(large)) ///
				text(.125 0.5 "Add 3 days Leads", size(3.2) place(e)) ///
				scheme(plotplain)	
				
		graph save "$appendix_figure/figA4/figA4_F", replace
*/

* do it for both IV or OLS
	clear			
	use "$temp/figureA1/gcur_aqi_cleads.dta", clear
	gen days = _n
	replace days = days - 4
		
	graph twoway (rarea max95 min95 days , fcolor(black*0.15)  lcolor(gray*0.15)) ///
				(connected estimate days , msymbol(circle) lpattern(solid) lwidth(med) mcolor(blue*1) lcolor(blue*0.6) msize(0.75)) ///
				,xlabel(-3.5 " " -3 "+3" -2 "+2" -1 "+1" 0 "t"  3 "t-3" 6 " t-6" 9 "t-9" 12 "t-12" 15 "t-15" 18 "t-18" 21 "t-21" 21.5 " ", nogrid labsize(2.5))  ///
				ylabel(-.15 "-.15" -.1 "-.1" -.05 "-.05" 0 "0" .0499999 "     ." .05 ".05" .1 ".1" .125 " ", nogrid labsize(2.5)) ///
				legend(off) ///
				yline(0, lcolor(black%30)) ///
				xtitle("") ///
				ytitle("") ///
				title("F", position(11) ring(30) span size(large)) ///
				text(.125 -2 "Add 3 days Leads", size(3) place(e)) ///
				scheme(plotplain)	
				
		graph save "$appendix_figure/figureA1/FigureA1_F", replace
				
	

********************************************************************************
			
	graph combine "$appendix_figure/figureA1/FigureA1_A" "$appendix_figure/figureA1/FigureA1_B" "$appendix_figure/figureA1/FigureA1_C" "$appendix_figure/figureA1/FigureA1_D" "$appendix_figure/figureA1/FigureA1_E" "$appendix_figure/figureA1/FigureA1_F", col(3) row(2) imargin(3 3 3 3 3 3) xsize(20) ysize(10) graphregion(margin(vtiny) fcolor(white) lcolor(white)) iscale(0.7)
			
		graph save "$appendix_figure/figureA1/FigureA1",replace
		graph export "$appendix_figure/figureA_png/FigureA1.png", replace width(3000)
		graph export "$appendix_figure/figureA_eps/FigureA1.eps", replace
		graph export "$appendix_figure/figureA_pdf/FigureA1.pdf", replace
