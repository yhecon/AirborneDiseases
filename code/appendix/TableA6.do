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

use "$data/master_japan", replace

replace gflu = gflu * 100

xtset pref_id time
drop if year == 2009

**** table delete
cap erase "$appendix_table/TableA6.txt"
cap erase "$appendix_table/TableA6.xls"

**** OLS
xtset pref_id time

foreach pollute in spm {
	
	reghdfe gflu `pollute' temp prec wind, absorb(i.pref_id#i.week i.pref_id#i.year i.time) cluster(pref_id week)
	lincom `pollute'
	outreg2 using "$appendix_table/TableA6.xls", nocons excel keep(`pollute') auto(2) label addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	
	reghdfe gflu f.`pollute' `pollute' temp prec wind, absorb(i.pref_id i.time) cluster(pref_id week)
	lincom `pollute'
	outreg2 using "$appendix_table/TableA6.xls", nocons excel keep(`pollute') auto(2) label addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	
	reghdfe gflu `pollute' temp prec wind if week <= 18 | week >= 45, absorb(i.pref_id i.time) cluster(pref_id week)
	lincom `pollute'
	outreg2 using "$appendix_table/TableA6.xls", nocons excel keep(`pollute') auto(2) label addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	
}

**** IV second stage
xtset pref_id time
* Full sample
foreach pollute in spm {
foreach iv in invs_mean {
	
	ivreghdfe gflu (`pollute' = `iv') temp prec wind, absorb(i.pref_id#i.week i.pref_id#i.year i.time) cluster(pref_id)
	local F = e(cdf)
	outreg2 using "$appendix_table/TableA6.xls", nocons excel keep(`pollute') auto(2) label addstat(F-stat, `F') addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	
	ivreghdfe gflu f.`pollute' (`pollute' = `iv') temp prec wind, absorb(i.pref_id i.time) cluster(pref_id)
	local F = e(cdf)
	outreg2 using "$appendix_table/TableA6.xls", nocons excel keep(`pollute') auto(2) label addstat(F-stat, `F') addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
	
	ivreghdfe gflu (`pollute' = `iv') temp prec wind if week <= 18 | week >= 45, absorb(i.pref_id i.time) cluster(pref_id)
	local F = e(cdf)
	outreg2 using "$appendix_table/TableA6.xls", nocons excel keep(`pollute') auto(2) label addstat(F-stat, `F') addtext(Control climate, "Yes", Prefecture FE, "Yes", Year-by-Week FE, "Yes")
		
   		
}
} 

