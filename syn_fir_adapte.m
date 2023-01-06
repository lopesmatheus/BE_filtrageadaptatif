function [riG]=syn_fir_adapte(canal,dt,flagt)

% [riG]=syn_fir_adapte(canal,dt,flagt);
%--------------------------------------------------------------------------
% Filtre FIR adapté
%--------------------------------------------------------------------------
% canal :   modèle du canal acoustique
% dt	:	pas d'échantillonnage
% flagt :   indicateur de tracé
%
% riG   :	réponse impulsionnelle du filtre FIR adapté
%--------------------------------------------------------------------------

fprintf('Calcul du filtre FIR adapte à sigs=0\n');


%--------------------------------------------------------------------------
% Modèle du canal F à temps continu
%--------------------------------------------------------------------------

% Paramètres
w  = canal.w;
xi = canal.xi;
g  = canal.g;

% Modèle d'état du canal
AF = [ 0 1 ; -w^2 -2*xi*w ];
BF = [ 0 ; w^2];
CF = [ g 0 ];
DF = [0 ];
sysFc = ss(AF,BF,CF,DF);

% Réponse impulsionnelle 
[riFc,Tc] = impulse(sysFc);
Tcmax = Tc(end,1);

% Réponse impulsionnelle discrétisée
N       = ceil(Tcmax/dt);
Td      = (0:1:N-1)'*dt;
[riFd]	= impulse(sysFc,Td);

%--------------------------------------------------------------------------
% Filtre FIR adapté 
%--------------------------------------------------------------------------

% Réponse impulsionnelle
riG = -riFd*dt;

% Modèle d'état
AG = [zeros(N-1,1) [eye(N-2,N-2);zeros(1,N-2)]];
BG = riG(2:N,1);
CG = zeros(1,N-1);CG(1,1)=1;
DG = riG(1,1);
sysGd = ss(AG,BG,CG,DG,dt);
    
%--------------------------------------------------------------------------
% Analyse du filtre RIF comparée au filtre F
%--------------------------------------------------------------------------
if flagt==1
    figure;
    
    % Bode Fc
    subplot(121);
    bode(AF,BF,CF,DF);
    
    % Bode G
    hold on;
    dbode(AG,BG,CG,DG,dt,1);
    grid on;
    legend('F','G','Location','Best');
    
    % réponses impulsionnelle de F et G
    subplot(13,2,[4 12]);
    YGimp	= dimpulse(AG,BG,CG,DG,1,N);
    TGimp	= (0:length(YGimp)-1)'*dt;
    plot(Tc,riFc); hold on;
    stairs(TGimp,YGimp); grid on;
    legend('F impulse response','G impulse response','Location','Best');
    xlabel('Time (seconds)'); 
    title('Time Response');
    
    % réponses indicielle de F et G 
    subplot(13,2,[18 26]);
    [YFstep,TFstep] = step(sysFc);
    YGstep  = dstep(AG,BG,CG,DG,1,N);
    TGstep	= (0:length(YGstep)-1)'*dt;
    plot(TFstep,YFstep); hold on;
    stairs(TGstep,YGstep); grid on;
    legend('F step response','G step response','Location','Best');
    xlabel('Time (seconds)'); 
 
    
    % Titre
    axes('Units','normalized','Position', ...
        [0.01 0.96 0.98 0.01], 'Visible', 'Off');
    text('Units','normalized', ...
        'Position', [0.3 0], ...
        'String', '\bf FILTRE ANTI-BRUIT ADAPTE à \sigma_{b_s}=0        ',...
        'HorizontalAlignment', 'center');
    
    drawnow;
end;
