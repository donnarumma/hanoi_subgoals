function prob = compute_policy_prob(policy_program)
% function prob = compute_policy_prob(policy_program)
% 
% Description: algoritmic probability of the policy program
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
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

if isempty(policy_program)
    prob = 0;
else
    prob = 2^(-length(policy_program));
end



