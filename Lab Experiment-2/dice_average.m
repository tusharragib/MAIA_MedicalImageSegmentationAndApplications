function dice= dice_average(seg_result,Label,label,number_slice) 
number=0;
dice=0;
 for i = 1:number_slice
 dice_score = compute_dice(double(seg_result(:,:,i)),double(Label.img(:,:,i)));
 if ~isnan(dice_score(label)) 
     dice=dice+dice_score(label);
     number=number+1;
 end
 end
  dice=dice/number;
end

  