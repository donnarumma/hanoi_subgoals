function [S] = getThreePegEncoding()
% function [S] = getThreePegEncoding()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

S = cell(1,27);
S{1}    = [1,1,1];
S{2}    = [2,1,1];
S{3}    = [3,1,1];
S{4}    = [2,3,1];
S{5}    = [3,2,1];
S{6}    = [3,3,1];
S{7}    = [1,3,1];
S{8}    = [1,2,1];
S{9}    = [2,2,1];
S{10}   = [3,3,2];
S{11}   = [2,2,3];
S{12}   = [1,3,2];
S{13}   = [2,3,2];
S{14}   = [3,2,3];
S{15}   = [1,2,3];
S{16}   = [1,2,2];
S{17}   = [2,1,2];
S{18}   = [3,1,3];
S{19}   = [1,3,3];
S{20}   = [2,2,2];
S{21}   = [3,2,2];
S{22}   = [3,1,2];
S{23}   = [1,1,2];
S{24}   = [1,1,3];
S{25}   = [2,1,3];
S{26}   = [2,3,3];
S{27}   = [3,3,3];
return