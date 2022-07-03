/* Emily Huang
Joanne Song-McLaughlin
ECO498 - Undergraduate Research
22 March 2022
*/

/*LOCAL WAY*/
/* Professor Joanne Song-McLaughlin's Desktop
local progFolder "C:\Users\jsmclaug\Box\Projects\Intersectionality\progs\"
local dataFolder "C:\Users\jsmclaug\Box\Projects\Intersectionality\data\"
local outputFolder "C:\Users\jsmclaug\Box\Projects\Intersectionality\output\"
local rawDataFolder "C:\Users\jsmclaug\Box\Projects\Intersectionality\"*/

/* Professor Joanne Song-McLaughlin's Laptop
local progFolder "C:\Users\SongJ\Box\Projects\Intersectionality\progs\"
local dataFolder "C:\Users\SongJ\Box\Projects\Intersectionality\data\"
local outputFolder "C:\Users\SongJ\Box\Projects\Intersectionality\output\"
local rawDataFolder "C:\Users\SongJ\Box\Projects\Intersectionality\"*/

/*Micro Variables for Box
local progFolder "C:\Users\Emilyemlz\Box\Emily Huang\programs"
local dataFolder "C:\Users\Emilyemlz\Box\Emily Huang\analysis_data"
local outputFolder "C:\Users\Emilyemlz\Box\Emily Huang\output"
local rawDataFolder "C:\Users\Emilyemlz\Box\Emily Huang\raw_data"

use "`rawDataFolder'\cps_00019", clear
drop cpsid asecflag asecwth pernum cpsidp asecwt sploc aspouse month age race marst educ sex_sp

keep if relate == 101 & year == 2018

tempfile headData
save `headData', replace

use "`rawDataFolder'/cps_00019", clear
drop cpsid asecflag asecwth pernum cpsidp asecwt sploc aspouse month age race marst educ sex

keep if relate == 101 & year == 2018
replace relate = . if relate == 101
rename relate relate_spouse

tempfile spouseData
save `spouseData', replace

merge 1:1 serial using `headData'

replace sex_sp = . if relate != 101
replace relate_spouse = . if relate != 101

ge male = (sex == 1)
ge female = (sex == 2)

ge maleSpouse = (sex_sp == 1)
ge femaleSpouse = (sex_sp == 2)

ge doubleMale = male*maleSpouse
ge doubleFemale = female*femaleSpouse

ge gay = 1 if doubleMale == 1 | doubleFemale == 1
replace gay = 0 if gay == .*/


/*Emily Huang's Laptop Script - Direct*/
cd "C:\Users\Emilyemlz\Documents\Undergraduate Research"
use cps_00019, clear
drop cpsid asecflag asecwth pernum cpsidp asecwt

keep if inlist(relate, 101)

generate male = (sex == 1)
generate female = (sex == 2)

generate maleSpouse = (sex_sp == 1)
generate femaleSpouse = (sex_sp == 2)

generate doubleMale = male*maleSpouse
generate doubleFemale = female*femaleSpouse

ge gay = 1 if doubleMale == 1 | doubleFemale == 1
replace gay = 0 if gay == .

keep if inlist(year, 2018)

misstable summarize gay

*Ah*
drop year serial month age race marst sploc aspouse educ relate sex sex_sp maleSpouse femaleSpouse doubleFemale doubleMale male female

local i = 0
foreach var in varlist * {
   local ++i
}

di `i'

gen varname=""
gen mean=.
local i=1

foreach var of varlist sex sex_sp {
     quietly sum `var'
     replace mean = r(mean) in `i'
     replace varname = "`var'" in `i'
     local ++i
}

/*
local i = 0
forval gay = 1/67909 {
    if `gay' == 1  local i = `i' + 1
}
di `i'

egen counter = group(gay)


local i=0
foreach x of gay 1/67909 {
local i=`i'+1
di `i'
}


local i = 0
forval x = 1/3 {
    if `x' == 1  local i = `i' + 1
}
display `i'*/

* There are 500 gays in 2018. There are 1,969 gays from 2018-2021

**CHECKING MY WORK**
drop if relate != 101
drop if year != 2018

gen number = 0
    replace number = 1 if ((sex==1 & sex_sp==1) | (sex==2 & sex_sp==2))
	replace number = 2 if ((sex==1 & sex_sp==.) | (sex==2 & sex_sp==.))
	
tab number

/*
keep if relate==101 | relate==201

bysort serial: egen number = count(serial)

drop number

tab month, nol

drop if month != 3

bysort serial: egen number = count(serial)

tab number

drop if year !=2018

drop number

bysort serial: egen number = count(serial)

tab number

keep if number ==2

bysort serial: egen meansex = mean(sex)

tab meansex*/