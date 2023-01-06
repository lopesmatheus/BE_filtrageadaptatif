function []=subplot_text(varargin);

% subplot_text(nl,nc,n,titre,FontWeight,FontSize);
%--------------------------------------------------------------------------
%  ouvre un subplot, ajoute un titre sur cet emplacement, efface les axes.
%--------------------------------------------------------------------------
%  nl,nc,n ou N : meme syntaxe qu'un subplot
%  titre        : texte (multilignes) a ecrire a la place du subplot
%  FontWeight, FontSize : meme syntaxe qu'un subplot
%--------------------------------------------------------------------------

% Author:   Philippe Mouyon, ONERA


nl = varargin{1};
if ischar(nl)
    
    %------------------------------------
    % SYNTHAXE : subplot_text(titre,[]);
    %------------------------------------
    titre = nl;
    varother = {varargin{2:end}};
    
elseif isnumeric(nl)
    
    nc = varargin{2};
    if ischar(nc)
        
        %------------------------------------
        % SYNTHAXE :  subplot(N,titre,[]);
        %------------------------------------
        titre = nc;
        subplot(nl);
        varother = {varargin{3:end}};
        
    elseif isnumeric(nc)
        
        n     = varargin{3};
        titre = varargin{4};
        
        %----------------------------------------
        % SYNTHAXE :  subplot(nl,nc,n,titre,[]);
        %----------------------------------------
        subplot(nl,nc,n);
        varother = {varargin{5:end}};

    end;
end;

%----------------------------------------
% Traitement des arguments Font et Size
%----------------------------------------
FontSize   = 10;
FontWeight = 'normal';

narg = length(varother);
for k = 1:narg
    qwe = varother{k};
    if ischar(qwe) FontWeight = qwe; end;
    if isnumeric(qwe) FontSize = qwe; end;
end;


%----------------------------------------
% Enfin!
%----------------------------------------
if size(titre,1)==1
    ypos = 0;
else
    ypos = 0.5;
end;
h=text(0,ypos,titre,'FontWeight',FontWeight,'FontSize',FontSize);
set(gca,'Visible','off');



