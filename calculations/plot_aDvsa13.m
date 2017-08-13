% plot alphas against literatures

lits = csvread('Lit Values.csv',1,2)
aDlit = lits(:,2)/1000 + 1;
a13lit= lits(:,1)/1000 + 1;

calc30 = csvread('calculated30.csv',1);   
calc37 = csvread('calculated37.csv',1);

calc30(calc30==0) = NaN;
calc37(calc37==0) = NaN;

calc30(:,3:6) = 1000*[calc30(:,3)-1, calc30(:,4), calc30(:,5)-1, calc30(:,6)];
calc37(:,3:6) = 1000*[calc37(:,3)-1, calc37(:,4), calc37(:,5)-1, calc37(:,6)];

figure(1); clf; hold on;

plot([lits(:,1)-lits(:,3), lits(:,1)+lits(:,3)]', [lits(:,2), lits(:,2)]', '-', 'color', [0.7 0.7 0.7], 'linewidth',1);
plot([lits(:,1), lits(:,1)]', [lits(:,2)-lits(:,4), lits(:,2)+lits(:,4)]', '-', 'color', [0.7 0.7 0.7], 'linewidth',1);
plot(lits(:,1),lits(:,2), 'x', 'color', [0.7 0.7 0.7], 'markersize', 5, 'markerfacecolor', [0.7 0.7 0.7]);

plot([calc30(:,3)-calc30(:,4), calc30(:,3)+calc30(:,4)]', [calc30(:,5), calc30(:,5)]', '-', 'color', 'k', 'linewidth',1);
plot([calc30(:,3), calc30(:,3)]', [calc30(:,5)-calc30(:,6), calc30(:,5)+calc30(:,6)]', '-', 'color', 'k', 'linewidth',1);
plot(calc30(:,3),calc30(:,5), 'ks',  'markersize', 5, 'markerfacecolor', 'k');

plot([calc37(:,3)-calc37(:,4), calc37(:,3)+calc37(:,4)]', [calc37(:,5), calc37(:,5)]', '-', 'color', 'k', 'linewidth',1);
plot([calc37(:,3), calc37(:,3)]', [calc37(:,5)-calc37(:,6), calc37(:,5)+calc37(:,6)]', '-', 'color', 'k', 'linewidth',1);
plot(calc37(:,3),calc37(:,5), 'ko',  'markersize', 5, 'markerfacecolor', 'r');


hold off;

xlim([-40 0])
ylim([-400 0])

axis square
box on
set(gca(),'TickLength', [0.02 0.02])

set(gcf(), 'Position', [50 50 300 650]); 
set(gcf, 'PaperPositionMode', 'auto')
print -depsc2 FigXX_aDva13.eps    