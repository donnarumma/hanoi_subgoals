function demo_test(wo,start_state,goal_state)
% main test
% ind   perceptive look-ahead
%  1 ->    100          0
%  2 ->     95          5
%  3 ->     90         10
%  4 ->     85         15
%  5 ->     80         20
%  6 ->     75         25
%  7 ->     70         30
%  8 ->     65         35
%  9 ->     60         40
% 10 ->     55         45
% 11 ->     50         50
% 12 ->     45         55
% 13 ->     40         60
% 14 ->     35         65
% 15 ->     30         70
% 16 ->     25         75
% 17 ->     20         80
% 18 ->     15         85
% 19 ->     10         90
% 20 ->      5         95
% 21 ->      0        100
% demo_test(11,27,20) correspond to setting equal samples for a combined 
% perceptive and look-ahead execution from start_state=20 and goal_state=27 
%
%
% Authors:     Francesco Donnarumma, Domenico Maisto, Giovanni Pezzulo
% Date:        2016 March 18                 
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%pathsLoadHanoiTower;

pathsLoadHanoiTower;     % load needed paths

try 
    goal_state;
catch
    goal_state=20;
end

priors                  = cell(0,0);
priors{end+1}           = {['PerceptivePriors_goal' num2str(goal_state)], ['LookaheadPriors_goal' num2str(goal_state)]};

dirToSave               = sprintf('Results/%s',mfilename);
dd                      = 5;

if nargin < 1
    wo                  =  11;
end
try 
    start_state;
catch
    start_state=27;
end

contexts                = [(100:-dd:0)' (0:dd:100)'];
contexts                = contexts(wo,:);

dirToSave               = [dirToSave '_' num2strLexi(contexts(1))];
dirToSave               = [dirToSave '_' num2strLexi(contexts(2))];

params.contexts         = contexts;


params.repetitions      =   5;                                              % max number of repetitions
params.nvotes           =   8;                                              % max number of votes
params.priors           = priors;
params.maxiter          =  10;                                              % max number of stepsin the environment
params.afterGoal        =   1;                                              % continue iterations even if a solution is found
params.Nparticles       =  30;                                              % number of sampled particles

params.sampfuns         = {'sampleModelPM_perceptive' 'sampleModelPM_v3'};  % name 0of the functions used for sampling in perceptive and look-forward cases
params.testName         = 'HanoiTower';

params.goal_state       = goal_state;   
params.start_state      = start_state;  
params.runningCodeExport= '/tmp/';                                          % directory to save current version of code

dirToSave               = [dirToSave '_s' num2str(params.start_state)];
params.dirToSave        = dirToSave;
subgoalingWithVotes(params);

            