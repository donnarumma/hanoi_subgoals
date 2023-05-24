function s=num2strLexi(num,hm)
% function s=num2strLexi(num,hm)
% 
% transform number to strings in order to get lexicographical order
%
% Authors:     Francesco Donnarumma, Domenico Maisto, Giovanni Pezzulo
%                  
% Note:
% This code is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This code is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3
    hm=3;
end
if num==0
    cn=1;
else
    cn= ceil(log10(num+1)); % number of cypher
end
st='0';
s='';
for i=1:hm-cn
    s=[st,s];
end
s=sprintf('%s%s',s,num2str(num));
return