function p=pathsLoadHanoiTower(root_dir)
% function p=pathsLoadHanoiTower(root_dir)
% load paths of the functions needed
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
try 
    root_dir;
catch
    root_dir='../../';
end
paths=cell(0,0);
paths{end+1}=[root_dir 'TestCases/testing_tools/'];
paths{end+1}=[root_dir 'PlanningBySubgoals/'];
paths{end+1}=[root_dir 'SIR_algo/montecarlo/'];
paths{end+1}=[root_dir 'SIR_algo/SubSIR/'];

for k=1:length(paths)
    addpath(paths{k});
end

if nargout > 0
    p=paths;
end