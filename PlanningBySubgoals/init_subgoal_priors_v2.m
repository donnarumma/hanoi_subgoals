function [subgoal_priors, place_cells] = init_subgoal_priors_v2(transition_cpt,policy_idxs,num_sampled_policies)
% function [subgoal_priors, place_cells] = init_subgoal_priors_v2(transition_cpt,policy_idxs,num_sampled_policies)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: search for subgoal priors 
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

tic

num_states = size(transition_cpt,1);

subgoal_priors = zeros(1,num_states);

if (nargin  < 2)
    policy_idxs = policyIndexCreate(transition_cpt);
end

if (nargin <= 2)

    S=[];
    fprintf('Finding exact subgoals');
    for gno = 1 : num_states
        fprintf('Cycle %g/%g\n',gno,num_states);
        state_seq=[];
        S = push(gno,S);
        subgoal_priors(gno) = 0;
        while (size(S) ~= 0)
            [s S] = pop(S);
            state_seq = [s state_seq];
            
            prog=states2program(state_seq,transition_cpt);
            
            subgoal_priors(gno) = subgoal_priors(gno) + ...
                                  get_multiplicity(state_seq,policy_idxs) * ...
                                  compute_policy_prob(prog);

            if (~isempty(prog) || (isempty(prog) && isempty(find(state_seq~=gno,1))))

                S = push(policy_idxs{s},S);

            else
                state_seq = state_seq((1+walking_back(state_seq,policy_idxs))...
                            :(length(state_seq)));
            end
        end        
    end  
else
    fprintf('Finding sampled subgoals');
    num_policies = getNumPolicy(policy_idxs);
    to_sample=num_sampled_policies;
    drawn_policies_idx = [];
    while (to_sample > 0)
        sampling = randi(num_policies,to_sample,1);
        drawn_policies_idx = unique([sampling ; drawn_policies_idx]);
        to_sample = num_sampled_policies - length(drawn_policies_idx);
    end
    
    for gno = 1 : num_states
        fprintf('Cycle %g/%g\n',gno,num_states);
        for sno = 1 : num_states
            for pno = 1 : num_sampled_policies
                
                policy = getPolicyByInt(drawn_policies_idx(pno),policy_idxs,transition_cpt);
                
                state2goal = policy2program(sno,gno,transition_cpt,policy);

                subgoal_priors(gno) = subgoal_priors(gno) + compute_policy_prob(state2goal);

            end
        end
    end
end

subgoal_priors = subgoal_priors/norm(subgoal_priors,1);

priors = cell(1,length(subgoal_priors));
for i=1:length(priors)
    for j=1:length(policy_idxs{i})
        priors{i}(j) = subgoal_priors(policy_idxs{i}(j));
    end  
end

place_cells = struct('map', policy_idxs, 'priors', priors);

toc

%---------------------------------------
%---------------------------------------
function [popped, mod_stack]=pop(stack)
if (size(stack)  ~= 0)  
    popped=stack(length(stack));
    mod_stack = stack(1:(length(stack)-1));
else
    popped=[];
    mod_stack = [];
end
return

function [mod_stack] = push(element,stack)
mod_stack = [stack ; element];
return

%%
function num_steps = walking_back(path,possibilities)
% This function is related to the order of graph visits 
% and to the data structure
stop=0;
num_steps=1;
while ((stop ==0) && (num_steps <(length(path)-1)))
    leaf = path(num_steps);
    parent = path(num_steps+1);
    if (find(possibilities{parent}==leaf)==1)
        num_steps=num_steps+1;
    else
        stop=1;
    end
end
return

%%
function multiplicity = get_multiplicity(state_sequence,possibilities)
multiplicity=1;
num_states=length(possibilities);
for i=1:num_states
    if (sum(state_sequence==i)<1)
        multiplicity = multiplicity * length(possibilities{i});
    end
end
return

%%
function num_policy = getNumPolicy(possibilities)
num_policy=1;
for i=1:length(possibilities)
    num_policy=length(possibilities{i})*num_policy;
end
return
