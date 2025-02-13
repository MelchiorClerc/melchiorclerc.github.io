

* Le PSM se fait en deux étapes 

*******************************************************************************
*************** Etape 1 : estimation du score de propension *******************
*******************************************************************************

* Régression (souvent à l'aide un modèle probit) du fait d'être traité (member = 1) ou non (member = 0) sur les variables de contrôle :
* educ, radio ownership, land ownership, sexhead, agehead, hhsize
* Pour plus de puissance prédictive, l'estimation ne se fait que sur les kebeles traités (ktreated = 1), ou le choix de participer à une coopérative peut vraiment se réaliser. 

		xi: _____ ___ ___ ___ ___ ___ ___ i.domain if _________	

* Création du PS : probabilité que l'outcome soit positif

		_____ PSCORE

* Examiner la distribution du PS pour voir s'il y a un common support suffisant
		twoway (kdensity ___ if _____ & ____) 
		(kdensity ___ if _____)

******************************************************
*************** Etape 2 : Matching *******************
******************************************************

* ssc install psmatch2
* help psmatch2 s'il y a un doute
* Quelle population veut-on exclure de l'échantillon d'estimation ? 


* Kernel matching : régression sur le sample souhaité en imposant un common support avec comme outcome le prix des céréales (pcereals)

xi : psmatch2 ____ if ____ _____ _____ , pscore (____) kernel common outcome(_____)


* 5 neighbors matching matching : same but with a change in the matching technique 

xi : psmatch2 ____ if _____ _____ _____, pscore (____) n(5) common outcome(_____)




