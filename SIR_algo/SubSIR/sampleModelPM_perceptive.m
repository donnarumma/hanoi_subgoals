% function [state] = sampleModelPM_perceptive(model,oldstate,MC)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  perceptive sampling
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
function [state] = sampleModelPM_perceptive(model,oldstate,MC)
% SG      = 1;
% P       = 2;
% S       = 3;
% F       = 4;
% A       = 5;
% R       = 6;
% 
% w2 = estimate_next_subgoal
% w1 = compute_policy_prob
%     fprintf('Processing Particle %g/%g...\n',MC.n,MC.N);
    if MC.debug 
        if mod(MC.n,round(MC.N/10))==0
            fprintf('Processing Particle %g/%g...\n',MC.n,MC.N);
        end
    end
    subgoal_priors = model.subgoal_priors;
    state       = oldstate;
    if ~isfield(state,'visited')
        state.visited = zeros(1,MC.num_states);
    end
    node_sizes = model.node_sizes;
    total = numel(node_sizes)/2;
    vals        = cell(1,total);
    
    if MC.k==1
        os = [];
    else
        os = oldstate.vars;
    end
    
    vals        = updateNextS(vals,os,MC);                      % OK! Code Proof!
    
    Stp1        = vals{3};
    
    
    if MC.k==1
        SGtp1       = Stp1;
    else 
        SGtp1       = oldstate.nextSG;
    end
    
    vals{1}         = SGtp1;
    
    state.visited(Stp1)=1;
    
    previous_SG             = SGtp1;
    previous_S              = Stp1;

    
    if Stp1==SGtp1 && Stp1 ~= MC.goal_state
        howmany = 100;
        next_SG = zeros(1,howmany);
        wSG     = zeros(1,howmany);
        for i=1:howmany
            next_SG(i)     = updateNextSG(Stp1,SGtp1,subgoal_priors);   % OK! Code Proof!
                while MC.memory && state.visited(next_SG(i))
                    next_SG(i)     = updateNextSG(Stp1,SGtp1,subgoal_priors);
                end
                                                    
            wSG(i) = estimate_next_perceptive_subgoal(  next_SG(i),  ...
                                                        previous_SG, ...
                                                        MC.goal_state);     
        end
        [mval, ind] = max(wSG);
        next_SG = next_SG(ind);
    else
        next_SG     = SGtp1;
    end
       
     w2 = estimateNextSubgoal(  next_SG,            ...
                                previous_SG,        ...
                                previous_S,         ...
                                subgoal_priors,  ...
                                MC.transitions_cpt, ...
                                MC.policies,        ...
                                MC.num_sampled_policies);

    %% added 21/02/2014
    if isfield (oldstate,'vars') && oldstate.vars{3} == MC.goal_state
        vals{3}   = MC.goal_state;
        vals{1}   = MC.goal_state;
        next_SG = MC.goal_state;
    end
    %%
    
    Stp1    = vals{3};
    SGtp1   = vals{1};
    
    
    if SGtp1 == Stp1
        [pitp1 w1]      = updatePi(SGtp1,next_SG,MC);  % OK! Code Proof!
    else
        [pitp1 w1]      = updatePi(Stp1,SGtp1,MC);     % OK! Code Proof!
    end
    
    vals{2}         = pitp1;
    
    warn = 0;
    if w1 == 0 || (w2 == 0 ) %&& Ft == 2)
        fprintf('Particle %g/%g Warning|',MC.n,MC.N);
        warn = 1;
    end
    if w1 == 0
        w1 = (1/10^308.2547);
        if SGtp1 == Stp1
            fprintf(' compute_policy_prob = 0 | updatePi(S%g,S%g) [new] (perceptive)',SGtp1,next_SG);
        else
            fprintf(' compute_policy_prob = 0 | updatePi(S%g,S%g) (perceptive)',Stp1,SGtp1);
        end
    end
    if w2 == 0
       w2 = (1/10^308.2547);
%        if Ft == 2
            fprintf(' estimate_next_subgoal p(SG%g|SG%g,S%g) = 0 (perceptive) |',next_SG, previous_SG,previous_S)
%        end
    end
    if warn
        fprintf('\n');
    end
        
    vals        = updateA(vals);                            % OK! Code Proof!

    vals        = updateF(vals,MC.goal_state);              % OK! Code Proof!

    state.nextSG = next_SG;
    state.vars  = vals;
    state.w2    = w2;
    state.w1    = w1;
    
    if MC.debug 
        modv = 1; %100;
        if mod(MC.n,round(MC.N/modv))==0
%             fprintf('Processing Particle %g/%g...\n',MC.n,MC.N);
            fprintf('S%g|SG%g|F=%g|A=%g|w1=compute_policy_prob=%g|w2=p(SG%g|SG%g,S%g) = %g |nextSG%g\n', ...
                     state.vars{3}, state.vars{1},  state.vars{4}, state.vars{5}, state.w1, next_SG, previous_SG, previous_S, state.w2, state.nextSG);
        end
    end
return