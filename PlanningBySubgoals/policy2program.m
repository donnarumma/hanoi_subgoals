function program = policy2program(start_state,halt_state,transition_cpt,policy_matrix)
% function program = policy2program(start_state,halt_state,transition_cpt,policy_matrix)
% 
% Authors:     Francesco Donnarumma, Giovanni Pezzulo, Domenico Maisto
%
% Description:  encode the program entailed by a policy into a binary string
%               empty vector in case of non halting program
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

% Note: the halting state encoding can be deleted 
% even if it could be emploed in labelling useful policies

program=[];
[num_states, num_actions] = size(policy_matrix);

head_reading = start_state;
visited_states = start_state;
halting = 0;
table = [];

if (start_state ~= halt_state)
    while (halting == 0)

        action = find(policy_matrix(head_reading,:));

        next_state = find(transition_cpt(head_reading,action,:));

        if (find(visited_states==next_state))
            halting = 1;
        else
            action2bin = de2bi(action);

            table = [table [action2bin zeros(1,length(de2bi(num_actions))-length(action2bin))]];

            if (next_state == halt_state)
                halting = 1;
            else
                visited_states = [visited_states next_state];
            end
            
            head_reading = next_state;
        end
    end

    if (head_reading == halt_state)

        start2bin = de2bi(start_state);
        %nstart  = length(start2bin);

        % binary encoding of the starting state
        program = [start2bin zeros(1,length(de2bi(num_states))-length(start2bin))];

        halt2bin = de2bi(halt_state);

        % binary encoding of the halting state
        program = [program [halt2bin zeros(1,length(de2bi(num_states))-length(halt2bin))]];

        % binary encoding of the transition rules
        program = [program table];

    end
else
     start2bin = de2bi(start_state);
    %nstart  = length(start2bin);

    %inserisco la codifica binaria dello stato di partenza
    program = [[start2bin zeros(1,length(de2bi(num_states))-length(start2bin))]...
                [start2bin zeros(1,length(de2bi(num_states))-length(start2bin))]];

%     halt2bin = de2bi(halt_state);
% 
%     %inserisco la codifica binaria dello stato di arresto
%     program = [program [halt2bin zeros(1,length(de2bi(num_states))-length(halt2bin))]];
end

