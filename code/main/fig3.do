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
		
	*distribution
	
	use "$data/master_china.dta",replace
	
		drop if city_code == 4201
		drop if aqi == .
		
	egen cat = cut(it), at(0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2. 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5, 5.25, 5.5, 5.75, 6, 6.25, 100)
	
				
		collapse (count) it, by(cat)
		drop if cat == .
			
		save "$temp/figure3/distribution.dta", replace

	
	* first stage regression 	
	
	use "$data/master_china.dta",replace
	gen city_code = city_code2010*100


	merge m:1 city_code date using "$data/processed/wind_all.dta"
	drop if _merge == 2
	drop _merge

	merge m:1 city_code year month using "$data/processed/wind_dir.dta"
	drop if _merge == 2
	
	drop if city_code2010 == 4201 /* It was `city_code` here, but city_code variable is not available so I change it to `city_code2010`*/
	drop if aqi == .

	drop city_code
	rename city_code2010 city_code

	generate cat = (it == 0)*1 + ///
			(it > 0 & it <= 0.5)*2 + ///
			(it>0.5 & it <= 1)*3 + ///
			(it>1 & it <= 1.5)*4 + ///
			(it>1.5 & it <= 2)*5 + ///
			(it>2 & it <= 2.5)*6 + ///
			(it>2.5 & it <= 3)*7 + ///
			(it>3 & it <= 3.5)*8 + ///
			(it>3.5 & it <= 4)*9 + ///
			(it>4 & it <= 4.5)*10 + ///
			(it>4.5 & it <= 5)*11 + ///
			(it>5 & it <= 5.5)*12 + ///
			(it>5.5 & it <= 6)*13 + ///
			(it>6)*14
					
	
	local wth = "temp prec snow ave_winds"
	
	reghdfe aqi `wth', absorb(city_code daynum,savefe) residuals(resid)
	reghdfe resid i.cat, noabsorb
	parmest, saving("$temp/figure3/first`i'.dta", replace) idnum(100)
			
	cd $temp/figure3/
	openall 
	
	keep if idnum == 100
	
	cap drop x
	gen x = _n
	drop if estimate == .
	replace cat = (x - 1) * 0.5
	drop it
	drop if parm == "_cons"
	
	merge 1:1 cat using "$temp/figure3/distribution.dta"
		
	graph twoway (bar it cat, lcolor(white) fcolor(blue*0.40) yaxis(2) yscale(range(0 18000) axis(2)) barwidth(0.25)) ///
			(lfit estimate cat, lpattern(dash) yaxis(1) lcolor(gs4)) ///
			(rspike min95 max95 cat, yaxis(1)) ///
			(scatter estimate cat, yscale(alt) yscale(alt axis(2)) msymbol(circle) mcolor(gs4)) ///
			,legend(ring(0) pos(2) order(1 4 3) label(1 "Distribution") lab(4 "Average Residual") lab(3 "95% CI") rowgap(0.8)) ///
			xlabel(0 (2) 7, nogrid) ylabel(, nogrid) ///
			ylabel(-10 0 10 20 29.999999 "      ." 30, nogrid axis(1)) ///
			ylabel(none, nogrid axis(2)) ///
			ytitle("Average Residual in AQI", axis(1)) ///
			title("A", position(11) ring(30) span size(large)) ///
			ytitle("", axis(2)) ///
			xtitle("Temperature Inversion") ///
			scheme(plotplain)
	
	graph save "$figure/figure3/Figure3_A",replace
		
