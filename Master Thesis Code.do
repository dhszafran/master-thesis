************************
* Daria Helena Szafran *
** Master Thesis Code **
****** July 2022 *******
************************

clear
set more off
version 17

*************************

/// global DATA_PATH "xxx"
/// global WORK_PATH "xxx"

/// use "${DATA_PATH}xxx.dta", clear

************************
*** DATA PREPARATION ***
************************

* Limiting the dataset to the final sample *
drop if agegrpK == 1 & agegrpK == 2 & agegrpK == 3
drop if tntyp == 2
drop if KSsubj != 1 & KSsubj != 2 & KSsubj != 3 & KSsubj != 4 & KSsubj != 5
drop if USbmiB_kh != 1 & USbmiB_kh != 2 & USbmiB_kh != 3 & USbmiB_kh != 4 & USbmiB_kh != 5

* Creating new variables *
generate female = .
replace female = 0 if sex == 1
replace female = 1 if sex == 2

generate age_binary = .
replace age_binary = 0 if agegrpK == 4
replace age_binary = 1 if agegrpK == 5

generate west_east = .
replace west_east = 0 if wo1 == 1
replace west_east = 1 if wo1 == 2

generate urban = .
replace urban = 0 if gkpol4 == 1
replace urban = 1 if gkpol4 == 2
replace urban = 2 if gkpol4 == 3
replace urban = 3 if gkpol4 == 4

generate migrant = .
replace migrant = 0 if MImigrant == 2
replace migrant = 1 if MImigrant == 1

generate ses = .
replace ses = 0 if SDEses == 1
replace ses = 1 if SDEses == 2
replace ses = 2 if SDEses == 3

generate mother_bmi = .
replace mother_bmi = 0 if PAEbmim_k == 1
replace mother_bmi = 1 if PAEbmim_k == 2
replace mother_bmi = 2 if PAEbmim_k == 3
replace mother_bmi = 3 if PAEbmim_k == 4

generate tv_video = .
replace tv_video = 0 if MNfernC == 2 | MNfernC == 3
replace tv_video = 1 if MNfernC == 1
replace tv_video = 2 if MNfernC == 4 | MNfernC == 5 | MNfernC == 6

generate com_internet = .
replace com_internet = 0 if MNpcC == 2 | MNpcC == 3
replace com_internet = 1 if MNpcC == 1
replace com_internet = 2 if MNpcC == 4 | MNpcC == 5 | MNpcC == 6

generate soc_network = .
replace soc_network = 0 if MNsoznw == 2 | MNsoznw == 3
replace soc_network = 1 if MNsoznw == 1
replace soc_network = 2 if MNsoznw == 4 | MNsoznw == 5 | MNsoznw == 6

generate congames = .
replace congames = 0 if MNkonsC == 2 | MNkonsC == 3
replace congames = 1 if MNkonsC == 1
replace congames = 2 if MNkonsC == 4 | MNkonsC == 5 | MNkonsC == 6

generate bmi_kh = .
replace bmi_kh = 0 if USbmiB_kh == 1
replace bmi_kh = 1 if USbmiB_kh == 2
replace bmi_kh = 2 if USbmiB_kh == 3
replace bmi_kh = 3 if USbmiB_kh == 4
replace bmi_kh = 4 if USbmiB_kh == 5

generate sbe = .
replace sbe = 0 if KSsubj == 1
replace sbe = 1 if KSsubj == 2
replace sbe = 2 if KSsubj == 3
replace sbe = 3 if KSsubj == 4
replace sbe = 4 if KSsubj == 5

