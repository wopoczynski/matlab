tic
clear ; close all; clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2)); 
N1 = 1:6:61;
folder = '2 warstwy traingd'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'tansig','purelin'}, 'traingd'); 

net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2; 
Y = sim(net,X); 
figure(i);
plot(Xlearn, Dlearn, 'ro'); 
hold on;
plot(X,Y);
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n metoda traingd', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

% test
Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana wartosci bledow w zaleznosci \n od ilosci liczby neuronow w pierwszej warstwie'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)

%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy traingdm'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'tansig','purelin'}, 'traingdm'); 

net.trainParam.epochs = 200; 
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2; 
Y = sim(net,X);
figure(i);
plot(Xlearn, Dlearn, 'ro'); 
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n metoda traingdm', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

% test
Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana wartosci bledow w zaleznosci \n od ilosci liczby neuronow w pierwszej warstwie'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy tagsig purelin'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'tansig','purelin'}, 'trainlm'); 
net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;   
Y = sim(net,X); 
figure(i);
plot(Xlearn, Dlearn, 'ro'); 
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie funkcja tansig+purelin', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

% test
Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana bledow f.tansig+purelin'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
%% 3 warstw 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '3 warstwy'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) 5 N2], {'tansig','tansig','purelin'}, 'trainlm'); 
net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;   
Y = sim(net,X); 
figure(i);
plot(Xlearn, Dlearn, 'ro'); 
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n 5 neuronów w warstwie II oraz 1 w III warstwie', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

% test
Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana wartosci bledow w zaleznosci \n od ilosci liczby neuronow w pierwszej warstwie'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
%% 5 warstw 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '5 warstw'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) 5 5 5 N2], {'tansig','tansig','tansig','tansig','purelin'}, 'trainlm'); 
net.trainParam.epochs = 200; 
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;  
Y = sim(net,X); 
figure(i);
plot(Xlearn, Dlearn, 'ro');
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n 5 neuronów w warstwie II,III,IV oraz 1 w V', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

% test
Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana wartosci bledow w zaleznosci \n od ilosci liczby neuronow w pierwszej warstwie'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy tansig logsig'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'tansig','logsig'}, 'trainlm'); 

net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2; 
Y = sim(net,X);
figure(i);
plot(Xlearn, Dlearn, 'ro');
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n funkcja aktywacji tansig+logsig', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

% test
Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('wartosci bledow f.tansig+logsig'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy logsig tansig'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'logsig','tansig'}, 'trainlm'); 
net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;  
Y = sim(net,X); 
figure(i);
plot(Xlearn, Dlearn, 'ro'); 
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n funkcja aktywacji logsig+tansig', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');


Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana bledow f. logsig+tansig'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy purelin tansig'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'purelin','tansig'}, 'trainlm');
net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;  
Y = sim(net,X);
figure(i);
plot(Xlearn, Dlearn, 'ro');
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n funkcja aktywacji purelin+tansig', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

% test
Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana bledow f. purelin+tansig'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)z
%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy trainlm 500ep'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'tansig','purelin'}, 'trainlm'); 
net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;  
Y = sim(net,X);
figure(i);
plot(Xlearn, Dlearn, 'ro'); 
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n 500 epochs', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');


Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana wartosci bledow w zaleznosci \n od ilosci liczby neuronow w pierwszej warstwie'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2));
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy trainlm'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'tansig','purelin'}, 'trainlm'); 

net.trainParam.epochs = 100;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;  
Y = sim(net,X); 
figure(i);
plot(Xlearn, Dlearn, 'ro'); 
hold on;
plot(X,Y); 
title(sprintf('aproksymacja dla %d neuronow w I warstwie 100 epochs', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana wartosci bledow w zaleznosci \n od ilosci liczby neuronow w pierwszej warstwie'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)
close all;clc;
%% 
clear;close all;clc
oldFolder = cd('D:\Dropbox\studia\SISN\lab3 aproksymacja');
Xlearn = [0:.5:10];
Dlearn = sin(7*log(Xlearn.^2)); 
N1 = 1:6:61;
N2 = 1;
folder = '2 warstwy trainlm 1000ep'; 
mkdir (folder);
cd (folder);

for i=1:length(N1)
net = newff([0, 10], [N1(i) N2], {'tansig','purelin'}, 'trainlm');
net.trainParam.epochs = 200;
net.trainParam.showWindow = false;
net = train(net, Xlearn, Dlearn);

X = [-3:.5:10]+2;  
Y = sim(net,X);
figure(i);
plot(Xlearn, Dlearn, 'ro');
hold on;
plot(X,Y);
title(sprintf('aproksymacja dla %d neuronow w I warstwie \n 1000 epochs', N1(i)));
hold off;
xlabel('x');
ylabel('f(x)');
print(figure(i), ['siec_' num2str(i) '.png'], '-dpng');

Et = [];
El = [];
    for j = 1:10
        Xtest = Xlearn+1.5;
        Ytest = sim(net, Xtest);
        Dtest = sin(7*log(Xlearn.^2));
        Et(j) = mse(Dtest-Ytest);
        Ylearn = sim(net, Xlearn);
        El(j) = mse(Dlearn-Ylearn);
    end
    Etest(i)=median(Et);
    Elearn(i)=median(El);

end

fig = figure;
plot(N1, Elearn, 'r', N1, Etest, 'g');
title(sprintf('zmiana wartosci bledow w zaleznosci \n od ilosci liczby neuronow w pierwszej warstwie'));
legend('Elearn', 'Etest');
xlabel('ilosc neuronow');
ylabel('wartosc wskaznika');
print(fig, 'bledy sieci.png', '-dpng');
cd(oldFolder)


toc
