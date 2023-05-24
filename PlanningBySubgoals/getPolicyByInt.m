function policy = getPolicyByInt(int,possibilities,transitions)
% function policy = getPolicyByInt(int,possibilities,transitions)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  godel numbering of the policies: 
%               at each integer corresponds one policy
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

num_policy = getNumPolicy(possibilities);
policy = [];
if ((int <= num_policy) && (int > 0))
    dividend = ones(1,length(possibilities));
    for i=2:length(dividend)
        dividend(i)= dividend(i-1)*length(possibilities{i-1});
    end
    
    trans_idx=zeros(1,length(possibilities));
    
    to_divide = int-1;
    for i=length(dividend):-1:1
        trans_idx(i) = floor(to_divide/dividend(i))+1;
        to_divide = rem(to_divide,dividend(i));       
    end
    
    policy =zeros(length(trans_idx),size(transitions,2));
    for i=1:size(policy,1)
        policy(i,:) = transitions(i,:,possibilities{i}(trans_idx(i)));
    end
end


%----------------------------------------------------------
%----------------------------------------------------------
function num_policy = getNumPolicy(possibilities)
num_policy=1;
for i=1:length(possibilities)
    num_policy=length(possibilities{i})*num_policy;
end
return


