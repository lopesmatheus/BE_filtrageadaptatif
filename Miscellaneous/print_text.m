function print_text(titre,fid)

% print_text(titre,[fid]);
%--------------------------------------------------------------------------
% Impression d'un titre
%--------------------------------------------------------------------------
% titre : titre pouvant avoir plusieurs lignes
%
% fid   :
%         []     => Impression à l'écran
%         num    => Ecriture dans le fichier identifié par num
%         'nom'  => Impression sur l'imprimante "nom"
%--------------------------------------------------------------------------

% Author:   Philippe Mouyon, ONERA


if nargin==1
    fid=[];
end;

% Impression à l'écran
%----------------------
if isempty(fid)
    nlig=size(titre,1);
    for k=1:nlig
        tampon=titre(k,:);
        fprintf('%s',tampon);
        fprintf('\n');
    end;
    return
end;

% Impression dans un fichier (ouvert en écriture)
%----------------------------
if isnumeric(fid)
    nlig=size(titre,1);
    for k=1:nlig
        tampon=titre(k,:);
        fprintf(fid,tampon);
        fprintf(fid,'\n');
    end;
    return
end;

% Impression sur imprimante
%---------------------------
if ischar(fid)
    % Creation d'un fichier temporaire
    printer=fid;
    name='Ztemp';
    while exist(name,'file') name=[name,name]; end;
    fid = fopen(name,'w');
    % Ecriture dans le fichier
    print_text(titre,fid);
    fclose(fid);
    % Impression du fichier
    eval(['!lp -scP',printer,' ',name]);
    % Nettoyage
    eval(['delete ',name]);
end;
