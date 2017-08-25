clear all;clc;close all;
I1=imread('1.png');
I2=imread('2.png');
I3=imread('3.png');
I4=imread('4.png');
I5=imread('5.png');
I6=imread('6.png');

t=0.5;

I1=im2bw(I1, t);
I2=im2bw(I2, t);
I3=im2bw(I3, t);
I4=im2bw(I4, t);
I5=im2bw(I5, t);
I6=im2bw(I6, t);

I1=imresize(I1,[100 100]);
I2=imresize(I2,[100 100]);
I3=imresize(I3,[100 100]);
I4=imresize(I4,[100 100]);
I5=imresize(I5,[100 100]);
I6=imresize(I6,[100 100]);
I55=double(I4);
I5noise1=imnoise(I55,'salt & pepper',0.1);
imwrite(I5noise1,'noise 10%.png');
I5noise3=imnoise(I55,'salt & pepper',0.3);
imwrite(I5noise3,'noise 30%.png');
I5noise5=imnoise(I55,'salt & pepper',0.5);
imwrite(I5noise5,'noise 50%.png');


imwrite(I1,'1b.png');
imwrite(I2,'2b.png');
imwrite(I3,'3b.png');
imwrite(I4,'4b.png');
imwrite(I5,'5b.png');
imwrite(I6,'6b.png');
