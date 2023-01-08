function [spec_sim] = specif_simu(cas)

% [spec_sim] = specif_simu(cas);
%---------------------------------------------------------------------
% Spécification des cas à simuler
%---------------------------------------------------------------------
% tab_sigbe :  la liste des sig_be
% tab_sigbs :  la liste des sig_bs
% tab_mu    :  la liste des mu
% Nrho      :  le nombre total de cas
%---------------------------------------------------------------------
sigs = 3.406855956653819;

switch cas
    case 1
        %------------------------------------------------------------------
        % Une seule simulation 
        %------------------------------------------------------------------
        spec_sim.tab_sigbe = 0;
        spec_sim.tab_sigbs = 0;
        spec_sim.tab_mu    = 0.5;%0.0001;

    case 2
        %------------------------------------------------------------------
        % Variation de sigma_bs=[0 , 5]
        %------------------------------------------------------------------
        spec_sim.tab_sigbe = 0;
        spec_sim.tab_sigbs = linspace(0,2*sigs,20)';
        spec_sim.tab_mu    = 1.6;%0.00001;

    case 3
        %------------------------------------------------------------------
        % Variation de mu=[0 , 0.5]
        %------------------------------------------------------------------
        spec_sim.tab_sigbe = 0;
        spec_sim.tab_sigbs = 0;%linspace(0.1,sigs,5);%0;
        spec_sim.tab_mu    = linspace(0.001,3,30)';

    case 4
        %------------------------------------------------------------------
        % Variation de sigma_be=[0 , 0.5]
        %------------------------------------------------------------------
        spec_sim.tab_sigbe = linspace(0,0.5,20)';
        spec_sim.tab_sigbs = 0;
        spec_sim.tab_mu    = 0;

    otherwise
        error('Cas non spécifié');
        
end;

% Nombre total de cas
Nrho = 1;
Nrho = Nrho * length(spec_sim.tab_sigbe);
Nrho = Nrho * length(spec_sim.tab_sigbs);
Nrho = Nrho * length(spec_sim.tab_mu); 
spec_sim.Nrho = Nrho;