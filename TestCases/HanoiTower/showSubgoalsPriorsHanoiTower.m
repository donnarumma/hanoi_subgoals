% function subgoal_priors = showSubgoalsPriorsHanoiTower(subgoal_priors)
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
function [hfig, scd, occ] = showSubgoalsPriorsHanoiTower(subgoal_priors,vals,ticks)
    sx              =  8;
    sy              = 15;
    if nargin < 1
        subgoal_priors = zeros(1,27);
        scd = 1-subgoal_priors;
    else
        scd = 1-scaledata(subgoal_priors,0,1);      % scaled subgoal values
    end
    ccc                 = repmat(scd<0.5,3,1);  % state text color (black or wite)
    occ                 = ccc;
    cols                = (repmat(scd,3,1));    % grayscale state color
    cv                  = 0.5;                  % state curvature
    interpreterLatex    = 1;                    % use interpreter latex for states
    lw                  = 7;                    % line width of the states
%     figure;
    hfig = figure('position',[100, 100, 1600, 800]);
    hold on; 
    colormap(flipud(gray));
    
    %% plot states 
%     oc = [0.5,0,0];
    oc = [0,0,0];                               % border state color
    wid = 0.9;
    hei = 0.9;
    
    %      1     2  3    4  5     6  7  8  9    10 11    12 13 14 15    16 17 18 19   20 21 22 23 24 25 26 27
    px = [ 8     7  9    6 10     5  7  9 11     4 12     3  5 11 13     2  6 10 14    1  3  5  7  9 11 13 15];
    %	 row1	row2     row3        row 4	 row 5      row 6        row 7                  row 8
    py = [ 1     2  2    3  3     4  4  4  4     5  5     6  6  6  6    7*ones(1,4)           8*ones(1,8)];
    
    px ([ 2, 3])  = px([3,2]);
    px ([ 4, 5])  = px([5,4]);
    px ([ 6:9 ])  = px([9:-1:6]);
    px ([10 11])  = px([11 10]);
    px ([12:15])  = px([15:-1:12]);
    px ([16:19])  = px([19:-1:16]);
    px ([20:27])  = px([27:-1:20]);
    
    px = px - 0.45;
    
    py = py - 0.45;

    for ind= 1:length(px)
        rectangle('Position',[px(ind),py(ind),wid,hei],'EdgeColor',oc,'Curvature',cv,'linewidth',6,'FaceColor',cols(:,ind));
    end

    
    %% plot black (green) links
