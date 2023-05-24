%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sourcecode for tests in the paper:
% 
% Problem Solving as Probabilistic Inference with Subgoaling: 
% Explaining Human Successes and Pitfalls in the Tower of Hanoi
% published in:
%
% PLoS Computational Biology. 
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
%
% In directory PlanningBySubgoals files for computing algorithmic probabilities
% In directory montecarlo the files for approximate inference
% In directory TestCases file for the test
% In directory TestCases/HanoiTower demo_test.m is the file that can be used 
%              for reproducing tests in the paper
%
% note that all the test needs to precompute offline the algorithmic priors of the
% environment Tower of Hanoi. This demo, if does not find them, compute and 
% properly save them in order to avoid this (slow) recomputation.  
%
% test 1
% params.start_state=11
% params.goal_state=13;
% params.repetitions      =   5;            % max number of repetitions
% params.nvotes           =  10;            % max number of votes
% params.maxiter          =  12;            % max number of inferential steps
% params.Nparticles       = 100;            % number of sampled particles
% In this experiment all the samples are executed with lookahed strategy
% To start the test: 
%
% demo_test(21,start_state,goal_state)

% test 2
% params.start_state=27
% params.goal_state=20;
% params.repetitions      =   1;            % max number of repetitions
% params.nvotes           =  10;            % max number of votes
% params.maxiter          =  12;            % max number of inferential steps
% params.Nparticles       = 100;            % number of sampled particles
% To get the results for different  the test: 
%
% for i=1:21
%	demo_test(1,start_state,goal_state)
% end

% test 3
% The data modeled in test 3 are taken from
% Goel V, Grafman J (1995) 
% Are the frontal lobes implicated in planning functions? 
% Interpreting data from the tower of hanoi. 
% Neuropsychologia 33: 623-642.
% vgoel@yorku.ca
%
% params.start_state=27
% params.goal_state=20;
% params.repetitions      =  25;            % max number of repetitions
% params.nvotes           =  10;            % max number of votes
% params.maxiter          =  12;            % max number of inferential steps
% params.Nparticles       = 100;            % number of sampled particles
% To get the results for different  the test:
% 
% demo_test( 4,start_state,goal_state)
% demo_test(18,start_state,goal_state)

