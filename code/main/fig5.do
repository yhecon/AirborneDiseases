*==============================================================================* 
* Project: COVID and Air Pollution					    			           *   
* Date:   2020 Mar                                                             *
* Author: Guojun, Yuhang, Tanaka                                               *    
*==============================================================================* 

* set directories
* change to standard: 50, 100, 150, 200
clear all
set maxvar  30000
set matsize 11000 
set more off
cap log close

********************************************************************************

	use "$data/master_china.dta", clear

	*drop Wuhan
		drop if city_code2010 == 4201

		preserve
			gen b_sky = (aqi<=100) & aqi !=.
			collapse (mean) gcur aqi   (sum) case new_death new_cure cur b_sky, by(daynum)
			tset daynum
			gen rr_day = (new_death+new_cure)/l.cur
			keep daynum gcur aqi case new_death new_cure cur rr_day b_sky
			save "$temp/figure5/cur_simu_real.dta", replace
		restore

		foreach outcome of var gcur {
			replace `outcome' =. if daynum <=8423
		}
	*
		keep gcur case cur aqi city_code2010 daynum date  

		foreach standard in "50" "100" "150" "200" {

		preserve	
		sort city_code daynum
		xtset city_code daynum

	* days since outbreak with 10 cases
		gen dso = (case>9)
		bys city_code2010 : gen sum_dso = sum(dso)
		gen initial = cur if sum_dso==1
	
	*replace gcur =. if sum_dso ==1

	* last 2-13 days aqi
		forvalues i = 2(1)13{
			gen aqi_l`i' = L`i'.aqi
		}
	*
		forvalues i = 2(1)13{
			gen diff_aqi_l`i' = aqi_l`i' - `standard' if aqi_l`i' >= `standard'
			replace diff_aqi_l`i' = 0 if aqi_l`i' < `standard'
		}
	*

	* impact calculation
		gen impact2 = diff_aqi_l2*.0282376
		gen impact3 = diff_aqi_l3*.0422651
		gen impact4 = diff_aqi_l4*.0439272
		gen impact5 = diff_aqi_l5*.0375481
		gen impact6 = diff_aqi_l6*.0274522
		gen impact7 = diff_aqi_l7*.017964
		gen impact8 = diff_aqi_l8*.0124903
		gen impact9 = diff_aqi_l9*.0107687
		gen impact10 = diff_aqi_l10*.0116196
		gen impact11 = diff_aqi_l11*.0138631
		gen impact12 = diff_aqi_l12*.0163195
		gen impact13 = diff_aqi_l13*0.0178091

		egen total_impacts = rowtotal(impact2-impact13)
		replace total_impacts=0 if l.cur ==0
		replace total_impacts =. if daynum < 8423
		replace total_impacts =. if gcur ==.

	/* average impacts */
		sum total_impacts

		gen new_gcur = gcur - total_impacts
		gen per_gcur_new = exp(new_gcur/100)
		
		drop diff_aqi*
		drop impact2-impact13
		drop aqi_l2-aqi_l13


	* first day
		gen ini_1 = (1+l.initial)*per_gcur_new-1

		forvalues i = 2(1)91{
		local m = `i'-1
			gen ini_`i' = (1+l.ini_`m')*per_gcur_new-1
			replace ini_`i'=0 if ini_`i'<0
		}
	*
		gen p_case =.
		forvalues i = 1(1)91{
			replace p_case = ini_`i' if p_case ==.
		}
	*
		replace p_case = cur if p_case ==.
		drop ini_*

			collapse (mean) new_gcur (sum) p_case, by(daynum)
			rename new_gcur p_gcur_rate_`standard'
			rename p_case p_gcur_case_`standard'
			save "$temp/figure5/cur_simu_`standard'.dta", replace

		restore
		}

