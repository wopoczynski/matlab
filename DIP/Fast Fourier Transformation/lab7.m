%na 0 poprawne wy�wietlanie widma amplitudowego i fazowego
%na 1 filtracja dolnoprzepustowa i g�rnoprzepustowa
%na 2 filtracja pasmoprzepustowa
I=(imread('circles.png'));
I2=(imread('sticks.png'));
I3=(imread('triangles.png'));
I4=(imread('sin.png'));
I5=(imread('gauss.png'));

%wy�wietlenie widm
f=filtr(I5,50);
FL1=fftshift(fft2(I5));
ML1=log(abs(FL1)+1);
figure
imshow(ML1,[]);
title('widmo amplitudowe')
figure
imshow(angle(FL1),[]);
title('widmo fazowe')