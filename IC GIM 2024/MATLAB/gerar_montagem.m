clear;clc;close all;
um = imread("mg1.jpg");
dois = imread("mg1_pedaço.jpg");
tres = imread("mg1_gauss.jpg");
quatro = imread("mg1_gauss_pedaço.jpg");
cinco = imread("mg1_wiener.jpg");
seis = imread("mg1_wiener_pedaço.jpg");

figure
t = tiledlayout(2,3);
t.TileSpacing = 'none';
t.Padding = 'none';
nexttile
imshow(um)

nexttile
imshow(tres)

nexttile
imshow(cinco)

nexttile
imshow(dois)

nexttile
imshow(quatro)

nexttile
imshow(seis)