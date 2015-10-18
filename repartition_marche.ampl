/*Réinitialisation*/ 
reset;

/*Choix du Solver*/
option solver gurobi;

## Déclaration des ensembles

set DETAILLANTS;
set REGIONS;
set CATEGORIES;

## Déclaration des paramètres

/*Paramètres initiaux*/
param region{DETAILLANTS} symbolic in REGIONS;
param huile{DETAILLANTS} >= 0;
param nb_pts_vente{DETAILLANTS} >= 0;
param spiritueux{DETAILLANTS} >= 0;
param categorie{DETAILLANTS} symbolic in CATEGORIES;

/*Paramètres calculés*/
param nb_pts_vente_total = sum{d in DETAILLANTS} nb_pts_vente[d];
param spiritueux_total = sum{d in DETAILLANTS} spiritueux[d];
param huile_total{r in REGIONS} = sum{d in DETAILLANTS : region[d] = r} huile[d];
param detaillants_total{c in CATEGORIES} = sum{d in DETAILLANTS : categorie[d] = c} 1;

## Déclaration des variables

/*Variables initiales*/
var appartient_a_D1{DETAILLANTS} binary;

var borne_nb_pts_vente >= 0, <= 0.05;
var borne_spiritueux >= 0, <= 0.05;
var borne_huile_par_region >= 0, <= 0.05;
var borne_detaillants_par_categorie >= 0, <= 0.05;

/*Variables calculées*/
var nb_pts_vente_D1 = sum{d in DETAILLANTS} appartient_a_D1[d] * nb_pts_vente[d];
var spiritueux_D1 = sum{d in DETAILLANTS} appartient_a_D1[d] * spiritueux[d];
var huile_D1{r in REGIONS} = sum{d in DETAILLANTS : region[d] = r} appartient_a_D1[d] * huile[d];
var detaillants_D1{c in CATEGORIES} = sum{d in DETAILLANTS : categorie[d] = c} appartient_a_D1[d];

var rapport_nb_pts_vente_D1 = nb_pts_vente_D1 / nb_pts_vente_total;
var rapport_spiritueux_D1 = spiritueux_D1 / spiritueux_total;
var rapport_huile_D1{r in REGIONS} = huile_D1[r] / huile_total[r];
var rapport_detaillants_D1{c in CATEGORIES} = detaillants_D1[c] / detaillants_total[c];

## Objectif

/*Objectif de la question 1*/
#maximize inutile :  
#	1;

/*Objectif de la question 2.1*/
minimize somme_variation_abs : 
	borne_nb_pts_vente + borne_spiritueux + borne_huile_par_region + borne_detaillants_par_categorie;	

/*Objectif de la question 2.2*/
#minimize variation_max_vabs : 
#	(à faire);

## Contraintes

/*Contraintes liées au nombre de points de vente de la division D1*/
subject to nb_pts_vente_min : 
	rapport_nb_pts_vente_D1 >= 0.40 - borne_nb_pts_vente;

subject to nb_pts_vente_max : 
	rapport_nb_pts_vente_D1 <= 0.40 + borne_nb_pts_vente;

/*Contraintes liées au marché des spiritueux de la division D1*/
subject to spiritueux_min : 
	rapport_spiritueux_D1 >= 0.40 - borne_spiritueux;

subject to spiritueux_max : 
	rapport_spiritueux_D1 <= 0.40 + borne_spiritueux;

/*Contraintes liées au marché de l'huile par région de la division D1*/
subject to huile__par_region_min{r in REGIONS} : 
	rapport_huile_D1[r] >= 0.40 - borne_huile_par_region;

subject to huile_par_region_max{r in REGIONS} : 
	rapport_huile_D1[r] <= 0.40 + borne_huile_par_region;

/*Contraintes liées au nombre de détaillants par catégorie de la division D1*/
subject to detaillants_par_categorie_min{c in CATEGORIES} : 
	rapport_detaillants_D1[c] >= 0.40 - borne_detaillants_par_categorie;

subject to detaillants_par_categorie_max{c in CATEGORIES} : 
	rapport_detaillants_D1[c] <= 0.40 + borne_detaillants_par_categorie;
