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

use "$data/master_japan.dta", replace

replace gflu = gflu * 100

xtset pref_id time
drop if year == 2009

**** table delete
cap erase "$appendix_table/TableA5.txt"
cap erase "$appendix_table/TableA5.xls"

**** OLS
xtset pref_id time

foreach pollute in spm {
	reghdfe gflu `pollute' temp prec wind, absorb(i.pref_id i.time) cluster(pref_id week)
	lincom `pollute'
	outreg2 using "$appendix_table/TableA5.xls", nocons excel keep(`pollute') auto(2) label addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	
	/*
	reghdfe gflu `pollute' temp prec wind if week <= 18 | week >= 45, absorb(i.pref_id i.time) cluster(pref_id week)
	lincom `pollute'
	outreg2 using "$outfiles/TT_second_stage.xls", nocons excel keep(`pollute') auto(2) label addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	*/

	reghdfe gflu `pollute' l.`pollute' l2.`pollute' temp prec wind, absorb(i.pref_id i.time) cluster(pref_id week)
	lincom `pollute' + l.`pollute' + l2.`pollute'
	local estimate = r(estimate)
	local se = r(se)
	outreg2 using "$appendix_table/TableA5.xls", nocons excel keep(`pollute' l.`pollute' l2.`pollute') auto(2) label addstat(estimate, `estimate', se, `se') addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	
}

**** IV second stage
xtset pref_id time
* Full sample
foreach pollute in spm {
foreach iv in invs_mean {
	
	ivreghdfe gflu (`pollute' = `iv') temp prec wind, absorb(i.pref_id i.time) cluster(pref_id)
	local F = e(cdf)
	outreg2 using "$appendix_table/TableA5.xls", nocons excel keep(`pollute') auto(2) label addstat(F-stat, `F') addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	/*
	ivreghdfe gflu (`pollute' = `iv') temp prec wind if week <= 18 | week >= 45, absorb(i.pref_id i.time) cluster(pref_id)
	local F = e(cdf)
	outreg2 using "$outfiles/TT_second_stage.xls", nocons excel keep(`pollute') auto(2) label addstat(F-stat, `F') addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	*/
	
	ivreghdfe gflu (`pollute' l.`pollute' l2.`pollute' = `iv' l.`iv' l2.`iv') temp prec wind, absorb(i.pref_id i.time) cluster(pref_id)
	lincom `pollute' + l.`pollute' + l2.`pollute'
	local estimate = r(estimate)
	local se = r(se)
	local F = e(cdf)
	outreg2 using "$appendix_table/TableA5.xls", nocons excel keep(`pollute' l.`pollute' l2.`pollute') auto(2) label addstat(F-stat, `F', estimate, `estimate', se, `se') addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
   		
}
} 

