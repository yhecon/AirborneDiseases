Data and Code for “Air Pollution and the Airborne Diseases: Evidence from China and Japan”

Replication Folders: 
The replication files include 6 folders. "code," "data," "temp," "figure," "appendix_figure," and "appendix_table." The "code" folder includes all the codes necessary for replications. The "data" folder includes all the cleaned data for analysis. The figures and tables in the paper can be produced in the "figure," "appendix_figure," and "appendix_table" when we run the codes to replicate them. The "temp" folder includes intermediate data sets that are necessary to replicate the outputs.

Setup: 
Programming language: The codes are written in STATA and the authors used STATA 16-18 for all the analyses. You will need STATA license to replicate all the files.

Repository: First, set your repository in the 
- “$dir/code/config.do"

Master code: Run the following code. The code will automatically execute all the processes needed for replication
- “$dir/code/master.do"

Data and variable: 
1.For Air Pollution and COVID-19 in China: 
The "$dir/data/master_china.dta" is used. Variables are listed in Table 1
2.Air Pollution and Influenza hospital visits in Japan: 
The "$dir/data/master_japan.dta" is used. Variables are listed in Table 2. 

Codes: 
1.Figures and Tables: 
These codes produce main figures and tables 
Figures
	- "$dir/code/main/fig2.do"
	- "$dir/code/main/fig3.do"
	- "$dir/code/main/fig4.do"
	- "$dir/code/main/fig5.do"
	- "$dir/code/main/fig6.do"
	- "$dir/code/main/fig7.do"

2.Appendix: 
These codes produce Appendix figures and tables 
Appendix Figures
	- "$dir/code/main/figA1.do"
	- "$dir/code/main/figA2.do"
	- "$dir/code/main/figA3.do"
	- "$dir/code/main/figA4.do"
	- "$dir/code/main/figA5.do"
	- "$dir/code/main/figA6.do"

	Appendix Tables
	- "$dir/code/main/TableA2.do"
	- "$dir/code/main/TableA4.do"
	- "$dir/code/main/TableA5.do"
	- "$dir/code/main/TableA6.do"



