function [SGS, valStrategies, indStrategies, modelSave, oSGS, sinds] = successfulStrategies(MC,oldSGS,oldModelSave)
%% function [SGS valStrategies indStrategies modelSave oSGS sinds] = successfulStrategies(MC,oldSGS,oldModelSave)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  select strategies 
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% 
% SGS:              all strategies of SG
% indStrategies:    ordered index of all strategies
% valStrategies:    value of all strategies indexed by indStrategies
% modelSave:        occurences of strategies per model indexes by indStrategies
% oSGS:             all strategies of SG
% sinds:            all indexes of SG


count   = 0;
indexes = [];
for i=1:MC.N
    if MC.states{i}.vars{3}==MC.goal_state %&& MC.states{i}.vars{1}==MC.goal_state
        count = count +1;
        indexes(count) = i;
%         fprintf('Particle %g|w=%g!\n',i,MC.states{i}.logWeight);
    end
end

count = length(oldSGS);
SGS = oldSGS;

for in = 1:length(indexes);
    count = count+1;
    particleIndex = indexes(in);
    
    SGS{count} = [];
    for k = 1:length(MC.historyStates)
            state = MC.historyStates{k}{particleIndex};

            
            SGt             = state.vars{1};
%             Pt              = state.vars{2};
%             St              = state.vars{3};
%             Ft              = state.vars{4};
%             At              = state.vars{5};
%             Stp1 = find (squeeze(MC.transitions_cpt(St,At,:))==1);

            SGS{count} = [SGS{count} SGt];
            
            

    end
    if SGS{count}(end) ~= MC.goal_state
        SGS{count} = [SGS{count} MC.goal_state];
    end
    
    MC.states{particleIndex}.model;
    
    oSGS{count} = SGS{count};
    SGS{count}  = uniqueUnsorted(SGS{count});
end


countStrategies =  0;
indStrategies = 1:length(SGS);
for i=length(SGS):-1:1
    aSG = SGS{i};
    res = 1;
    for k=1:i+1        
          cSG = SGS{k};
            
          if length(aSG)==length(cSG)
              res = sum(abs(aSG-cSG));
          end
          if res == 0;
              indStrategies(i)     = indStrategies(k);
              if i==k
                countStrategies = countStrategies+1;
              end
              break;
          end
        
    end
end

sind = indStrategies;
ms = unique(indStrategies);

valStrategies   = zeros(size(ms));
modelSave       = zeros(countStrategies,length(MC.models));
if nargin > 2
    if ~isempty(oldModelSave)        
        modelSave(1:size(oldModelSave,1),:)=oldModelSave;
    end
end

for i=1:length(indexes)
   particleIndex    = indexes(i);
   im               = MC.states{particleIndex}.model;
   in               = indStrategies(end-length(indexes)+i);
   in               = find(ms==in);
   modelSave(in,im) = modelSave(in,im)+1;
end

for i=1:countStrategies
   hm               = sum(ms(i)==indStrategies);
   valStrategies(i) = hm;
end

sinds =  indStrategies;

indStrategies = ms;
valStrategies = valStrategies/sum(valStrategies);