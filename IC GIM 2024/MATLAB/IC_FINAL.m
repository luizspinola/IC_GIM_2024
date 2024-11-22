%Código Final IC - Luiz Felipe Spinola Silva
%Título: Análise e Avalização de Ruído em Perfil em Imagens Mamográficas
%
%Objetivo: Código que recebe como entrada uma imagem PROCESSADA e retorna
%subplots do gráfico de perfil da coluna média da imagem e a imagem
%correspondente para imagens realçadas com filtros Roberts, Sobel, Prewitt
%e Frei-Chen, além disso, retorna uma planilha com os dados de SNR e ICC
%(Índice Carneiro de Contraste) referentes a imagem original e cada Filtro

%% Seções

clc; clear; close all;

%% Abertura da imagem

name = input("Escreva o nome da imagem\n", "s");

img = dicomread(strcat("IMAGENS IC\IMAGENS NÃO SELECIONADAS\", name));

img = uint16(double(img)*16.0037);

[m, n] = size(img);

%% Processo de Filtragem da Imagem

%Filtro de Roberts
roberts_ver = [0 0 -1; 0 1 0; 0 0 0];
roberts_hor = [-1 0 0; 0 1 0; 0 0 0];

img_roberts_ver = imfilter(img, roberts_ver);
img_roberts_hor = imfilter(img, roberts_hor);

img_roberts = img + img_roberts_ver + img_roberts_hor;

%Filtro de Sobel
sobel_ver = 0.25.*[1 0 -1; 2 0 -2; 1 0 -1];
sobel_hor = 0.25.*[-1 -2 -1; 0 0 0; 1 2 1];

img_sobel_ver = imfilter(img, sobel_ver);
img_sobel_hor = imfilter(img, sobel_hor);

img_sobel = img + img_sobel_ver + img_sobel_hor;

%Filtro de Prewitt
prewitt_ver = (1/3).*[1 0 -1; 1 0 -1; 1 0 -1];
prewitt_hor = (1/3).*[-1 -1 -1; 0 0 0; 1 1 1];

img_prewitt_ver = imfilter(img, prewitt_ver);
img_prewitt_hor = imfilter(img, prewitt_hor);

img_prewitt = img + img_prewitt_ver + img_prewitt_hor;

%Filtro de Frei-Chen
freichen_ver = (1/(2+sqrt(2))).*[1 0 -1; sqrt(2) 0 sqrt(2); 1 0 -1];
freichen_hor = (1/(2+sqrt(2))).*[-1 -sqrt(2) -1; 0 0 0; 1 sqrt(2) 1];

img_freichen_ver = imfilter(img, freichen_ver);
img_freichen_hor = imfilter(img, freichen_hor);

img_freichen = img + img_freichen_ver + img_freichen_hor;

%Média Não Local
img_nonlocalmeans = imnlmfilt(img); %Referencial para filtro de denoising

%% Geração dos Vetores da coluna média.

collumn_img = img(:, (n/2));
collumn_img_roberts = img_roberts(:, (n/2));
collumn_img_sobel = img_sobel(:, (n/2));
collumn_img_prewitt = img_prewitt(:, (n/2));
collumn_img_freichen = img_freichen(:, (n/2));
collumn_img_nonlocalmeans = img_nonlocalmeans(:, (n/2));

%% Obtendo valores quantitativos

snr_img = SNR(img);
snr_img_roberts = SNR(img_roberts);
snr_img_sobel = SNR(img_sobel);
snr_img_prewitt = SNR(img_prewitt);
snr_img_freichen = SNR(img_freichen);
snr_img_nonlocalmeans = SNR(img_nonlocalmeans);

icc_img = ICC(img);
icc_img_roberts = ICC(img_roberts);
icc_img_sobel = ICC(img_sobel);
icc_img_prewitt = ICC(img_prewitt);
icc_img_freichen = ICC(img_freichen);
icc_img_nonlocalmeans = ICC(img_nonlocalmeans);

%% Resposta Qualitativa

%% Imagem Original
figure()

subplot(1,2,1)
imshow(img)
hold on
xline(n/2, 'Color', [255,255,51]/255, 'LineWidth', 2);
title('Imagem Original', 'FontSize', 14, 'FontName', 'Times New Roman');
hold off

subplot(1,2,2)
plt = plot(collumn_img);
hold on
title('Perfil da Coluna média da imagem');
set(plt, 'LineStyle','-', 'Color', [7, 153, 146]/255, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');
xlabel('Linha')
ylabel('Tom de Cinza (16 bits)')
xlim([0 m])
ylim([0 65535])
set(gca, 'TickLength', [.02 .02], 'XminorTick', 'on', 'YMinorTick', 'on', 'LineWidth', 1);
set(gcf, 'color', 'w');
hold off

%% Imagem Roberts
figure()

subplot(1,2,1)
imshow(img_roberts)
hold on
xline(n/2, 'Color', [255,255,51]/255, 'LineWidth', 2);
title('Imagem Realçada com Roberts', 'FontSize', 14, 'FontName', 'Times New Roman');
hold off

subplot(1,2,2)
plt = plot(collumn_img_roberts);
hold on
title('Perfil da Coluna média da imagem');
set(plt, 'LineStyle','-', 'Color', [7, 153, 146]/255, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');
xlabel('Linha')
ylabel('Tom de Cinza (16 bits)')
xlim([0 m])
ylim([0 65535])
set(gca, 'TickLength', [.02 .02], 'XminorTick', 'on', 'YMinorTick', 'on', 'LineWidth', 1);
set(gcf, 'color', 'w');
hold off

%% Imagem Sobel
figure()

subplot(1,2,1)
imshow(img_sobel)
hold on
xline(n/2, 'Color', [255,255,51]/255, 'LineWidth', 2);
title('Imagem Realçada com Sobel', 'FontSize', 14, 'FontName', 'Times New Roman');
hold off

subplot(1,2,2)
plt = plot(collumn_img_sobel);
hold on
title('Perfil da Coluna média da imagem');
set(plt, 'LineStyle','-', 'Color', [7, 153, 146]/255, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');
xlabel('Linha')
ylabel('Tom de Cinza (16 bits)')
xlim([0 m])
ylim([0 65535])
set(gca, 'TickLength', [.02 .02], 'XminorTick', 'on', 'YMinorTick', 'on', 'LineWidth', 1);
set(gcf, 'color', 'w');
hold off

%% Imagem Prewitt
figure()

subplot(1,2,1)
imshow(img_prewitt)
hold on
xline(n/2, 'Color', [255,255,51]/255, 'LineWidth', 2);
title('Imagem realçada com Prewitt', 'FontSize', 14, 'FontName', 'Times New Roman');
hold off

subplot(1,2,2)
plt = plot(collumn_img_prewitt);
hold on
title('Perfil da Coluna média da imagem');
set(plt, 'LineStyle','-', 'Color', [7, 153, 146]/255, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');
xlabel('Linha')
ylabel('Tom de Cinza (16 bits)')
xlim([0 m])
ylim([0 65535])
set(gca, 'TickLength', [.02 .02], 'XminorTick', 'on', 'YMinorTick', 'on', 'LineWidth', 1);
set(gcf, 'color', 'w');
hold off

%% Imagem Frei-Chen
figure()

subplot(1,2,1)
imshow(img_freichen)
hold on
xline(n/2, 'Color', [255,255,51]/255, 'LineWidth', 2);
title('Imagem realçada com Frei-Chen', 'FontSize', 14, 'FontName', 'Times New Roman');
hold off

subplot(1,2,2)
plt = plot(collumn_img_freichen);
hold on
title('Perfil da Coluna média da imagem');
set(plt, 'LineStyle','-', 'Color', [7, 153, 146]/255, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');
xlabel('Linha')
ylabel('Tom de Cinza (16 bits)')
xlim([0 m])
ylim([0 65535])
set(gca, 'TickLength', [.02 .02], 'XminorTick', 'on', 'YMinorTick', 'on', 'LineWidth', 1);
set(gcf, 'color', 'w');
hold off

%% Imagem Non Local Means
figure()

subplot(1,2,1)
imshow(img_nonlocalmeans)
hold on
xline(n/2, 'Color', [255,255,51]/255, 'LineWidth', 2);
title('Imagem Média Não Local', 'FontSize', 14, 'FontName', 'Times New Roman');
hold off

subplot(1,2,2)
plt = plot(collumn_img_nonlocalmeans);
hold on
title('Perfil da Coluna média da imagem');
set(plt, 'LineStyle','-', 'Color', [7, 153, 146]/255, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');
xlabel('Linha')
ylabel('Tom de Cinza (16 bits)')
xlim([0 m])
ylim([0 65535])
set(gca, 'TickLength', [.02 .02], 'XminorTick', 'on', 'YMinorTick', 'on', 'LineWidth', 1);
set(gcf, 'color', 'w');
hold off

%% Salvando Dados Quantitativos num .csv

names_vector = ["Nomes"; "Original"; "Roberts"; "Sobel"; "Prewitt"; "Frei-Chen"; "Média não Local"];
icc_vector = ["ICC"; icc_img; icc_img_roberts; icc_img_sobel; icc_img_prewitt; icc_img_freichen; icc_img_nonlocalmeans];
snr_vector = ["SNR"; snr_img; snr_img_roberts; snr_img_sobel; snr_img_prewitt; snr_img_freichen; snr_img_nonlocalmeans];

T = table(names_vector,icc_vector, snr_vector);
writetable(T, 'Dados.csv', 'Delimiter',',','QuoteStrings',true);
