%tworzenie pliku drozdze do obrobki
clear all;clc;close all
%wczytanie pliku
dane=importdata('drozdze.xls');
dane=dane.textdata;
dane=dane(71:end,3:end);
%wydobycie danych z formatu cell do tabeli
dane=cellfun(@str2double,dane);
%odnalezienie wartosci NaN oraz ich usuniecie
[row,col]=find(isnan(dane));
[dane2,removed]=removerows(dane,'ind',row);
drozdze=dane2(1:500,1:end);
%zapis do pliku drozdze.mat 
save('drozdze.mat','drozdze');