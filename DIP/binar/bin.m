function Iout = bin(I,T)
[m,n]=size(I);
Inew=[];
for i=1:m
    for j=1:n
        if I(i,j) >= T
            Inew(i,j)=0;
        else
            Inew(i,j)=1;
        end
    end
end
Iout=Inew;
end