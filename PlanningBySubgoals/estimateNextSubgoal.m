% function prob_next_subgoal = estimateNextSubgoal(next,previous,previous_state,previous_priors,transition_cpt,policy_idxs,num_sampled_policies)
function prob_next_subgoal = estimateNextSubgoal(next,previous,previous_state,previous_priors,transition_cpt,policy_idxs,num_sampled_policies)
    prob_next_subgoal = estimate_next_subgoal_not_normalized(next,previous,previous_state,previous_priors,transition_cpt,policy_idxs,num_sampled_policies);
end