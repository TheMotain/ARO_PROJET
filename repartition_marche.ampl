option solver gurobi;

set DETAILLANTS;
set REGIONS;
set CATEGORIES;

param region{DETAILLANTS} symbolic in REGIONS;
param huile{DETAILLANTS} >= 0;
param nb_pts_vente{DETAILLANTS} >= 0;
param spiritueux{DETAILLANTS} >= 0;
param categorie{DETAILLANTS} symbolic in CATEGORIES;

param z = 1;

var appartient_a_D1{DETAILLANTS} binary;

maximize bidon : 
	z;

subject to nb_pts_vente_min : 
	(sum{d in DETAILLANTS} appartient_a_D1[d] * nb_pts_vente[d]) / (sum{e in DETAILLANTS} nb_pts_vente[e]) >= 0.35;

subject to nb_pts_vente_max : 
	(sum{d in DETAILLANTS} appartient_a_D1[d] * nb_pts_vente[d]) / (sum{e in DETAILLANTS} nb_pts_vente[e]) <= 0.45;

subject to spiritueux_min : 
	(sum{d in DETAILLANTS} appartient_a_D1[d] * spiritueux[d]) / (sum{e in DETAILLANTS} spiritueux[e]) >= 0.35;

subject to spiritueux_max : 
	(sum{d in DETAILLANTS} appartient_a_D1[d] * spiritueux[d]) / (sum{e in DETAILLANTS} spiritueux[e]) <= 0.45;

subject to huile_region_min{r in REGIONS} : 
	(sum{d in DETAILLANTS : region[d] = r} appartient_a_D1[d] * huile[d]) / (sum{e in DETAILLANTS : region[e] = r} huile[e]) >= 0.35;

subject to huile_region_max{r in REGIONS} : 
	(sum{d in DETAILLANTS : region[d] = r} appartient_a_D1[d] * huile[d]) / (sum{e in DETAILLANTS : region[e] = r} huile[e]) <= 0.45;

subject to detaillant_categorie_min{c in CATEGORIES} : 
	(sum{d in DETAILLANTS : categorie[d] = c} appartient_a_D1[d]) / (sum{e in DETAILLANTS : categorie[e] = c} 1) >= 0.35;

subject to detaillant_categorie_max{c in CATEGORIES} : 
	(sum{d in DETAILLANTS : categorie[d] = c} appartient_a_D1[d]) / (sum{e in DETAILLANTS : categorie[e] = c} 1) <= 0.45;
