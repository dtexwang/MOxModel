% plot Lambda' against literatures

lits = csvread('Lit Values.csv',1,2)
Lprime = lits(:,2)./lits(:,1)
Lprime = Lprime'
xlit = [0 35]'
ylit = bsxfun(@times, Lprime, xlit)

data30 = csvread('dataforpy30.csv',1);    % [tp	f	unc_f	d13C	unc_d13C	dD	unc_dD	D13CH3D	unc_D13CH3D]
data37 = csvread('dataforpy37.csv',1);

x30 = 1000*log((data30(:,4)/1000+1) ./ (data30(1,4)/1000+1))
x37 = 1000*log((data37(:,4)/1000+1) ./ (data37(1,4)/1000+1))

y30 = 1000*log((data30(:,6)/1000+1) ./ (data30(1,6)/1000+1))
y37 = 1000*log((data37(:,6)/1000+1) ./ (data37(1,6)/1000+1))

b = [x30;x37]\[y30;y37]     % best fit line slope

figure(2); clf;
plot([-1000 1000]',[0 0]','k:', 'linewidth', 1);
hold on;
plot([0 0], [-1000 1000], 'k:', 'linewidth', 1);
% plot(xlit,ylit(:,1:7),'-','color',[0.8 0.8 0.8]); 
% plot(xlit,ylit(:,8:end),'--','color',[0.8 0.8 0.8]); 
plot(xlit,ylit,'-','color',[0.8 0.8 0.8]); 
plot(xlit,b*xlit,'k-','linewidth',1)
plot(x30,y30,'ks', 'markersize', 5, 'markerfacecolor','k', 'markeredgecolor','k');
plot(x37,y37,'ro', 'markersize', 5, 'markerfacecolor','r', 'markeredgecolor','k');
hold off;

xlim([-2 32])
ylim([-20 320])

axis square
set(gca(),'TickLength', [0.02 0.02])

set(gcf(), 'Position', [50 50 300 650]); 
set(gcf, 'PaperPositionMode', 'auto')
print -depsc2 FigXX_Lprime.eps    


[coeffs, coeffints, aa, bb, stats] = regress([y30;y37],[x30;x37])
errors = (coeffints(:,2)-coeffints(:,1))/(2*1.9654)     % http://stackoverflow.com/a/11048237