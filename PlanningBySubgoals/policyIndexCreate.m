function [possibilities, total, numps] = policyIndexCreate(transition_cpt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [possibilities, total, numps] = policyIndexCreate(transition_cpt)
% Description:
% create a graph structure of the state and transitions 
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
%
% Note:
% This code is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU
% General Public License can be obtained from the
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ns  = size(transition_cpt,1);
    
possibilities = cell(1,ns);
total = 1;
numps = ones(1,ns);
for si=1:ns
    [i,~,k] = ind2sub(size(transition_cpt(si,:,:)), find(transition_cpt(si,:,:)==1));
    possibilities{si} = k;
    numps (1,si) = length(i); 
    total = total*length(i);
end
numps=numps(end:-1:1);
return
