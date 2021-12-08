function convert_to_hgp_file( fileName, colorpalname, nSteps )
%convert_to_hgp_file convert/prepare MATLAB colormaps and export them
% for usage with HILGUS/OCULUS.
% 
% Simple function that allows the conversion of MATLAB colormaps to use
% them with HILGUS/OCULUS.
%
% Implemented by Daniel Hufschläger © 2019
%

if nSteps > 256
    nSteps = 256;
end

% get colormap values in regard with requested interpolation size
colorpal = 0;
eval(['colorpal = ', colorpalname, '(', num2str(nSteps), ');' ] );

% open/create file for writing
fD = fopen( fileName ,'w');
% Writing header
fprintf( fD, '[Palette]\n');
% Writing number of color steps
fprintf( fD, 'Steps=%d\n', nSteps);

% Stetting invalid, not measured and no time of flight colors to default
% values. These should be changed through the color editor after
% importing.

fprintf( fD, 'InvalidColor=16777215\n');
fprintf( fD, 'NotMeasColor=16777215\n');
fprintf( fD, 'NoTOFColor=15790320\n');

% Writing the color pal name 
fprintf( fD, 'Name=%s\n', colorpalname );

for iDx = 0:nSteps-1
    % get color and scale the values
    cColor = floor(256*colorpal( iDx+1, :));
    % data is stored inverted ( RGB -> BGR )
    color = uint32( 2^16 * cColor(3) + 2^8 * cColor(2) + cColor(1));
    fprintf( fD, 'Color%d=%ld\n', iDx, color );
end
    
% be tidy and closing the file descriptor
fclose(fD);

end

