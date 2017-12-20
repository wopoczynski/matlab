close all;clc;clear all;
control = load('Control.mat');
panIn = load ('PanIN.mat');

data = load ('data_interp.mat'); % mz/y/names/group

[rowP, colP] = size(panIn.spectra);
for i = 1:colP
    Y(:,i) = panIn.spectra{1,i}(:,2);
end
MZ = panIn.spectra{1,1}(:,1);

[rowC, colC] = size(control.spectra);
for i = 1:colC
    YControl(:,i) = control.spectra{1,i}(:,2);
end
MZControl = control.spectra{1,1}(:,1);

cd '../../..'
 MZ = data.mz; Y = data.y;
figure();
plot(MZ,Y);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('PanIN');
% 
% figure();
% plot(MZControl,YControl);
% xlabel('Mass/Charge (M/Z)');
% ylabel('Relative Intensity');
% title('Control');
% 
% clear all;clc;close all;

%% dane panIN
%resampling
% [MZD,YD] = msresample(MZ,Y,5000,'Range',[800 10000]);
% 
% figure();
% plot(MZD,YD);
% xlabel('Mass/Charge (M/Z)');
% ylabel('Relative Intensity');
% title('PanIN resampled');
%korekcja t�a
YB = msbackadj(MZ,Y,'WindowSize',500,'Quantile',0.20);

figure();
plot(MZ,YB);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('PanIN backgr. adj. ');
[sizeY ,~] = size(Y);
for i=1:sizeY
    meanY(i,:) = mean(Y(i,:));
end
%heatmap calosci 
msheatmap(MZ,YB);
%fft korelacja do wzorca (srednie z prob)
YA = adaptive_PAFFT(MZ,YB, meanY, 0.7, 0.1, 't');
msheatmap(MZ,YA(:,1));

%normalizacja danych przed i po korelacji
YN1 = msnorm(MZ, Y, 'LIMITS', [500 inf], 'MAX', 100);
YN2 = msnorm(MZ, YA, 'LIMITS', [500 inf], 'MAX', 100);

figure();
plot(MZ,YN1);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('PanIN normalized');

figure();
plot (MZ, YN2);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('PanIN normalized after adapt. FFT');
%powiekszenie na region najwiekszego piku
YN3 = msnorm(MZ, YA,'limits', [7900 8500], 'quantile',[0.8 1],'MAX', 40);

figure();
plot(MZ, YN3); axis([7000 10000 -5 105]);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('PanIN normalized after adapt. FFT zoom in');

%redukcja szumu
YS = mssgolay(MZ, YN2, 'SPAN', 35, 'ShowPlot', 3);

figure();
plot(MZ,YS);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('PanIN noise removal');

%odnalezienie pikow ION
slopeSign = diff(YS(:,1))> 0;
slopeSignChange = diff(slopeSign)< 0;
h = find(slopeSignChange) + 1;
h(MZ(h) < 800) = [];
h(YS(h,1) < 3) = [];

figure();
plot(MZ,YS(:,1),'-',MZ(h),YS(h,1),'ro');
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('PanIn higest peak ION');

%% Dane control

%resampling
[MZDControl,YDControl] = msresample(MZControl,YControl,5000,'Range',[800 10000]);

figure();
plot(MZDControl,YDControl);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('Control resampled');

%korekcja tla
YControlB = msbackadj(MZControl,YControl,'WindowSize',500,'Quantile',0.20);

figure();
plot(MZControl, YControlB);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('Control background adj.');

[sizeYControl ,~] = size(YControl);
for i=1:sizeYControl
    meanYControl(i,:) = mean(YControl(i,:));
end

%heatmap
msheatmap(MZControl,YControlB(:,1));
%fft korelacja do wzorca (srednie z prob)
YControlA = adaptive_PAFFT(MZControl,YControlB, meanYControl, 0.7, 0.1, 't');
msheatmap(MZControl,YControlA(:,1));

%normalizacja danych przed i po korelacji
YControlN1 = msnorm(MZControl, YControl, 'LIMITS', [500 inf], 'MAX', 100);
YControlN2 = msnorm(MZControl, YControlA, 'LIMITS', [500 inf], 'MAX', 100);

figure();
plot(MZControl,YControlN1);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('Control normalization ');

figure();
plot (MZControl, YControlN2);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('Control after normalization and FFT corelation adapt.');
%powiekszenie na region najwiekszego piku
YControlN3 = msnorm(MZControl, YControlA,'limits', [7900 8500], 'quantile',[0.8 1],'MAX', 40);

figure();
plot(MZControl, YControlN3); axis([7000 10000 -5 105]);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('Control higest peak zoom in');
%redukcja szumow
YControlS = mssgolay(MZControl, YControlN2, 'SPAN', 35, 'ShowPlot', 3);

figure();
plot(MZControl, YControlS);
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('Control noise removal');

%identyfikacjia pikow ION
slopeSign = diff(YControlS(:,1))> 0;
slopeSignChange = diff(slopeSign)< 0;
h = find(slopeSignChange) + 1;
h(MZControl(h) < 1500) = [];
h(YControlS(h,1) < 5) = [];

figure();
plot(MZControl,YControlS(:,1),'-',MZControl(h),YControlS(h,1),'ro');
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
title('Control ION peaks');
