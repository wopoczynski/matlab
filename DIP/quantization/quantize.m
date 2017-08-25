function Iout = quantize(Iin,level)
level = 4;
Iout = double(Iin) / 255;
Iout = uint8(Iout * level);
Iout = double(Iout) / level;
end
