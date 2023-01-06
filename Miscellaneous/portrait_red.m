

%   portrait reduit:  Met la figure courante au format A4 et en mode portrait

  Ox =  2.0 ;
  Oy =  2.0 ; 
  Px = 25.0 ; 
  Py = 21.0 ;
  Lx=Px-2*Ox;
  Ly=Py-2*Oy;

%  
%   configuration impression
%

  PaperOrientation = 'portrait' ;
  PaperUnits = 'centimeters';
  PaperPosition = [ Ox Oy Ly Lx ] ;
  PaperType = 'a4letter';

%
%   configuration figure
%

  Position = [ Ox+13 Oy Ly Lx ] ;
  Units=' centimeters';

set(gcf,        'PaperType', PaperType, ...
		'PaperOrientation', PaperOrientation, ...
		'PaperUnits',PaperUnits, ...
                'PaperPosition', PaperPosition, ...
                'Units', 'centimeters', ...
		'Position',Position ...
)  ;


