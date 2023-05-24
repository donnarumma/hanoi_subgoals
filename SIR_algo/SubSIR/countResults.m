% function c=countResults(fname)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  count particles reaching goal state
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nodes in topological order.
%         SG             = states{s}.vars{1};
%         P              = states{s}.vars{2};
% 
%         F              = states{s}.vars{4};
%         A              = states{s}.vars{5};


function c=countResults(fname)

count = 0;
mc      = load(fname);
hisEnd  = 8;
states  = mc.MC.historyStates{hisEnd};
goal    = mc.MC.goal_state;
for s=1:length(states)
    S              = states{s}.vars{3};
    if S==goal
        count=count+1;
    end
end
c = count;
return