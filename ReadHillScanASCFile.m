function [param] = ReadHillScanASCFile( KeyName, filename)
% Reads parameters from Hillger A-Scan measurement files (usally *.asc).
%  
% Syntax
%   param = ReadHillScanASCFile(KeyName, filename) 
%
% Description
%   param = ReadHillScanASCFile(KeyName, filename)
%
%   This function is adapted on GetPrivateProfileString() from the Windows-API
%   that is well known for reading ini-file data. Since we hav no section
%   headers and the declaration of key is slighly different, it is a
%   adapted version.
%
%    The parameters are:
%
%       KeyName  = Key name separated by an equal to sign, of the type abc = 123
%       filename = ASC file name to be used
%
%       param    = double value of the key found, or -1 if key was not
%                  found.
% 
% Implemented by Daniel Hufschläger © 2021
%

param = '';

%% Try to read in inifile
fid = fopen(filename, 'r');
if fid < 0
	warning('MATLAB:HillASC:couldNotOpenInifile', 'Ini-file "%s" was not found or could not be read.', filename);
	return
end%if

% input to a string
data = fread(fid, '*char')';
fclose(fid);
%% Separate lines and parse away
curKey = '';
while(~isempty(data))
    % get next line by LFs
    [curLine, data] = strtok(data, char(10)); %#ok<STTOK>
    
    % remove whitespace (includes removing CRs if present)
    curLine = strtrim(curLine);
    
    % if line's empty or too short
    if length(curLine) < 2
        % ignore empty lines, or in this case lines with a max of 1 char,
        % there's nothing we can do
    
    % if we have a comment
    elseif strcmp(curLine(1), ';') 
        % ignore this line, it's a comment       
    % or if we have a key
    elseif ~isempty(strfind(curLine, ':')) % found a :, it's a key
        [curKey, remainder] = strtok(curLine, ':');
        curVal = strtok(remainder, ':');       
        %% removing nasty units from key values
        if ~isempty(strfind(curKey, '['))
            [curKey, ~] = strtok(curKey, '[');
        end % if              
        % remove whitespaces from tokens
        curKey = strtrim(curKey);
        curVal = strtrim(curVal);
    
    % this means we also ignore all other lines with rubbish etc in them...
    end%if
    
    % check if we found what we're looking for, NOT case sensitive
    if strcmpi(curKey, KeyName)
        param = str2double(curVal);
        return
    else
        param = -1;
    end%if
    
end%while

end % function