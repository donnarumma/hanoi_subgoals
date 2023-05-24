% function probPaths=getMediumVar(MC,ShowVar,takeAll)
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  get probabilities of successful samples
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
% SG      = 1;
% P       = 2;
% S       = 3;
% F       = 4;
% A       = 5;
% R       = 6;

function probPaths=getMediumVar(MC,ShowVar,takeAll)

SG      = 1;
P       = 2;
S       = 3;
F       = 4;
A       = 5;
R       = 6;


if nargin < 3
    takeAll = 0;
end
if nargin < 2
    ShowVar     = SG;
end
count       = 0;
weights     = zeros(1,MC.N);
for i=1:MC.N
    weights(i)=exp(MC.states{i}.logWeight);
    if MC.states{i}.vars{S}==MC.goal_state || takeAll%&& MC.states{i}.vars{1}==MC.goal_state
        count           = count +1;
        indexes(count)  = i;
%         fprintf('Particle %g|w=%g!\n',i,MC.states{i}.logWeight);
    end
end

sN      = MC.num_states;
paths   = length(MC.historyStates);
probPaths = cell(1,paths);
for k = 1:paths
    probs   = zeros(1,sN);
    for i=1:count
        particleIndex = indexes(i);
        state = MC.historyStates{k}{particleIndex};
        St              = state.vars{ShowVar};
        probs(1,St)     = probs(1,St)+1;
    end
    probPaths{k}=probs/sum(probs);
end
return