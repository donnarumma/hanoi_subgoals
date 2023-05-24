function [MC]= approximate_inference_interface(es,fname,MCversion,Nparticles,start_state,goal_state,context,sampfuns,testName,maxiter,afterGoal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [MC]= testPM(es,fname,MCversion,Nparticles)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: approximate bayesian inference 
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

if nargin < 4
    Nparticles = 5000;
end
if nargin < 3
    MCversion = 'debug';
end
if nargin < 2
    fname = {'priors.mat'};   % priors
end
if nargin < 1
    es = 1; 
end

%% create Rng  
rngname = ['myrng' num2str(es) '.mat'];
if exist(rngname, 'file') ~= 2
  myrng = rng('shuffle');
  save(rngname,'myrng');
end

MC.name                 = [MCversion];
if exist(MC.name, 'file') ~= 2
    load(rngname);
    rng(myrng);
    display(['loading ' rngname]);
end

transitionsCreate = str2func(['transitionsCreate' testName]);
[transitions_cpt, num_states, num_actions]    = transitionsCreate();

if nargin < 5
    start_state = 1;
end
if nargin < 6
    goal_state  = num_states;
end

[policies_inds, num_policies]                = policyIndexCreate(transitions_cpt);

num_subGoals = num_states; %



fprintf ('States %g | ' , num_states  );
fprintf ('Actions %g | ' , num_actions );
fprintf ('Policies %d\n' , num_policies);

cm = length(fname);
model = cell(1,cm);
showPriors = 0;

fprintf ('Context (')
for m=1:cm
    fprintf (' %g',context(m));
end
fprintf (')\n');

for m = 1:cm
    fprintf ('Model %g/%g | ',m,cm);
    model{m} = subGoals_halting_dbn( num_states,num_actions,num_policies,num_subGoals);
    model{m}.sampleFunction = str2func(sampfuns{m});
    model{m}.subgoal_priors = findPriors(fname{m},showPriors,testName,goal_state);
    for i=1:length(model{m}.subgoal_priors);
        fprintf ('p%g=%g ',i,model{m}.subgoal_priors(i));
    end
    fprintf ('\n');
end

MC.pxM                  = context;
MC.models               = model;
MC.nM                   = length(model);
MC.var                  = 1;
MC.N                    = Nparticles; 
MC.resampleThreshold    = MC.N/100; 
MC.debug                = 1;
MC.num_states           = num_states;
MC.num_actions          = num_actions;
MC.num_policies         = num_policies;
MC.num_subGoals         = num_subGoals;
MC.transitions_cpt      = transitions_cpt;
MC.policies_inds        = policies_inds;
% MC.policies             = policies;
MC.policies             = policies_inds;
MC.start_state          = start_state;
MC.goal_state           = goal_state;
MC.updateLikelihood     = str2func('updateLogLikelihoodPM');
MC.modShow              = 1;
MC.updateStates         = str2func('sampleModelsPlus');
MC.showIteration        = str2func('showIterationPM');
MC.num_sampled_policies = 100; %
MC.goal_reached         = 0;
MC.enableResampling     = 0;
MC.memory               = 1;

MC.k                    = 1;

if exist(MC.name,'file')==2
    fprintf ('%s: File %s exists, Restarting...\n',mfilename,MC.name);
    load(MC.name)
else 
    fprintf ('%s: File %s is new, Initializing...\n',mfilename,MC.name);
end

if nargin < 10
    maxiter = 100; 
end
if nargin < 11
    afterGoal = 0;
end
[MC] = SMCEnhancedFiltering(model,MC,maxiter,MC.k,afterGoal);
