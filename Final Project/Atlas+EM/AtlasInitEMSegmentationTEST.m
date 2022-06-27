clc; clear all; close all;
tic
% Folder index for the validation dataset
folder_index = {'02'; '10'; '15'};

%Loop to segment all validation dataset images
for index=1:length(folder_index)
    % Path to the folder of the registered volumes files
    files_volume=strcat('Test_Set/IBSR_', folder_index{index} ,'/IBSR_',folder_index{index} , '.nii.gz'); 
    filename_volume=files_volume;
    
    % Path to the folder of the registered labels file
    files_label=strcat('Test_Set/IBSR_', folder_index{index} ,'/IBSR_',folder_index{index} , '_seg.nii.gz'); 
    filename_label=files_label;

    %Reading registered CSF, GM, WM Atlas
    CSF_atlas_vector = niftiread(strcat('Registered_images\Test_Set\registered_labels\IBSR_', folder_index{index}, '\csf\result.nii.gz'));
    GM_atlas_vector = niftiread(strcat('Registered_images\Test_Set\registered_labels\IBSR_', folder_index{index}, '\gm\result.nii.gz'));
    WM_atlas_vector = niftiread(strcat('Registered_images\Test_Set\registered_labels\IBSR_', folder_index{index}, '\wm\result.nii.gz'));
 
    %Reshape CSF, GM, WM Atlas to 1D array
    CSF_atlas_vector_resh = reshape(CSF_atlas_vector, numel(CSF_atlas_vector), 1);
    GM_atlas_vector_resh = reshape(GM_atlas_vector, numel(GM_atlas_vector), 1);
    WM_atlas_vector_resh = reshape(WM_atlas_vector, numel(WM_atlas_vector), 1);
    
    %Reading nifti volume
    volume = niftiread(filename_volume);
    %Reading nifti label
    %label = niftiread(filename_label);

    % Reshape volume to 1D-array
    %labels_vector= reshape(label, numel(label), 1);
    % Reshape label to 1D-array
    volume_vector = reshape(volume, numel(volume), 1);

    %Creating mask from the volume
    mask = volume;
    mask(mask>0)=1;
    %Reshape mask to 1D array
    mask_vector= reshape(mask, numel(volume_vector), 1);

    %Create empty 3D array with three Atlas and fill in with Atlas array
    atlas_array = zeros(length(mask_vector), 3);
    atlas_array(:,1) = CSF_atlas_vector_resh;
    atlas_array(:,2) = GM_atlas_vector_resh;
    atlas_array(:,3) = WM_atlas_vector_resh;
    
    % Take only the largest value of 3D atlas_array
    [val,idx] = max(atlas_array,[],2);
    
    % Multiply class index by reshaped mask of the volume
    our_label_vect = (idx).* double(mask_vector);
    %Reshape segmented array to 3D volume
    our_label_vect_resh = reshape(our_label_vect, size(volume));
    
    %Display GT and Segmented volume
    figure();
    imshow(label2rgb(our_label_vect_resh(:,:,128), 'hsv' ,'k'))
    title(folder_index{index}, 'The image numebr: ');  

   
    niftiwrite(our_label_vect_resh,strcat('Segmented_images/Test_Set/AtlasInitEMSegmentation/IBSR_',folder_index{index} , '_segmented'), 'Compressed', true);

end
toc