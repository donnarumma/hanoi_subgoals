function perceptive_priors = init_perceptive_subgoal_priors(goal_state)
% function perceptive_priors = init_perceptive_subgoal_priors(goal_state)

state_code=getThreePegEncoding();

perceptive_priors = zeros(1,length(state_code));

for i=1:length(state_code)
    perceptive_priors(i)=exp(-norm(state_code{i}-state_code{goal_state},1));
end

perceptive_priors=perceptive_priors/norm(perceptive_priors,1);
