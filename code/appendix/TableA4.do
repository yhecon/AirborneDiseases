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

**** Descriptive Stats

local pollution = "spm pm so2 no2 co ox"
local disease = "flu gflu"
local weather = "temp prec wind"
local iv = "invs_mean"

format `disease' `pollution' `iv' `weather' %9.2g
sum  `disease' `pollution' `iv' `weather', format

