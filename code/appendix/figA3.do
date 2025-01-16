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

	import excel "$temp/figureA3/OLS_IV.xlsx", clear cellrange(B5 :K22) firstrow
	
	
	foreach i in main min max {
		replace `i' = `i' *100
		}
	
	
	drop if IV == "dust"

	gen x = 17 - _n
							
	graph twoway (bar main x if method == "OLS" & x >= 9, horizontal barwidth(0.8) color(blue*0.20) lcolor(blue*0.2)) ///
				(rcap min max x if method == "OLS" & x >= 9, horizontal lcol(blue*0.40)) ///
				(bar main x if method == "IV" & x >= 9, horizontal barwidth(0.8) color(blue*0.60) lcolor(blue*0.6)) ///
				(rcap min max x if method == "IV" & x >= 9, horizontal lcolor(blue*0.30)) /// 
				(bar main x if method == "OLS" & x < 9, horizontal barwidth(0.8) color(red*0.20) lcolor(red*0.2)) ///
				(rcap min max x if method == "OLS" & x < 9, horizontal lcol(red*0.30)) ///
				(bar main x if method == "IV" & x < 9, horizontal barwidth(0.8) color(red*0.60) lcolor(red*0.6)) ///
				(rcap min max x if method == "IV" & x < 9, horizontal lcolor(red*0.30)) ///
				,legend(order(1 3 5 7) label(1 "Adult Mortality, OLS") label(3 "IV (*)") label(5 "Infant Mortality, OLS")  label(7 "IV (*)")  row(2) col(2) ring(0) pos(10) colgap(1) size(2.5)) ///
				xlabel(0 "0" 20 "20" 40 "40" 60 "60" 80 "80",nogrid) ///
				xscale(range(-10 140)) ///
				ylabel(0.5 " " 1.5 "Knittel et al. (2016) " 3.5 "Sam Heft-Neal et al. (2020) " 5.5 "Arcelo et al. (2016) " 7.5  "Chay and Greenstone (2003) " 9.5 "Deschenes et al. (2017) " 11.5 "Cheung et al. (2020) " 13.5 "He et al. (2020) " 15.5  "Deryugina et al. (2019) " , nogrid) ///
				yscale(range(0.5 19.5)) ///
				xtitle("") ///
				ytitle("") ///
				scheme(plotplain) ///
				title("Percentage increase in mortality rate per 10 unit increase in pollutants", position(6) ring(30) span size(2.5)) ///
				text(18.2 115 "Pollutants, IV", place(c) size(2.5)) ///
				text(17.6 115 "(Country)", place(c) size(2.5)) ///
				text(15.8 115 "PM2.5, Wind and Emission", place(c) size(2.5)) ///
				text(15.2 115 "(U.S.)", place(c) size(2.5)) ///
				text(13.8 115 "PM2.5, Agricultural Burning", place(c) size(2.5)) ///
				text(13.2 115 "(China)", place(c) size(2.5)) ///
				text(11.8 115 "API, Wind and Emissionn", place(c) size(2.5)) ///
				text(11.2 115 "(Hong Kong)", place(c) size(2.5)) ///
				text(9.8 115 "NOx, Environmental Regulation", place(c) size(2.5)) ///	
				text(9.2 115 "(U.S)", place(c) size(2.5)) ///
				text(7.8 115 "TSP, Recession", place(c) size(2.5)) ///
				text(7.2 115 "(U.S)", place(c) size(2.5)) ///
				text(5.8 115 "PM10, Thermal Inversion", place(c) size(2.5)) ///
				text(5.2 115 "(Mexico)", place(c) size(2.5)) ///
				text(3.8 115 "PM2.5, Rainfall", place(c) size(2.5)) ///
				text(3.2 115 "(African Countries)", place(c) size(2.5)) ///
				text(1.8 115 "PM10, Traffic Volume", place(c) size(2.5)) ///	
				text(1.2 115 "(U.S)", place(c) size(2.5)) ///	
				text(1.2 38 "*", place(c) size(3.5) color(red*0.50)) ///
				text(3.2 27 "*", place(c) size(3.5) color(red*0.50)) ///
				text(5.2 8 "*", place(c) size(3.5) color(red*0.50)) ///
				text(7.2 5 "*", place(c) size(3.5) color(red*0.50)) ///
				text(9.2 16 "*", place(c) size(3.5) color(blue*0.50)) ///
				text(11.2 10 "*", place(c) size(3.5) color(blue*0.50)) ///
				text(13.2 5.5 "*", place(c) size(3.5) color(blue*0.50)) ///
				text(15.2 4 "*", place(c) size(3.5) color(blue*0.50)) 
					
		graph save "$appendix_figure/figureA3/FigureA3",replace
		graph export "$appendix_figure/figureA_png/FigureA3.png", replace width(3000)
		graph export "$appendix_figure/figureA_eps/FigureA3.eps", replace
		graph export "$appendix_figure/figureA_pdf/FigureA3.pdf", replace
