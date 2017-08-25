%% %% 
% %life
% % open life % polecenie open otwiera kazdy napisany skrypt w matlabie
% % :3life
% %generalnie powinnismy zmodyfikowac life >> mylife
% %moja gra
% 
% %rozmiar max 900x900
% 
% %wielkosc tablicy
% 
% rozmiar=650;
% m = randi(2, rozmiar)-1;
% while true      %use control C to stop
%    imshow(m);
%    drawnow;
%    neighbours = conv2(m, [1 1 1 1 1; 1 1 1 1 1; 1 1 0 1 1; 1 1 1 1 1; 1 1 1 1 1], 'same');
%    %neighbours = conv2(m, [1 1 1 ; 1 0 1; 1 1 1], 'same');
%    m = double((m & neighbours == 1) | neighbours == 3); %zmieniajac tutaj parametry zmieniasz uklad
%    pause(0.001)
%    
% end
%% v2
clear all;clc;close all;
ilosckomorek=100;
ilosciteracji=600; %ilosc przejsc
colormap summer;% whitebg('black'); %gdy colormap kolor odklikac whitebg
Mapa= round(rand(ilosckomorek));
A = [ilosckomorek 1:ilosckomorek-1];
B = [2:ilosckomorek 1];
licznik=0;
while licznik<ilosciteracji 
    
    Sasiedztwo = Mapa(A,:)+Mapa(B,:)+Mapa(:,B)+Mapa(:,A)+Mapa(A,B)+Mapa(A,A)+Mapa(B,B)+Mapa(B,A);
    Mapa = double((Mapa & (Sasiedztwo == 3)) | (Sasiedztwo == 1));
    surf(Mapa); view([0 90]); pause(0.001)
    
    licznik=licznik+1;
end

