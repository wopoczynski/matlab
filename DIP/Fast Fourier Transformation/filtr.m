function Iout = filtr(Iin,m)
Iout=Iin;
for i=(128+m):(128-m)
    for j=(128+m):(128-m) 
    Iout(i,j)=0;%%%%
    end
end
end