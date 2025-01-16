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

	use "$data/master_china.dta",replace
		
	* Summary of Statistic
	
		drop if city_code == 4201

		local sum_covid = "case c_cure death cur gcur"		
		local sum_aqi = "aqi"
		local sum_wth = "temp prec snow it"
		local sum_aq = "pm pm10 so2 no2 co o3"
		
		format `sum_aqi' `sum_wth' `sum_covid' `sum_aq' %9.3g
		sum `sum_covid' `sum_aqi' `sum_wth' `sum_aq', format
