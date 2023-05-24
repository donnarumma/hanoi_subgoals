function [priors] = updatePriorsMultiple(MCnames,mn)
% function [priors] = updatePriorsMultiple(MC,names)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  update priors after voting
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% 
% 
    load(MCnames{1});
    probs       = getMediumVar(MC);
    totprobs    = zeros(size(probs{1}));
    oldpriors   = MC.models{mn}.subgoal_priors;
    for k=1:length(probs)
        totprobs = totprobs + probs{k};
    end
    
    for i=2:length(MCnames)
        
        load(MCnames{i});
        probs      = getMediumVar(MC);    
        
        for k=1:length(probs)
            totprobs = totprobs + probs{k};
        end
        
    end
    totprobs = totprobs/sum(totprobs);
    
    priors = totprobs.*oldpriors;
    priors = priors/sum(priors);
return
    