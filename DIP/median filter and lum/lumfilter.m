function Iout = LUM(Iin,masksize,zakres)
    [n m]=size(Iin); 
    step=floor(masksize/2);
    mediana=ceil(masksize^2/2);
    A=Iin;
    for i=1:(n-2*step)
        for j=1:(m-2*step)
            A1=Iin(i:(i+2*step),j:(j+2*step));
            mediana2=sort(A1(:));
            lum=mediana2((mediana-zakres):(mediana+zakres));
            if Iin(i+step,j+step)< min(lum) | Iin(i+step,j+step)>max(lum)
                mediana2=lum(zakres+1);
                A(i+step,j+step)=mediana2;	
            end
        end
    end
    Iout=A;
end
