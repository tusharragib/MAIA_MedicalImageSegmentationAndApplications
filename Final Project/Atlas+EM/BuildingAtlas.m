clc;
clear all;
close all;

% Reading IBSR_01 volume as a template to take size of the image
template_image = niftiread('Training_Set/IBSR_01/IBSR_01.nii.gz');

% Reshape template image to take length of the volume
template_image_reshaped = reshape(template_image, numel(template_image), 1);

% Folder indexes for the registered volumes and labels
folder_index = {'IBSR_01'; 'IBSR_03'; 'IBSR_04'; 'IBSR_05'; 'IBSR_06'; 'IBSR_07'; 'IBSR_08'; 'IBSR_09'; 'IBSR_16'; 'IBSR_18'};

% length of the array with the folder indexes
len_files = length(folder_index);

% Create empty arrays of the length of the reshaped template image  with
% 10-D dimension
volume_reshaped = zeros(length(template_image_reshaped),len_files);
label_reshaped = zeros(length(template_image_reshaped),len_files);

% Path to the folder of the registered volumes
path_directory_volume='Registered_images/Training_Set/registered_images/'; 
% Path to the folder of the registered labels
path_directory_label='Registered_images/Training_Set/registered_labels/'; 

%Loop to read all training dataset images to create Atlas
for index=1:length(folder_index)
    % Path to the folder of the registered volumes files
    files_volume=strcat(path_directory_volume, folder_index{index} , '/result.2.nii.gz'); 
    filename_volume=files_volume;
    % Path to the folder of the registered labels file
    files_label=strcat(path_directory_label, folder_index{index} , '/result.nii.gz'); 
    filename_label=files_label;
    %Reading nifti volume
    volume= niftiread(filename_label);
    %Reading nifti label
    label= niftiread(files_label);
    
    % Reshape volume to 1D-array
    volume_resh= reshape(volume, numel(volume), 1);
    % Reshape label to 1D-array
    label_resh= reshape(label, numel(label), 1);
    
    % Save volume to 10D-array
    volume_reshaped(:,index) = volume_resh;
    % Save label to 10D-array
    label_reshaped(:,index) = label_resh;
    
    % Display volumes and labels names
    disp(filename_volume);
    disp(filename_label);
end

% From 10D-array we extract  labels equal to 1 (CSF tissue)
CSF_array = (label_reshaped==1);
% Aveage 10D-array to 1D
CSF_vect = mean(CSF_array, 2);
% Reshape array to 3D volume
CSF_prob_map = reshape(CSF_vect, size(template_image));

% From 10D-array we extract  labels equal to 2 (GM tissue)
GM_array = (label_reshaped==2); 
% Aveage 10D-array to 1D
GM_vect = mean(GM_array, 2);
% Reshape array to 3D volume
GM_prob_map =reshape(GM_vect, size(template_image));


% From 10D-array we extract  labels equal to 3 (WM tissue)
WM_array = (label_reshaped==3);
% Aveage 10D-array to 1D
WM_vect = mean(WM_array, 2);
% Reshape array to 3D volume
WM_prob_map = reshape(WM_vect, size(template_image));

% Aveage 10D-array of volumes to 1D
tissue_model_vect = mean(volume_reshaped, 2);
% Reshape array to 3D volume
tissue_model = reshape(tissue_model_vect, size(template_image));

% Save all CSF, GM, WM, Tissues Atlas
niftiwrite(CSF_prob_map,'atlas/atlas_CSF', 'Compressed', true);
niftiwrite(GM_prob_map,'atlas/atlas_GM', 'Compressed', true);
niftiwrite(WM_prob_map,'atlas/atlas_WM', 'Compressed', true);
niftiwrite(tissue_model,'atlas/tissue_model', 'Compressed', true);

%Reconstruction of slices
 for i = 150
    figure(),
    subplot(1,4,1);
    imshow(double(CSF_prob_map(:,:,i)));
    title('CSF Atlas')
   
    subplot(1,4,2);   
    imshow(double(GM_prob_map(:,:,i)));
    title('GM Atlas')
   
    subplot(1,4,3);
    imshow(double(WM_prob_map(:,:,i)));
    title('WM Atlas')  
    
    subplot(1,4,4);
    imshow(double(tissue_model(:,:,i)), []);
    title('Tissue Atlas')
 end
 disp('CSF Atlas, GM Atlas, WM Atlas are created!');


