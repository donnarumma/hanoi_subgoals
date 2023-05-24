% function prob_next_perceptive_subgoal = estimate_next_perceptive_subgoal(next,previous,goal,alpha,beta)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  algorithmic probability of perceptive priors
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

function prob_next_perceptive_subgoal = estimate_next_perceptive_subgoal(next,previous,goal,alpha,beta)

state_code=getThreePegEncoding();

code_next=state_code{next};
code_prev=state_code{previous};
code_goal=state_code{goal};

if (nargin<4)
    alpha=1;
    beta=1;
end

% product of the probability of perceive the subgoal "near"
% wrt the current state and the goal state
prob_next_perceptive_subgoal= exp(-(alpha*norm(code_prev-code_next,1) +...
                                    beta*norm(code_next-code_goal,1)));


return