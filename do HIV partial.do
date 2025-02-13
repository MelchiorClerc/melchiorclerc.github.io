
clear all 

cd "_____"

set matsize 800

ssc install estout


*****************
*** Figure 2A ***
*****************



use hiv-figure2a


*** Générer une variable de distance à la frontière négative dans les pays avec civil law, et positive dans les pays common law
______
______ 

*** Générer une variable donnant la distance au carré
gen rd2_2=rd2^2


*** Créer une boucle pour faire des groupes de 5km autour de la frontière 

preserve

*** Exemple pour le groupe entre -100 et -95 :
gen group=-100 if rd2>=-100&rd2<-95

*** Comment coder cela de manière automatique pour ne pas tout faire à la main ? 

*** Fonctionnement forvalues :  forvalues i=#1(#d)#2
*** Pour chaque valeur i, de #1 à #2 par pas de #d

*** On veut créer des groupes de 5km chacun, de -100 à 100 : Combien de groupes au total ? 

forvalues i=_(_)_ {
replace group=-100+(`i'*__) if rd2>=-100+(`i'*__) & rd2<-95+(`i'*__)
}


*** Utilisation des groupes pour créer des moyennes par tranche de 5km 
egen rd2_mean=mean(rd2), by(____)
egen hivpos_mean=mean(hivpos), by(____)



*Côté gauche (Civil law)*
reg hivpos rd2 rd2_2 if rd2<___&rd2>___,robust cluster(country)

*** Prédiction linéaire de l'équation au-dessus
predict yhat_1

*Côté droit (Common law)
reg hivpos rd2 rd2_2 if rd2>___&rd2<___,robust cluster(country)

*** Prédiction linéaire de l'équation au-dessus 
predict yhat_2

twoway (scatter ___ ___ if ____ & ____) /*
*/ (line yhat_1 rd2 if rd2<0&rd2>-100, sort)/* 
*/ (line yhat_2 rd2 if rd2>0&rd2<100, sort) , /* 
*/ xtitle(Distance to Border) ytitle(Female HIV) legend(off) xline(0)

graph save femaleRD2_hivpos.gph,replace

restore


******************
**Table 1*********
*******************

******************
**Cluster pays*********
*******************
clear

use hiv-table1.dta


xi: reg ___ ___      wifeage wifenoeduc i.tribe_code gdp_pop_ppp2004 abs_latitude longitude rain_min humid_max low_temp yt  j_pd0 j_l0708 j_km2split j_mean_ele j_mean_sui j_malarias j_petroleu  j_diamondd j_capdista j_seadist1 j_borderdi southafrica centralafrica eastafrica westafrica rdkm rdkmsq  if rdkm<=200      , cluster(country)
est sto A 
xi: reg ___ ___     wifeage wifenoeduc i.tribe_code gdp_pop_ppp2004 abs_latitude longitude rain_min humid_max low_temp yt  j_pd0 j_l0708 j_km2split j_mean_ele j_mean_sui j_malarias j_petroleu  j_diamondd j_capdista j_seadist1 j_borderdi southafrica centralafrica eastafrica westafrica rdkm rdkmsq  if rdkm<=150      , cluster(country)
est sto B 
xi: reg ___ ___       wifeage wifenoeduc i.tribe_code gdp_pop_ppp2004 abs_latitude longitude rain_min humid_max low_temp yt  j_pd0 j_l0708 j_km2split j_mean_ele j_mean_sui j_malarias j_petroleu  j_diamondd j_capdista j_seadist1 j_borderdi southafrica centralafrica eastafrica westafrica rdkm rdkmsq  if rdkm<=100      , cluster(country)
est sto C
xi: reg ___ ___      wifeage wifenoeduc i.tribe_code gdp_pop_ppp2004 abs_latitude longitude rain_min humid_max low_temp yt  j_pd0 j_l0708 j_km2split j_mean_ele j_mean_sui j_malarias j_petroleu  j_diamondd j_capdista j_seadist1 j_borderdi southafrica centralafrica eastafrica westafrica rdkm rdkmsq  if rdkm<=100 & target==1     , cluster(country)
est sto D
xi: reg ___ ___       wifeage wifenoeduc i.tribe_code gdp_pop_ppp2004 abs_latitude longitude rain_min humid_max low_temp yt  j_pd0 j_l0708 j_km2split j_mean_ele j_mean_sui j_malarias j_petroleu  j_diamondd j_capdista j_seadist1 j_borderdi southafrica centralafrica eastafrica westafrica rdkm rdkmsq  if rdkm<=100   & target==0   , cluster(country)
est sto E

esttab _ _ _ _ _, keep(_) se 






