/* Analysis on LAPD and LAFD
Christine Lee, Marine Lin, Sangjun Han
December 22, 2017
*/


cd "/Users/eggis/Documents/UCLA/201709 Fall/STAT 130/Project"
import delimited "Payroll.csv",clear
gsort-year
keep if (departmenttitle=="Fire (LAFD)"|departmenttitle=="Police (LAPD)")
keep if (jobclasstitle=="Firefighter I" |jobclasstitle=="Firefighter II" |jobclasstitle=="Firefighter III" |jobclasstitle=="Police Officer II"|jobclasstitle=="Police Officer I"|jobclasstitle=="Police Officer III")
keep if year == 2015
keep year departmenttitle jobclasstitle paygrade overtime hourlyoreventrate base
sort departmenttitle jobclasstitle

save "Payrollfinal.dta", replace
destring projectedannualsalary, gen(annual) ignore("$")
destring basepay, gen(newbasepay) ignore("$")
destring overtime, gen(newovertime) ignore("$")
destring hourlyoreventrate, gen(newhourlyoreventrate) ignore("$")
label variable annual "Annual Salary"

save "P.dta", replace
/*Descriptive of Statistics*/


use "P.dta",clear
keep if departmenttitle=="Police (LAPD)"
summarize annual
graph box annual, over(jobclasstitle)
ylabel(,angle(0));
summarize annual
#delimit cr


use "P.dta",clear
keep if departmenttitle=="Fire (LAFD)"
summarize annual
graph box annual, over(jobclasstitle)
title("annual wage for different job classes in LAFD")
ylabel(,angle(0));
#delimit cr

/*Regression Analysis*/
use "P.dta",clear
correlate annual newovertime newhourlyoreventrate newbasepay
graph matrix annual newovertime newhourlyoreventrate newbasepay, half
regress annual newovertime newhourly



/*Anova*/
use "P.dta",clear
anova annual  

/*To compare the means of annual payment for different paygrade*/
use "P.dta",clear
keep if 
tabulate jobclasstitle, summarize(annual)


tabulate jobclasstitle departmenttitle, chi2 expected
