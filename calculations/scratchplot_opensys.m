% plot what hapens to D13CH3D in open system with variable split ratio
% between two output flows, with one of hte sinks having no isotope effect
%
% see notes 01/27/2016

d13i = -38.27 / 1000;
dDi = -150.12 / 1000;
D13CH3Di = +2.61 / 1000;

a13 = 0.988;
aD = 0.895;
gamma = 1.000;

psiOx = [0:0.1:1]';

% d13 = (d13i+1) / ( ((1-psiOx)+psiOx*a13) ./ (1-psiOx) )  - 1;
% dD = (dDi+1) / ( ((1-psiOx)+psiOx*aD) ./ (1-psiOx) )  - 1;
% D13CH3D = D13CH3Di - log( ( (1-psiOx)+(psiOx*gamma*a13*aD) .* (1-psiOx) ) ./ ( ((1-psiOx)+psiOx*a13) .* ((1-psiOx)+psiOx*aD) ) );

d13 = (d13i + 1)./(1 + (a13-1)*psiOx) - 1;
dD = (dDi + 1)./(1 + (aD-1)*psiOx) - 1;
D13CH3D = D13CH3Di - log( (1+(gamma*a13*aD-1)*psiOx) ./ ( (1+(a13-1)*psiOx) .* (1+(aD-1)*psiOx) ) );

%% plot

figure(1);

subplot(2,1,1)
plot(1000*dD,1000*D13CH3D,'x')

subplot(2,1,2)
plot(1000*dD,1000*d13,'x')


