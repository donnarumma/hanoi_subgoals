% function vals = updateNextS(vals)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: update next state
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

function vals = updateNextS(vals,oldvals,MC)
    if MC.k == 1
        Stp1 = MC.start_state;
    else
        St = oldvals{3};
        if St == MC.goal_state
            Stp1 = MC.goal_state;
        else
            At = oldvals{5};
            Stp1 = find (squeeze(MC.transitions_cpt(St,At,:))==1);
        end
    end
    vals{3} = Stp1;
    
return