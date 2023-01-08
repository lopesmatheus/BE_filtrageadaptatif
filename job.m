%==========================================================================
% BE filtrage adatatif pour la rejection de bruit acoustique
%==========================================================================

clear all
close all
clc;
addpath('Miscellaneous');


% Mod�lisation du syst�me
[simulation,source,canal] = init_modele;

% Filtre r�jecteur
[filtreRIF] = init_filtre(simulation,canal,0);

% Sp�cification des cas � simuler
[spec_sim] = specif_simu(1);

% Evaluation des performances
eval_perf(spec_sim,simulation,filtreRIF);