generate over_under = .
replace over_under = 0 if bmi_kh == 0 & sbe == 0 | bmi_kh == 1 & sbe == 1 | bmi_kh == 2 & sbe == 2 | bmi_kh == 3 & sbe == 3 | bmi_kh == 4 & sbe == 4
replace over_under = 1 if bmi_kh == 0 & sbe == 1 | bmi_kh == 0 & sbe == 2 | bmi_kh == 1 & sbe == 2 | bmi_kh == 0 & sbe == 3 | bmi_kh == 1 & sbe == 3 | bmi_kh == 2 & sbe == 3 | bmi_kh == 0 & sbe == 4 | bmi_kh == 1 & sbe == 4 | bmi_kh == 2 & sbe == 4 | bmi_kh == 3 & sbe == 4
replace over_under = 2 if bmi_kh == 1 & sbe == 0 | bmi_kh == 2 & sbe == 0 | bmi_kh == 2 & sbe == 1 | bmi_kh == 3 & sbe == 0 | bmi_kh == 3 & sbe == 1 | bmi_kh == 3 & sbe == 2 | bmi_kh == 4 & sbe == 0 | bmi_kh == 4 & sbe == 1 | bmi_kh == 4 & sbe == 2 | bmi_kh == 4 & sbe == 3

**************************
*** SUMMARY STATISTICS ***
**************************

table over_under
prop over_under [pweight=wQSUS]

table female
prop female [pweight=wQSUS]

table tv_video
prop tv_video [pweight=wQSUS]

table com_internet
prop com_internet [pweight=wQSUS]

table soc_network
prop soc_network [pweight=wQSUS]

table congames
prop congames [pweight=wQSUS]

table age_binary
prop age_binary [pweight=wQSUS]

table age
prop age [pweight=wQSUS]

table west_east
prop west_east [pweight=wQSUS]

table urban
prop urban [pweight=wQSUS]

table migrant
prop migrant [pweight=wQSUS]

table ses
prop ses [pweight=wQSUS]

table mother_bmi
prop mother_bmi [pweight=wQSUS]

**************************
*** BIVARIATE ANALYSIS ***
**************************

* Gender + DV; weighted proportions, weighted frequencies, weighted Chi2-test *
prop over_under [pweight=wQSUS], over(female)
table over_under female [pweight=wQSUS]
tabi 499 453 \ 169 278 \ 198 69, chi2

* Gender + media use; weighted proportions, weighted frequencies, weighted Chi2-tests *
prop tv_video [pweight=wQSUS], over(female)
table tv_video female [pweight=wQSUS]
tabi 60 50 \ 463 419 \ 333 326, chi2

prop com_internet [pweight=wQSUS], over(female)
table com_internet female [pweight=wQSUS]
tabi 109 98 \ 472 384 \ 267 307, chi2

prop soc_network [pweight=wQSUS], over(female)
table soc_network female [pweight=wQSUS]
tabi 220 127 \ 539 469 \ 95 197, chi2

prop congames [pweight=wQSUS], over(female)
table congames female [pweight=wQSUS]
tabi 116 417 \ 446 285 \ 290 90, chi2

* Media use + DV; weighted proportions, weighted frequencies, weighted Chi2-tests *
prop over_under [pweight=wQSUS], over(tv_video)
table over_under tv_video [pweight=wQSUS]
tabi 62 519 357 \ 31 209 206 \ 17 154 95, chi2

prop over_under [pweight=wQSUS], over(com_internet)
table over_under com_internet [pweight=wQSUS]
tabi 120 508 304 \ 47 224 172 \ 40 124 98, chi2

prop over_under [pweight=wQSUS], over(soc_network)
table over_under soc_network [pweight=wQSUS]
tabi 200 596 144 \ 81 260 101 \ 65 152 48, chi2

prop over_under [pweight=wQSUS], over(congames)
table over_under congames [pweight=wQSUS]
tabi 299 415 223 \ 174 183 84 \ 60 132 73, chi2

**************************************
*** MULTIVARIATE ANALYSIS + GRAPHS ***
**************************************

ssc install grstyle, replace
ssc install palettes, replace
ssc install colrspace, replace
set scheme s2color
grstyle init
grstyle set plain, box
grstyle color background white
grstyle color major_grid gs8
grstyle set legend 4, box

ssc install mplotoffset


