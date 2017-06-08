
%% calculate the symmetric Laue Bragg angle
%for the below calculation, assume the s polarization
E = 13.7;
lamda = 12.4/E;%unit is angstrom
k0 = 2*pi/lamda;
h = 2;
k = 2;
l = 0;
a = 5.431;
theta_B = asin((sqrt(h^2+k^2+l^2)*lamda)/(2*a));
%theta_B_degree = theta_B*180/pi;

%% calculate the forward scattering form factor using the refractive index
% data source:http://henke.lbl.gov/tmp/xray3674.dat

delta = 2.59e-6;
beta = 2.1267e-8;
gamma = 5.6e-8;
f_r = delta*2/(8*gamma);
f_i = beta*2/(8*gamma);

%% calculate the structure factor
%for silicon 220, the structure factor is 8*f
F_r = 8*f_r;
F_i = 8*f_i;
F = F_r + 1i*F_i;
epsilon = 1.0;
Fh = F/epsilon;
%% expression for eta and relation between K and delta theta
del_theta = linspace(-200e-6,200e-6,500);
eta = (-del_theta*sin(2*theta_B)+gamma*F)/(gamma*Fh);
%eta = del_theta*sin(2*theta_B)/(gamma*real(Fh));
%eta = real(eta_T);
% Ka_r = real(0.5*k0*Fh*(eta + sqrt(eta.^2+1))+k0*(1+gamma*F/2));
% Kb_r = real(0.5*k0*Fh*(eta - sqrt(eta.^2+1))+k0*(1+gamma*F/2));
%% transmitted beam:using expressions from the paper
x = log(0.001887);%2mm
%x = log(0.208429);%0.5mm
%x = log(0.996359);%0.05mm

I0 = 0.25.*(1+eta./(1+eta.^2)).^2 .* exp(x.*(1+epsilon./sqrt(1+eta.^2))./gam_0)+0.25.*(1 - eta./(1+eta.^2)).^2 .* exp(x.*(1 - epsilon./sqrt(1+eta.^2))./gam_0);
Ih = 0.25.*(1./(1+eta.^2)).*exp(x.*(1+epsilon./sqrt(1+eta.^2))./gam_0)+0.25.*(1./(1+eta.^2)).*exp(x.*(1-epsilon./sqrt(1+eta.^2))./gam_0);

%% Symmetric Bragg calculation

I_H = zeros(size(eta));
for ii = 1:length(eta)
    if real(eta(ii))<0
        I_H(ii) = abs(eta(ii)+sqrt(eta(ii).^2-1))^2;
    else
        I_H(ii) = abs(eta(ii)-sqrt(eta(ii).^2-1))^2;
    end
end
%% plotting
figure(1);
plot(del_theta,I0,'r');hold on;
plot(del_theta,Ih,'b');
title('thick 2mm 220 Laue O beam and H beam');

xlabel('\delta\theta(\murad)');
ylabel('I/I_{0}');
legend({'I0','Ih'});
axis tight;
%figure(2);
%plot(del_theta,Ih);

%% Bragg plotting 
figure(2);
plot(del_theta,I_H,'r');
title('thick 220 Bragg H beam');

xlabel('\delta\theta(\murad)');
ylabel('I/I_{0}');
legend({'I_{H}'});
axis tight;