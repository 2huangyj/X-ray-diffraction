%% read the csv file
%data = csvread('D:\SU\classes\2017Spring\x ray\HW\HW4\align1_scan111.csv');
%data = csvread('align1_scan111.csv');
O_ave = 682666.4;%measure this in order to take out the gain difference
H_ave = 155986.6;%photon count when there is only through beam
%%
% filename = 'align1_scan34'; description = '220 thick Laue O';
% filename = 'align1_scan111'; description = '220 thick Laue H';
% filename = 'thinsample_scan20'; description = '220 thin Laue O';
% filename = 'thinsample_scan24'; description = '220 thin Laue H';
% filename = 'Bragg_111_scan105'; description = '220 Bragg';
% data= importdata([filename '.csv']);
% phi = data.data(:,2);
% i1 = data.data(:,9);
% figure(3);
% plot(phi,i1);hold on;

%% thick Laue with no analyzer
%everything with analyzer in is wrong measurement in principle

filename = 'align1_scan111'; 
data= importdata([filename '.csv']);
phi = data.data(:,2);
i1 = data.data(:,9)./H_ave;
i2 = data.data(:,10)./O_ave;

figure(3);

plot(phi,i2,'r');
hold on;
plot(phi,i1,'b');
ylim = ([0 0.1]);
title('220 thick Laue O and H');
%title([description ':' 'FWHM'  num2str(f.c1)]);
xlabel('\delta\theta(\murad)');
ylabel('I/I_{0}');
legend({'O','H'})
%axis auto;
grid on
%% thin laue with no analyzer

filename = 'thinsample_scan5'; 
data= importdata([filename '.csv']);
phi = data.data(:,2);
i1 = data.data(:,9)./H_ave;
i2 = data.data(:,10)./O_ave;

figure(3);
plot(phi,i2,'r');hold on;
plot(phi,i1,'b');
title('220 thin Laue O and H');
%title([description ':' 'FWHM'  num2str(f.c1)]);
xlabel('\delta\theta(\murad)');
ylabel('I/I_{0}');
legend({'O','H'})
axis auto;
grid on

%% Gaussian fitting
f = fit(phi,i1,'gauss2');
plot(f,phi,i1);
%%
title([description]);
%title([description ':' 'FWHM'  num2str(f.c1)]);
xlabel('\delta\theta(\murad)');
ylabel('I/I_{0}');
axis auto;
grid on


