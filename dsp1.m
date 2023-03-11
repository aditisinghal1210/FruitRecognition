close all;
clear all;
clc

%read image
im_IN = imread('fruits.jpg');

%Conversion from RGB to HSV
im_HSV = rgb2hsv(im_IN);

%divide the image in 3 channels for HSV
im_H = im_HSV(:,:,1);
im_S = im_HSV(:,:,2);
im_V = im_HSV(:,:,3);

%divide the image in 3 channels for RGB
im_R=im_IN(:,:,1);
im_G=im_IN(:,:,2);
im_B=im_IN(:,:,3);

%-------------------------------------------------
%Segmentation for apple and banana
h_inf=0.100;
h_sup=0.193;
im_H_BIN=roicolor(im_H,h_inf,h_sup);
s_inf=0.155;
s_sup=1.000;
im_S_BIN=roicolor(im_S,s_inf,s_sup);
v_inf=0.412;
v_sup=1.000;
im_V_BIN=roicolor(im_V,v_inf,v_sup);
%AND operation to multiply all channels and divide the picture in 2
im_BIN1=im_H_BIN.*im_S_BIN.*im_V_BIN;
banana_BIN = imcrop(im_BIN1,[1 7 710 487]);
apple_BIN = imcrop(im_BIN1,[1 495 710 955]);
%Segmentation for orange
h_inf=0.042;
h_sup=0.094;
im_H_BIN=roicolor(im_H,h_inf,h_sup);
s_inf=0.395;
s_sup=1.000;
im_S_BIN=roicolor(im_S,s_inf,s_sup);
v_inf=0.695;
v_sup=1.000;
im_V_BIN=roicolor(im_V,v_inf,v_sup);
%AND operation to multiply all channels
orange_BIN=im_H_BIN.*im_S_BIN.*im_V_BIN;
orange_BIN = imcrop(orange_BIN,[1 495 710 955]);
%Segmentation for kiwi
h_inf=0.061;
h_sup=0.082;
im_H_BIN=roicolor(im_H,h_inf,h_sup);
s_inf=0.227;
s_sup=0.758;
im_S_BIN=roicolor(im_S,s_inf,s_sup);
v_inf=0.043;
v_sup=0.730;
im_V_BIN=roicolor(im_V,v_inf,v_sup);
%AND operation to multiply all channels
kiwi_BIN=im_H_BIN.*im_S_BIN.*im_V_BIN;
kiwi_BIN = imcrop(kiwi_BIN,[1 307 710 764]);
%-------------------------------------------------

im_R_mask = imcrop(im_R,[1 7 710 487]).*uint8(banana_BIN); 
im_G_mask = imcrop(im_G,[1 7 710 487]).*uint8(banana_BIN);
im_B_mask = imcrop(im_B,[1 7 710 487]).*uint8(banana_BIN);
%concat operation to multiply all channels
im_RGB_MASK_banana=cat(3,im_R_mask,im_G_mask,im_B_mask);

im_R_mask = imcrop(im_R,[1 495 710 955]).*uint8(apple_BIN);
im_G_mask = imcrop(im_G,[1 495 710 955]).*uint8(apple_BIN);
im_B_mask = imcrop(im_B,[1 495 710 955]).*uint8(apple_BIN);
%concat operation to multiply all channels
im_RGB_MASK_apple=cat(3,im_R_mask,im_G_mask,im_B_mask);

im_R_mask = imcrop(im_R,[1 495 710 955]).*uint8(orange_BIN);
im_G_mask = imcrop(im_G,[1 495 710 955]).*uint8(orange_BIN);
im_B_mask = imcrop(im_B,[1 495 710 955]).*uint8(orange_BIN);
%concat operation to multiply all channels
im_RGB_MASK_orange = cat(3,im_R_mask,im_G_mask,im_B_mask);

im_R_mask = imcrop(im_R,[1 307 710 764]).*uint8(kiwi_BIN);
im_G_mask = imcrop(im_G,[1 307 710 764]).*uint8(kiwi_BIN);
im_B_mask = imcrop(im_B,[1 307 710 764]).*uint8(kiwi_BIN);
%concat operation to multiply all channels
im_RGB_MASK_kiwi = cat(3,im_R_mask,im_G_mask,im_B_mask);


subplot(4,4,1);
imshow(im_HSV)
title('HSV picture')
subplot(4,4,2);
imshow(im_H)
title('Channel H')
subplot(4,4,3);
imshow(im_S)
title('Channel S')
subplot(4,4,4);
imshow(im_V)
title('Channel v')
subplot(4,4,5);
imshow(banana_BIN)
title('Banana BIN')
subplot(4,4,6);
imshow(apple_BIN)
title('Apple BIN')
subplot(4,4,7);
imshow(orange_BIN)
title('Orange BIN')
subplot(4,4,8);
imshow(kiwi_BIN)
title('Kiwi BIN')
subplot(4,4,9);
imshow(im_IN)
title('Original Picture ')
subplot(4,4,10);
imshow(im_R)
title('Channel R BIN')
subplot(4,4,11);
imshow(im_G)
title('Channel G BIN')
subplot(4,4,12);
imshow(im_B)
title('Channel B BIN')
subplot(4,4,13);
imshow(im_RGB_MASK_banana)
title('Banana')
subplot(4,4,14);
imshow(im_RGB_MASK_apple)
title('Apple')
subplot(4,4,15);
imshow(im_RGB_MASK_orange)
title('Orange')
subplot(4,4,16);
imshow(im_RGB_MASK_kiwi)
title('Kiwi')