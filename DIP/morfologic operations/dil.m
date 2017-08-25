function I_done = dil(I, len)
step = (len/2)-0.5;
[n, m] = size(I);
for  i = (1+step):(n-(1+step))
    for j = (1+step):(m-(1+step))
        el_vec = [];
        for k = (i-step):(i+step)
            for l = (j-step):(j+step)
                el_vec = [el_vec, I(k, l)];
            end
        end
        max_vec = max(el_vec);
        I_done(i, j) = max_vec; 
    end
end
end