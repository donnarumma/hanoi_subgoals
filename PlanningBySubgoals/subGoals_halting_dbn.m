function bnet = subGoals_halting_dbn(num_states,num_actions,num_policies,num_subGoals)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% function bnet = subGoals_halting_dbn(num_states,num_actions,num_policies,num_subGoals)
% 
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


% 2TBN model with halting node F
num_steps = 2;
num_finish = 3;

% The number of nodes.
% # sub-goal nodes + plan nodes + action nodes + state nodes + reward nodes + finishing nodes + cumulative reward node
% N = num_steps + num_steps + num_steps + num_steps + num_steps + num_steps + 1;


%Nodes in topological order.
SG      = 1;
P       = 2;
S       = 3;
F       = 4;
A       = 5;
R       = 6;

dnodes  = 1:6;
onodes  = [S]; %eventualmente anche R

node_sizes = [num_subGoals num_policies num_states num_finish num_actions 2];

intra   = zeros(6);
intra(SG,[P F]) = 1;
intra(S,[A P F R])  = 1;
intra(P,A)  = 1;

inter   = zeros(6);
inter(SG,SG) = 1;
inter(A,S)   = 1;
inter(S,S)   = 1;
inter(F,SG)  = 1;

bnet.node_sizes =[node_sizes' node_sizes'];
bnet.inter      =inter;
bnet.intra      =intra;
bnet.dnodes     =dnodes;
bnet.onodes     =onodes;

% Initialize Bayes net.        
% bnet = mk_dbn(intra,inter, node_sizes, 'discrete', dnodes, 'observed', onodes);