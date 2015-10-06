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
param categorie{DETAILLANTS} symbolic in CATEGORIE;
# définition des variables
var detail_D1{DETAILLANTS} binary;
var detail_D2{DETAILLANTS} binary;
# déclaration d'objectif
minimize division1: ads(40 - (sum{m in DETAILLANTS}detail_D1[m] * nb_pts_vente);
# déclaration des contraintes
subject to nb_total_pts_vente:
