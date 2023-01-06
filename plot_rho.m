function plot_rho(spec_sim,perfo,simu)

% plot_rho(spec_sim,perfo,simu);
%------------------------------------------------------------------
% tracé des résultats de simulation
%------------------------------------------------------------------

tab_sigbe   = spec_sim.tab_sigbe;
tab_sigbs   = spec_sim.tab_sigbs;
tab_mu      = spec_sim.tab_mu;
Nrho        = spec_sim.Nrho;
Npts        = length(perfo(1).nriG.time);

tab_rho = zeros(Nrho,1);
tab_nriG = zeros(Npts,Nrho);

for k = 1:Nrho
    tab_rho(k,1) 	= perfo(k).rho;
    tab_nriG(:,k)   = perfo(k).nriG.values;
    tab_t(:,1)      = perfo(k).nriG.time;
end;

tab_rhodB=10*log10(tab_rho);

% Qu'est-ce qui a varie?
vbe=0; vbs=0; vmu=0;
if std(tab_sigbe)>eps vbe=1; end;
if std(tab_sigbs)>eps vbs=1; end;
if std(tab_mu)>eps vmu=1; end;


%------------------------------------------------------------------
% Tracé pour une variation de sig_bs
%------------------------------------------------------------------
if norm([vbe vbs vmu]-[0 1 0])==0
    
    figure_position(0.6,0.6,0,0.5);
    
    subplot(221);
    plot(tab_sigbs,tab_rho,'b-');
    grid on;
    xlabel('\bf Performances: \rho( \sigma_{b_s} )');
    axis([0 max(tab_sigbs) min(tab_rho) max(tab_rho)]);
    
    subplot(222);
    plot(tab_sigbs,tab_rhodB,'b-');
    grid on;
    xlabel('\bf Performances: \rho( \sigma_{b_s} ) [dB] ');
    axis([0 max(tab_sigbs) min(tab_rhodB) max(tab_rhodB)]);
    
    subplot(223);
    plot(tab_t,tab_nriG','b-');
    grid on;
    xlabel('\bf ||riG||(t) : norme du filtre');
    axis([0 max(tab_t) 0 max(max(tab_nriG))]);
    
    subplot_text(224,simu.texte);
    
end;


%------------------------------------------------------------------
% Tracé pour une variation de sig_be
%------------------------------------------------------------------
if norm([vbe vbs vmu]-[1 0 0])==0
    
    figure_position(0.6,0.6,0,0.5);
    
    subplot(221);
    plot(tab_sigbe,tab_rho,'b-');
    grid on;
    xlabel('\bf Performances: \rho( \sigma_{b_e} )');
    
    subplot(222);
    plot(tab_sigbe,tab_rhodB,'b-');
    grid on;
    xlabel('\bf Performances: \rho( \sigma_{b_e} ) [dB] ');
    
    subplot(223);
    plot(tab_t,tab_nriG','b-');
    grid on;
    xlabel('\bf ||riG||(t) : norme du filtre');
    
    subplot_text(224,simu.texte);
end;


%------------------------------------------------------------------
% Tracé pour une variation de mu
%------------------------------------------------------------------
if norm([vbe vbs vmu]-[0 0 1])==0 
    
    figure_position(0.6,0.6,0,0.5);
    
    subplot(221);
    plot(tab_mu,tab_rho,'b-');
    grid on;
    xlabel('\bf Performances: \rho( \mu )');
    
    subplot(222);
    plot(tab_mu,tab_rhodB,'b-');
    grid on;
    xlabel('\bf Performances: \rho( \mu ) [dB] ');
    
    subplot(223);
    plot(tab_t,tab_nriG','b-');
    grid on;
    xlabel('\bf ||riG||(t) : norme du filtre');
    
    subplot_text(224,simu.texte);

end;


