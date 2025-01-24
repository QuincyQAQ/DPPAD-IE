close all
clear

P1=imread("image_1.jpg");
P2=imread("image_2.jpg");
P3=imread("image_3.jpg");
P4=imread("image_4.jpg");
P5=imread("image_5.jpg");
P6=imread("image_6.jpg");

[IMG1] = Shengchengtupian_Jiami(img11_RGB,img22_RGB);
jiamihou_1=uint8(cat(3,IMG1(:,:,1),IMG1(:,:,2),IMG1(:,:,3)));
jiamihou_2=uint8(cat(3,IMG1(:,:,4),IMG1(:,:,5),IMG1(:,:,6)));
[img11_RGB_b,img22_RGB_b] = Shengchengtupian_Jiemi(IMG1);



