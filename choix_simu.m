function [simu,filtre] = choix_simu(k,spec_sim,simulation,filtreRIF)

% [simu,filtre] = choix_simu(k,spec_sim,simulation,filtreRIF);
%--------------------------------------------------------------------------
% Pr�paration des structures utilis�es par la simulation
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Le sch�ma de simulation utilise les structures : simu, canal et filtre.
%
% La structure "canal" est identique quelque soit la simulation.
%
% La structure "simulation" est transform� en "simu".
%   - ajout des niveaux de bruit
%   - ajout description textuelle
%   - ajout flag de trac�
%
% La structure "filtreRIF" est transform�e en "filtre".
%   - ajout valeur de mu
%   - supression du nom de l'algorithme (pas support� par Simulink R2015b)
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Lecture des sp�cifications
%--------------------------------------------------------------------------

% Bruits de mesure
tab_sigbe = spec_sim.tab_sigbe;
tab_sigbs = spec_sim.tab_sigbs;

% Pas d'adaptation
tab_mu    = spec_sim.tab_mu;

% Nombres de cas � simuler
Nrho = spec_sim.Nrho;
Nbe = length(spec_sim.tab_sigbe);
Nbs = length(spec_sim.tab_sigbs);
Nmu = length(spec_sim.tab_mu);

%--------------------------------------------------------------------------
% Mise en forme 
%--------------------------------------------------------------------------

% D�finition des trac�s
if Nrho==1      % On trace les r�ponses temporelles
    flagt(1) = 1;
    flagt(2) = 0;
else            % On trace l'indice de performance
    flagt(1) = 0;
    flagt(2) = 1;
end; 

% Description (pour impression)
texte = [];
texte = add_text(texte,['\bf FILTRE:']);
texte = add_text(texte,[...
    '    Nx   = ',num2str(filtreRIF.Nx,3),...
    '    dt   = ',num2str(filtreRIF.dt,3)]);

if length(tab_mu)==1
    texte = add_text(texte,[...
    '    Algo   = ',filtreRIF.NomAlgo,...
    '    \mu   = [',num2str(tab_mu(1),2),']']);
else
    texte = add_text(texte,[...
    '    Algo   = ',filtreRIF.NomAlgo,...
    '    \mu   = [',num2str(tab_mu(1),2),',',num2str(tab_mu(end),2),']']);
end;

if length(tab_sigbe)==1
    tsbe = ['    \sigma_{be}   = [',num2str(tab_sigbe(1),2),']'];
else
    tsbe = ['    \sigma_{be}   = [',num2str(tab_sigbe(1),2),' - ',num2str(tab_sigbe(end),2),']'];
end;
if length(tab_sigbs)==1
    tsbs = ['    \sigma_{bs}   = [',num2str(tab_sigbs(1),2),']'];
else
    tsbs = ['    \sigma_{bs}   = [',num2str(tab_sigbs(1),2),' - ',num2str(tab_sigbs(end),2),']'];
end;
texte = add_text(texte,merge_text(tsbe,tsbs,'h'));

% Indices � utiliser pour la simulation n� k
kk = 0;
for ie = 1:Nbe
    for is = 1:Nbs
        for im = 1:Nmu
            kk = kk+1;
            if kk==k 
                kbe = ie;
                kbs = is;
                kmu = im;
            end;
        end;
    end;
end;

%--------------------------------------------------------------------------
% Structure "simu" utilis�e par le sch�ma de simulation
%--------------------------------------------------------------------------

% Initialisation
simu	= simulation;

% Ecarts-types des bruits de mesures
simu.sigbe = tab_sigbe(kbe);
simu.sigbs = tab_sigbs(kbs);

% Description
simu.texte = texte;

% Trac�
simu.flagt = flagt;

% Passage des param�tres dans le workspace
assignin('base','simu',simu);

%--------------------------------------------------------------------------
% Structure "filtre" utilis�e par le sch�ma de simulation
%--------------------------------------------------------------------------

% Initialisation
filtre	= filtreRIF;

% Algorithme d'adaptation (num�ro, car nom pas support� par Simulink R2015b)
filtre	= rmfield(filtre,'NomAlgo'); 

% Pas d'adaptation
filtre.mu = tab_mu(kmu);

% Passage des param�tres dans le workspace
assignin('base','filtre',filtre);


