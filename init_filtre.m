function filtreRIF = init_filtre(simulation,canal,flagt)

% [filtreRIF] = init_filtre(simulation,canal,flagt);
%---------------------------------------------------------------------
% Initialisation du filtre
%---------------------------------------------------------------------

% -- Filtre anti-bruit acoustique --
dt = 1*simulation.dt;     % Pas d'échantillonnage
NomAlgo = 'RLS'; %'sans';         % Algorithme d'adaptation
%Init    = 'zero';%'G_0*'; %'G_0*';         % Initialisation de la RI ('zero' ou 'G_0*')

if strcmp(NomAlgo,'sans')
    Init = 'G_0*';
else
    Init = 'zero';
end

% Numéro de l'algo d'adaptation
if strcmp(NomAlgo,'sans') NumAlgo=0; end;
if strcmp(NomAlgo,'NLMS') NumAlgo=1; end;
if strcmp(NomAlgo,'LMS')  NumAlgo=2; end;
if strcmp(NomAlgo,'RLS')  NumAlgo=3; end;

%--------------------------------------------------------------------------
% Etude du filtre adapté au cas sans bruit ('G_0*')
%--------------------------------------------------------------------------
[riG_opt] = syn_fir_adapte(canal,dt,flagt);

%--------------------------------------------------------------------------
% Réponse impulsionnelle initiale
%--------------------------------------------------------------------------
if strcmp(Init,'zero')
    riG_ini = zeros(length(riG_opt),1);
elseif strcmp(Init,'G_0*')
    riG_ini = riG_opt;   
end;

%--------------------------------------------------------------------------
% Enregistrement
%--------------------------------------------------------------------------
filtreRIF.dt = dt;              % Pas d'échantillonnage
filtreRIF.NomAlgo = NomAlgo;  	% Nom algorithme d'adaptation
filtreRIF.NumAlgo = NumAlgo;  	% Numero algorithme d'adaptation
filtreRIF.riG_ini = riG_ini;	% Initialisation de la RI
filtreRIF.Nx = length(riG_ini);	% Longueur de la RI
filtreRIF.H_ini = 0.1*eye(length(riG_ini));

