function show_trainset(p,t,xlim,ylim);

[kx,ky]=size(t); outputs=kx; samples=ky;
colors='brgymc';
plot(p(1,:),p(2,:),'ow'); hold on;
set(gca,'Color',[0 0 0]);
if outputs==1  %dla przypadku dwuklasowego
   plot(p(1,find(t==1)),p(2,find(t==1)),'.r'); plot(p(1,find(t==1)),p(2,find(t==1)),'ow');
   plot(p(1,find(t==0)),p(2,find(t==0)),'.b'); plot(p(1,find(t==0)),p(2,find(t==0)),'ow'); 
else   %dla przypadku wieloklasowego
   [tsort,ti]=sort(t); ti=flipud(ti);
   ti=ti(1,:); 
   for i=1:samples
      plot(p(1,i),p(2,i),['.',colors(ti(i))]); plot(p(1,i),p(2,i),'ow');
   end;
end;
axis([xlim,ylim]);
hold off

