function Iout = quantizelinearHSV(Iin,level)
    [m,n,o]=size(Iin);
    Iout=zeros(m,n,o);
    for i=1:o
        Iij_min=double(min(min(Iin(:,:,i))));
        Iij_max=double(max(max(Iin(:,:,i))));
        wektor(:,:,i)= linspace(Iij_min,Iij_max,level);
        wektor_i=wektor(:,:,i);
        index=double(Iin(:,:,i));
        Iout(:,:,i) = interp1(wektor_i,wektor_i,index,'nearest');
    end
    Iout=uint8(Iout);
end