* Model 1: Hypotheses 1 and 2 *
* IVs: Gender + control variables *
mlogit over_under i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins, dydx(female)
marginsplot, recast(scatter) xscale(range(-0.5 2.5)) title("Figure 5: Accuracy of weight estimation, Average Marginal Effects for Girls", size(medium) margin(b=3)) yline(0) xtitle("Accuracy of subjective weight estimation relative to actual BMI", size(medsmall) margin(t=2)) ytitle("Effects on Probability", size(medsmall) margin(r=2)) xlabel(0 "Accurate estimation" 1 "Overestimation" 2 "Underestimation", notick labsize(small)) ylabel(, notick labsize(small) angle(0)) note("Note: 95% CIs; red line represents the gender reference category, i.e., boys" "Data source: KiGGS Wave 2", margin(t=3)) plot1opts(msymbol(O) msize(medsmall) mcolor(green)) ci1opts(lcolor(green))

generate boys = .
replace boys = 0 if female == 2
replace boys = 1 if female == 1

mlogit over_under i.boys i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins, dydx(boys)

* Model 2: Hypothesis 3 *
* IVs: TV/DVD/Video use + gender + control variables *
mlogit over_under i.tv_video i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins, dydx(tv_video)
mplotoffset, recast(scatter) yline(0) xlabel(1.89 " " 2 "Never" 3 "≥ 2 hours/day" 3.11 " ", notick labsize(medsmall)) ylabel(-0.2(0.1)0.2, notick labsize(medsmall) angle(0)) ytitle("Effects on Probability", size(medium) margin(r=2)) title("(a) TV and DVD/Video Use", size(medlarge) margin(b=2)) xtitle("") legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)

* Model 3: Hypothesis 4 *
* IVs: Computer/internet use + gender + control variables *
mlogit over_under i.com_internet i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins, dydx(com_internet)
mplotoffset, recast(scatter) yline(0) xlabel(1.89 " " 2 "Never" 3 "≥ 2 hours/day" 3.11 " ", notick labsize(medsmall)) ylabel(-0.2(0.1)0.2, notick labsize(medsmall) angle(0)) yscale(alt) ytitle("Effects on Probability", size(medium) margin(r=2)) xtitle("") title("(b) Computer and Internet Use", size(medlarge) margin(b=2)) legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange) lcolor(orange) lwidth(medthick)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green) lcolor(green) lwidth(medthick)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple) lcolor(purple) lwidth(medthick)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)

* Model 4: Hypothesis 5 *
* IVs: Social networks use + gender + control variables *
mlogit over_under i.soc_network i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins, dydx(soc_network)
mplotoffset, recast(scatter) yline(0) xlabel(1.89 " " 2 "Never" 3 "≥ 2 hours/day" 3.11 " ", notick labsize(medsmall)) ylabel(-0.2(0.1)0.2, notick labsize(medsmall) angle(0)) ytitle("Effects on Probability", size(medium) margin(r=2)) title("(c) Social Networks Use", size(medlarge) margin(b=2)) xtitle("") legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange) lcolor(orange) lwidth(medthick)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green) lcolor(green) lwidth(medthick)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple) lcolor(purple) lwidth(medthick)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)

* Model 5: Hypothesis 6 *
* IVs: Console games use + gender + control variables *
mlogit over_under i.congames i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins, dydx(congames)
mplotoffset, recast(scatter) yline(0) xlabel(1.89 " " 2 "Never" 3 "≥ 2 hours/day" 3.11 " ", notick labsize(medsmall)) ylabel(-0.2(0.1)0.2, notick labsize(medsmall) angle(0)) yscale(alt) ytitle("Effects on Probability", size(medium) margin(r=2)) title("(d) Console Games Use", size(medlarge) margin(b=2)) xtitle("") legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange) lcolor(orange) lwidth(medthick)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green) lcolor(green) lwidth(medthick)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple) lcolor(purple) lwidth(medthick)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)

* Model 6: all media types *
* IVs: all 4 media types + gender + control variables *
mlogit over_under i.tv_video i.com_internet i.soc_network i.congames i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins, dydx(tv_video com_internet soc_network congames)

