% function vals = updateNextSG(vals)
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
% SG      = 1;  % up 2 (probabilistic sample + w2)
% P       = 2;  % up 3 (random sample + w1)
% S       = 3;  % up 1 (deterministic sample)
% F       = 4;  % up 5 (deterministic sample)
% A       = 5;  % up 4 (deterministic sample)
% R       = 6;   

function [SGtp1] = updateNextSG(SGt,Ft,subgoalpriors)
    r   = rand;
    p   = subgoalpriors;
    dp  = 0;
    found = 0;

    for i=1:length(p)
        dp = dp+p(i);
        if r<dp
            SGtp1 = i;
            found = 1;
            break;            
        end
    end
    if ~found
        SGtp1 = length(p);
    end

    while SGt==SGtp1

        r   = rand;
        dp  = 0;
        found = 0;
        for i=1:length(p)
            if p<r
                SGtp1 = i;
                found = 1;
            else
                dp = dp+p(i);
            end
            if found
                break;
            end
        end
        if ~found
            SGtp1 = length(p);
        end
    end
    
return