function program = states2program(state_seq,transition_cpt)
% function program = states2program(state_seq,transition_cpt)
% 
% Description: 
% convert the program referring to the sequence of states into a binary string
% if the program does not halt it returns an empty vector
% 
% the part that codes the halting state could be deleted even if in this 
% verstion it can be employed for the labelling of useful policies
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

program=[];

[num_states, num_actions, num_states] = size(transition_cpt);


if (length(state_seq)>1)
    start_state = state_seq(1);
    head_reading = start_state;
    visited_states = start_state;
    halt_state = state_seq(length(state_seq));
    halting = 0;
    table = [];

    if (start_state ~= halt_state)
        while (halting == 0)
            
            next_state_idx= find(state_seq==head_reading)+1;
            
            if (length(next_state_idx)>1)
                halting = 1;
            else
                next_state = state_seq(next_state_idx);
                action = find(transition_cpt(head_reading,:,next_state));

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

            % binary encoding of the starting state
            program = [start2bin zeros(1,length(de2bi(num_states))-length(start2bin))];

            halt2bin = de2bi(halt_state);

            % binary encoding of the halting state
            program = [program [halt2bin zeros(1,length(de2bi(num_states))-length(halt2bin))]];

            % binary encoding of the transition table
            program = [program table];

        end
    else
        start2bin = de2bi(start_state);
        
        % binary encoding of the starting state
        program = [[start2bin zeros(1,length(de2bi(num_states))-length(start2bin))]...
                    [start2bin zeros(1,length(de2bi(num_states))-length(start2bin))]];

    end
end