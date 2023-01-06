function titre=mktit(titre,titp)

% titre=mktit(titre,titp);
%--------------------------------------------------------------------------
% Concatenation de titres
%--------------------------------------------------------------------------
% titre = entete pouvant avoir plusieurs lignes
% titp  = ligne a rajouter a l'entete
%--------------------------------------------------------------------------

% Author:   Philippe Mouyon, ONERA


deblank(titp);

siztit=size(titre,2);
siztitp=size(titp,2);
plus=siztitp-siztit;

if plus<0
  fin=blanks(-plus);
  titp=[titp,fin];
elseif plus>0
  fin=blanks(plus);
  nlig=size(titre,1);
  tit=[];
  for k=1:nlig
    tampon=titre(k,:);
    tampon=[tampon,fin];
    tit=[tit;tampon];
  end;
  titre=tit;
end;

titre=[titre;titp];
