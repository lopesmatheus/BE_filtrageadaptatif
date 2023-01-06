function plot_sim(res_sim,simu,perfo)

% plot_sim(res_sim,simu,perfo);
%------------------------------------------------------------------
% tracé des résultats de simulation
%------------------------------------------------------------------

% -- extraction du log --
tab_s   = res_sim.tab_s;
tab_y   = res_sim.tab_y;
tab_e   = res_sim.tab_e;
tab_sm  = res_sim.tab_sm;
tab_em  = res_sim.tab_em;
tab_u   = res_sim.tab_u;
tab_riG   = res_sim.tab_riG;

figure_position(0.9,0.9,0.5,0.5);

subplot(331);
t = tab_s.time;
s = tab_s.values;
plot(t,s);grid on;
xlabel('\bf s(t) : bruit émis');

subplot(332);
t = tab_y.time;
y = tab_y.values;
plot(t,y);grid on;
xlabel('\bf y(t) : bruit transmis');

subplot(333);
t = tab_e.time;
e = tab_e.values;
plot(t,e);grid on;
xlabel('\bf e(t) : bruit résiduel');

subplot(334);
t = tab_sm.time;
sm = tab_sm.values;
plot(t,sm);grid on;
xlabel('\bf s_m(t) : mesure du bruit émis');

subplot(335);
t = tab_u.time;
u = tab_u.values;
plot(t,u);grid on;
xlabel('\bf u(t) : anti-bruit');

subplot(336);
t = tab_em.time;
em = tab_em.values;
plot(t,em);grid on;
xlabel('\bf e_m(t) : mesure du bruit résiduel');

subplot(337);
t = tab_riG.time;
riG = tab_riG.values;
nriG = sum(riG.*riG,2);
plot(t,nriG);grid on;
xlabel('\bf || \theta ||(t) : norme des paramètres');

texte = add_text(' ',simu.texte);
subplot_text(3,3,[8],texte);

texte = add_text(' ',perfo.texte);
texte = add_text(' ',texte);
subplot_text(3,3,[9],texte);

