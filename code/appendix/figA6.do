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
	
	* Death Rate
	
	use "$data/master_china.dta",replace
	drop if city_code == 4201

	* create weekly data
		gen week = daynum - dow(daynum)
		egen startdate = min(daynum), by(week)
		
		collapse (mean) prec snow temp aqi it prov_code (min) day month year startdate (max) case c_cure death, by(city_code week)
		egen wkid = group(week)
	
	* create variable
		
		xtset city_code wkid
		rename c_cure recover
		
		foreach v of varlist case recover death{
			gen n`v' = `v' - l.`v'
			}
				
		gen cur = case-recover-death
		gen gcur = (ln(cur+1) - ln(l.cur+1)) * 100
		
		gen deathrate = ndeath/cur * 100		
		
		sum gcur
		sum deathrate if cur > 0
	
	collapse (max) death, by(city_code)
			
		generate category = (death == 0)*1 + ///
			(death > 0 & death <= 1)*2 + ///
			(death>1 & death <= 2)*3 + ///
			(death>2 & death <= 3)*4 + ///
			(death>3 & death <= 4)*5 + ///
			(death>4 & death <= 5)*6 + ///
			(death>5 & death <= 6)*7 + ///
			(death>6 & death <= 7)*8 + ///
			(death>7 & death <= 8)*9 + ///
			(death>8 & death <= 9)*10 + ///
			(death>9 & death <= 10)*11 + ///
			(death>10 & death <= 15)*12 + ///
			(death>15 & death <= 20)*13 + ///
			(death>20 & death <= 25)*14 + ///
			(death>25 & death <= 30)*15 + ///
			(death>30)*16
				
		collapse (count) death, by(category)
		
		egen sum = sum(death)
		gen share = death/sum
		
		graph twoway bar share category ///
			, fcolor(emidblue) lcolor(none) ///
			xlabel(1 "0"  3 "<=2" 5 "<=4"  7 "<=6"  9 "<=8" 11 "<=10" 13 "<=20" 15 "<=30"  , nogrid labsize(3)) ///
			ylabel( 0 "   0" .2 ".2" .4 ".4" .6 ".6" .8 ".8" , nogrid labsize(3)) ///
			xtitle("Number of Deaths in Each City") ///
			ytitle("Shage of Cities") ///
			title("B", position(11) ring(30) span size(large)) ///
			xscale(extend) ///
			text(0.7 2 "80% of Cities" "Have No Deaths" , place(e) size(3)) ///
			scheme(plotplain)
				
	graph save "$appendix_figure/figureA6_new/FigureA6_B",replace

********************************************************************************
		
	use "$data/master_china.dta",clear
	drop if city_code == 4201
		
	collapse (sum) death, by(daynum)
	
	tsset daynum
	gen ndeath = death - l.death
	
		graph  twoway (area ndeath daynum, fcolor(orange%20) lcolor(orange%5)) ///
			 , xlabel(8398 " " 8401 "Jan 1" 8423 "23" 8432 "Feb 1" 8461 "Mar 1" 8492 "Apr 1" 8495 " ", nogrid) ///
			 ylabel( 0 "   0" 10 "10" 20 "20" 30 "30" 40 "40", nogrid) ///
			 title("A", position(11) ring(30) span size(large)) ///
			 xline(8423) ///
			 legend(order(1) label(1 "Death")  ring(0) pos(2)) ///
			 text(35 8405 "Wuhan" "Lockdown", place(e) size(3) color(black)) ///
			 xtitle("Date") ytitle("COVID-19 Death", axis(1))  ///
			 scheme(plotplain) 

		graph save "$appendix_figure/figureA6_new/FigureA6_A",replace
	
********************************************************************************

		* drate OLS
					
		cd "$temp/figureA6"
		
		openall
		split idstr, p("_")
		keep if parm == "sum" | parm == "aqi" | parm == "L.aqi" | parm == "L2.aqi" | parm == "L3.aqi"
				
		keep if idstr1 == "drate"
		keep if idstr2 == "ols"
			
		gen x = _n
	
		label define xlabel   ///
				0 " " ///
				1 "t" ///
				2 "Lag 1 week" ///
				3 "lag 2 weeks" ///
				4 "lag 3 weeks" ///
				
			label values x xlabel	
			
		graph twoway  (rspike min95 max95 x, msymbol(circle) mcolor(gs6)) ///
				(scatter estimate x, msymbol(circle) mcolor(gs6)) ///
				, ylabel(-0.04 -0.02 0 "   0" 0.02 0.04, nogrid) ///
				yscale(range()) ///
				xlabel(1/4, nogrid valuelabel) ///
				xscale(range(0.5 4.5) extend) ///		
				legend(off) ///
				yline(0) ///
				title("C", position(11) ring(2) span size(4)) ///
				xtitle("Week", size(3.5) place(c)) ///
				ytitle("Estimated Coefficients") ///
				text(0.04 0.75 "OLS", size(4)) ///
				scheme(plotplain)
				
			graph save "$appendix_figure/figureA6_new/FigureA6_C", replace

	
********************************************************************************

		* drate IV
					
		cd "$temp/figureA6"
		
		openall
		split idstr, p("_")
		keep if parm == "sum" | parm == "aqi" | parm == "L.aqi" | parm == "L2.aqi" | parm == "L3.aqi"
				
		keep if idstr1 == "drate"
		keep if idstr2 == "iv"
			
		gen x = _n
	
		label define xlabel   ///
				0 " " ///
				1 "t" ///
				2 "Lag 1 week" ///
				3 "lag 2 weeks" ///
				4 "lag 3 weeks" ///
				
			label values x xlabel	
			
		graph twoway  (rspike min95 max95 x, msymbol(circle) mcolor(gs6)) ///
				(scatter estimate x, msymbol(circle) mcolor(gs6)) ///
				, ylabel(-1 -.5 0 "   0" .5 1, nogrid) ///
				yscale(range()) ///
				xlabel(1/4, nogrid valuelabel) ///
				xscale(range(0.5 4.5) extend) ///		
				legend(off) ///
				yline(0) ///
				title("D", position(11) ring(30) span size(4)) ///
				xtitle("Week", size(3.5) place(c)) ///
				ytitle("Estimated Coefficients") ///
				text(1 0.75 "IV", size(4)) ///
				scheme(plotplain)
				
			graph save "$appendix_figure/figureA6_new/FigureA6_D", replace

********************************************************************************

	graph combine "$appendix_figure/figureA6_new/FigureA6_A" "$appendix_figure/figureA6_new/FigureA6_B" "$appendix_figure/figureA6_new/FigureA6_C" "$appendix_figure/figureA6_new/FigureA6_D", col(2) row(2) xsize(16) ysize(12) imargin(3 3 3 3) graphregion(margin(none) fcolor(white) lcolor(white)) iscale(0.65)
			
	graph save "$appendix_figure/figureA6_new/FigureA6_new",replace
	graph export "$appendix_figure/figureA_png/FigureA6_new.png", replace width(3000)
	graph export "$appendix_figure/figureA_eps/FigureA6_new.eps", replace
	graph export "$appendix_figure/figureA_pdf/FigureA6_new.pdf", replace
