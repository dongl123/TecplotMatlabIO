function [Nx, Ny] = ExtractTecPlotVecDim(filehead)
%---------- 2d vec dim lookup -------
%  filehead must be a char vector 
%  first the 2d vec dim should be extract from the data.textdata cell array
%  I=68, J=68,F=POINT
datapackingformat = '=POINT';
% filehead is a cell array,  extract to char array
point_format = strfind(filehead,datapackingformat);
if point_format < 1  
    % '=POINT' is not found in filehead
    error('vec is not the datapackingformat: =POINT is not found in filehead');
end

itoken = 'I=';
jtoken = 'J=';
ipos = strfind(filehead,itoken);
if(size(ipos,2)<1) % not found
    itoken = 'i=';
    ipos = strfind(filehead,itoken);
end

jpos = strfind(filehead,jtoken);
if(size(jpos,2)<1) % not found
    jtoken = 'j=';
    jpos = strfind(filehead,jtoken);  
end
if (size(ipos,2)<1  || size(jpos,2)<1 )
    error('can not find i=/I= or j=/J= tokennizer in the file head');
end

% what happens if I do not declear var outside loop? should be fine in Matlab
if ( size(ipos,2) == 1 && size(jpos,2) == 1 )
i = 1;
j = 1;

endTokenChar = ',';
while filehead(ipos + size(itoken,2)+i-1) ~= endTokenChar
%while i<3
    istr(i) = filehead(ipos + size(itoken,2)+i-1);
    i = i + 1;
end

while filehead(jpos+size(jtoken,2)+j-1) ~= endTokenChar
    jstr(j) = filehead(jpos+size(jtoken,2)+j-1);
    j = j + 1;
end

Nx = int32( str2double(istr) );  % I= row, firtst dim of vec field
Ny = int32( str2double(jstr) );

else
    error('"I=" or "J=" string can not been found, not unique or not capitaled?');
end

end % end of function ExtractVecDim()