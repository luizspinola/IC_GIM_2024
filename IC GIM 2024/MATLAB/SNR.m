function [snr_image] = SNR(img)

avg = mean(double(img(:)));
despad = std(double(img(:)));

snr_image = avg/despad;
end