* Model 7: Hypothesis 7 *
* IVs: TV/DVD/Video use x gender + control variables *
mlogit over_under i.tv_video##i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins tv_video, dydx(female)
mplotoffset, recast(scatter) yline(0) xlabel(-0.25 " " 0 "< 2 hours/day" 1 "Never" 2 "≥ 2 hours/day" 2.25 " ", notick labsize(medsmall)) ylabel(-0.4(0.2)0.4, notick labsize(medsmall) angle(0)) ytitle("Effects on Probability", size(medium) margin(r=2)) title("(a) TV and DVD/Video Use", size(medlarge) margin(b=2)) xtitle("") legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange) lcolor(orange) lwidth(medthick)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green) lcolor(green) lwidth(medthick)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple) lcolor(purple) lwidth(medthick)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)

* Model 8: Hypothesis 8 *
* IVs: Computer/internet use x gender + control variables *
mlogit over_under i.com_internet##i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins com_internet, dydx(female)
mplotoffset, recast(scatter) yline(0) xlabel(-0.25 " " 0 "< 2 hours/day" 1 "Never" 2 "≥ 2 hours/day" 2.25 " ", notick labsize(medsmall)) ylabel(-0.4(0.2)0.4, notick labsize(medsmall) angle(0)) yscale(alt) ytitle("Effects on Probability", size(medium) margin(r=2)) title("(b) Computer and Internet Use", size(medlarge) margin(b=2)) xtitle("") legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange) lcolor(orange) lwidth(medthick)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green) lcolor(green) lwidth(medthick)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple) lcolor(purple) lwidth(medthick)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)

* Model 9: Hypothesis 9 *
* IVs: Social networks use x gender + control variables *
mlogit over_under i.soc_network##i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins soc_network, dydx(female)
mplotoffset, recast(scatter) yline(0) xlabel(-0.25 " " 0 "< 2 hours/day" 1 "Never" 2 "≥ 2 hours/day" 2.25 " ", notick labsize(medsmall)) ylabel(-0.4(0.2)0.4, notick labsize(medsmall) angle(0)) ytitle("Effects on Probability", size(medium) margin(r=2)) title("(c) Social Networks Use", size(medlarge) margin(b=2)) xtitle("") legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange) lcolor(orange) lwidth(medthick)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green) lcolor(green) lwidth(medthick)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple) lcolor(purple) lwidth(medthick)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)

* Model 10: Hypothesis 10 *
* IVs: Console games use x gender + control variables *
mlogit over_under i.congames##i.female i.age_binary age i.ses i.migrant i.urban i.west_east i.mother_bmi [pweight=wQSUS], vce(cluster ppoint)
margins congames, dydx(female)
mplotoffset, recast(scatter) yline(0) xlabel(-0.25 " " 0 "< 2 hours/day" 1 "Never" 2 "≥ 2 hours/day" 2.25 " ", notick labsize(medsmall)) ylabel(-0.4(0.2)0.4, notick labsize(medsmall) angle(0)) yscale(alt) ytitle("Effects on Probability", size(medium) margin(r=2)) title("(d) Console Games Use", size(medlarge) margin(b=2)) xtitle("") legend(order(4 "Accurate estimation" 5 "Overestimation" 6 "Underestimation") rows(1) symys(*.3) symxs(*.3) size(vsmall) position(bottom) subtitle("Dependent variable categories", size(small))) plot1opts(msymbol(O) msize(medlarge) mcolor(orange) lcolor(orange) lwidth(medthick)) ci1opts(lcolor(orange)) plot2opts(msymbol(D) msize(medlarge) mcolor(green) lcolor(green) lwidth(medthick)) ci2opts(lcolor(green)) plot3opts(msymbol(S) msize(medlarge) mcolor(purple) lcolor(purple) lwidth(medthick)) ci3opts(lcolor(purple)) ysize(3) xsize(3.25)













