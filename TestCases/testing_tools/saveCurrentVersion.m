function saveCurrentVersion(saveDir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function saveCurrentVersion(saveDir)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: approximate bayesian inference 
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
try
    if nargin < 1
        saveDir = '';
    end
    s   = stringDate;
    nf  = ['hanoi_subgoals_code_' s '.tar'];
    root_dir='hanoi_subgoals';
    display ([ 'Saving code in ' nf ])
    fprintf('%s: Executing command: %s\n',mfilename,[ 'cd ../../../; tar -cf code.tar code; mv code.tar ' saveDir '/' nf]);
    system ([ 'cd ../../../; tar -cf code.tar ' root_dir '; mv code.tar ' saveDir '/' nf]);
catch
    fprintf('%s: Warning: cannot create a tar file of the running code! (Linux platform recommended)\n',mfilename)
end
