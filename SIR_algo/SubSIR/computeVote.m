% function [vote]=computeVote(MC)
% 
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  compute current votes
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% MC structure
% oldSGS sequences 
% oldPs 
function [vote, SGS, p, modelSave, indStrategies]=computeVote(MC,oldSGS,oldPs,oldModelSave)

transition_cpt  = MC.transitions_cpt;
policy_idxs     = MC.policies_inds;
if nargin < 1
    oldSGS = cell(0,0);
end
[SGS, valStrategies, indStrategies, modelSave] = successfulStrategies(MC,oldSGS,oldModelSave);
num_sampled_policies    = MC.num_sampled_policies;
nstrategies             = length(valStrategies);
vote                    = zeros(1,nstrategies);

p       = zeros(size(valStrategies));

% warning: oldPs is not used anymore
if nargin > 2
    p(1:size(oldPs,1),1:size(oldPs,2)) = oldPs;
end

for k=1:nstrategies
    seq     = SGS{indStrategies(k)};
    r = rand;
    pm = modelSave(k,:);
    pm = pm/sum(pm);
    mos = length(pm);
    for z=1:length(pm)-1
        if r<pm(z)
            mos = z;
        end
    end
    previous_priors = MC.models{mos}.subgoal_priors;
    fprintf('Seq%g|',k);
%     if k > length(oldPs)
        %% p([sg_{0},...,sg_{t}]_k)
        p(k)    = 1;
        flatPrior = 1;
        if ~flatPrior
            for ind=1:length(seq)-1
                sgtp1           = seq(ind+1); 
                sgt             = seq(ind);
                st              = sgt;
%                 est             = estimate_next_subgoal_v2(sgtp1,sgt,st,previous_priors,transition_cpt,policy_idxs,num_sampled_policies);
                est             = estimate_next_subgoal_beta(sgtp1,sgt,st,previous_priors,transition_cpt,policy_idxs,num_sampled_policies);
                fprintf('estimate_next_subgoal (%g, %g, %g) = %g\n',sgtp1,sgt,st,est);
                if est==Inf
                    est=0;
                end
                p(k) = p(k)*est;
            end
        end
%         p
%     end
    %% P(q(t)|[sg_{0},...,MC.models{1}.sg_{t}=s_{goal}]_k) = valStrategies(k)
    vote(k) = p(k)*valStrategies(k);
%     vote(k) = valStrategies(k);
end

[v, i]=max(valStrategies);
fprintf('\nBest Sampled Strategy=%g\n',i);

[v, i]=max(vote);
fprintf('Best Posterior Strategy=%g\n',i);

return