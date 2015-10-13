option solver gurobi;
# ajout des ensembles de valeurs
set DETAILLANTS;
set REGIONS;
set CATEGORIES;
# ajout des paramètres
param region{DETAILLANTS} symbolic in REGIONS;
param huile{DETAILLANTS} >= 0;
param nb_pts_vente{DETAILLANTS} >= 0;
param spiritueux{DETAILLANTS} >= 0;
param categorie{DETAILLANTS} symbolic in CATEGORIES;
# définition des variables
var division{DETAILLANTS} binary;
var borne >= 0;
# déclaration d'objectif
minimize max_vabs : borne;
# déclaration des contraintes
# nbtotalpv
subject to nbtotalpvmin : 
(sum{d in DETAILLANTS}division[d]*nb_pts_vente[d])*100/(sum{D in DETAILLANTS}nb_pts_vente[D]) >= 35;
subject to nbtotalpvmax : 
(sum{d in DETAILLANTS}division[d]*nb_pts_vente[d])*100/(sum{D in DETAILLANTS}nb_pts_vente[D]) <= 45;
# nbtotalspiritueux
subject to nbtotalspiritueuxmin : 
(sum{d in DETAILLANTS}division[d]*spiritueux[d])*100/(sum{D in DETAILLANTS}spiritueux[D]) >= 35;
subject to nbtotalspiritueuxmax : 
(sum{d in DETAILLANTS}division[d]*spiritueux[d])*100/(sum{D in DETAILLANTS}spiritueux[D]) <= 45;
# nbtotalhuile
subject to nbtotalhuilemin{r in REGIONS} :
(sum{d in DETAILLANTS : region[d] = r} division[d]*huile[d])*100/(sum{D in DETAILLANTS : region[D] = r}huile[D]) >= 35;
subject to nbtotalhuilemax{r in REGIONS} :
(sum{d in DETAILLANTS : region[d] = r} division[d]*huile[d])*100/(sum{D in DETAILLANTS : region[D] = r}huile[D]) <= 45;
# nbtotaldetail
subject to nbtotaldetailmin{c in CATEGORIES} :
(sum{d in DETAILLANTS : categorie[d] = c} division[d])*100/(sum{D in DETAILLANTS : categorie[D] = c}1) >= 35;
subject to nbtotaldetailmax{c in CATEGORIES} :
(sum{d in DETAILLANTS : categorie[d] = c} division[d])*100/(sum{D in DETAILLANTS : categorie[D] = c}1) <= 45;
# minimiser la variation 40/60
subject to borne_inf : 
-borne <= (sum{d in DETAILLANTS}division[d])*100/(sum{D in DETAILLANTS}1);
subject to borne_sup :
borne >= (sum{d in DETAILLANTS}division[d])*100/(sum{D in DETAILLANTS}1);
