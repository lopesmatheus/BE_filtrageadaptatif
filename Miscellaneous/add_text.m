function titre=add_text(titre,textp)

% titre = add_text(titre,textp);
%--------------------------------------------------------------------------
% Concatenation de titres
%--------------------------------------------------------------------------
% titre = entete pouvant avoir plusieurs lignes
% textp = autre texte a rajouter a l'entete
%--------------------------------------------------------------------------

% Author:   Philippe Mouyon, ONERA


nligtxt=size(textp,1);

for k=1:nligtxt
  titre=mktit(titre,textp(k,:));
end;
