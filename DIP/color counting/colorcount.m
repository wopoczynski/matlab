function n = colorcount(img)
img=double(img)/255;
rgb=img(:,:,1)+256*img(:,:,2)+256^2*img(:,:,3);
wektor=[];
n=1;
wektor_rgb=rgb(:)';
wektor_rgb=sort(wektor_rgb);
last=length(wektor_rgb);
for i=1:last-1 
    if wektor_rgb(i)~=wektor_rgb(i+1)
        n=n+1;        
    end
end
end
