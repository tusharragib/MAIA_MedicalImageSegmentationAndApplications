function [noise_free_img] = testDiffusion (im1, num_iter, delta_t, kappa, option, gaussian_sigma)

H = fspecial('disk',3);
blurred = imfilter(im1,H,'replicate');
blurred_gaussian = imgaussfilt(im1,gaussian_sigma);

ad = anisodiff(im1,num_iter,kappa,delta_t,option);
figure;
%subplot 131, imshow(im1), subplot 132, imshow(ad,[]), subplot 133, imshow(blurred,[])

subplot(141),imshow(im1,[]),title('Original image');
subplot(142),imshow(ad, []),title('Anisotropic Diffusion result');
subplot(143),imshow(blurred,[]),title('Blurred by filter');
subplot(144),imshow(blurred_gaussian,[]),title('Gaussian smoothing');
%noise_free_img = imshow(ad, []);
%noise_free_img = uint8(ad,[]);
noise_free_img = uint8(255 * mat2gray(ad));
end

