% function prob_next_subgoal = estimate_next_subgoal_not_normalized(next,previous,previous_state,previous_priors,transition_cpt,policy_idxs,num_sampled_policies)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: estimate next subgoal
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
function prob_next_subgoal = estimate_next_subgoal_not_normalized(next,previous,previous_state,previous_priors,transition_cpt,policy_idxs,num_sampled_policies)

% compute probability of sg at time t+1 conditioned by the option
% (sg,p_i,s) at time t
%
% formula:
%P(sg(t+1)|sg(t)) = sum_i[P(sg(t+1)|sg(t),p_i)P(sg(t)|p_i)P(p_i)] / P(sg(t))
%
%

num_policies = getNumPolicy(policy_idxs);
num_states = size(transition_cpt,1);

start2bin = de2bi(previous_state);

% binary encoding of starting state
prefix = [start2bin zeros(1,length(de2bi(num_states))-length(start2bin))];

halt2bin = de2bi(next);

% binary encoding of halting state
prefix = [prefix [halt2bin zeros(1,length(de2bi(num_states))-length(halt2bin))]];

size_prefix = length(prefix);

prob = 0;

if (nargin <=6)
    for j=1:num_policies

        program = [];
        
        policy = getPolicyByInt(j,policy_idxs,transition_cpt);

        state2previous = policy2program(previous_state,previous,transition_cpt,policy);      

        previous2next = policy2program(previous,next,transition_cpt,policy);

        if ~isempty(previous2next)

            if (previous == previous_state)

                program = [prefix   previous2next((size_prefix+1):length(previous2next))]; 

            else
                if ~isempty(state2previous)

                    program = [prefix  state2previous((size_prefix+1):length(state2previous))...
                                        previous2next((size_prefix+1):length(previous2next))];

                end
            end
        end
                         
        prob = prob + compute_policy_prob(program);
    end
else
    to_sample=num_sampled_policies;
    drawn_policies_idx = [];
    while (to_sample > 0)
        sampling = randi(num_policies,to_sample,1);
        drawn_policies_idx = unique([sampling ; drawn_policies_idx]);
        to_sample = num_sampled_policies - length(drawn_policies_idx);
    end
    
    for j=1:num_sampled_policies

        program = [];
        
        policy = getPolicyByInt(drawn_policies_idx(j),policy_idxs,transition_cpt);

        state2previous = policy2program(previous_state,previous,transition_cpt,policy);      

        previous2next = policy2program(previous,next,transition_cpt,policy);

        if ~isempty(previous2next)

            if (previous == previous_state)

                program = [prefix   previous2next((size_prefix+1):length(previous2next))]; 

            else
                if ~isempty(state2previous)

                    program = [prefix  state2previous((size_prefix+1):length(state2previous))...
                                        previous2next((size_prefix+1):length(previous2next))];

                end
            end
        end
        
        prob = prob + compute_policy_prob(program);
    end
end

% prob_next_subgoal = (prob * (1/num_policies)) / previous_priors(previous);
prob_next_subgoal = (prob) / previous_priors(previous);

%------------------------------------------------------
%------------------------------------------------------

function num_policy = getNumPolicy(possibilities)
num_policy=1;
for i=1:length(possibilities)
    num_policy=length(possibilities{i})*num_policy;
end
return


