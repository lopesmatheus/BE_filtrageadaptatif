function [res_sim] = lire_logs(logsout)

% [res_sim] = lire_logs(logsout);
%--------------------------------------------------------------------------
% Mise en forme du log de la simulation 
%--------------------------------------------------------------------------
% Pour tous les signaux enregistrés dans le log:
%   res_sim.nom.values :  valeurs du signal 'nom'
%   res_sim.nom.time :    vecteur temps associé
%--------------------------------------------------------------------------

% Les différents éléments présents dans le log
Nel = logsout.numElements;          % Nombre
Names = logsout.getElementNames;    % Liste

% Boucle sur les éléments
for kel = 1:Nel
    nom = Names{kel};
    
    % Extraction du log
    signal  = logsout.getElement(nom).Values.Data;
    temps   = logsout.getElement(nom).Values.Time;
    
    % Petis arrangements entre amis
    signal = squeeze(signal);
    if size(signal(1,:),2)==length(temps)
        signal = signal';
    end;
    
    % Enregistrement
    eval(['res_sim','.',nom,'.values = signal;']);
    eval(['res_sim','.',nom,'.time = temps;']);
end;


