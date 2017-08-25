function out = unsharp(I)
H = padarray(2,[2 2]) - fspecial('gaussian' ,[5 5],2);
figure,imshow(I);
K = imfilter(I,H);
out=K;
end