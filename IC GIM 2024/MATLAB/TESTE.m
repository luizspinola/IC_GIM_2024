clear;clc; close all;

im_name= 'MG20_proc';
im = dicomread(strcat(im_name));
fig2=im;
[m,n] = size(fig2);

%varrendo a linha média da imagen original

for c=50:m-50;
Linha(c,1)=fig2(c,(round(n/2)));
end;

Linha;
media = mean(Linha); %média da linha da original para usar como fator
maximo = max(max(fig2));
minimo = min(min(fig2));
media2 = mean(fig2(:));

%__________________________________________________________________________
%%Filtrando image

%filtro media 3
filtrom3 = fspecial('average', 3);
figfiltradam3 = imfilter(fig2,filtrom3);

%filtro media 7
filtrom7 = fspecial('average', 7);
figfiltradam7 = imfilter(fig2,filtrom7);

%filtro wiener
figfiltradaw = wiener2(fig2,[3 3]);

%exponencial
r = 0:4095;
factor = 6000;
s( 1 + r ) = ( 4095 / ( exp( 4095 / factor ) - 1 ) ) * ( exp( r / factor ) - 1 );
[coluna,linha] = size (s);
figfiltradaex = s( fig2 + 1 );
%__________________________________________________________________________
%%Obtendo imagem filtrada
fig2D=double(fig2);

%__________________________________________________________________________
%correcao da imagem

Imagem_Nova_media3=(round((fig2./figfiltradam3)*(media))); %% correção da imagem usando fator de correção
Imagem_Nova_media3=uint16(Imagem_Nova_media3);

Imagem_Nova_media7=(round((fig2./figfiltradam7)*(media))); %% correção da imagem usando fator de correção
Imagem_Nova_media7=uint16(Imagem_Nova_media7);

Imagem_Nova_wiener=(round((fig2./figfiltradaw)*(media))); %% correção da imagem usando fator de correção
Imagem_Nova_wiener=uint16(Imagem_Nova_wiener);

Imagem_Nova_exponencial = figfiltradaex;

%__________________________________________________________________________
%%varrendo linha média da imagem corrigida = Imagem_Nova

for b=50:n-50;    
LinhaNovam3(b,1)=Imagem_Nova_media3(b,(round(m/2)));
LinhaNovam7(b,1)=Imagem_Nova_media7(b,(round(m/2)));
LinhaNovawi(b,1)=Imagem_Nova_wiener(b,(round(m/2)));
LinhaNovaex(b,1)=Imagem_Nova_exponencial(b,(round(m/2)));
end

%%varrendo linha média da imagem filtrada

for a=50:m-50;    
LinhaFiltradam3(a,1)=figfiltradam3(a,(round(n/2)));
LinhaFiltradam7(a,1)=figfiltradam7(a,(round(n/2)));
LinhaFiltradawi(a,1)=figfiltradaw(a,(round(n/2)));
LinhaFiltradaex(a,1)=figfiltradaex(a,(round(n/2)));
end
%__________________________________________________________________________
%Gerando Figuras 
%Media 3
figure(1);
ax1 = subplot(1,2,1);
plot (ax1,Linha); %% plot da linha media da imagem
title('imagemoriginal');
ax2 = subplot(1,2,2);
plot (ax2,LinhaFiltradam3);
title('imagemmedia3');

figure (2);
subplot(1,3,1);
imshow(fig2,'DisplayRange',[]);
title('imagemoriginal');
subplot(1,3,2);
imshow(figfiltradam3,'DisplayRange',[]);
title('imagemomedia3');

subplot(1,3,3);
imshow(Imagem_Nova_media3,'DisplayRange',[]);
title('imagemoriginal_nova media');

figure (3);
imshow(figfiltradam3,'DisplayRange',[]);

%__________________________________________________________________________
%Media 7
figure(4);
ax1 = subplot(1,2,1);
plot (ax1,Linha); %% plot da linha media da imagem
title('imagemoriginal');
ax2 = subplot(1,2,2);
plot (ax2,LinhaFiltradam7);
title('imagemmedia7');
figure (5);
subplot(1,3,1);
imshow(fig2,'DisplayRange',[]);
title('imagemoriginal');

subplot(1,3,2);
imshow(figfiltradam7,'DisplayRange',[]);
title('imagemomedia7');

subplot(1,3,3);
imshow(Imagem_Nova_media7,'DisplayRange',[]);
title('imagemnovamedia7');

figure (6);
imshow(figfiltradam7,'DisplayRange',[]);
%__________________________________________________________________________
%Wiener

figure(7);
ax1 = subplot(1,2,1);
plot (ax1,Linha); %% plot da linha media da imagem

ax2 = subplot(1,2,2);
plot (ax2,LinhaFiltradawi);

figure (8);
subplot(1,3,1);
imshow(fig2,'DisplayRange',[]);

subplot(1,3,2);
imshow(figfiltradaw,'DisplayRange',[]);

subplot(1,3,3);
imshow(Imagem_Nova_wiener,'DisplayRange',[]);

figure (9);
imshow(figfiltradaw,'DisplayRange',[]);
%__________________________________________________________________________
%Exponencial

figure(10);
ax1 = subplot(1,2,1);
plot (ax1,Linha); %% plot da linha media da imagem

ax2 = subplot(1,2,2);
plot (ax2,LinhaFiltradaex);

figure (11);
subplot(1,3,1);
imshow(fig2,'DisplayRange',[]);

subplot(1,3,2);
imshow(figfiltradaex,'DisplayRange',[]);

subplot(1,3,3);
imshow(Imagem_Nova_exponencial,'DisplayRange',[]);

figure (12);
imshow(figfiltradaex,'DisplayRange',[]);