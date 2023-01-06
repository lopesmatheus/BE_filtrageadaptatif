function [simulation,source,canal] = init_modele()

% [simulation,source,canal] = init_modele;
%---------------------------------------------------------------------
% Initialisation du modèle simulé
%---------------------------------------------------------------------

% -- Parametres des simulations -- 
fc   = 5/2/pi;                      % fréquence maximale à représenter
simulation.dt   = 1/(20*fc);        % pas d'échantillonnage (s)
simulation.hor  = 125;              % horizon de la simulation (s)

% -- Source du bruit acoustique --
source.wi = 1;          % pulsation initiale (rd/s)
source.wf = 1;          % pulsation finale (rd/s)
source.xi = 0.01;       % amortissement
rng('default');         % rng('shuffle');

% -- Canal acoustique --
canal.w     = 3;	% pulsation (rd/s)
canal.xi	= 0.3;	% amortissement
canal.g     = 0.9;	% gain



