% function [policy_matrix, w1] = updatePi(S,SG,MC)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  update policy
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
% SG      = 1;
% P       = 2;
% S       = 3;
% F       = 4;
% A       = 5;
% R       = 6;
% 
function [policy_matrix, w1] = updatePi(S,SG,MC)

    start_state     = S;
    halt_state      = SG;

    [policy_matrix, w1] = smartSampleP( start_state,        ...
                                        halt_state,         ...
                                        MC.transitions_cpt, ... 
                                        MC.policies_inds,   ...
                                        MC.num_sampled_policies);

return