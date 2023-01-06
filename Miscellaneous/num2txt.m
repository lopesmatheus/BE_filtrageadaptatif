function titre=num2txt(tabnum,forma)

% titre = num2txt(tabnum,forma);
%--------------------------------------------------------------------------
% Passage en texte d'une matrice
%--------------------------------------------------------------------------
%  tabnum = matrice de nombres
%  titre  = meme matrice en texte
%
%  [forma] = format a utiliser dans titre
%            par defaut '  %7.4f'
%--------------------------------------------------------------------------

% Author:   Philippe Mouyon, ONERA


[nlig,nnbre]=size(tabnum);

if exist('forma')==0
  forma='  %7.4f';
end;

if nlig==0
  titre=[];
end;

for ic=1:nlig
  titlig=num2str([]);

  for jc=1:nnbre
    ajout=sprintf(forma,tabnum(ic,jc));
    titlig=[titlig,ajout];
  end;

  if exist('titre')==0
    titre=titlig;
  else
    titre=mktit(titre,titlig);
  end;
end;
