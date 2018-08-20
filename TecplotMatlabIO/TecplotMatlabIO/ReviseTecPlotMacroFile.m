function ReviseTecPlotMacroFile(inputTemplateMacroFile, inputImageFile,outputImageFile, outputMacroFile)
% replace file name(inputImage ) with another image file name(outputImageFile) in  tecplot macro file, 
% param: inputTemplateMacroFile, inputImageFile,outputImageFile,outputMacroFile
% NO space in imageFileStem

str=inputImageFile;
inputImageType=str((size(str,2)-2):size(str,2));

% JPG or JPEG ...
if ~strcmp(inputImageType, 'bmp') 
    error('input image file must be bmp type');
end
% test if it is supported by image laoder addon? must be bmp ppm ---
%outputMacroFile = strcat(imageFileStem, '.mcr');

ifid = fopen(inputTemplateMacroFile,'r');
ofid=fopen(outputMacroFile,'w');

% if there is quite a lot var need to reset, use a map of key/value 
inputFileVarSetString = '$!VarSet |FNAME| = ';
outputFileVarSetString = '$!EXPORTSETUP EXPORTFNAME =';

while 1
    tline = fgets(ifid); % keep the newline char as ending
    if ~ischar(tline)
        break
    elseif strfind(tline, inputFileVarSetString);  
        tline=strcat( inputFileVarSetString,'"', inputImageFile, '"');
        disp(strcat('found the set string', tline) );  
        fprintf(ofid, '%s\r\n',tline);
    elseif strfind(tline, outputFileVarSetString);
        tline=strcat( outputFileVarSetString,'"', outputImageFile, '"');
        disp(strcat('found the set var: ', tline) );  
        fprintf(ofid, '%s\r\n',tline);
    else
        fprintf(ofid, '%s',tline);
    end
end % while

fclose(ifid);
fclose(ofid);

end