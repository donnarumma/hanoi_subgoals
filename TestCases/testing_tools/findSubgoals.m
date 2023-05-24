function [subgoal_priors] = findSubgoals(fname,showPriors,testName)
% function [subgoal_priors] = findSubgoals(fname,showPriors,testName)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: search for priors 
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

    if nargin < 3
        testName = 'HanoiTower';
    end

    transitionsCreate                           = str2func(['transitionsCreate' testName]);
    transition_cpt                              = transitionsCreate();
    
    if nargin < 1
        fname = ['priorsPM'];
    end
    fname = [fname '.mat'];
    
    t = tic;
    if exist(fname, 'file') == 2
        load(fname);
        fprintf ('Loading Subgoals for file %s...', fname);
    else
        fprintf ('Saving Subgoals for file %s...', fname);
        subgoal_priors = init_subgoal_priors_v2(transition_cpt);
        save (fname,'subgoal_priors');
    end
    toc(t)
    fprintf('| (ended subgoals phase)\n')

    priors          = load (fname);
    subgoal_priors  = priors.subgoal_priors;
    if showPriors
        showSubgoalsPriors = str2func(['showSubgoalsPriors' testName]);
        showSubgoalsPriors(subgoal_priors);
    end
end