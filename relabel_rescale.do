* ************************************************************************
* https://github.com/evpu
* Suppose you have a set of variables with variable labels that indicate 
* some common scale (e.g. millions).
* This loop allows to rescale (into e.g. billions) and relabel everything quickly.
* ************************************************************************

clear all

* Example dataset. Generate some sample random variables:
set obs 10
gen year = 2016
set seed 20161126
gen cold = rpoisson(520)
gen hot = rpoisson(630)
label var cold "Cold variable [millions]"
label var hot "Hot variable [millions]"

* Select all variables except the year variable
ds year, not

foreach v of varlist `r(varlist)' {
    * Change the label from millions to billions
    local label_`v': variable label `v'
    local label_`v' = subinstr("`label_`v''", "millions", "billions" , .)
    label var `v' "`label_`v''"
    * Rescale
    replace `v' = `v' / 1000
}
