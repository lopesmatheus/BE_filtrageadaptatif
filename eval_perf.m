function eval_perf(spec_sim,simulation,filtreRIF)

% eval_perf(spec_sim,simulation,filtreRIF);
%==========================================================================
% Evaluation des performances
%==========================================================================
% spec_sim:     Liste des cas � tester
% simulation:	Caract�ristiques de la simulation
% filtreRIF:	Caract�ristiques du filtre adaptatif
%==========================================================================
fprintf('Evaluation des performances\n');

%--------------------------------------------------------------------------
% Pr�paration des arguments du sch�ma simulink
%--------------------------------------------------------------------------

% Nombre de cas � simuler
Nrho = spec_sim.Nrho;

%--------------------------------------------------------------------------
% Boucle sur les diff�rents cas de simulation 
%--------------------------------------------------------------------------
for k = 1:Nrho
    
    % Affichage
    fprintf(['Simulation n�',num2str(k),'/',num2str(Nrho),': ']);
    
    % Ajustement du cas de simulation
    [simu,filtre] = choix_simu(k,spec_sim,simulation,filtreRIF);
    
    % Simulation (donn�es stock�es dans logsout)
    sim('Simu_FIR');
    [res_sim(k)] = lire_logs(logsout);
    
    % Analyse de performance
    [perfo(k)] = ana_sim(res_sim(k));
    
    % Trac�
    if simu.flagt(1)==1
        plot_sim(res_sim(k),simu,perfo(k))
    end;
    
    % Affichage
    fprintf(['sigbe=',num2str(simu.sigbe,2),...
        ', sigbs=',num2str(simu.sigbs,2),...
        ', Algo=',filtreRIF.NomAlgo,...
        ', mu=',num2str(filtre.mu,2),...
        ', rho=',num2str(10*log10(perfo(k).rho),2),' [dB] \n']);
%     fprintf(perfo.texte)

    sigbs(k) = simu.sigbs;
    mu_p(k) = filtre.mu;
end;

% figure()
% txt = [];
% hold on
% for i=1:length(spec_sim.tab_sigbs)
%     cont = 1;
%     for k = 1:Nrho
%         if(sigbs(k)==spec_sim.tab_sigbs(i))
%             rho_plot(cont) = 10*log10(perfo(k).rho);
%             mu_plot(cont) = mu_p(k);
%             cont = cont + 1;
%         end
%     end
%     plot(mu_plot,rho_plot,'LineWidth',1.2)
%     txt = add_text(txt,['\sigma_{bs} = ',num2str(spec_sim.tab_sigbs(i),3)]);
% end
% 
% hold off
% title('�tude param�trique \mu')
% xlabel('\mu')
% ylabel('\rho [dB]')
% legend(txt)

% trac� de l'indice de performance
if simu.flagt(2)==1
    plot_rho(spec_sim,perfo,simu);
end;
