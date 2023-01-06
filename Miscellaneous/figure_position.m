function [nf] = figure_position(TailleH,TailleV,CentrageH,CentrageV)

% [nf] = figure_position(TailleH,TailleV,CentrageH,CentrageV);
%==========================================================================
% Ouverture d'une figure avec choix de la position
%==========================================================================
% TailleH : Dimension horizontale par rapport à l'écran (0 = petit, 1 = grand)
% TailleV : Dimension verticale par rapport à l'écran (0 = petit, 1 = grand)
% CentrageH : Position Horizontale (0 = gauche, 1 = droite)
% CentrageVl : Position Verticale (0 = bas, 1 = haut)
%==========================================================================

if nargin==0
    help figure_position;
    return;
end;

% Vérification des arguments d'entrée
TailleMin = 0.1; % taille mini = 10% de l'écran
TailleH = min(1,max(TailleMin,TailleH)); 
TailleV = min(1,max(TailleMin,TailleV));
CentrageH = min(1,max(0,CentrageH));
CentrageV = min(1,max(0,CentrageV));

% Taille écran
scrsz = get(0,'ScreenSize');

%--------------------------------------------------------------------------
% Points extrêmes
%--------------------------------------------------------------------------
rogne	= 10;
Bas     = rogne;            % Point Bas
Haut	= scrsz(4) - rogne;	% Point Haut
Gauche	= rogne;            % Point Gauche
Droite	= scrsz(3) - rogne;	% Point Droite

%--------------------------------------------------------------------------
% Position horizontale
%--------------------------------------------------------------------------

% Taille figure
largeurmin	= (Droite-Gauche) * TailleMin;
largeur     = (Droite-Gauche) * TailleH - rogne * (1/TailleH-1);
largeur     = max(largeurmin,largeur);

% Plage de réglage de la position horizontale
PH_gauche = Gauche;
PH_droite = Droite-largeur;

% Position horizontale
PositionH = (1-CentrageH) * PH_gauche + CentrageH * PH_droite;

%--------------------------------------------------------------------------
% Position verticale
%--------------------------------------------------------------------------

% Taille du bandeau des figures
bandeau	= 0.08*scrsz(4);
rogne	= 12;

% Taille figure
hauteur = (Haut-Bas) * TailleV - (1 -TailleV) * rogne - bandeau;

% Plage de réglage de la position horizontale
PV_basse = Bas;
PV_haute = Haut-hauteur-bandeau;

% Position verticale
PositionV = (1-CentrageV) * PV_basse + CentrageV * PV_haute;

%--------------------------------------------------------------------------
% Ouverture de la figure
%--------------------------------------------------------------------------
if nargout==0
    figure('Position',[PositionH PositionV largeur hauteur]);        
else
    nf = figure('Position',[PositionH PositionV largeur hauteur]);
end;