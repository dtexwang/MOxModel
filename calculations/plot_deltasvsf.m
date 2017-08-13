% Plot Figure XX for McB Manuscript
% Shows d13C, dD, and D13CH3D vs f
% Both data and average-fractionation model for both experiments

clear all;
close all;

figure(1);
fpos = get(gcf(), 'Position');
set(gcf(), 'Position', [50 50 300 650]); 
h = tight_subplot(3,1, 0.03, 0.06, 0.1);

%% Model 30 C

McBdata = csvread('dataforpy30.csv',1);    % [tp	f	unc_f	d13C	unc_d13C	dD	unc_dD	D13CH3D	unc_D13CH3D]

% Fractionation Factors
a13  = 0.988;       % fitted to data
aD   = 0.895;      
g13D = 1.0000;      

% Initial Methane Isotopologue Concentrations
d2i = McBdata(1,4)/1000;    % d13C init
d3i = McBdata(1,6)/1000;    % dD init
D4i = McBdata(1,8)/1000;    % D13CH3D init

f = [1:-0.01:0.02]; 

d2mod = 1000*(exp( log(d2i+1) + (a13-1)*log(f) ) - 1);
d3mod = 1000*(exp( log(d3i+1) + (aD-1)*log(f) ) - 1);
D4mod = 1000*(D4i + (g13D*a13*aD - a13 - aD + 1)*log(f));

% Plot Model
axes(h(1)); plot(f, d2mod, '-', 'Color', 'k', 'linewidth', 1); hold on; %axis square;
axes(h(2)); plot(f, d3mod, '-', 'Color', 'k', 'linewidth', 1); hold on; %axis square;
axes(h(3)); plot(f, D4mod, '-', 'Color', 'k', 'linewidth', 1); hold on; %axis square;

% Plot Model for Product Rule
gammas = [0.9990 1.0010]
for i = 1:length(gammas)
    g13D = gammas(i);      
    D4mod = 1000*(D4i + (g13D*a13*aD - a13 - aD + 1)*log(f));
    axes(h(3)); plot(f, D4mod, '-', 'Color', [0.4 0.4 0.4], 'linewidth', 0.5);
end

gammas = [0.9980 1.0020]
for i = 1:length(gammas)
    g13D = gammas(i);      
    D4mod = 1000*(D4i + (g13D*a13*aD - a13 - aD + 1)*log(f));
    axes(h(3)); plot(f, D4mod, '-', 'Color', [0.8 0.8 0.8], 'linewidth', 0.5);
end

%% Model 37 C

McBdata = csvread('dataforpy37.csv',1);    % [tp	f	unc_f	d13C	unc_d13C	dD	unc_dD	D13CH3D	unc_D13CH3D]

% Fractionation Factors
a13  = 0.978;       % fitted to data
aD   = 0.798;      
g13D = 1.0000;    

% Initial Methane Isotopologue Concentrations
d2i = McBdata(1,4)/1000;    % d13C init
d3i = McBdata(1,6)/1000;    % dD init
D4i = McBdata(1,8)/1000;    % D13CH3D init

d2mod = 1000*(exp( log(d2i+1) + (a13-1)*log(f) ) - 1);
d3mod = 1000*(exp( log(d3i+1) + (aD-1)*log(f) ) - 1);
D4mod = 1000*(D4i + (g13D*a13*aD - a13 - aD + 1)*log(f));

% Plot Model
axes(h(1)); plot(f, d2mod, '-', 'Color', 'r', 'linewidth', 1); hold on;
axes(h(2)); plot(f, d3mod, '-', 'Color', 'r', 'linewidth', 1); hold on;
axes(h(3)); plot(f, D4mod, '-', 'Color', 'r', 'linewidth', 1); hold on;

% Plot Model for Product Rule
gammas = [0.9990 1.0010]
for i = 1:length(gammas)
    g13D = gammas(i);      
    D4mod = 1000*(D4i + (g13D*a13*aD - a13 - aD + 1)*log(f));
    axes(h(3)); plot(f, D4mod, '-', 'Color', [1 0.4 0.4], 'linewidth', 0.5);
end

gammas = [0.9980 1.0020]
for i = 1:length(gammas)
    g13D = gammas(i);      
    D4mod = 1000*(D4i + (g13D*a13*aD - a13 - aD + 1)*log(f));
    axes(h(3)); plot(f, D4mod, '-', 'Color', [1 0.8 0.8], 'linewidth', 0.5);
end


%% Plot 30 C Data

McBdata = csvread('dataforpy30.csv',1);    % [tp	f	unc_f	d13C	unc_d13C	dD	unc_dD	D13CH3D	unc_D13CH3D]

