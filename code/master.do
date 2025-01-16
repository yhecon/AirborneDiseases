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
	* Replicating all the process for the publication


********************************************************************************
	
	* main
	* figures
		
		do "$dir\code\main\fig2.do"
		do "$dir\code\main\fig3.do"
		do "$dir\code\main\fig4.do"
		do "$dir\code\main\fig5.do"
		do "$dir\code\main\fig6.do"
		do "$dir\code\main\fig7.do"
		
	
********************************************************************************
	
	* appendix
	* appendix figures
		
		do "$dir\code\appendix\figA1.do"
		do "$dir\code\appendix\figA2.do"
		do "$dir\code\appendix\figA3.do"
		do "$dir\code\appendix\figA4.do"
		do "$dir\code\appendix\figA5.do"
		do "$dir\code\appendix\figA6.do"
		
	* appendix tables
		
		do "$dir\code\appendix\TableA2.do"
		do "$dir\code\appendix\TableA4.do"
		do "$dir\code\appendix\TableA5.do"
		do "$dir\code\appendix\TableA6.do"

		
		
		
		
		
		
		
		
		
