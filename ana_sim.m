function [perfo]=ana_sim(res_sim)

% [perfo] = ana_sim(res_sim);
%----------------------------------------------------------------------
% analyse des r?sultats de simulation
%----------------------------------------------------------------------
% res_sim :  Le log de la simulation (mis en forme par lire_logs))
%
% perfo.rho   :  mesure de la performance de r?jection
% perfo.texte :  Texte pour impression
%----------------------------------------------------------------------

% -- extraction du log --
tab_s  = res_sim.tab_s.values;
tab_y  = res_sim.tab_y.values;
tab_e  = res_sim.tab_e.values;
tab_sm = res_sim.tab_sm.values;
tab_em = res_sim.tab_em.values;
tab_u  = res_sim.tab_u.values;
tab_riG	= res_sim.tab_riG.values;
tab_t	= res_sim.tab_riG.time;

% -- calcul des variances --
sigs_est = std(tab_s);
sigy_est = std(tab_y);
sigu_est = std(tab_u);
sige_est = std(tab_e);

sigsm_est = std(tab_sm);
sigem_est = std(tab_em);

% -- estimation de la performance --
rho   = sige_est/sigy_est;
rho   = rho*rho;
rhodB = 10*log10(rho);

% -- Norme de riG --
nriG.values	= sqrt(sum(tab_riG.*tab_riG,2));
nriG.time	= tab_t;

% -- Pour impression --
texte = [];
texte = add_text(texte,['\bf ANALYSE:']);
texte = add_text(texte,['    \sigma_s   = ',num2str(sigs_est,4),'    \sigma_y   = ',num2str(sigy_est,4),'    \sigma_e   = ',num2str(sige_est,4)]);
texte = add_text(texte,['    \sigma_{s_m} = ',num2str(sigsm_est,4),'    \sigma_u   = ',num2str(sigu_est,4),'    \sigma_{e_m} = ',num2str(sigem_est,4)]);
texte = add_text(texte,['    \rho = ',num2str(rho,2),'  = ',num2str(rhodB,2),' [dB]']);

% -- variable de sortie --
perfo.rho = rho;
perfo.texte = texte;
perfo.nriG = nriG;