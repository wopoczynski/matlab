
clear;clc;
populacja_wielkosc = 100;
iloscbitow = 6;
mutacja = 0.05;
maximum = 25;
minimum = 0;
wagi = [7 8 2 1 3 4];
wartosci = [10 11 7 6 8 3];

populacja = randi([0 1], populacja_wielkosc, iloscbitow);
wagi = populacja.*wagi;
wartosci = populacja.*wartosci;
fenotyp=wagi; 
a = (maximum-minimum)/(2^iloscbitow-1);
x = fenotyp*a+minimum;
x = sin((6*pi*x)/10)+3;
Fdopasowania = x;
for k=1:6
    if sum(fenotyp(k,:)) > maximum;
        Fdopasowania=-1;
    end
end

for i = 1:populacja_wielkosc
    [value, index] = sort(Fdopasowania);
    populacja = populacja(index(1:(populacja_wielkosc/2)),:);
    rodzice = randi([1 (populacja_wielkosc/2)],[(populacja_wielkosc/2) 2]); 
    rodzic_A =(populacja(rodzice(:,1),:));
    rodzic_B =(populacja(rodzice(:,2),:));
    krzyzowanie = randi([1 iloscbitow],[(populacja_wielkosc/2) 1]);
    potomki = []; 
    for j = 1:(populacja_wielkosc/2)
        potomki(j, (1:iloscbitow)) = [rodzic_A(j,(1:(krzyzowanie(j)-1))) rodzic_B(j,((krzyzowanie(j)):end))];
        if mutacja <= rand()
            mutacja_miejsce = randi([1 iloscbitow],1);
            if potomki(j,mutacja_miejsce) == 1
                potomki(j,mutacja_miejsce) = 0;
            else
                 potomki(j,mutacja_miejsce) = 1;
            end
        end
    end
    populacja = [populacja; potomki];
    wartosci = populacja.*wartosci;

    fenotyp =wagi;
    a = (maximum-minimum)/(2^iloscbitow - 1);
    x = fenotyp*a + minimum; 
    x = sin((6*pi*x)/10)+3;
    Fdopasowania = x; 
    for k=1:6
        if sum(fenotyp(k,:)) > maximum;
            Fdopasowania==-1;
        end
    end
end
disp('         ~~~~~~~~~~done~~~~~~~~~~~~');
disp(populacja);

