% function [states] =  sampleModelsPlus(MC,contexts)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description: sampling
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

function [states] =  sampleModelsPlus(MC,contexts)

        models = MC.models;
    
        lenc    = length(contexts);
        if isfield (MC,'states')
            states = MC.states;
        else
            states = cell(MC.N,1);
            display('init States')
            for i=1:MC.N
                states{i}.resampleHistory = [];
            end
        end
        randnums = rand (MC.N,1);
        for n=1:MC.N
            MC.n=n;
            if isfield (states{n},'model')
                findcont = states{n}.model;
            else
                cont        = 0;
                findcont    = 0;
                for i=1:lenc-1
                    cont = cont + contexts(i);
                    if randnums(n) < cont
                        findcont = i;
                    end
                    if findcont>0 
                        break
                    end
                end
                if ~findcont
                    findcont = lenc;
                end
            end
            sampleFunction = models{findcont}.sampleFunction;
            
            states{n}       = sampleFunction(models{findcont},states{n},MC);
            states{n}.model = findcont;
            if ~isfield (states{n},'logWeight')
                states{n}.logWeight = 1;
            end
%             if MC.debug
%                 fprintf('Particle %g/%g\n',n,MC.N);
%                 states{n}
%                 pause
%             end
        end
end