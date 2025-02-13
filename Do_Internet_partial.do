clear all
set more off

cd "C:\Users\zenit\Downloads\AER-2016-1385"

* Pour les données DHS 
* Données disponibles uniquement sur demande, car contenant des informations personnelles : on réplique ici les colonnes 2 et 3 uniquement. 


* Pour les données Afrobarometer

use "data\afrobarometer.dta"

* Générer les effets fixes pays x année 
* La variable "group (a b)" prend une valeur différente pour chaque couple (a b) de l'échantillon
egen country_year = group(___ ___)

* Générer les effets fixes pixel x connecté
egen grid_connect = group(___ ___)


*** Faire la régression en elle-même 
*** areg : régression linéaire avec beaucoup de variables muette. 
*** La fonction "absorb" permet d'inclure à la régression une variable de catégorie (ici, les effets fixes grilles connectées) qui n'apparaîtrait pas sinon.
*** Attention aux conditions : on ne veut pas les individus à plus de 10km (=0.1 ici) du réseau central, on ne veut pas les individus de plus de 65 ans (âge = q1) pour avoir un échantillon comparable au QLFS de l'Afrique du Sud qui n'a pas d'individus de plus de 65 ans

areg ___ treatment i.country_year if ____ & ____, absorb(____) cluster(grid10)
eststo reg2



clear

* Pour les données sur l'Afrique du Sud (sa-qlfs)

use "data\qlfs.dta"

*** Uniquement condition sur la distance ici 

areg ____ treatment i.time if time < 20103 & ____, absorb(eacode) cluster(eacode)
eststo reg3



esttab ___ ___, se b(3) stats(N ymean, labels("Observations" "Mean of Outcome")) label alignment(center) nogaps fragment nonumbers mlabels(none) drop(*year* *time* _cons) collabels()  nocon starlevels(* 0.10 ** 0.05 *** 0.01)



*** Figure 6

* Normaliser la date d'arrivée des câbles sous-marins (20093) à 0 et créer les dates pour les autres trimestres (de -4 à 3) : 

gen timesince = 0 if time == 20093

replace timesince = ___ if time == ___
replace timesince = ___ if time == ___
replace timesince = ___ if time == ___
replace timesince = ___ if time == ___
replace timesince = ___ if time == ___
replace timesince = ___ if time == ___

* Créer le graph en lui-même : 

binscatter ___ ___, linetype(connect) by(___) xline(0)

*** Que peut-on dire de la Common Trend Assumption ? 
