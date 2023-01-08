%==========================================================================
% BE filtrage adatatif pour la rejection de bruit acoustique
%==========================================================================

clear all
close all
clc;
addpath('Miscellaneous');


% Modélisation du système
[simulation,source,canal] = init_modele;

% Filtre réjecteur
[filtreRIF] = init_filtre(simulation,canal,0);

% Spécification des cas à simuler
[spec_sim] = specif_simu(1);

% Evaluation des performances
eval_perf(spec_sim,simulation,filtreRIF);


