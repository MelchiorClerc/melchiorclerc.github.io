version 11.0

set more off
capture clear
clear mata
capture log close
clear matrix
set mem 300m
set matsize 800




cd "C:\Users\zenit\OneDrive\Documents\Thèse\Cours\Analyse d'impact S1 2022-23\TD 5 - IV\nunn_wantchekon_aer_2011_replication_files"

use "Nunn_Wantchekon_AER_2011.dta", clear

local baseline_controls "age age2 male urban_dum i.education i.occupation i.religion i.living_conditions district_ethnic_frac frac_ethnicity_in_district i.isocode"
local colonial_controls "malaria_ecology total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33"

*********************************************************************
******************************** Table 5 ****************************
*********************************************************************

**** ivreg var dep (var endogène = instrument) variables exogènes

xi: ivreg ____ (____ =____) _____ _____ ln_init_pop_density, cluster(murdock_name) 

/* First stage F-stat */
xi: reg _______ ______ _______ _______ ln_init_pop_density if missing(trust_relatives)~=1, cluster(murdock_name)
test distsea==0






*********************************************************************
******************************** Table 7 ****************************
*********************************************************************

**** Test placebo : on veut évaluer l'effet de la distance à la côte sur la confiance envers le gouvernement local (trust_local_govt) là où il y a eu esclavage et là où il n'y en pas eu.

****************************
** Colonnes 1 & 2 : ASS ****
****************************

clear
cd "C:\Users\zenit\OneDrive\Documents\Thèse\Cours\Analyse d'impact S1 2022-23\TD 5 - IV\nunn_wantchekon_aer_2011_replication_files"

use "Nunn_Wantchekon_AER_2011.dta", clear



**** On veut mener les estimation sans contrôle sur le sample avec contrôle : quelles restrictions faut-il introduire à la première régression ? 

xi: reg ____ ____ i.isocode if _____ & _____ & _____ & _____, cluster(murdock_name)
est sto t7c1
xi: reg ____ ____ age age2 male i.education i.religion i.isocode, cluster(murdock_name)
est sto t7c2

****************************
* Colonnes 3 & 4 : Placebo *
****************************


preserve

clear 

cd "C:\Users\zenit\OneDrive\Documents\Thèse\Cours\Analyse d'impact S1 2022-23\TD 5 - IV\nunn_wantchekon_aer_2011_replication_files"

use "Asiabarometer_falsification_dataset.dta", clear

rename distance_coast distsea

**** Idem

xi: reg ___ ___ i.COUNTRY if ___  & ___ & ___ & ___, cluster(distsea)
est sto t7c3
xi: reg ___ ___ age* male i.education i.religion i.COUNTRY, cluster(distsea)
est sto t7c4

restore

esttab t7c1 t7c2 t7c3 t7c4, keep (distsea) se r2





