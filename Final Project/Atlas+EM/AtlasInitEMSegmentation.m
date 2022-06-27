clc; clear all; close all;
tic
% Folder index for the validation dataset
folder_index = {'11'; '12'; '13'; '14'; '17'};

%Loop to segment all validation dataset images
for index=1:length(folder_index)
    % Path to the folder of the registered volumes files
    files_volume=strcat('Validation_Set/IBSR_', folder_index{index} ,'/IBSR_',folder_index{index} , '.nii.gz'); 
    filename_volume=files_volume;
    
    % Path to the folder of the registered labels file
    files_label=strcat('Validation_Set/IBSR_', folder_index{index} ,'/IBSR_',folder_index{index} , '_seg.nii.gz'); 
    filename_label=files_label;
    
    %Reading registered CSF, GM, WM Atlas
    CSF_atlas_vector = niftiread(strcat('Registered_images\Validation_Set\registered_labels\IBSR_', folder_index{index}, '\csf\result.nii.gz'));
    GM_atlas_vector = niftiread(strcat('Registered_images\Validation_Set\registered_labels\IBSR_', folder_index{index}, '\gm\result.nii.gz'));
    WM_atlas_vector = niftiread(strcat('Registered_images\Validation_Set\registered_labels\IBSR_', folder_index{index}, '\wm\result.nii.gz'));
     
    %Reading nifti volume
    volume= niftiread(filename_volume);
    %Reading nifti label
    label= niftiread(filename_label);   

    % Reshape volume to 1D-array
    volume_reshaped= reshape(volume,numel(volume),1);
    % Reshape label to 1D-array
    label_reshaped= reshape(label,numel(label),1);
    
    %Create a copy of 1D array of the volume
    volume_reshaped_copy = repmat(volume_reshaped, 1);
    %Remove 0-s pixels
    label_black= find(~volume_reshaped);
    label_black_no= find(volume_reshaped);
    volume_reshaped_copy(label_black)=[];
    
    %Reshape atlas to 1D array
    CSF_atlas_vector_resh = reshape(CSF_atlas_vector, numel(CSF_atlas_vector), 1);
    GM_atlas_vector_resh = reshape(GM_atlas_vector, numel(GM_atlas_vector), 1);
    WM_atlas_vector_resh = reshape(WM_atlas_vector, numel(WM_atlas_vector), 1);

    %Create binary mask from the volume
    mask = repmat(volume, 1);
    mask(mask>0)=1;
    mask= reshape(mask, numel(mask), 1);
    
    %Take ROI of the volume with a binary mask
    image_roi = double(volume_reshaped).*double(mask);
    %Extract non-zero pixels from Atlas array according to the mask
    im_mask = (volume_reshaped > 0);
    CSF_atlas_flatten = CSF_atlas_vector_resh(im_mask);
    GM_atlas_flatten = GM_atlas_vector_resh(im_mask);
    WM_atlas_flatten = WM_atlas_vector_resh(im_mask);
    
    %Create empty 3D array with three Atlas and fill in with Atlas array
    atlas_flatten_array = zeros(3, length(CSF_atlas_flatten));
    atlas_flatten_array(1, :) = CSF_atlas_flatten;
    atlas_flatten_array(2, :) = GM_atlas_flatten;
    atlas_flatten_array(3, :) = WM_atlas_flatten;
    
    % Take only the largest value of 3D atlas_array
    [val,atlas_flatten_array_segmentation] = max(atlas_flatten_array,[],1);
    %Create empty array to save initial mu values of the EM algorithm
    mu2 = zeros(3,1); 
    csf = (atlas_flatten_array_segmentation==1);
    gm = (atlas_flatten_array_segmentation==2);
    wm = (atlas_flatten_array_segmentation==3);
    
    %Calculate my by averaging arrays of the tissues
    image_flatten = image_roi(im_mask);
    mu2(1,:) = mean(image_flatten(csf));
    mu2(2,:) = mean(image_flatten(gm));
    mu2(3,:) = mean(image_flatten(wm));


    %membership_weights = zeros(3,1); 
    %Calculate membership weights and covariance matrix to initialize EM algorithm
    clear membership_weights;
    atlas_flatten_array_segmentationdd = atlas_flatten_array_segmentation';
    membership_weights(:,1) = (atlas_flatten_array_segmentationdd == 1);
    membership_weights(:,2) = (atlas_flatten_array_segmentationdd == 2);
    membership_weights(:,3) = (atlas_flatten_array_segmentationdd == 3);
    
    Nk = [sum(atlas_flatten_array_segmentationdd == 1),sum(atlas_flatten_array_segmentationdd == 3),sum(atlas_flatten_array_segmentationdd == 2)];
    X=image_flatten';

    for i=1:3
        dummy_var = (X-mu2(i))';
        xx = (X-mu2(i));
    end

    for i=1:3
        dummy_var = (X-mu2(i))';
        xx = (X-mu2(i));
        npmultiply = membership_weights(:,i) .* dummy_var;
        c = npmultiply .* xx';
        co(i) = (1/Nk(i)) *(npmultiply' * xx');
    end
    alpha = zeros(1, 3);  
    for i=1:3
        alpha(i) = Nk(i)/length(X); 
    end

    %EM algorithm
    [segmented,mu,v,p]=EMSeg2(volume_reshaped_copy,3, alpha, mu2, co);

    %Add zeros pixels to the mask and reshape
    file_reshaped=zeros(length(volume_reshaped), 1);
    file_reshaped(label_black_no)=segmented;
    result_segmented=reshape(file_reshaped,size(label));
    
    %Display GT and Segmented volume
    figure(),
    imshowpair(double(label(:,:,128)),label2rgb(result_segmented(:,:,128), 'hsv' ,'k'), 'montage')
    title(folder_index{index}, 'The image numebr: ');  
 
    segmented_data = reshape(result_segmented,numel(result_segmented),1);
    groundtruth_data = label_reshaped;
    
    %Calculate Dice Similarity Coefficient
    dice_coef = zeros(3, 1);
    for cluster = 1:3
        Seg = (segmented_data == cluster);
        GT = (groundtruth_data == cluster);
        dice_coef(cluster) = dice(Seg, GT);   
    end
    
    %Display DCS for each tissue
    fprintf(strcat('The image numebr: ', folder_index{index}, '\n'));
    fprintf('The Dice similarity for CSF is \n');
    disp(dice_coef(1));
    
    fprintf('The Dice similarity for GM is \n');
    disp(dice_coef(2));

    fprintf('The Dice similarity for WM is \n');
    disp(dice_coef(3));
    
    %save segmented images
    niftiwrite(result_segmented,strcat('Segmented_images/Validation_Set/AtlasInitEMSegmentation/IBSR_',folder_index{index} , '_segmented'), 'Compressed', true);

end
toc