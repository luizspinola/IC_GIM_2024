function [icc] = ICC(img)

if not(isa(img, 'uint16'))
    warning('Image is not uint12!');
end

icc_not_normalized = mean(stdfilt(double(img(:))));
icc = icc_not_normalized/((2^16)-1);




end