********************************************************************************

	use "$data/master_china.dta", clear
	
	*drop Wuhan
		drop if city_code2010 == 4201

		foreach outcome of var gcur {
			replace `outcome' =. if daynum <=8423
		}
	*
		keep gcur case cur aqi city_code2010 daynum date  


		foreach standard in "5" "10" "20" "30" "50" {
		preserve
		sort city_code daynum
		xtset city_code daynum

		foreach outcome of var gcur {
			replace `outcome' =. if daynum <=8423
		}
	*

	* days since outbreak
		gen dso = (case>9)
		bys city_code2010 : gen sum_dso = sum(dso)
		gen initial = cur if sum_dso==1
	*replace gcur =. if sum_dso ==1

	* last 2-13 days aqi
		forvalues i = 2(1)13{
			gen aqi_l`i' = L`i'.aqi
		}
	*
		forvalues i = 2(1)13{
			gen diff_aqi_l`i' = aqi_l`i' * `standard' * 0.01
		}
	*

	* impact calculation
		gen impact2 = diff_aqi_l2*.0282376
		gen impact3 = diff_aqi_l3*.0422651
		gen impact4 = diff_aqi_l4*.0439272
		gen impact5 = diff_aqi_l5*.0375481
		gen impact6 = diff_aqi_l6*.0274522
		gen impact7 = diff_aqi_l7*.017964
		gen impact8 = diff_aqi_l8*.0124903
		gen impact9 = diff_aqi_l9*.0107687
		gen impact10 = diff_aqi_l10*.0116196
		gen impact11 = diff_aqi_l11*.0138631
		gen impact12 = diff_aqi_l12*.0163195
		gen impact13 = diff_aqi_l13*0.0178091


		egen total_impacts = rowtotal(impact2-impact13)
		replace total_impacts=0 if l.cur ==0
		replace total_impacts =. if daynum < 8423
		replace total_impacts =. if gcur ==.

	/* average impacts */
		sum total_impacts

		gen new_gcur = gcur - total_impacts
		gen per_gcur_new = exp(new_gcur/100)

		drop diff_aqi*
		drop impact2-impact13
		drop aqi_l2-aqi_l13


	* first day
		gen ini_1 = (1+l.initial)*per_gcur_new-1

		forvalues i = 2(1)91{
		local m = `i'-1
			gen ini_`i' = (1+l.ini_`m')*per_gcur_new-1
			replace ini_`i'=0 if ini_`i'<0
		}
	*

		gen p_case =.
		forvalues i = 1(1)91{
			replace p_case = ini_`i' if p_case ==.
		}
		*
		drop ini_*
		replace p_case = cur if p_case ==.
			collapse (mean) new_gcur (sum) p_case cur, by(daynum)
			rename new_gcur p_gcur_rate_`standard'p
			rename p_case p_gcur_case_`standard'p
			save "$temp/figure5/cur_simu_`standard'p.dta", replace



		restore
		}




	clear
	* combine dataset
	clear
	use "$temp/figure5/cur_simu_real.dta" ,replace
	gen real_rate = exp(gcur/100)
	replace real_rate =. if gcur==0

	merge 1:1 daynum using "$temp/figure5/cur_simu_5p.dta"
	drop _merge
	rename cur real_cur
	rename (p_gcur_case_5p p_gcur_rate_5p)  (cur_5p rate_5p)


	foreach u in "10" "20" "30" "50"{ 
	merge 1:1 daynum using "$temp/figure5/cur_simu_`u'p.dta"
	drop _merge
	drop cur
	rename (p_gcur_case_`u'p p_gcur_rate_`u'p) (cur_`u'p rate_`u'p)
	}
	*

	merge 1:1 daynum using "$temp/figure5/cur_simu_50.dta"
	drop _merge
	rename (p_gcur_case_50 p_gcur_rate_50) (cur_50 rate_50)

	foreach u in "100" "150" "200"{
	merge 1:1 daynum using "$temp/figure5/cur_simu_`u'.dta"
	drop _merge
	rename (p_gcur_case_`u' p_gcur_rate_`u') (cur_`u' rate_`u')
	}

	foreach u of var real_cur cur_5p cur_10p cur_20p cur_30p cur_50p cur_50 cur_100 cur_150 cur_200{
		replace `u' = 354 if daynum == 8424
	}
	*

	foreach u of var real_rate rate_5p rate_10p rate_20p rate_30p rate_50p rate_50 rate_100 rate_150 rate_200{
		replace `u' = `u'-1
	}
	*
	order  daynum gcur real_rate real_cur

	save "$temp/figure5/boe.dta", replace

	clear
	use "$temp/figure5/boe.dta", clear


	* graph - A: growth rate
	replace gcur=. if daynum < 8424		
	gen diff_100 = gcur-rate_100
	replace b_sky = b_sky/329*100
	replace b_sky = b_sky-10
	graph twoway (connected gcur daynum, mcolor(red*0.40) msymbol(circle) lcolor(red*0.20) msize(0.4)) ///
				(connected rate_100 daynum, mcolor(blue*0.40) msymbol(circle) lcolor(blue*0.20) msize(0.4)) ///
				(bar diff_100 daynum, yaxis(2) fcolor(orange*0.40) lcolor(orange*0.5)) ///
				,scheme(plotplain) xtitle("")  ///
				xlabel(8398 " " 8401 "Jan 1" 8423 "Jan 23" 8432 "Feb 1" 8461 "Mar 1" 8492 "Apr 1" 8495 " ", nogrid) ///
				xline(8423, lcolor(gs10) lpattern(shortdash)) ///
				text(30 8410 "Wuhan" "Lockdown", place(e) size(2.5) color(black)) ///
				yline(0, lcolor(gs10) lpattern(shortdash)) ///
				ytitle("Growth Rate of Active Cases (*0.)") ///
				title("A", position(11) ring(30) span size(large)) ///
				ylabel(-20 "-20" 0 "0" 20 "20" 39.999999 "          ." 40 "40",nogrid) ///
				ylabel(1 "1" 3 "3" 5 "5" 7 "7" 6.9999 ".          ", axis(2)) ///
				yscale(range(1 25) axis(2)) ///
				legend(order(1 2) ring(0) pos(2) colgap(0.6) rowgap(0.6) keygap(0.4) label(1 "Average growth rate (Observed)") label(2 "Average growth rate (''Blue Sky'' Scenario)")) ///
				text(-15 8465 "Change in growth rate (%)", place(e) size(2.5) color(black)) ///
				ytitle("", axis(2)) 
	graph save "$figure/figure5/Figure5_A",replace


	* graph - B: active cases
	gen diff_100cur = real_cur-cur_100
	gen diff_100per = (real_cur-cur_100)*100/real_cur
	graph twoway (connected real_cur daynum if daynum > 8423, mcolor(red*0.40) msymbol(circle) lcolor(red*0.20) msize(0.4)) ///
				(connected cur_100 daynum if daynum > 8423, mcolor(blue*0.40) msymbol(circle) lcolor(blue*0.20) msize(0.4)) ///
				(bar diff_100cur daynum if daynum > 8423, yaxis(2) fcolor(orange*0.40) lcolor(orange*0.5)) ///
				,scheme(plotplain) xtitle("")  ///
				xlabel(8398 " " 8401 "Jan 1" 8423 "Jan 23" 8432 "Feb 1" 8461 "Mar 1" 8492 "Apr 1" 8495 " ", nogrid) ///
				xline(8423, lcolor(gs10) lpattern(shortdash)) ///
				text(23000 8410 "Wuhan" "Lockdown", place(e) size(2.5) color(black)) ///
				yline(0, lcolor(gs10) lpattern(shortdash)) ///
				ytitle("Active Cases") ///
				title("B", position(11) ring(30) span size(large)) ///
				ylabel(0 10000 20000 30000 29999.9999 "          .", nogrid) ///
				ylabel(0 2000 4000 6000 5999.9999 ".          ", axis(2)) ///
				yscale(range(2000 20000) axis(2)) ///
				legend(order(1 2) ring(0) pos(2) colgap(0.6) rowgap(0.6) keygap(0.4) label(1 "Active cases (Observed)") label(2 "Active cases (''Blue Sky'' Scenario)")) ///
				text(7000 8465 "Change in active cases", place(e) size(2.5) color(black)) ///
				ytitle("", axis(2))
	graph save "$figure/figure5/Figure5_B",replace
				
			
	* confirmed cases

	tset daynum
	gen removed = l.cur_100*rr_day
	gen new = cur_100 - l.cur_100 + removed
	replace new = 0 if new < 0
	gen con_100 = sum(new)
	replace con_100 = case if daynum == 8424

	gen rr= rr_day*100

	graph twoway (connected case daynum if daynum > 8423, mcolor(red*0.40) msymbol(circle) lcolor(red*0.20) msize(0.4)) ///
				(connected con_100 daynum if daynum > 8423, mcolor(blue*0.40) msymbol(circle) lcolor(blue*0.20) msize(0.4)) ///
				(bar rr daynum if daynum > 8423, yaxis(2) fcolor(orange*0.40) lcolor(orange*0.5)) ///
				,scheme(plotplain) xtitle("")  ///
				xlabel(8398 " " 8401 "Jan 1" 8423 "Jan 23" 8432 "Feb 1" 8461 "Mar 1" 8492 "Apr 1" 8495 " ", nogrid) ///
				xline(8423, lcolor(gs10) lpattern(shortdash)) ///
				text(35000 8410 "Wuhan" "Lockdown", place(e) size(2.5) color(black)) ///
				yline(0, lcolor(gs10) lpattern(shortdash)) ///
				ytitle("Confirmed Cases") ///
				title("C", position(11) ring(30) span size(large)) ///
				ylabel(0 10000 20000 30000 40000 39999.9999 "          .", nogrid) ///
				ylabel(0 10 20 19.9999 ".          ", axis(2)) ///
				yscale(range(0 80) axis(2)) ///
				legend(order(1 2) ring(0) pos(2) colgap(0.6) rowgap(0.6) keygap(0.4) label(1 "Confirmed cases (Observed)") label(2 "Confirmed cases (''Blue Sky'' Scenario)")) ///
				text(12000 8470 "Removed Rate (%)", place(e) size(2.5) color(black)) ///
				ytitle("", axis(2)) 
	graph save "$figure/figure5/Figure5_C",replace


	* combine

				
		graph combine "$figure/figure5/Figure5_A" "$figure/figure5/Figure5_B" "$figure/figure5/Figure5_C", col(1) row(3) xsize(12) ysize(24) imargin(0 0 0) graphregion(margin(none) fcolor(white) lcolor(white)) iscale(0.8)
			
				
		graph save "$figure/figure5/Figure5",replace
		graph export "$figure/figure_png/Figure5.png", replace width(3000)
		graph export "$figure/figure_eps/Figure5.eps", replace
		graph export "$figure/figure_pdf/Figure5.pdf", replace
