function dice= compute_dice(T_nii,Label)

%This functions computes the dice score for CSF, GM, AND WM. It assumes the
%labels for CSF is 1, GM is 2 and WM is 3.
Nii_reshaped=reshape(T_nii,numel(T_nii),1);
Label_reshaped=reshape(Label,numel(Label),1);


dice_Label=zeros(length(Label_reshaped),3);
label_total=zeros(3,1);
dice_Nii=zeros(length(Nii_reshaped),3);
dice=zeros(3,1);
inter_vec_dif=zeros(length(Nii_reshaped),3);
for i = 1:3
    dice_Label(:,i)=Label_reshaped==i;
    label_total(i)=sum(dice_Label(:,i));
    dice_Nii(:,i)=Nii_reshaped==i;
    inter_vec_dif(:,i)=dice_Label(:,i)-dice_Nii(:,i);
    error=sum(inter_vec_dif(:,i)>0)/label_total(i);
    dice(i)=1-error;

end
dice=round(dice,2);

end