%     vc = 'g'; 
    vc = 'k'; 
    dv = 0.1;
    
    xx = cell(0,0);
    yy = cell(0,0);
    
    xx{end+1} = [7-dv 8+dv];
    yy{end+1} = [2 2];
    
    xx{end+1} = [5-dv 6+dv];
    yy{end+1} = [4 4];
    
    xx{end+1} = [7-dv 8+dv];
    yy{end+1} = [4 4];
    
    xx{end+1} = [9-dv 10+dv];
    yy{end+1} = [4 4];
    
    xx{end+1} = [3-dv 4+dv];
    yy{end+1} = [6 6];
    
    xx{end+1} = [11-dv 12+dv];
    yy{end+1} = [6 6];
    
    xx{end+1} = [1-dv 2+dv];
    yy{end+1} = [8 8];
    
    xx{end+1} = [3-dv 4+dv];
    yy{end+1} = [8 8];
    
    xx{end+1} = [5-dv 6+dv];
    yy{end+1} = [8 8];
    
    xx{end+1} = [7-dv 8+dv];
    yy{end+1} = [8 8];
    
    xx{end+1} = [9-dv 10+dv];
    yy{end+1} = [8 8];
    
    xx{end+1} = [11-dv 12+dv];
    yy{end+1} = [8 8];
    
    xx{end+1} = [13-dv 14+dv];
    yy{end+1} = [8 8];
    
    for i=1:length(xx)
        xx{i} = xx{i}+0.5;
    end
    
    sh = 0.1;
    
    xx{end+1} = [ 7+sh  7-sh]+0.5;
    yy{end+1} = [ 1-sh  1+sh]+0.5;
    
    xx{end+1} = [ 8-sh  8+sh]+0.5;
    yy{end+1} = [ 1-sh  1+sh]+0.5;

    xx{end+1} = [ 6+sh  6-sh]+0.5;
    yy{end+1} = [ 2-sh  2+sh]+0.5;
    
    xx{end+1} = [ 9-sh  9+sh]+0.5;
    yy{end+1} = [ 2-sh  2+sh]+0.5;
    
    xx{end+1} = [ 5+sh  5-sh]+0.5;
    yy{end+1} = [ 3-sh  3+sh]+0.5;
    
    xx{end+1} = [ 6-sh  6+sh]+0.5;
    yy{end+1} = [ 3-sh  3+sh]+0.5;
    
    xx{end+1} = [ 9+sh  9-sh]+0.5;
    yy{end+1} = [ 3-sh  3+sh]+0.5;
    
    
    xx{end+1} = [10-sh 10+sh]+0.5;
    yy{end+1} = [ 3-sh  3+sh]+0.5;
    
    xx{end+1} = [ 4+sh  4-sh]+0.5;
    yy{end+1} = [ 4-sh  4+sh]+0.5;
    
    xx{end+1} = [11-sh 11+sh]+0.5;
    yy{end+1} = [ 4-sh  4+sh]+0.5;
    
    xx{end+1} = [ 3+sh  3-sh]+0.5;
    yy{end+1} = [ 5-sh  5+sh]+0.5;
    
    xx{end+1} = [12-sh 12+sh]+0.5;
    yy{end+1} = [ 5-sh  5+sh]+0.5;
    
    xx{end+1} = [ 2+sh  2-sh]+0.5;
    yy{end+1} = [ 6-sh  6+sh]+0.5;
    
    xx{end+1} = [13-sh 13+sh]+0.5;
    yy{end+1} = [ 6-sh  6+sh]+0.5;
    
    xx{end+1} = [ 1+sh  1-sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    xx{end+1} = [14-sh 14+sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    xx{end+1} = [ 4-sh  4+sh]+0.5;
    yy{end+1} = [ 5-sh  5+sh]+0.5;
    
    xx{end+1} = [11+sh 11-sh]+0.5;
    yy{end+1} = [ 5-sh  5+sh]+0.5;
    
    xx{end+1} = [ 5-sh  5+sh]+0.5;
    yy{end+1} = [ 6-sh  6+sh]+0.5;
    
    xx{end+1} = [10+sh 10-sh]+0.5;
    yy{end+1} = [ 6-sh  6+sh]+0.5;
    
    xx{end+1} = [ 6-sh  6+sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    xx{end+1} = [ 9+sh  9-sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    xx{end+1} = [ 2-sh  2+sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    xx{end+1} = [13+sh 13-sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    xx{end+1} = [ 5+sh  5-sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    xx{end+1} = [10-sh 10+sh]+0.5;
    yy{end+1} = [ 7-sh  7+sh]+0.5;
    
    for i=1:length(xx)
        plot(xx{i},yy{i},'Color',vc,'linewidth',lw);
    end
%% end green bars
    
%% row 1
%     col = 'y'; 
    col = [0.7,0,0];
    fs      = 20;
    fw      = 'bold';

    dy      = -0.7;
    dx      = -0.3;
    dx2     = -0.45;
    
    sx(1) =  8; sy(1) = 1;
    sx(2) =  9; sy(2) = 2;
    sx(3) =  7; sy(3) = 2;
%% row 2
    sx(4) = 10; sy(4) = 3;
    sx(5) =  6; sy(5) = 3;
    sx(6) = 11; sy(6) = 4;
    sx(7) = 9; sy(7) = 4;
    sx(8) = 7; sy(8) = 4;    
%% row 3
    sx(9) = 5; sy(9) = 4;
    sx(10) = 12; sy(10) = 5;
    sx(11) = 4; sy(11) =  5;
    sx(12) = 13; sy(12) = 6;
    sx(13) = 11; sy(13) = 6;
%% row 4
    sx(14) = 5; sy(14) =  6;
    sx(15) = 3; sy(15) =  6;
    sx(16) = 14; sy(16) = 7;
    sx(17) = 10; sy(17) = 7;
    sx(18) = 6; sy(18) =  7;
%% row 5
    sx(19) = 2; sy(19) =  7;
    sx(20) = 15; sy(20) = 8;
    sx(21) = 13; sy(21) = 8;
%%
    sx(22) = 11; sy(22) = 8;
    sx(23) = 9; sy(23) =  8;
    sx(24) = 7; sy(24) =  8;
    sx(25) = 5; sy(25) =  8;
    sx(26) = 3; sy(26) =  8;
    sx(27) = 1; sy(27) =  8;
%%
    
    if dy<0
        ccc=zeros(size(ccc));
    end
    
    if interpreterLatex
        fs = fs+3;
    end
    for i=1:length(scd)
        if i>9
            ax = dx2;
        else
            ax = dx;
        end

        if interpreterLatex
            text(sx(i)+ax,sy(i)+dy,['$$\textbf{\textit{S}' num2str(i) '}$$'],'fontsize',fs,'Color',ccc(:,i),'interpreter','latex');
        else
            text(sx(i)+dx2,sy(i)+dy,['S' num2str(i)],'fontsize',fs,'Color',ccc(:,i));
        end
    end

%% other settings    
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    set(gcf, 'PaperPositionMode','auto')
    ylim ([0.5,8+0.48])
    xlim ([0+0.49,16-0.51])
    box off

    cbr = colorbar;
    caxis([min(subgoal_priors), max(subgoal_priors)]);
    if nargin < 2

    elseif nargin == 2
        if vals == 1
            set(cbr,'YTick',unique(subgoal_priors));
        end
    else
	    set(cbr,'YTick',        vals );
        set(cbr,'YTickLabel',   ticks);
    end
    axis off;
    set(gca,'YDir','reverse');
    set(gca,'Color',[1 1 1]);
    set(gcf,'Color',[1 1 1]); 
    set(gcf,'inverthardcopy','off')
    
    hold off;
end