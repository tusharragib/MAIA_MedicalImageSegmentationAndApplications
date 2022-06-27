function similarity(modified, ref)
%imDiff = image1 - image2;
%imSum = image1 + image2;  
%percentDiff = 200 * mean(imDiff(:)) / mean(imSum(:));
ssimval = ssim(modified,ref) 
disp(ssimval);

figure(4);
subplot(131),imshow(modified,[]),title('Bias/noise corrected');
subplot(132),imshow(ref,[]),title('Ground truth');


end

