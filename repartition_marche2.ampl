set DETAILLANTS;
set REGIONS;
set CATEGORIES;

param region{DETAILLANTS};
param huile{DETAILLANTS} >= 0;
param nb_pts_vente{DETAILLANTS} >= 0;
param spiritueux{DETAILLANTS} >= 0;
param categorie{DETAILLANTS};
