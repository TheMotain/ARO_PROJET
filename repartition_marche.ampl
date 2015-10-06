option solveur gurobi;

set DETAILLANTS;
set REGIONS;
set CATEGORIES;

param region{DETAILLANTS} symbolic in REGIONS;
param huile{DETAILLANTS} >= 0;
param nb_pts_vente{DETAILLANTS} >= 0;
param spiritueux{DETAILLANTS} >= 0;
param categorie{DETAILLANTS} symbolic in CATEGORIES;

var appartient_a_D1{DETAILLANTS} binary;

minimize ecart : 
	abs(40 - (sum{d in DETAILLANTS} appartient_a_d1[d] * nb_pts_vente[d] / sum{e in DETAILLANTS} nb_pts_vente[e]) * 100);
