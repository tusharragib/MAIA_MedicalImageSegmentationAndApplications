clc;
clear all;
close all;
tic
%Load the NIFTI Volume for Input Images and GroundTruth
T1_nii= load_untouch_nii('dataset/1/T1.nii');
Flair_nii= load_untouch_nii('dataset/1/T2_FLAIR.nii');
Label_nii= load_untouch_nii('dataset/1/LabelsForTesting.nii');   


% Let's reshape nii files to the vector
T1_reshaped= reshape(T1_nii.img,numel(T1_nii.img),1);
Flair_reshaped= reshape(Flair_nii.img,numel(Flair_nii.img),1);
Label_reshaped= reshape(Label_nii.img,numel(Label_nii.img),1);

%Remove 0-s pixels
Label_black= find(~Label_reshaped);
Label_black_no= find(Label_reshaped);


T1_reshaped(Label_black)=[];
disp(size(T1_reshaped));
Flair_reshaped(Label_black)=[];

nii_files= [T1_reshaped Flair_reshaped] ;
nii_files=double(nii_files);

%Let's initialize parameters
alpha = [1/3 1/3 1/3];
mean = [28   60;
        140   180;
        200   150]

covariance(:,:,1) = [120  105;
                    105  260]
covariance(:,:,2) =[60  -25;
                    -25  35]

covariance(:,:,3) =[10  -4;
                    -4  12]
cluster_number = 3;
number_iterations = 120;
stop_threshold = 0.001;
for number_iter = 1:number_iterations
    
    %e-step
    
    p = estep(cluster_number, nii_files, alpha, mean, covariance);
    sums = sum(p);
    log_sums=sum(log(sums));
    log_current=sum(log(log_sums));
    w=(p ./ sums);

    %m-step
    [mean, covariance] = mstep(cluster_number, nii_files, w, alpha, mean, covariance);
    
    p = estep(cluster_number, nii_files, alpha, mean, covariance);
    sums = sum(p);
    log_sums=sum(log(sums));
    log_updated=sum(log(log_sums));
    Error=log_updated-log_current;
    Diff_Error(number_iter)=Error;
    
    disp(['Error--> ','Iteration = ',num2str(number_iter),' --> ',num2str(Error)]); 

    if(abs(Error)<stop_threshold) 
        break; 
    end
    
    number_iter=number_iter+1;

end

%Graphical Presentation of Error VS Iterations
figure(1);
plot(Diff_Error);
xlabel('Iterations');
ylabel('Error (Difference between loglikelihood)');
xlim([0 50])
title('Error vs Iteration in 3D GMM EM')
grid on;

w=w';
[~,class]=max(w);
% Reshape to the image with 0-s pixels
file_reshaped=zeros(1,length(Label_reshaped));
number_slices=48;
file_reshaped(Label_black)=0;
file_reshaped(Label_black_no)=class;
size_Label=size(Label_nii.img);
result_segmented=reshape(file_reshaped,size_Label(1),size_Label(2),size_Label(3));
 
%Let's compute Dice Similarity Score

 for cluster = 1:3
    dice(cluster)=dice_average(result_segmented,Label_nii,cluster,number_slices);
 end
 
 fprintf('The Dice similarity for CSF, GM And WM are \n');
 disp(dice);

 
 %Reconstruction of slices
 for i = 1:48
    dice_score=compute_dice(double(result_segmented(:,:,i)),double(Label_nii.img(:,:,i)));
    figure(2),
    hold on;
    
   imshowpair(double(Label_nii.img(:,:,i)),label2rgb(result_segmented(:,:,i), 'hsv' ,'k'), 'montage')
    title(['GT (Left) and Segmented (Right) for slice = ',num2str(i)])
    xlabel(['Dice score for CSF=',num2str(dice_score(1)),', Dice score for GM=',num2str(dice_score(2)),', Dice score for WM=',num2str(dice_score(3))])
    pause(1)
    
 end
 toc