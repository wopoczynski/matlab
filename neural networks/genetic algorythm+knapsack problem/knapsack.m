clear all;clc
ilosc_pokolen=20;
rozmiar_populacji=15;
populacja = randi([0 1], 100,rozmiar_populacji);
mutacja = 0.05;
max_waga = 30;
%dla 5 przedmiotow
% przedmioty(1,:) = [5 6 7 4 7];
% przedmioty(2,:) = [7 8 2 1 3];
% %dla 10 przedmiotow
% przedmioty(1,:) = [1 2 1 1 1 1 2 2 1 4]; % ³¹czna waga = 26
% przedmioty(2,:) = [7 8 3 3 5 4 2 8 1 5]; % ³¹czna wartoœæ = 56
% %dla 15 przedmiotow
przedmioty(1,:) = [4 3 4 6 7 3 8 1 2 10 12 5 3 5 7]; %³¹czna waga = 42
przedmioty(2,:) = [5 5 6 8 9 9 15 3 6 10 9 12 15 8 4];% ³¹czna wartoœæ = 124
najlepszy = zeros(100,rozmiar_populacji);
populacja_temp=num2str(populacja);
fen = bin2dec(populacja_temp);
for i=1:100
    fenotyp_temp(i) = sum(przedmioty(2,logical(populacja(i,:))));
end

[fenotyp_temp_1 fenotyp_temp_2] = size(fenotyp_temp);

for i=1:fenotyp_temp_2
    if sum(przedmioty(1,logical(populacja(i,:)))) > max_waga
    fenotyp_temp(i) = -1;
    end
end

for i=1:ilosc_pokolen
    [xs, index] = sort(fenotyp_temp,'descend');%sortowanie kolumnami
    index = index(1:50);
    najlepszy(i,:) = populacja(index(1),:);
    [populacja_size_1 populacja_size_2] = size(populacja);
    rodzic = populacja(index,:);
    potomek_temp = zeros(populacja_size_1, populacja_size_2);
    for i=1:populacja_size_1
        idx = randi([1 50], populacja_size_1);
        rodzic_1=rodzic(idx(1),:);
        rodzic_2=rodzic(idx(2),:);
        potomek_temp = zeros(1,length(rodzic_1));
        miejsce_podzialu = length(rodzic_1) - 1;
        krzyzowanie = randi([1 miejsce_podzialu], 1);
        potomek_temp(1:krzyzowanie) = rodzic_1(1:krzyzowanie);
        potomek_temp(krzyzowanie:length(potomek_temp)) = rodzic_2(krzyzowanie:length(rodzic_2));
        potomek(i,:)=potomek_temp;
    end
    mutacja_szansa = rand(populacja_size_1, populacja_size_2);
    for i = 1:populacja_size_1
        for j = 1:populacja_size_2
            if mutacja_szansa(i,j) < mutacja
                if potomek(i,j) == 1
                    potomek(i,j) = 0;
                else
                    potomek(i,j) = 1;
                end
            end
        end
    end
    populacja_temp=num2str(populacja);
    fenotyp = bin2dec(populacja_temp);
    for i=1:100
        fenotyp_temp(i) = sum(przedmioty(2,logical(populacja(i,:))));
    end
[fenotyp_temp_1 fenotyp_temp_2] = size(fenotyp_temp);
    for i=1:fenotyp_temp_2
        if sum(przedmioty(1,logical(populacja(i,:)))) > max_waga
            fenotyp_temp(i) = -1;
        end
    end
end
najlepszy_temp=num2str(najlepszy);
fenotyp = bin2dec(najlepszy_temp);
% dekodowanie i wyliczenie stopnia przystosowania
for i=1:100
    najlepszy_suma(i) = sum(przedmioty(2,logical(najlepszy(i,:))));
end
[najlepszy_suma_size_1 najlepszy_suma_size_2] = size(najlepszy_suma);
for i=1:najlepszy_suma_size_2
    if sum(przedmioty(1,logical(najlepszy(i,:)))) > max_waga
        najlepszy_suma(i) = -1;
    end
end

[naj,najlepszy_index] = sort(najlepszy_suma,'descend');
wynik = najlepszy(najlepszy_index(1),:)
