clear;clc;close all;

im_raw_name= 'MG24_proc';
im = dicomread(strcat(im_raw_name));

mg19= im;
[m,n] = size(mg19);

%__________________________________________________________________________
%%Filtrando imagem

%filtro media 3
filtrom3 = fspecial('average', [3 3]);
imMEDIA3 = imfilter(mg19,filtrom3);

%filtro media 5
filtrom5 = fspecial('average', [5 5]);
imMEDIA5 = imfilter(mg19,filtrom5);

%filtro mediana
imMEDIANA = medfilt2(mg19);

%filtro gaussiano
imGAUSSIANO = imgaussfilt(mg19);

%filtro wiener
imWIENER = wiener2(mg19,[3 3]);

%__________________________________________________________________________
%desvio padrao imagem original
dp_im_original = stdfilt(mg19);
% figure (1);
% imshow(dp_im_original, []);

%desvio padrao media 3
dp_im_med3 = stdfilt(imMEDIA3);
% figure (2);
% imshow(dp_im_med3, []);

im_ruido_med3 = abs(mg19 - imMEDIA3);
dp_im_ruido_med3 = stdfilt(im_ruido_med3);
% figure(3);
% imshow(dp_im_ruido_med3, []);

med_med3 = mean(dp_im_ruido_med3(:));

%desvio padrao media 5
dp_im_med5 = stdfilt(imMEDIA5);
% figure (4);
% imshow(dp_im_med5, []);

im_ruido_med5 = abs(mg19 - imMEDIA5);
dp_im_ruido_med5 = stdfilt(im_ruido_med5);
% figure(5);
% imshow(dp_im_ruido_med5, []);

med_med5 = mean(dp_im_ruido_med5(:));

%desvio padrao mediana
dp_im_mediana = stdfilt(imMEDIANA);
% figure (6);
% imshow(dp_im_mediana, []);

im_ruido_mediana = abs(mg19 - imMEDIANA);
dp_im_ruido_mediana = stdfilt(im_ruido_mediana);
% figure(7);
% imshow(dp_im_ruido_mediana, []);

med_mediana = mean(dp_im_ruido_mediana(:));

%desvio padrao gaussiano
dp_im_gaussiano = stdfilt(imGAUSSIANO);
% figure (8);
% imshow(dp_im_gaussiano, []);

im_ruido_gaussiano = abs(mg19 - imGAUSSIANO);
dp_im_ruido_gaussiano = stdfilt(im_ruido_gaussiano);
% figure(9);
% imshow(dp_im_ruido_gaussiano, []);

med_gaussiano = mean(dp_im_ruido_gaussiano(:));

%desvio padrão WIENER
dp_im_wiener = stdfilt(imWIENER);
% figure (10);
% imshow(dp_im_wiener, []);

im_ruido_wiener = abs(mg19 - imWIENER);
dp_im_ruido_wiener = stdfilt(im_ruido_wiener);
% figure(11);
% imshow(dp_im_ruido_wiener, []);

med_wiener = mean(dp_im_ruido_wiener(:));

%__________________________________________________________________________
%Calcular Médias e Desvios Padrões Globais

avg_original = mean(double(mg19(:)));
dp_original = std(double(mg19(:)));

avg_med3 = mean(double(imMEDIA3(:)));
dp_med3 = std(double(imMEDIA3(:)));

avg_med5 = mean(double(imMEDIA5(:)));
dp_med5 = std(double(imMEDIA5(:)));

avg_mediana = mean(double(imMEDIANA(:)));
dp_mediana = std(double(imMEDIANA(:)));

avg_gauss = mean(double(imGAUSSIANO(:)));
dp_gauss = std(double(imGAUSSIANO(:)));

avg_wiener = mean(double(imWIENER(:)));
dp_wiener = std(double(imWIENER(:)));

%__________________________________________________________________________
%Printar Resultados.

fprintf('IMAGEM ORIGINAL:\n');
fprintf('MEDIA GLOBAL:\n');
disp(avg_original)
fprintf('DP GLOBAL:\n');
disp(dp_original)
fprintf('SNR:\n');
disp(avg_original/dp_original)

fprintf('MEDIA 3:\n');
fprintf('MED DP MATRIZ RUÍDO:\n');
disp(med_med3)
fprintf('MEDIA GLOBAL:\n');
disp(avg_med3)
fprintf('DP GLOBAL:\n');
disp(dp_med3)
fprintf('SNR:\n');
disp(avg_med3/dp_med3)


fprintf('MEDIA 5:\n');
fprintf('MED DP MATRIZ RUÍDO:\n');
disp(med_med5)
fprintf('MEDIA GLOBAL:\n');
disp(avg_med5)
fprintf('DP GLOBAL:\n');
disp(dp_med5)
fprintf('SNR:\n');
disp(avg_med5/dp_med5)


fprintf('MEDIANA:\n');
fprintf('MED DP MATRIZ RUÍDO:\n');
disp(med_mediana)
fprintf('MEDIA GLOBAL:\n');
disp(avg_mediana)
fprintf('DP GLOBAL:\n');
disp(dp_mediana)
fprintf('SNR:\n');
disp(avg_mediana/dp_mediana)


fprintf('GAUSSIANO:\n');
fprintf('MED DP MATRIZ RUÍDO:\n');
disp(med_gaussiano)
fprintf('MEDIA GLOBAL:\n');
disp(avg_gauss)
fprintf('DP GLOBAL:\n');
disp(dp_gauss)
fprintf('SNR:\n');
disp(avg_gauss/dp_gauss)

fprintf('WIENER 3:\n');
fprintf('MED DP MATRIZ RUÍDO:\n');
disp(med_wiener)
fprintf('MEDIA GLOBAL:\n');
disp(avg_wiener)
fprintf('DP GLOBAL:\n');
disp(dp_wiener)
fprintf('SNR:\n');
disp(avg_wiener/dp_wiener)