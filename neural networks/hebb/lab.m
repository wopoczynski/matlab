clear all; clc; close all;

d1=[1 -1 -1 -1 -1 ...
    -1 1 -1 -1 -1 ...
    -1 -1 1 -1 -1 ...
    -1 -1 -1 1 -1 ...
    -1 -1 -1 -1 1]';

d2=[-1 -1 -1 -1 -1 ...
    1 -1 -1 -1 -1 ...
    1 1 -1 -1 -1 ...
    1 1 1 -1 -1 ...
    1 1 1 1 -1]';

d3=[1 -1 -1 -1 1 ...
    -1 -1 1 -1 -1 ...
    -1 1 1 1 -1 ...
    -1 -1 1 -1 -1 ...
    1 -1 -1 -1 1]';

d4=[1 -1 -1 -1 1 ...
    -1 -1 -1 -1 -1 ...
    -1 -1 -1 -1 -1 ...
    -1 -1 -1 -1 -1 ...
    1 -1 -1 -1 1]';

d5=[1 1 -1 1 1 ...
    -1 1 1 1 -1 ...
    -1 1 -1 1 -1 ...
    -1 1 1 1 -1 ...
    1 1 -1 1 1]';

d6=[1 1 -1 -1 -1 ...
    1 1 -1 -1 -1 ...
    1 1 1 1 1 ...
    -1 -1 1 1 1 ...
    -1 -1 1 1 1]';

t=[1 -1 -1 -1 1 ...
    -1 -1 1 -1 -1 ...
    -1 1 -1 1 -1 ...
    -1 -1 1 -1 -1 ...
    1 -1 -1 -1 1]';

d1_v2=reshape(d1, 5, 5);
d2_v2=reshape(d2, 5, 5);
d3_v2=reshape(d3, 5, 5);
d4_v2=reshape(d4, 5, 5);
d5_v2=reshape(d5, 5, 5);
d6_v2=reshape(d6, 5, 5);
t_v2=reshape(t, 5, 5);

D(:,1)=d1;
D(:,2)=d2;
D(:,3)=d3;
D(:,4)=d4;
D(:,5)=d5;
D(:,6)=d6;
N=length(d1);%iloœæ neuronów
Pmax=N-1;%pseudoinwersja
PNmax=0.138*N;%hebb
W=(1/N)*D*D';%wagi dla æwiczenia 1 r. Hebba
W2=D*(((D')*D)^(-1))*(D');%wagi dla æwiczenia 2


for i=1:10
    if i==1
        wynik=sign(W*t);
    else
        wynik=sign(W*wynik);
    end
end
wynik_Hebba=reshape(wynik, 5, 5);

for i=1:10
    if i==1
        wynik2=sign(W2*t);
    else
        wynik2=sign(W2*wynik2);
    end
end
wynik_pseudo=reshape(wynik2, 5, 5);

figure (1)
suptitle('Regu³a Hebba');

subplot(2, 4, 1)
imshow(d1_v2)
title('wzorzec d1')

subplot(2, 4, 2)
imshow(d2_v2)
title('wzorzec d2')

subplot(2, 4, 3)
imshow(d3_v2)
title('wzorzec d3')

subplot(2, 4, 4)
imshow(d4_v2)
title('wzorzec d4')

subplot(2, 4, 5)
imshow(d5_v2)
title('wzorzec d5')

subplot(2, 4, 6)
imshow(d6_v2)
title('wzorzec d6')

subplot(2, 4, 7)
imshow(t_v2)
title('obraz testowy')

subplot(2, 4, 8)
imshow(wynik_Hebba)
title('wynik')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (2)
suptitle('Regu³a Pseudoinwersji');

subplot(2, 4, 1)
imshow(d1_v2)
title('wzorzec d1')

subplot(2, 4, 2)
imshow(d2_v2)
title('wzorzec d2')

subplot(2, 4, 3)
imshow(d3_v2)
title('wzorzec d3')

subplot(2, 4, 4)
imshow(d4_v2)
title('wzorzec d4')

subplot(2, 4, 5)
imshow(d5_v2)
title('wzorzec d5')

subplot(2, 4, 6)
imshow(d6_v2)
title('wzorzec d6')

subplot(2, 4, 7)
imshow(t_v2)
title('obraz testowy')

subplot(2, 4, 8)
imshow(wynik_pseudo)
title('wynik')

% print(figure(1), '2x2v1.png','-dpng');
% print(figure(2), '2x2v2.png','-dpng');
