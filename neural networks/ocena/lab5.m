
clear;clc;close all;

data = normrnd(0,10,2,200);
t = randperm(200); 
save ('danetestowe','data','t')
%%
load danetestowe

klasy(t(1:100)) = 1;
klasy(t(101:end)) = -1;
data(:,klasy == -1) = data(:, klasy == -1) +30;
fig=figure(1);
plot(data(1,klasy == -1), data(2,klasy == -1),'ko','MarkerFaceColor','r', 'markersize', 7);
hold on;
plot(data(1,klasy == 1), data(2,klasy == 1),'ko','MarkerFaceColor','b', 'markersize', 7);
legend ('klasa -1', 'klasa 1');
hold on;
saveas(1, 'klasy generowane', 'png');

klasy_wynik=[];
parfor i=1:length(klasy)
    data_pousunieciu = data;
    data_pousunieciu(:,i)=[];
    testowy = data(:,i);
    klasy_pousunieciu = klasy;
    klasy_pousunieciu(:,i)=[];
    net=newp(data,klasy,'hardlims','learnpn');
    net.trainParam.epochs=100; 
    net.trainParam.showWindow = false;
    net=train(net, data_pousunieciu, klasy_pousunieciu);
    fprintf('po iteracji = %d\n', i);
    klasy_wynik(i) = sim(net, testowy);
end
fprintf('done gen');
plot(data(1,klasy_wynik == -1), data(2,klasy_wynik == -1),'ko','MarkerFaceColor','r', 'markersize', 4);
hold on
plot(data(1,klasy_wynik == 1), data(2,klasy_wynik == 1),'ko','MarkerFaceColor','b', 'markersize', 4);
legend ('klasa -1 po', 'klasa 1 po')

saveas(1, 'klasy wynik generowane', 'png');


FP = 1;
FN = 1;
TP = 99;
TN = 99;

Err = (FP+FN)/(TP+TN+FP+FN);
Acc = (TP+TN)/(TP+TN+FP+FN);
Sens = TP/(TP+FN);
Spec = TN/(TN+FP);
%% 
clear;clc;close all;
old = 'D:\Dropbox\studia\SISN\lab5 ocena jakosci';
cd 'D:\Dropbox\studia\SISN\lab5 ocena jakosci\Data_PTC_vs_FTC';
load('Data_PTC_vs_FTC.mat');
cd(old);

data(1,:) = Data.X(666,:);%
data(2,:) = Data.X(665,:);%
klasy = Data.D;
figure(1);
plot(data(1,klasy == -1), data(2,klasy == -1),'ko','MarkerFaceColor','r', 'markersize', 7);
hold on;
plot(data(1,klasy == 1), data(2,klasy == 1),'ko','MarkerFaceColor','b', 'markersize', 7);
legend ('klasa -1', 'klasa 1');
hold on;
saveas(1, 'klasy podane v2', 'png');

klasy_wynik=[];
parfor i=1:length(klasy)
    data_pousunieciu = data;
    data_pousunieciu(:,i)=[];
    testowy = data(:,i);
    klasy_pousunieciu = klasy;
    klasy_pousunieciu(:,i)=[];
    net=newp(data,klasy,'hardlims','learnpn'); 
    net.trainParam.epochs=200; 
    net.trainParam.showWindow = false;
    net=train(net, data_pousunieciu, klasy_pousunieciu);
    fprintf('po iteracji = %d\n', i);
    klasy_wynik(i) = sim(net, testowy);
end
fprintf('done real');
figure (1)
plot(data(1,klasy_wynik == -1), data(2,klasy_wynik == -1),'ko','MarkerFaceColor','r', 'markersize', 4);
hold on
plot(data(1,klasy_wynik == 1), data(2,klasy_wynik == 1),'ko','MarkerFaceColor','b', 'markersize', 4);
legend ('klasa -1 po', 'klasa 1 po')

saveas(1, 'klasy platforma po klasyfikacji v2', 'png');


FP = 86;
FN = 0;
TP = 86;
TN = 0;


Err = (FP+FN)/(TP+TN+FP+FN);
Acc = (TP+TN)/(TP+TN+FP+FN);
Sens = TP/(TP+FN);
Spec = TN/(TN+FP);

