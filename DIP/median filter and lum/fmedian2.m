function [I_out] = fmedian2(I, len)
step = floor(len/2);
[n, m] = size(I);
I_out=I;
for i = (1+step):(n-(1+step))
    for j = (1+step):(m-(1+step))
        median_vec = [];
        for k = (i-step):(i+step)
            for l = (j-step):(j+step)
                median_vec = [median_vec, I(k, l)];
            end
        end
        median_vec_sort = sort(median_vec);
        I_out(i, j) = median_vec_sort((len^2+1)/2);
    end
end
end