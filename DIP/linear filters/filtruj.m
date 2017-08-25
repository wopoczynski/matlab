function [im_b] = filtruj(im_a, len)
    step = len/2-0.5;
    [m,n] = size(im_a);
	im_b=im_a;
    for i = len:m-len
        for j = len:n-len
            sum = 0;
            for k = i-step:i+step
                for l = j-step:j+step
                    sum = sum+im_a(k,l);
                end
            end
            im_b(i,j) = sum/(len^2);
        end
    end
end 