% deltas vs f
axes(h(1));
    plot([McBdata(:,2)-McBdata(:,3), McBdata(:,2)+McBdata(:,3)]', [McBdata(:,4), McBdata(:,4)]', '-', 'color', 'k', 'linewidth',1);
    plot([McBdata(:,2), McBdata(:,2)]', [McBdata(:,4)-McBdata(:,5), McBdata(:,4)+McBdata(:,5)]', '-', 'color', 'k', 'linewidth',1);
    plot(McBdata(:,2),McBdata(:,4), 'ks',  'markersize', 5, 'markerfacecolor', 'k');
    xlim([0 1]);
    ylim([-45 5]);
    ylabel('\delta^{13}C');
%         set(gca(),'yticklabel',[]);
    set(gca(),'xticklabel',[]);
    set(gca(),'XDir','Reverse');
axes(h(2));
    plot([McBdata(:,2)-McBdata(:,3), McBdata(:,2)+McBdata(:,3)]', [McBdata(:,6), McBdata(:,6)]', '-', 'color', 'k', 'linewidth',1);
    plot([McBdata(:,2), McBdata(:,2)]', [McBdata(:,6)-McBdata(:,7), McBdata(:,6)+McBdata(:,7)]', '-', 'color', 'k', 'linewidth',1);
    plot(McBdata(:,2),McBdata(:,6), 'ks',  'markersize', 5, 'markerfacecolor', 'k');
    xlim([0 1]);
    ylim([-200 300]);
    ylabel('\deltaD');
%         set(gca(),'yticklabel',[]);
    set(gca(),'xticklabel',[]);
    set(gca(),'XDir','Reverse'); 
axes(h(3));
    plot([McBdata(:,2)-McBdata(:,3), McBdata(:,2)+McBdata(:,3)]', [McBdata(:,8), McBdata(:,8)]', '-', 'color', 'k', 'linewidth',1);
    plot([McBdata(:,2), McBdata(:,2)]', [McBdata(:,8)-McBdata(:,9), McBdata(:,8)+McBdata(:,9)]', '-', 'color', 'k', 'linewidth',1);
%         errorbar(McBdata(:,2),McBdata(:,8),McBdata(:,9), '.',  'color', 'k', 'linewidth',1);
    plot(McBdata(:,2),McBdata(:,8), 'ks',  'markersize', 5, 'markerfacecolor', 'k');
    xlim([0 1]);
    ylim([-8 6]);
    ylabel('\Delta^{13}CH_3D');
%         set(gca(),'yticklabel',[]);
    set(gca(),'XDir','Reverse');
    xlabel('fraction of methane remaining, f');


%% Plot Data for 37 C

McBdata = csvread('dataforpy37.csv',1);    % [tp	f	unc_f	d13C	unc_d13C	dD	unc_dD	D13CH3D	unc_D13CH3D]

% deltas vs f
axes(h(1));
    plot([McBdata(:,2)-McBdata(:,3), McBdata(:,2)+McBdata(:,3)]', [McBdata(:,4), McBdata(:,4)]', '-', 'color', 'k', 'linewidth',1);
    plot([McBdata(:,2), McBdata(:,2)]', [McBdata(:,4)-McBdata(:,5), McBdata(:,4)+McBdata(:,5)]', '-', 'color', 'k', 'linewidth',1);
    plot(McBdata(:,2),McBdata(:,4), 'ko',  'markersize', 5, 'markerfacecolor', 'r');
axes(h(2));
    plot([McBdata(:,2)-McBdata(:,3), McBdata(:,2)+McBdata(:,3)]', [McBdata(:,6), McBdata(:,6)]', '-', 'color', 'k', 'linewidth',1);
    plot([McBdata(:,2), McBdata(:,2)]', [McBdata(:,6)-McBdata(:,7), McBdata(:,6)+McBdata(:,7)]', '-', 'color', 'k', 'linewidth',1);
    plot(McBdata(:,2),McBdata(:,6), 'ko',  'markersize', 5, 'markerfacecolor', 'r');
axes(h(3));
    plot([McBdata(:,2)-McBdata(:,3), McBdata(:,2)+McBdata(:,3)]', [McBdata(:,8), McBdata(:,8)]', '-', 'color', 'k', 'linewidth',1);
    plot([McBdata(:,2), McBdata(:,2)]', [McBdata(:,8)-McBdata(:,9), McBdata(:,8)+McBdata(:,9)]', '-', 'color', 'k', 'linewidth',1);
%         errorbar(McBdata(:,2),McBdata(:,8),McBdata(:,9), '.',  'color', 'k', 'linewidth',1);
    plot(McBdata(:,2),McBdata(:,8), 'ko',  'markersize', 5, 'markerfacecolor', 'r');

    
%% Save Figure
for i = 1:3, set(h(i),'TickLength', [0.03 0.03]), end    
set(gcf, 'PaperPositionMode', 'auto')
print -depsc2 FigXX_deltasvsf.eps    