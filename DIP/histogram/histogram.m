clear all;close all;clc;
pmax=255;
I=imread('2.png');
I=double(I)/pmax;
figure
imhist(I)
title('lotnisko')
A=1;
B=0;
C=2;
I2=A*I.^C+B;
figure
imhist(I2);
title('port lotniczy');
figure
imshow(I2)
p=0.1;
a=min(min(I))+p;
b=max(max(I))-p;
HS=(I-a)./(b-a);
figure
imhist(HS)
figure
imshow(HS)
%% 
clear all;close all;clc;
pmax=255;
I=imread('portlotniczy.png');
I=double(I)./pmax;
[N M]=size(I);
lmax=max(max(I));
lmin=min(min(I));
ls=1./(N*M)*sum(sum(I));
k1=(lmax-lmin);
k2=(lmax-lmin)./ls;
k3=(lmax-lmin)./(lmax+lmin);
k4=4./(N*M)*sum(sum((I-ls).^2));