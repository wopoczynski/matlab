function show_regions_new(net,p,t,x_lim,y_lim);

[kx,ky]=size(t); outputs=kx; samples=ky;
vk=127; %liczba dyskretnych punktów podzialu obu osi
K=36;
colors='brgymc';
vx=x_lim(1):(x_lim(2)-x_lim(1))/vk:x_lim(2); %dyskretne punkty dla osi x
vy=y_lim(1):(y_lim(2)-y_lim(1))/vk:y_lim(2); %dyskretne punkty dla osi y

[x,y]=meshgrid(vx,vy); % meshgrid
[n,m]=size(x);
p2=[reshape(x,1,n*m);reshape(y,1,n*m)]; % zamiana wspolzednych dyskretnych punktow na macierz wejsc dla sieci 

y2=sim(net,p2); % symulacja sieci neuronowej dla dyskretnych punktow

%=============== Obliczenie numerow klas ==============================
if outputs==1
   yimage=hardlim(y2-0.5)+1; % dla przypadku dwuklasowego "1" dla pierwszej klasy gdy >0.5, "2" dla 2 klasy gdy <0.5
else
   [ysort,yi]=sort(y2); yi=flipud(yi); % dla przypadku wieloklasowego numer wyj?cia sieci na której jest najwieksza wartosc
   yimage=yi(1,:);
end;
y2=yimage;
yimage=reshape(yimage,n,m); % Zamiana wektora numerów klas na macierz


%====================== Rysowanie kolorowych obszarów dla klas =====================
clf;
hold on
map1=[0 0 1; 1 0 0; 0 1 0; 1 1 0; 1 0 1; 0 1 1]*0.66;
map = [map1;map1;map1;map1;map1;map1]; 
n_class = max(y2);
for i=1:n_class
    i_class = find(y2==i);
    plot(p2(1,i_class),p2(2,i_class),'.','Markersize',20,'Color',map(i,:));
end

%============= Rysowanie zbioru ===================
if outputs==1 %dla przypadku dwukladowego
   plot(p(1,find(t==1)),p(2,find(t==1)),'.r'); plot(p(1,find(t==1)),p(2,find(t==1)),'ow');
   plot(p(1,find(t==0)),p(2,find(t==0)),'.b'); plot(p(1,find(t==0)),p(2,find(t==0)),'ow');
else  % dla przypdku dwukladowego
   [tsort,ti]=sort(t); ti=flipud(ti);
   ti=ti(1,:); 
   for i=1:samples
      plot(p(1,i),p(2,i),['.',colors(ti(i))]); plot(p(1,i),p(2,i),'ow');
   end;
end;
xlim(x_lim); x_lim
ylim(y_lim); y_lim
hold off

