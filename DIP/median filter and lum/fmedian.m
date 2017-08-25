function [I_out] = fmedian(I)
[n, m] = size(I);
I_out=I;
for i = 2:n-1
    for j = 2:m-1
        median_vec = [];
        for k = (i-1):(i+1)
            for l = (j-1):(j+1)
                median_vec = [median_vec, I(k, l)];
            end
        end
        median_vec_sort = sort(median_vec);
        I_out(i, j) = median_vec_sort(5);
    end
end
end