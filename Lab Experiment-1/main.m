clc;close all;clear all;

cd 'C:\Users\HP\Desktop\Spain\MISA\1 lab\lab1\'

% GT = ground truth image (t1_icbm_normal_1mm_pn0_rf0.nii)
% Images with bias field
% b1 = t1_icbm_normal_1mm_pn0_rf20.nii
% b2 = t1_icbm_normal_1mm_pn0_rf40.nii
%----------------------------------
% Images with the noise
% n1 = t1_icbm_normal_1mm_pn1_rf0.nii
% n2 = t1_icbm_normal_1mm_pn5_rf0.nii
%----------------------------------
% Image with bias field and noise
% b_n = t1_icbm_normal_1mm_pn5_rf20.nii
% Opening all nifti-images
GT = load_untouch_nii('t1_icbm_normal_1mm_pn0_rf0.nii');
b1 = load_untouch_nii('t1_icbm_normal_1mm_pn0_rf20.nii');
b2 = load_untouch_nii('t1_icbm_normal_1mm_pn0_rf40.nii');
n1 = load_untouch_nii('t1_icbm_normal_1mm_pn1_rf0.nii');
n2 = load_untouch_nii('t1_icbm_normal_1mm_pn5_rf0.nii');
b_n = load_untouch_nii('t1_icbm_normal_1mm_pn5_rf20.nii');

% Choose the 90th slice
GT = GT.img;
GT_90 = GT(:,:,90);

b1 = b1.img;
b1_90 = b1(:,:,90);

b2 = b2.img;
b2_90 = b2(:,:,90);

%Converting the intensity of GT image to the range [0 255]
uint8GT = uint8(255 * mat2gray(GT_90));
%imtool(uint8GT,'DisplayRange',[]);

figure(1);
subplot(131),imshow(GT_90, []),title('Ground truth image');
subplot(132),imshow(b1_90,[]),title('20 bias field Image');
subplot(133),imshow(b2_90,[]),title('40 bias field Image');
%-----------------------------------------------------------
% Call MICO algorithm for image b1 = load_untouch_nii('t1_icbm_normal_1mm_pn0_rf20.nii');

iterNum = 165;
N_region=3;  
q=2;
[bias_free_img] = MICO_2D(b1_90, iterNum, N_region, q);
similarity(bias_free_img, uint8GT);

% save image without bias field
value= '20-bias_free_img.tif';
folder = 'bias-free images/';
fullFileName = fullfile(folder, value);
imwrite(uint8(bias_free_img), fullFileName);

%-----------------------------------------------------------
% Call MICO algorithm for image b2 = load_untouch_nii('t1_icbm_normal_1mm_pn0_rf40.nii');

iterNum = 170;
N_region=3;  
q=2;
[bias_free_img_2] = MICO_2D(b2_90, iterNum, N_region, q);
similarity(bias_free_img, uint8GT);

% save image without bias field
value_2= '40-bias_free_img.tif';
fullFileName = fullfile(folder, value_2);
imwrite(uint8(bias_free_img_2), fullFileName);


%-----------------------------------------------------------
% Noise supression - Anisotropic Diffusion
n1 = n1.img;
n1_90 = n1(:,:,90);

num_iter = 5;
delta_t = 0.25;
kappa = 13;
option = 1;
gaussian_sigma = 1;

[noise_free_img] = testDiffusion(n1_90, num_iter, delta_t, kappa, option, gaussian_sigma);
similarity(noise_free_img, uint8GT);

% save image without bias field
value_3 = '1-noise_free_img.tif';
fullFileName = fullfile(folder, value_3);
imwrite(uint8(noise_free_img), fullFileName);


%-------------------------------------------------------
% Noise supression - Anisotropic Diffusion
%n1 = load_untouch_nii('t1_icbm_normal_1mm_pn1_rf0.nii');
n2 = load_untouch_nii('t1_icbm_normal_1mm_pn5_rf0.nii');

n2 = n2.img;
n2_90 = n2(:,:,90);

num_iter = 10;
delta_t = 0.15;
kappa = 12;
option = 1;
gaussian_sigma = 5;

[noise_free_img_2] = testDiffusion(n1_90, num_iter, delta_t, kappa, option, gaussian_sigma);
similarity(noise_free_img, uint8GT);

% save image without bias field
value_4 = '5-noise_free_img.tif';
fullFileName = fullfile(folder, value_4);
imwrite(uint8(noise_free_img_2), fullFileName);

%-------------------------------------------------------
% Bias field removal + Noise supression

b_n = b_n.img;
b_n_90 = b_n(:,:,90);

iterNum = 200;
N_region=3;  
q=2;

num_iter = 110;
delta_t = 0.25;
kappa = 7;
option = 1;
gaussian_sigma = 1;

[bias_free_img_bn] = MICO_2D(b_n_90, iterNum, N_region, q);
[noise_free_img_bias] = testDiffusion(bias_free_img_bn, num_iter, delta_t, kappa, option, gaussian_sigma);
similarity(noise_free_img_bias, uint8GT);

% save image without bias field
value_bn = 'bias_noise_free_img.tif';
folder = 'bias-free images/';
fullFileName = fullfile(folder, value_bn);
imwrite(uint8(noise_free_img_bias), fullFileName);

%-----------------------------------------------------------
% Call MICO algorithm for 3D image b1 = load_untouch_nii('t1_icbm_normal_1mm_pn0_rf20.nii');

iterNum_outer=170;  % outer iteration
iterCM=2;  % inner interation for C and M
iter_b=1;  % inner iteration for bias
q = 2;   % fuzzifier
th_bg = 5;  %% threshold for removing background
N_region = 3; %% number of tissue types, e.g. WM, GM, CSF
tissueLabel=[1, 2, 3];


str_vector{1} = 't1_icbm_normal_1mm_pn0_rf20.nii';   % input a sequence of image file names 

MICO_3Dseq(str_vector, N_region, q, th_bg, iterNum_outer, iter_b, iterCM, tissueLabel);


