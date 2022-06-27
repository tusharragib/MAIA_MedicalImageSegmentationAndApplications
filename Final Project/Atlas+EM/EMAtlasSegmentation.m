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
    volume = niftiread(filename_volume);
    %Reading nifti label
    label = niftiread(filename_label);

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

    %EM algorithm
    [segmented,mu,v,p]=EMSeg(volume_reshaped_copy,3);

    %Add zeros pixels to the mask
    file_reshaped=zeros(length(volume_reshaped), 1);
    
    %file_reshaped(label_black)=0;
    file_reshaped(label_black_no)=segmented;
    result_segmented=reshape(file_reshaped,size(label));
 
    %Extract each class of the segmented mask to the separate vector
    CSF_EM_vector = (file_reshaped == 1);
    GM_EM_vector = (file_reshaped == 2);
    WM_EM_vector = (file_reshaped == 3);

    %----------------Atlas----------------------- 
    %Reshape atlas to 1D array
    CSF_atlas_vector_resh = reshape(CSF_atlas_vector, numel(CSF_atlas_vector), 1);
    GM_atlas_vector_resh = reshape(GM_atlas_vector, numel(GM_atlas_vector), 1);
    WM_atlas_vector_resh = reshape(WM_atlas_vector, numel(WM_atlas_vector), 1);

    %Multiply segmented masks of EM with atlas arrays
    atlas_array = zeros(length(volume_reshaped), 3);
    atlas_array(:,1) = CSF_atlas_vector_resh .* CSF_EM_vector;
    atlas_array(:,2) = GM_atlas_vector_resh .* GM_EM_vector;
    atlas_array(:,3) = WM_atlas_vector_resh .* WM_EM_vector;

    %Create binary mask from the volume
    mask = repmat(volume, 1);
    mask(mask>0)=1;
    mask_vector= reshape(mask, numel(volume_reshaped), 1);

    % Take only the largest value of 3D atlas_array
    [val,idx] = max(atlas_array,[],2) ;
    % Multiply class index by reshaped mask of the volume
    our_labels_atlas_EM = (idx).* double(mask_vector);
    %Reshape segmented array to 3D volume
    our_labels_atlas_EM_resh = reshape(our_labels_atlas_EM, size(volume));

    %Display GT and Segmented volume
    figure();
    imshowpair(double(label(:,:,128)),label2rgb(our_labels_atlas_EM_resh(:,:,128), 'hsv' ,'k'), 'montage')
    title(folder_index{index}, 'The image numebr: ');  
    
    segmented_data = our_labels_atlas_EM;
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
    niftiwrite(our_labels_atlas_EM_resh,strcat('Segmented_images/Validation_Set/EMAtlasSegmentation/IBSR_',folder_index{index} , '_segmented'), 'Compressed', true);

end
toc

