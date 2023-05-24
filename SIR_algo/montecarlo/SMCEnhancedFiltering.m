function [MC] = SMCEnhancedFiltering(model,MC,len,lin,afterGoal)
% function [MC] = SMCEnhancedFiltering(model,MC,len,lin,afterGoal)
%  
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: particle filter
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
if nargin < 2
    MC.models               = model;
    MC.nM                   = length(model);
    MC.var                  = 1;
    MC.feedbak              = [-1,1];
    MC.N                    = 5000;
    MC.resampleThreshold    = MC.N/2;%*(3/4);
    MC.debug                = 1;
end
N = MC.N;
if nargin < 3
    len = 100;
end

if nargin < 4
    if isfield (MC,'k')
        lin = MC.k+1;
    else
        lin=1;
    end
end

if nargin < 5
    afterGoal = 0;
end

for k=lin:len
    fprintf('Iter %g/%g ',k,len)
    sT = tic;
    if MC.goal_reached == 1
        fprintf ('Goal Reached!');
        if ~afterGoal
            fprintf (' Exiting...\n');
            break
        end
    end
%     k
    MC.k = k;
    
if isfield (MC,'pxM')
    pxM = MC.pxM/sum(MC.pxM);
else
    pxM = ones(1,MC.nM)/MC.nM;
end
   
    [MC.states] =  MC.updateStates(MC,pxM);
    
    %% in the echo state version vars is a vector. Now I set a cell
    if MC.debug && 0
        pause
        for kk=1:MC.N
            fprintf('Particle%g/%g|Model:%g|',kk,MC.N,MC.states{kk}.model);
            for iii=1:length(MC.states{kk}.vars)
                fprintf('Value:%g|',MC.states{kk}.vars{iii});
            end
            fprintf('logweight:%g\n',MC.states{kk}.logWeight);
        end
    end
    
    MC = MC.updateLikelihood(MC);

    if MC.enableResampling
        ess = GetESS(MC.states);
        modval = 50;
        if ess<MC.resampleThreshold || mod(k,modval)==0
          MC.states=smcResamplingStratified(MC.states,MC.k);
          fprintf('| Resampling!');
          if MC.debug
            fprintf('|ess:%g',ess);
          end
        end
    end
    MC.historyStates{MC.k}=MC.states;
        
    if mod(k,MC.modShow)==0
        MC = MC.showIteration(MC);
    end
    
    eT = toc(sT);
    fprintf(' | Time Elapsed %g ms',eT);
    fprintf('\n');
end