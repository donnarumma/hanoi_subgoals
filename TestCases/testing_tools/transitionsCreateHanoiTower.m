function [transition_cpt num_states num_actions]=transitionsCreateHanoiTower()
% function [transition_cpt num_states num_actions]=transitionsHanoiTower()
% 
%                                          S1=(111)
%                                         /        \   
%                                    S3=(311) -- S2=(211)
%                                    /                    \
%                                 S5=(321)               S4=(231)
%                                /        \             /        \
%                            S9=(221) -- S8=(121) -- S7=(131) -- S6=(331)
%                            /                                          \
%                           /                                            \
%                       S11=(223)                                      S10=(332)
%                      /        \                                     /         \
%               S15=(123) -- S14=(323)                           S13=(232) -- S12=(132)
%                /                    \                         /                      \
%           S19=(133)              S18=(313)               S17=(212)                  S16=(122) 
%         /          \            /         \             /         \                /         \
%  S27=(333) -- S26=(233) -- S25=(213) -- S24=(113) -- S23=(112) -- S22=(312) -- S21=(322) -- S20=(222)
    
 
%
%     if nargin < 1
%         blockNumber=3;
%     else
%         display('Warning, this functionality is disabled')
%     end

    % number of states per block
    % ib          = 4;

    % total number of states

    num_states  = 27;

    % 1 = disk from the first peg to the second, 
    % 2 = disk from the first peg to the third,
    % 3 = disk from the second peg to the first,
    % 4 = disk from the second peg to the third,
    % 5 = disk from the third peg to the first,
    % 6 = disk from the third peg to the second.
    num_actions = 6;

    % transition_cpt(s,a,s') = p(s'|a,s)
    transition_cpt = zeros(num_states, num_actions, num_states);
    
    %state S1 <--> (1 1 1)
    transition_cpt( 1, 1, 2) = 1;
    transition_cpt( 1, 2, 3) = 1; 
    
    %state S2 <--> (2 1 1)
    transition_cpt( 2, 3, 1) = 1; 
    transition_cpt( 2, 4, 3) = 1; 
    transition_cpt( 2, 2, 4) = 1;  

    %state S3 <--> (3 1 1)
    transition_cpt( 3, 5, 1) = 1;
    transition_cpt( 3, 6, 2) = 1; 
    transition_cpt( 3, 1, 5) = 1;
    
    %state S4 <--> (2 3 1)
    transition_cpt( 4, 5, 2) = 1;
    transition_cpt( 4, 4, 6) = 1; 
    transition_cpt( 4, 3, 7) = 1;
    
    %state S5 <--> (3 2 1)
    transition_cpt( 5, 3, 3) = 1;
    transition_cpt( 5, 6, 9) = 1; 
    transition_cpt( 5, 5, 8) = 1;
    
    %state S6 <--> (3 3 1)
    transition_cpt( 6, 6, 4) = 1;
    transition_cpt( 6, 5, 7) = 1; 
    transition_cpt( 6, 1, 10) = 1;
    
    %state S7 <--> (1 3 1)
    transition_cpt( 7, 2, 6) = 1;
    transition_cpt( 7, 1, 4) = 1; 
    transition_cpt( 7, 6, 8) = 1;
    
    %state S8 <--> (1 2 1)
    transition_cpt( 8, 2, 5) = 1;     
    transition_cpt( 8, 4, 7) = 1;
    transition_cpt( 8, 1, 9) = 1;
    
    %state S9 <--> (2 2 1)
    transition_cpt( 9, 4, 5) = 1;
    transition_cpt( 9, 3, 8) = 1; 
    transition_cpt( 9, 2, 11) = 1;
    
    %state S10 <--> (3 3 2)
    transition_cpt( 10, 3, 6) = 1;
    transition_cpt( 10, 5, 12) = 1; 
    transition_cpt( 10, 6, 13) = 1;
    
    %state S11 <--> (2 2 3)
    transition_cpt( 11, 5, 9) = 1;
    transition_cpt( 11, 4, 14) = 1; 
    transition_cpt( 11, 3, 15) = 1;
    
    %state S12 <--> (1 3 2)
    transition_cpt( 12, 2, 10) = 1;
    transition_cpt( 12, 1, 13) = 1; 
    transition_cpt( 12, 6, 16) = 1;
    
    %state S13 <--> (2 3 2)
    transition_cpt( 13, 4, 10) = 1;
    transition_cpt( 13, 3, 12) = 1; 
    transition_cpt( 13, 5, 17) = 1;
    
    %state S14 <--> (3 2 3)
    transition_cpt( 14, 6, 11) = 1;
    transition_cpt( 14, 5, 15) = 1; 
    transition_cpt( 14, 3, 18) = 1;
    
    %state S15 <--> (1 2 3)
    transition_cpt( 15, 1, 11) = 1;
    transition_cpt( 15, 2, 14) = 1; 
    transition_cpt( 15, 4, 19) = 1;
    
    %state S16 <--> (1 2 2)
    transition_cpt( 16, 4, 12) = 1;
    transition_cpt( 16, 1, 20) = 1; 
    transition_cpt( 16, 2, 21) = 1;
    
    %state S17 <--> (2 1 2)
    transition_cpt( 17, 2, 13) = 1;
    transition_cpt( 17, 4, 22) = 1;
    transition_cpt( 17, 3, 23) = 1; 

    
    %state S18 <--> (3 1 3)
    transition_cpt( 18, 1, 14) = 1;
    transition_cpt( 18, 5, 24) = 1; 
    transition_cpt( 18, 6, 25) = 1;
    
    %state S19 <--> (1 3 3)
    transition_cpt( 19, 6, 15) = 1;
    transition_cpt( 19, 1, 26) = 1;
    transition_cpt( 19, 2, 27) = 1; 
    
    %state S20 <--> (2 2 2)
    transition_cpt( 20, 3, 16) = 1;
    transition_cpt( 20, 4, 21) = 1; 
    
    %state S21 <--> (3 2 2)
    transition_cpt( 21, 5, 16) = 1;
    transition_cpt( 21, 6, 20) = 1; 
    transition_cpt( 21, 3, 22) = 1;
    
    %state S22 <--> (3 1 2)
    transition_cpt( 22, 6, 17) = 1;
    transition_cpt( 22, 1, 21) = 1;
    transition_cpt( 22, 5, 23) = 1; 

    %state S23 <--> (1 1 2)
    transition_cpt( 23, 1, 17) = 1;
    transition_cpt( 23, 2, 22) = 1; 
    transition_cpt( 23, 4, 24) = 1;
    
    %state S24 <--> (1 1 3)
    transition_cpt( 24, 2, 18) = 1;
    transition_cpt( 24, 6, 23) = 1;
    transition_cpt( 24, 1, 25) = 1;
    
    %state S25 <--> (2 1 3)
    transition_cpt( 25, 4, 18) = 1;    
    transition_cpt( 25, 3, 24) = 1;
    transition_cpt( 25, 2, 26) = 1; 
    
    %state S26 <--> (2 3 3)
    transition_cpt( 26, 3, 19) = 1;     
    transition_cpt( 26, 5, 25) = 1;
    transition_cpt( 26, 4, 27) = 1;
    
    %state S27 <--> (3 3 3)
    transition_cpt( 27, 5, 19) = 1;
    transition_cpt( 27, 6, 26) = 1; 
    
return