function text = merge_text(text1,text2,info);

% text = merge_text(text1,text2,[info]);
%--------------------------------------------------------------------------
% Merge two string arrays
%--------------------------------------------------------------------------
% info :  specify the way to merge the two texts (default is 'v')
%      info = 'v'   vertical merging
%      info = 's'   vertical merging with repetition of the shortest text
%      info = 'h'   horizontal merging
%      info = 'r'   horizontal merging with repetition of the shortest text
%      info = 'n'   horizontal merging with lign numbering added
%--------------------------------------------------------------------------

%  Philippe MOUYON     ONERA


if nargin<2
    help merge_text
    return
end;

if nargin==2
    info = 'v';
end;


%---------------------
% Vertical merging
%---------------------
if strcmp(info,'v')
    text = add_text(text1,text2);
end;

%--------------------------------------
% Vertical merging with repeated text
%--------------------------------------
if strcmp(info,'s')
    ncol1 = size(text1,2);
    ncol2 = size(text2,2);
    ncol  = max(ncol1,ncol2);
    
    text = '';
    for k = 0:ncol-1
        col1 = text1(:,rem(k,ncol1)+1);
        col2 = text2(:,rem(k,ncol2)+1);
        
        col  = [col1;col2];
        text = merge_text(text,col,'h');
    end;

end;

%---------------------
% Horizontal merging
%---------------------
if strcmp(info,'h')
    [nlig1,ncol1] = size(text1);
    [nlig2,ncol2] = size(text2);
    nlig  = max(nlig1,nlig2);
    
    blanc = '';
    if nlig1<nlig2 && ncol1>0, blanc(1,ncol1) = ' '; end;
    if nlig1>nlig2 && ncol2>0, blanc(1,ncol2) = ' '; end;
        
    text = '';
    for k = 1:nlig
        if k<= nlig1  lig1 = text1(k,:);
        else          lig1 = blanc;         end;
        
        if k<= nlig2  lig2 = text2(k,:);
        else          lig2 = blanc;         end;
        
        lig  = [lig1 lig2];
        text = add_text(text,lig);
    end;
end;

%----------------------------------------
% Horizontal merging with repeated text
%----------------------------------------
if strcmp(info,'r')
    nlig1 = size(text1,1);
    nlig2 = size(text2,1);
    nlig  = max(nlig1,nlig2);
    
    text = '';
    for k = 0:nlig-1
        lig1 = text1(rem(k,nlig1)+1,:);
        lig2 = text2(rem(k,nlig2)+1,:);
        
        lig  = [lig1 lig2];
        text = add_text(text,lig);
    end;
end;

%---------------------------------------
% Horizontal merging and lign numbering 
%---------------------------------------
if strcmp(info,'n')
    nlig1 = size(text1,1);
    nlig2 = size(text2,1);
    if nlig1>nlig2
        tampon  = text2;    nlt     = nlig2;
        text2	= text1;    nlig2	= nlig1;
        text1   = tampon;   nlig1	= nlt;
    end;
    if nlig1==1
        text2 = merge_text(text1,text2,'r');
    else
        text2 = merge_text(text1,text2,'h');
    end;
    nlig2 = size(text2,1);
    text1 = num2str((1:nlig2)');
    text1 = merge_text(text1,' :  ','r');   
    text  = merge_text(text1,text2,'h');
end;
