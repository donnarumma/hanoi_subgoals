function [pol, ks] = sampleP(transition_cpt,possibilities)
% function [pol ks] = sampleP(transition_cpt,possibilities)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  sample a random policy
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
    na  = size(transition_cpt,2);
    ns  = size(transition_cpt,1);
    ks = zeros(1,ns);
    pol = zeros(ns,na);
    for si=1:ns
        k = randi(length(possibilities{si}));
        ks(si)=k;
        pol(si,:) = transition_cpt(si,:,possibilities{si}(k));
    end
    
return