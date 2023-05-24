function subgoal_priors=findLookaheadPriors(transition_cpt,goal_state)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function subgoal_priors=findLookaheadPriors(transition_cpt,goal_state)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: lookahead piors 
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
try 
    load('LookaheadPriors')
catch
    subgoal_priors = init_subgoal_priors_v2(transition_cpt);
    save('LookaheadPriors','subgoal_priors');
end
vv=sort(subgoal_priors);
Delta=max(vv(2:end)-vv(1:end-1));
subgoal_priors(goal_state)=  max(subgoal_priors)+Delta;
subgoal_priors=subgoal_priors./sum(subgoal_priors);

