function Iout1=laplacian(Iin,parametr)
p1=(parametr/255);
[x,y]=size(Iin);
Iout=zeros(x);
for i=2:x-1
   for j=2:y-1
      Iout(i,j)=Iin(i-1,j)+Iin(i,j-1)+Iin(i,j+1)+Iin(i+1,j)-4*Iin(i,j);
            if Iout(i,j)>p1 %zmiana param zmienia jakosc obrazu
                Iout(i,j)=0;
            else
                Iout(i,j)=1;
            end
   end
end
Iout1=Iin.*Iout;
end
