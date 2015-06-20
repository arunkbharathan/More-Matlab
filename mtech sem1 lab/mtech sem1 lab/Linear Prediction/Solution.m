
% x(n)=-0.81*x(n-2)+u(n)(u(n)
% x(n)=u(n)+u(n-1)+u(n-2)
clear;
clc;
close;
%=================================================================

var = 1;
u = var*randn(1,1000);
% figure(3);
% plot(u);
a0 = [1 0 0.81];
x = filter(1,a0,u);   %H(z)=1/(1+a1*z^(-1)+a2*z^(-2))²
%Sxx(exp(j*w))=var/abs(1+sum(ak*exp(-j*w*k)))^2

w = linspace(-pi,pi,2000);
for mm = 1:2000
    c = w(mm);
    S(mm) = var/(abs(1+a0(2:3)*exp(-j*c*(1:2))'))^2;
end
figure(1);
plot(w,S,'b');
xlabel('½ÇÆµÂÊ/rad');
ylabel('xµÄ¹¦ÂÊÆ×');
title('¸ù¾ÝÒÑÖª²ÎÁ¿»­³öµÄARÄ£ÐÍµÄ¹¦ÂÊÆ×');

p = 60;
[a_p var_p] = Levinson_Durbin(x,p);

for mm = 1:2000
    c = w(mm);
    Sxx(mm) = var_p/(abs(1+a_p(2:p+1)*exp(-j*c*(1:p))'))^2;
end
hold on
plot(w,Sxx,'r');
xlabel('½ÇÆµÂÊ/rad');
ylabel('xµÄ¹¦ÂÊÆ×');
title('¸ù¾Ýµü´ú¼ÆËã³öµÄ²ÎÁ¿»­³öµÄARÄ£ÐÍµÄ¹¦ÂÊÆ×');

%==========================================================================

% clear;
var1 = 1;
u1 = var1*randn(1,1000);
b0 = [1 1 1];
x1 = filter(b0,1,u1);%x(n)=u(n)+u(n-1)+u(n-2)
%S = var*abs(sum(bk*exp(-j*w*k)))^2
for mm = 1:2000
    c = w(mm);
    S1(mm) = var1*(abs(b0*exp(-j*c*(0:2))'))^2;
end
figure(2);
plot(w,S1,'b');
xlabel('½ÇÆµÂÊ/rad');
ylabel('xµÄ¹¦ÂÊÆ×');
title('¸ù¾ÝÒÑÖª²ÎÁ¿»­³öµÄMAÄ£ÐÍµÄ¹¦ÂÊÆ×');

p1 = 8;
[a_p1 var_p1] = Levinson_Durbin(x1,p1);

for mm = 1:2000
    c = w(mm);
    Sxx1(mm) = var_p1/(abs(1+a_p1(2:p1+1)*exp(-j*c*(1:p1))'))^2;
end
a_p1
hold on
plot(w,Sxx1,'r');
xlabel('½ÇÆµÂÊ/rad');
ylabel('xµÄ¹¦ÂÊÆ×');
title('¸ù¾Ýµü´ú¼ÆËã³öµÄ²ÎÁ¿»­³öµÄMAÄ£ÐÍµÄ¹¦ÂÊÆ×');
