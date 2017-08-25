%rozmiar max 900x900

%wielkosc tablicy
m = randi(2, 150) - 1;
while true      %use control C to stop
   imshow(m);
   drawnow;
   neighbours = conv2(m, [1 1 1 1 1; 1 1 1 1 1; 1 1 0 1 1; 1 1 1 1 1; 1 1 1 1 1], 'same');
   %neighbours = conv2(m, [1 1 1 ; 1 0 1; 1 1 1], 'same');
   m = double((m & neighbours == 3) | neighbours == 3);
   
end
