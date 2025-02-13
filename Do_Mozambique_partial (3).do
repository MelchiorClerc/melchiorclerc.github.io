
**************************************************************************************************************************************
************** TD 1, "Does Information Break the Political Resource Curse? Experimental Evidence from Mozambique" **************
**************************************************************************************************************************************

clear all 
set more off 
set matsize 800

*** Importation de la base 

cd "_____"

use base_Mozambique.dta
	
xtset hh_id year

*** Beaucoup de variables de contôle : créons quelques groupes pour organiser tout ça

global ld_contr		"ld_age ld_age2 ld_educ_2 ld_educ_3 ld_rel_muslim ld_ethn_macua ld_ethn_maconde ld_adults_HH ld_a16 ld_married" 				// Contrôles pour régressions communautés (leader)
global hh_contr		"gender age age2 educ_2 educ_3 rel_muslim ethn_macua ethn_maconde hh_size a16 married sub_farmer" 								// Contrôles pour régressions individuelles (ménages)
global ldvi_contr	"strata_rnd1-strata_rnd3 infrastructure nat_res num_tables_14 distpalma methn_macua methn_maconde meduc_3" 						// Contrôles pour régressions communautés (communautés)
global vi_contr		"district1-district10 strata_rnd2-strata_rnd3 infrastructure nat_res num_tables_14 distpalma methn_macua methn_maconde meduc_3" // Contrôles pour régressions individuelles (communauté) 
			
********************************************************************************************
***************************************** Tableau 1 ****************************************
********************************************************************************************

*** Réplication du tableau		
			
reg ACLED ___ ___ ___ ___ L.ACLED if year == ___ & villobs == 1
est sto A1
reg GDELT ___ ___ ___ ___ L.GDELT if year == ___ & villobs == 1
est sto A2
reg ACLED_GDELT ___ ___ ___ ___ L.ACLED_GDELT if year == ___ & villobs == 1
est sto A3
reg symp_violence ___ ___ ___ ___ L.symp_violence if year == ___, cl(ae_id)
est sto A4
reg invol_violence ___ ___ ___ ___ L.invol_violence if year == ___, cl(ae_id)
est sto A5

esttab A1 A2 A3 A4 A5, keep(___ ___) se r2 

*** Test de la robustesse sans lag temporel (note de bas de page 13), en faisant bien attention à comparer des échantillons similaires !
			
reg ACLED tc1 tc2 $ld_contr $ldvi_contr if year == 2017 & villobs == 1
est sto D1
reg GDELT tc1 tc2 $ld_contr $ldvi_contr if year == 2017 & villobs == 1
est sto D2
reg ACLED_GDELT tc1 tc2 $ld_contr $ldvi_contr if year == 2017 & villobs == 1
est sto D3
reg symp_violence tc1 tc2 $hh_contr $ldvi_contr if year == 2017, cl(ae_id)
est sto D4
reg invol_violence tc1 tc2 $hh_contr $ldvi_contr if year == 2017, cl(ae_id)
est sto D5
			
esttab D1 D2 D3 D4 D5, keep(___ ___) se r2

*** Régression "naïve" : sans les variables de contrôle

reg ACLED ___ ___ if year == 2017 & villobs == 1	
est sto B1
reg GDELT ___ ___ if year == 2017 & villobs == 1
est sto B2
reg ACLED_GDELT ___ ___ if year == 2017 & villobs == 1
est sto B3
reg symp_violence ___ ___ if year == 2017, cl(ae_id)
est sto B4
reg invol_violence ___ ___ if year == 2017, cl(ae_id)
est sto B5

esttab B1 B2 B3 B4 B5, keep(___ ___) se r2 

*** Avec lag temporel (baseline value)
			
reg ACLED ___ ___ ___ if year == 2017 & villobs == 1	
est sto C1
reg GDELT ___ ___ ___ if year == 2017 & villobs == 1
est sto C2
reg ACLED_GDELT ___ ___ ___ if year == 2017 & villobs == 1
est sto C3
reg symp_violence ___ ___ ___ if year == 2017, cl(ae_id)
est sto C4
reg invol_violence ___ ___ ___ if year == 2017, cl(ae_id)
est sto C5
			
esttab C1 C2 C3 C4 C5, keep(___ ___) se r2 



*** Info sur la moyenne, exemple avec la première colonne
mean ACLED if ___ ___ & year == 2017 & villobs == 1


********************************************************************************************
***************************************** Figure 2 *****************************************
********************************************************************************************

*** Régressions préliminaires

reg ld_info ___ ___ ___ ___ if year == 2017 & villobs == 1	
est sto ld_info

reg ld_benef ___ ___ ___ ___ if year == 2017 & villobs == 1	
est sto ld_benef 

reg ld_rs ___ ___ ___ ___ if year == 2017 & villobs == 1	
est sto ld_rs 

reg ld_violence ___ ___ ___ ___ if year == 2017 & villobs == 1	
est sto ld_violence

reg el_capture ___ ___ ___ ___ if year == 2017 & villobs == 1	
est sto el_capture

*** Générer la figure 
	coefplot (___) (___) (___) (___) (___), keep(___ ___)||, ____ yline(0, lcolor(black) lpattern(-)) ytitle("Marginal effect") ///
	yscale(range(-0.4 0.6)) ylabel(-0.4(0.2)0.6) order(tc1 tc2)
	
********************************************************************************************
********************************** Table B2 : Balance test *********************************
********************************************************************************************

*** Colonne 3 : 

* Générer une dummy "traités"


* Régresser l'âge sur la dummy


*** Colonne 4 (même principe pour 5 et 6) avec par exemple l'age et le nombre d'individus dans le ménage : 

* Indice : le ttest est le test usuel de différence de moyennes 



