% function states = updateLogLikelihoodPM(MC)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  update log likelihood
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Nodes in topological order.
% SG      = 1;
% P       = 2;
% S       = 3;
% F       = 4;
% A       = 5;
% R       = 6;

function MC = updateLogLikelihoodPM(MC)
    allweights1 = zeros(1,MC.N);
    allweights2 = zeros(1,MC.N);
    oldweights = zeros(1,MC.N);
%     states = MC.states;
    goal_reached = MC.goal_reached;
    for i=1:MC.N
        c_state = MC.states{i};
        if c_state.vars{4} == 3 % end!
            goal_reached = 1;
        end
        allweights1(i) = MC.states{i}.w1;                       % maximize
        allweights2(i) = MC.states{i}.w2;                       % maximize
        oldweights(i) = MC.states{i}.logWeight;
    end % for i=1:MC.N
    MC.goal_reached = goal_reached;
    lambda1 = 1;
    lambda2 = 1;
    allweights = oldweights + lambda1*log(allweights1) + lambda2*log(allweights2);
    mw = max(allweights);
    allweights = allweights - mw;
    
    for i=1:MC.N
        
        MC.states{i}.logWeight = allweights(i);
        if MC.debug
            
            fprintf('Particle %g/%g | logWeight=%g\n', i, MC.N, MC.states{i}.logWeight);
        end
    end 
   
return

