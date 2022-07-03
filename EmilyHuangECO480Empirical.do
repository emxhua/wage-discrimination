//Emily Huang - 50285021
//Joanne Song Mclaughlin
//ECO480 - Empirical Project : Unbalanced Panel Data
//May 12, 2021

//Makes it so that it runs a fresh code
clear all

//Tells the code where to source the documents from
cd "C:\Users\Emilyemlz\Documents\College\tuJunior Spring\ECO 480 - Econometrics\Stata\EmpiricalProject"

set more off

//close existing log files running in the background
capture log close

//command to start a log file
log using EmilyHuangECO480Empirical.log, replace

use ecls_5th_grade, clear

//F Test
regress family_income reading_test
regress family_income reading_test school_type
display  (2.5068 - 2.5780)/ 2

regress family_income math_test
regress family_income math_test school_type
display (2.5140 - 2.6035) / 2

regress family_income science_test
regress family_income science_test school_type
display  (2.5115 - 2.5926) / 2

//T Test
ttest reading_test, by(problem_crowding)
ttest math_test, by(problem_crowding)
ttest science_test, by(problem_crowding)

ttest reading_test, by(problem_gangs)
ttest math_test, by(problem_gangs)
ttest science_test, by(problem_gangs)


//reading

regress family_income reading_test, robust
regress family_income reading_test region, robust
regress family_income reading_test region bmi, robust
regress family_income reading_test region bmi mom_educ, robust
regress family_income reading_test region bmi mom_educ school_type, robust
regress family_income reading_test region bmi mom_educ school_type problem_crowding, robust
regress family_income reading_test region bmi mom_educ school_type problem_crowding problem_gangs, robust

//math

regress family_income math_test, robust
regress family_income math_test region, robust
regress family_income math_test region bmi, robust
regress family_income math_test region bmi mom_educ, robust
regress family_income math_test region bmi mom_educ school_type, robust
regress family_income math_test region bmi mom_educ school_type problem_crowding, robust
regress family_income math_test region bmi mom_educ school_type problem_crowding problem_gangs, robust


//science

regress family_income science_test, robust
regress family_income science_test region, robust
regress family_income science_test region bmi, robust
regress family_income science_test region bmi mom_educ, robust
regress family_income science_test region bmi mom_educ school_type, robust
regress family_income science_test region bmi mom_educ school_type problem_crowding, robust
regress family_income science_test region bmi mom_educ school_type problem_crowding problem_gangs, robust

//The Graphs

scatter family_income bmi if region == 1, name(a)
scatter family_income bmi if region == 2, name(b)
scatter family_income bmi if region == 3, name(c)
scatter family_income bmi if region == 4, name(f)

graph combine a b c f

scatter family_income reading_test if school_type == 1, name(i)
scatter family_income reading_test if school_type == 2, name(j)
scatter family_income reading_test if school_type == 3, name(k)

graph combine i j k 

scatter family_income math_test if school_type == 1, name(o)
scatter family_income math_test if school_type == 2, name(p)
scatter family_income math_test if school_type == 3, name(q)

graph combine o p q

scatter family_income science_test if school_type == 1, name(r)
scatter family_income science_test if school_type == 2, name(s)
scatter family_income science_test if school_type == 3, name(t)

graph combine r s t

twoway (scatter family_income bmi if region == 1, mcolor(blue)) (scatter family_income bmi if region == 2, mcolor(red)) (scatter family_income bmi if region == 3, mcolor(yellow)) (scatter family_income bmi if region == 4, mcolor(green))

twoway (scatter family_income reading_test if region == 1, mcolor(blue)) (scatter family_income reading_test if region == 2, mcolor(red)) (scatter family_income reading_test if region == 3, mcolor(yellow)) (scatter family_income reading_test if region == 4, mcolor(green))

twoway (scatter family_income math_test if region == 1, mcolor(blue)) (scatter family_income math_test if region == 2, mcolor(red)) (scatter family_income math_test if region == 3, mcolor(yellow)) (scatter family_income math_test if region == 4, mcolor(green))

twoway (scatter family_income science_test if region == 1, mcolor(blue)) (scatter family_income science_test if region == 2, mcolor(red)) (scatter family_income science_test if region == 3, mcolor(yellow)) (scatter family_income science_test if region == 4, mcolor(green))

twoway (scatter family_income reading_test if mom_educ == 1, mcolor(blue)) (scatter family_income reading_test if mom_educ == 2, mcolor(red)) (scatter family_income reading_test if mom_educ == 3, mcolor(yellow)) (scatter family_income reading_test if mom_educ == 4, mcolor(green)) (scatter family_income reading_test if mom_educ == 5, mcolor(purple))

twoway (scatter family_income math_test if mom_educ == 1, mcolor(blue)) (scatter family_income math_test if mom_educ == 2, mcolor(red)) (scatter family_income math_test if mom_educ == 3, mcolor(yellow)) (scatter family_income math_test if mom_educ == 4, mcolor(green)) (scatter family_income math_test if mom_educ == 5, mcolor(purple))

twoway (scatter family_income science_test if mom_educ == 1, mcolor(blue)) (scatter family_income science_test if mom_educ == 2, mcolor(red)) (scatter family_income science_test if mom_educ == 3, mcolor(yellow)) (scatter family_income science_test if mom_educ == 4, mcolor(green)) (scatter family_income science_test if mom_educ == 5, mcolor(purple))

twoway (scatter family_income reading_test if problem_crowding == 0, mcolor(blue)) (scatter family_income reading_test if problem_crowding == 1), name(ab)

twoway (scatter family_income math_test if problem_crowding == 0, mcolor(blue)) (scatter family_income math_test if problem_crowding == 1), name (bd)

twoway (scatter family_income science_test if problem_crowding == 0, mcolor(blue)) (scatter family_income science_test if problem_crowding == 1), name(ce)

graph combine ab bd ce


twoway (scatter family_income reading_test if problem_gangs == 0, mcolor(blue)) (scatter family_income reading_test if problem_gangs == 1), name(x)

twoway (scatter family_income math_test if problem_crowding == 0, mcolor(blue)) (scatter family_income math_test if problem_crowding == 1), name (y)

twoway (scatter family_income science_test if problem_crowding == 0, mcolor(blue)) (scatter family_income science_test if problem_crowding == 1), name(z)

graph combine x y z

log close