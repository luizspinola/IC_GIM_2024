clear;clc;close all;

im_raw_name= 'MG19_raw';
im = dicomread(strcat("IMAGENS IC\IMAGENS NÃO SELECIONADAS\",im_raw_name));
maximo=max(im(:));
mg19= im;
%im_neg=4095-im;
im_neg = im;

[m,n] = size(mg19);

%varrendo a linha média da imagem original

for c=100:n-100
Linha(1,c)=im_neg((round(m/2)+200),c); %#ok<SAGROW> 
end

Linha;
media = mean(im_neg(:)); %média da linha da original para usar como fator
maximo = max(max(im_neg));
minimo = min(min(im_neg));
media2 = mean(im_neg(:));

%__________________________________________________________________________
%%Filtrando imagem

%filtro media 3
filtrom3 = fspecial('average', [3 3]);
imMEDIA3 = imfilter(im_neg,filtrom3);

%filtro media 7
filtrom7 = fspecial('average', 7);
imMEDIA7 = imfilter(im_neg,filtrom7);

%filtro wiener
imWIENER = wiener2(im_neg,[3 3]);

% %exponencial
% r = 0:4095;
% factor = 6000;
% s( 1 + r ) = ( 4095 / ( exp( 4095 / factor ) - 1 ) ) * ( exp( r / factor ) - 1 );
% [coluna,linha] = size (s);
% imEXP = s( im_neg + 1 );

%__________________________________________________________________________
%varrendo linha média da imagem filtrada

for a=100:n-100   
LinhaFiltradam3(1,a)=imMEDIA3((round(m/2)+200),a);
LinhaFiltradam7(1,a)=imMEDIA7((round(m/2)+200),a);
LinhaFiltradawi(1,a)=imWIENER((round(m/2)+200),a);
%LinhaFiltradaex(1,a)=imEXP((round(m/2)+200),a);
end
%__________________________________________________________________________
%Gerando Figuras 
%Media 3
figure(1);
ax1 = subplot(1,2,1);
plot (ax1,Linha); 
ylim([3500, 3800]);
title('ORIGINAL');
                  % plot da linha media da imagem
ax2 = subplot(1,2,2);
plot (ax2,LinhaFiltradam3);
ylim([3500, 3800]);
title('MEDIA 3');
%--------------------------------------------------------------------------
%visualização da imagem
 figure (2);
 subplot(1,2,1);
 imshow(im_neg,'DisplayRange',[3500,3800]);
 title('ORIGINAL');

 subplot(1,2,2);
 imshow(imMEDIA3,'DisplayRange',[3500,3800]);
 title('MEDIA 3');

 figure (3);
 imshow(imMEDIA3,'DisplayRange',[3500,3800]);
 title('MEDIA 3');
%__________________________________________________________________________
%Media 7
 figure(4);

 ax1 = subplot(1,2,1);
 plot (ax1,Linha); 
 ylim([3500,3800]);
 title('ORIGINAL');
                    % plot da linha media da imagem
 ax2 = subplot(1,2,2);
 plot (ax2,LinhaFiltradam7);
 ylim([3500,3800]);
 title('MEDIA 7');
 %-------------------------------------------------------------------------
 %visualização da imagem
 figure (5);

 subplot(1,2,1);
 imshow(im_neg,'DisplayRange',[3500,3800]);
 title('ORIGINAL');
 
 subplot(1,2,2);
 imshow(imMEDIA7,'DisplayRange',[3500,3800]);
 title('MEDIA 7');
 
 figure (6);

 imshow(imMEDIA7,'DisplayRange',[3500,3800]);
 title('MEDIA 7');
%__________________________________________________________________________
%Wiener

figure(7);

ax1 = subplot(1,2,1);
plot (ax1,Linha); 
ylim([3500,3800]);
title('ORIGINAL');
                   % plot da linha media da imagem
ax2 = subplot(1,2,2);
plot (ax2,LinhaFiltradawi);
ylim([3500,3800]);
title('WIENER');
%--------------------------------------------------------------------------
%visualização da imagem
figure (8);

subplot(1,2,1);
imshow(im_neg,'DisplayRange',[3500,3800]);
title('ORIGINAL')
 
subplot(1,2,2);
imshow(imWIENER,'DisplayRange',[3500,3800]);
title('WIENER');
 
figure (9);

imshow(imWIENER,'DisplayRange',[3500,3800]);
title('WIENER')
%__________________________________________________________________________
% %Exponencial
% 
% figure(10);
% 
% ax1 = subplot(1,2,1);
% plot (ax1,Linha); 
% ylim([3400,3800]);
% title('ORIGINAL');
%                        % plot da linha media da imagem
% ax2 = subplot(1,2,2);
% plot (ax2,LinhaFiltradaex);
% ylim([3400,3800]);
% title('EXPONENCIAL');
%--------------------------------------------------------------------------
% %visualização da imagem
% figure (11);
% 
% subplot(1,2,1);
% imshow(im_neg,'DisplayRange',[]);
% title('ORIGINAL');
% 
% subplot(1,2,2);
% imshow(imEXP,'DisplayRange',[]);
% title('EXPONENCIAL')

% figure (12);
% 
% imshow(imEXP,'DisplayRange',[]);
% title('EXPONENCIAL');


% desvio padrão WIENER

dp_im_original = stdfilt(im_neg);
figure (13);
imshow(dp_im_original, []);

dp_im_wiener = stdfilt(imWIENER);
figure (14);
imshow(dp_im_wiener, []);

im_ruido_wiener = abs(im_neg - imWIENER);
dp_im_ruido_wiener = stdfilt(im_ruido_wiener);
figure(15);
imshow(dp_im_ruido_wiener, []);

med_wiener = mean(dp_im_ruido_wiener(:));

%ruido media 3
dp_im_med3 = stdfilt(imMEDIA3);
figure (16);
imshow(dp_im_med3, []);

im_ruido_med3 = abs(im_neg - imMEDIA3);
dp_im_ruido_med3 = stdfilt(im_ruido_med3);
figure(17);
imshow(uint8(dp_im_ruido_med3), [0 255]);

med_med3 = mean(dp_im_ruido_med3(:));
