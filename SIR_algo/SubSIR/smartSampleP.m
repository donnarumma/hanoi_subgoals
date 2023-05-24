% function [policy_matrix, w1, k]=smartSampleP(start_state,halt_state,transitions_cpt,policies_inds,maxiter,threshold)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  sub filter for policies
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

function [policy_matrix, w1, k]=smartSampleP(start_state,halt_state,transitions_cpt,policies_inds,maxiter,threshold)

    if nargin < 5
        maxiter     = 1000;
    end
    if nargin < 6
        threshold   = 0; % eliminate only non significant policies: loops and policies that do not reach the halt state
    end

    found           = 0;
    it              = 0;

    [policy_matrix, k]  = sampleP(transitions_cpt,policies_inds);
    policyprogram   = policy2program(start_state,halt_state,transitions_cpt,policy_matrix);

    w1              = compute_policy_prob(policyprogram);            % maximize it

    while it < maxiter && ~found
%         w1
        if w1>threshold
            found = 1;
        else
            it = it+1;
            [matrixTemp, kTemp]  = sampleP(transitions_cpt,policies_inds);
            
            polTemp         = policy2program(start_state,halt_state,transitions_cpt,matrixTemp);
            w1Temp          = compute_policy_prob(polTemp);      % da massimizzare
    
            if w1Temp > w1
                w1              = w1Temp;
                policy_matrix   = matrixTemp;
                k               = kTemp;
            end

        end

    end
return
