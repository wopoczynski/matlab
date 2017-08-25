function [im_b] = filtr(im_a, len)
    step = floor(len/2);
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