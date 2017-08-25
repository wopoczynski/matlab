clear all;clc;
load drozdze;
data2=drozdze;
a=8;%dla kilku 2,4,8,
b=8;
net = newsom(data2',[a b],'randtop');%hextop randtop gridtop
net = train(net,data2');
% podpunkt c)
figure (1)
for i=1:a*b
    subplot(a,b,i)
    bar(net.iw{1}(i,:))
end
%przedstawienie odelglosci
odleglosci = dist(data2,net.iw{1}');
minimalne_odleglosci = min(odleglosci');
for z=1:length(minimalne_odleglosci)
   ktory_neuron(z) = find(odleglosci(z,:)==minimalne_odleglosci(z)); 
end
suptitle('wykres odleglosci')
% srednie wartosci expresji
figure (2)
for i=1:a*b
    subplot(a,b,i)
    if sum(ktory_neuron==i)==1
        dane2 = (data2(ktory_neuron==i,:));
    else
        dane2 = mean(data2(ktory_neuron==i,:));
    end
    bar(dane2)
end
suptitle('wykres srednich wartosci expresji')
