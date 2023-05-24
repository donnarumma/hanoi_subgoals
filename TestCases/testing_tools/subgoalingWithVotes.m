% function [results] = subgoalingWithVotes(params)
%                                          S1=(111)
%                                         /        \   
%                                    S3=(311) -- S2=(211)
%                                    /                    \
%                                 S5=(321)               S4=(231)
%                                /        \             /        \
%                            S9=(221) -- S8=(121) -- S7=(131) -- S6=(331)
%                            /                                          \
%                           /                                            \
%                       S11=(223)                                      S10=(332)
%                      /        \                                     /         \
%               S15=(123) -- S14=(323)                           S13=(232) -- S12=(132)
%                /                    \                         /                      \
%           S19=(133)              S18=(313)               S17=(212)                  S16=(122) 
%         /          \            /         \             /         \                /         \
%  S27=(333) -- S26=(233) -- S25=(213) -- S24=(113) -- S23=(112) -- S22=(312) -- S21=(322) -- S20=(222)
%
% Authors:     Francesco Donnarumma, Domenico Maisto, Giovanni Pezzulo
%                  
% Note:
% This code is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This code is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [results] = subgoalingWithVotes (params)
MCversion           = 'v3p0';
curdir              = cd;
saveDir             = params.dirToSave;
contexts            = params.contexts;
repetitions         = params.repetitions;
priors              = params.priors;
maxiter             = params.maxiter;
afterGoal           = params.afterGoal;
Nparticles          = params.Nparticles;
testName            = params.testName;
start_state         = params.start_state;
goal_state          = params.goal_state;
sampfuns            = params.sampfuns;
nvotes              = params.nvotes;

fprintf('%s version %s: Saving in Directory %s: press a key to continue\n',mfilename,MCversion,saveDir); pause;

mkdir(saveDir);
addpath(saveDir);
try
    saveCurrentVersion(params.runningCodeExport);
catch
    fprintf('%s: Warning: no snapshot of the running code created\n',mfilename)
end
results = cell(1,length(priors));

for i=1:length(priors)
    results{i}.times = zeros(repetitions,length(Nparticles));
end

MCnames         = cell(0,0);
count           = 0;
% number of repetitions
for rr=1:repetitions
    % loop on number of particles
    for n=1:length(Nparticles)
        % loop on number of contexts
        for kk = 1:size(contexts,1)
            context = contexts(kk,:);
            
            % loop on different priors                
            for i=1:length(priors)
                
                % loop on number of votes
                for ind = 1:nvotes
                    prior = priors{i};
                    for nmod = 1:length(prior)
                        prior{nmod} = [prior{nmod} '_' num2str(ind)];
                    end
                    tic;
                    count = count + 1;
                    MCName = ['_N' num2str(Nparticles(n))];
                    for ccc=1:length(context)
                        MCName = [MCName '_C' num2str(context(ccc))];
                    end
                    for pri=1:length(prior)
                        MCName = [MCName '_P' num2str(pri) prior{pri}];
                    end
                    MCnames{count} = ['MC_' MCversion '_Rep' num2str(rr) MCName '_Vote' num2str(ind) '.mat'];
                    fprintf('Computing %s\n',MCnames{count});

                    % the core of the sampling
                    approximate_inference_interface(rr,prior,MCnames{count},Nparticles(n),start_state,goal_state,context,sampfuns,testName,maxiter,afterGoal);
                    % % % % % % % % % % % % %
                    
                    %% vote Part
                    load (MCnames{count});
                    if exist([curdir '/' MC.name],'file')==2
                          movefile(MC.name,[saveDir '/'  MC.name]);
                    end
                    fprintf('Successes %g\n',countResults(MCnames{count}));
                    fprintf('Iteration %g\n',ind);

                    %%old votes
                    if ind>1
                        fp=load(['MC_' MCversion '_Rep' num2str(rr) oldMCName '_Vote' num2str(ind-1) '.mat']);
                        fp=fp.MC.voting;
                        o               = fp.o;
                        oldSGS          = fp.SGS;
                        oldModelSave    = fp.modelSave;
                    else
                        % initialize vote saving
                        oldSGS          = cell(0,0);     
                        oldModelSave    = [];
                        o               = 0;
                    end
                    oldMCName       = MCName;
                    [to, SGS, p, modelSave, indStrategies] = computeVote(MC,oldSGS,0,oldModelSave);      

                    if size(to,2) > size(o,2)
                        ot = zeros(size(o,1),size(to,2));
                        ot(1:size(o,1),1:size(o,2))=o;
                    end
                    o(ind,1:size(to,2))=to;

                    voting.o             = o;
                    voting.SGS           = SGS;
                    voting.indStrategies = indStrategies;
                    voting.modelSave     = modelSave; 
                    voting.p             = p;

                    MC.voting            = voting;
                    MC.showIteration(MC);
                    movefile(MC.name,[saveDir '/'  MC.name]);
                    for nmod = 1:length(prior)
                        subgoal_priors  = updatePriorsMultiple(MCnames,nmod);

                        prior{nmod}     = [priors{i}{nmod} '_' num2str(ind+1)];
                        if exist([curdir '/' priors{i}{nmod} '_' num2str(ind+1)],'file')==2
                            movefile([priors{i}{nmod} '_' num2str(ind)],[saveDir '/' prior{nmod}]);
                        end
                        fprintf (['Saving subgoal_prios ' prior{nmod}  '.mat\n'])
                        save([prior{nmod}  '.mat'],'subgoal_priors');
                    end
                end
            end
        end
    end
end    
return