*******************************************************************************
	
	* First Stage

	use "$data/master_china.dta",replace
	gen city_code = city_code2010*100


	merge m:1 city_code date using "$data/processed/wind_all.dta"
	drop if _merge == 2
	drop _merge

	merge m:1 city_code year month using "$data/processed/wind_dir.dta"
	drop if _merge == 2
		
	sort city_code daynum
	xtset city_code daynum
	
	cap erase "$temp/figure3/first.txt"
	cap erase "$temp/figure3/first.xml"
	
	local wth = "temp prec snow ave_winds"
	
	reghdfe aqi it `wth', absorb(city_code daynum) vce(cl city_code)
	outreg2 using "$temp/figure3/first",  excel append nocons e(r2 N_clust) se auto(2) addtext(City FE, Y, Month-by-Day FE, Y, Weather, N)
	esttab using "$temp/figure3/first_F.txt", replace ///
    se ///
	stats(F r2 N_clust, labels("F-statistic" "R-squared" "N_clust")) ///
	varlabels(_all " ") ///
    nonotes

	
	* create ranking for thermal inversion	
	
	* Over time placebo
		
		use "$data/master_china.dta",replace
		gen city_code = city_code2010*100


		merge m:1 city_code date using "$data/processed/wind_all.dta"
		drop if _merge == 2
		drop _merge

		merge m:1 city_code year month using "$data/processed/wind_dir.dta"
		drop if _merge == 2
			
		sort city_code daynum
		xtset city_code daynum
		
		bys city_code: egen rank_it = rank(it), unique
		for num 1/91: gen itX_ = it if rank_it == X
		for num 1/91: egen itX = max(itX_) , by(city_code)
		
		for num 1/91: drop itX_
		drop rank_it
		
		* create 1000 random variables/insert the thermal inversion
		
		forvalues i = 1(1)1000{
			quietly bys city_code: gen num`i' = runiform()
			quietly bys city_code: egen rank`i' = rank(num`i')
			
			quietly gen random`i' = 0
			
			
			forvalues t = 1(1)91{
				quietly replace random`i' = it`t' if rank`i' == `t'
			}
			}
			
			drop num* rank*
		
		* reg air quality on random thermal inversion
		
		
	local wth = "temp prec snow ave_winds"
		
		forvalues i = 1(1)1000{
			quietly reghdfe aqi random`i' `wth', absorb(city_code daynum) vce(cl city_code)
			quietly lincom random`i'
			quietly generate placebo_time`i' = r(estimate) 
		}
			
		* keep estimate
		
		keep placebo_time*
		
		gen sample = _n
		keep if sample == 1
		
		reshape long placebo_time, i(sample) j(x)
		drop sample 
		save "$temp/figure3/placebo_time.dta", replace
		
		
	* cross sectional placebo
		
		use "$data/master_china.dta",replace
		gen city_code = city_code2010*100


		merge m:1 city_code date using "$data/processed/wind_all.dta"
		drop if _merge == 2
		drop _merge

		merge m:1 city_code year month using "$data/processed/wind_dir.dta"
		drop if _merge == 2
			
		sort daynum city_code
		
		bys daynum: egen rank_it = rank(it), unique
		quietly for num 1/320: gen itX_ = it if rank_it == X
		quietly for num 1/320: egen itX = max(itX_) , by(daynum)
		
		quietly for num 1/320: drop itX_
		drop rank_it
		
		* create 1000 random variables/insert the thermal inversion
		
		forvalues i = 1(1)1000{
			quietly bys daynum: gen num`i' = runiform()
			quietly bys daynum: egen rank`i' = rank(num`i')
			
			quietly gen random`i' = 0
			
			
			forvalues t = 1(1)320{
				quietly replace random`i' = it`t' if rank`i' == `t'
			}
			}
			
			drop num* rank*
		
		* reg air quality on random thermal inversion
		
	local wth = "temp prec snow ave_winds"
		
		forvalues i = 1(1)1000{
			quietly reghdfe aqi random`i' `wth', absorb(city_code daynum) vce(cl city_code)
			quietly lincom random`i'
			quietly generate placebo_space`i' = r(estimate) 
		}
			
		* keep estimate
		
		keep placebo_space*
		
		gen sample = _n
		keep if sample == 1
		
		reshape long placebo_space, i(sample) j(x)
		drop sample 
		save "$temp/figure3/placebo_space.dta", replace
	
	* create graph
	
		foreach v in time space {
		
		use "$temp/figure3/placebo_`v'.dta", clear
				
			gen cat = 0
			
			foreach i of numlist 1(1)40{
			replace cat = `i' if placebo_`v' > (0.05*`i'-1.05) & placebo_`v' <= (0.05*`i'-1.0) 
			}
			
			collapse (count) placebo_`v', by(cat)
		
		save "$temp/figure3/placebo_`v'_count.dta", replace
		}
		*
		
		clear all
		local new = _N + 540
        set obs `new'
		gen cat = _n
						
		merge 1:1 cat using "$temp/figure3/placebo_time_count.dta"
		drop _merge
		merge 1:1 cat using "$temp/figure3/placebo_space_count.dta"
		drop _merge
		
		replace cat = (cat/20) - 1
		replace	placebo_time = placebo_time / 1000
		replace	placebo_space = placebo_space / 1000
		
		drop if cat > 4
		
		count
		local plus1 = r(N) + 1
		set obs `plus1'
		
		replace cat = 2.83 if cat == .
		gen bottom = 0
		gen top = 0.12
		
		sort cat
		
		graph twoway (bar placebo_time cat, fcolor(orange%60) barwidth(0.05) lcolor(white) lwidth(vthin)) ///
			(bar placebo_space cat, fcolor(blue%40) barwidth(0.05) lcolor(white) lwidth(vthin)) ///
			(rspike bottom top cat if cat >2.82 & cat < 2.84, vertical yaxis(1) lcolor(red*1.2) lwidth(medthick) lpattern(shortdash)) ///
			,xlabel(-1 (0.5) 4, nogrid) ///
			ylabel(0 .05 .1 .15  .149999 "      .", nogrid) ///
			legend(ring(0) pos(11) order(1 2) label(1 "Randomized Over Time") lab(2 "Randomized Over Space") rowgap(0.8)) ///
			text(0.132 2.83 "Coefficient" "in True Sample" "2.83 (95*0.CI: 2.01-3.65)", place(c) size(2.5) color(black) linegap(0.8)) ///
			xtitle("Estimated Coefficients") ///
			ytitle("Share of Estimates") ///
			title("B", position(11) ring(30) span size(large)) ///
			scheme(plotplain)
				
		graph save "$figure/figure3/Figure3_B", replace
				
		
** First Stage *****************************************************************
	
	graph combine "$figure/figure3/Figure3_A" "$figure/figure3/Figure3_B", col(2) xsize(12) ysize(4) imargin(3 3) graphregion(margin(vtiny) fcolor(white) lcolor(white)) iscale(1)
			
	graph save "$figure/figure3/Figure3",replace
	graph export "$figure/figure_png/Figure3.png", replace width(3000)
	graph export "$figure/figure_eps/Figure3.eps", replace
	graph export "$figure/figure_pdf/Figure3.pdf", replace
