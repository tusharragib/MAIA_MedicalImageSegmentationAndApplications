elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_03/IBSR_03.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_03
transformix -in Training_Set/IBSR_03/IBSR_03_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_03/ -tp Registered_images/Training_Set/registered_images/IBSR_03/TransformParameters.2.txt 

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_04/IBSR_04.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_04
transformix -in Training_Set/IBSR_04/IBSR_04_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_04/ -tp Registered_images/Training_Set/registered_images/IBSR_04/TransformParameters.2.txt

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_05/IBSR_05.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_05
transformix -in Training_Set/IBSR_05/IBSR_05_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_05/ -tp Registered_images/Training_Set/registered_images/IBSR_05/TransformParameters.2.txt

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_06/IBSR_06.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_06
transformix -in Training_Set/IBSR_06/IBSR_06_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_06/ -tp Registered_images/Training_Set/registered_images/IBSR_06/TransformParameters.2.txt

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_07/IBSR_07.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_07
transformix -in Training_Set/IBSR_07/IBSR_07_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_07/ -tp Registered_images/Training_Set/registered_images/IBSR_07/TransformParameters.2.txt

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_08/IBSR_08.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_08
transformix -in Training_Set/IBSR_08/IBSR_08_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_08/ -tp Registered_images/Training_Set/registered_images/IBSR_08/TransformParameters.2.txt

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_09/IBSR_09.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_09
transformix -in Training_Set/IBSR_09/IBSR_09_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_09/ -tp Registered_images/Training_Set/registered_images/IBSR_09/TransformParameters.2.txt

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_16/IBSR_16.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_16
transformix -in Training_Set/IBSR_16/IBSR_16_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_16/ -tp Registered_images/Training_Set/registered_images/IBSR_16/TransformParameters.2.txt

elastix -f Training_Set/IBSR_01/IBSR_01.nii.gz -m Training_Set/IBSR_18/IBSR_18.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Training_Set/registered_images/IBSR_18
transformix -in Training_Set/IBSR_18/IBSR_18_seg.nii.gz -out Registered_images/Training_Set/registered_labels/IBSR_18/ -tp Registered_images/Training_Set/registered_images/IBSR_18/TransformParameters.2.txt


elastix -f Validation_Set/IBSR_11/IBSR_11.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Validation_Set/registered_images/IBSR_11
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_11/csf -tp Registered_images/Validation_Set/registered_images/IBSR_11/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_11/wm -tp Registered_images/Validation_Set/registered_images/IBSR_11/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_11/gm -tp Registered_images/Validation_Set/registered_images/IBSR_11/TransformParameters.2.txt 

elastix -f Validation_Set/IBSR_12/IBSR_12.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Validation_Set/registered_images/IBSR_12
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_12/csf -tp Registered_images/Validation_Set/registered_images/IBSR_12/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_12/wm -tp Registered_images/Validation_Set/registered_images/IBSR_12/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_12/gm -tp Registered_images/Validation_Set/registered_images/IBSR_12/TransformParameters.2.txt 

elastix -f Validation_Set/IBSR_13/IBSR_13.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Validation_Set/registered_images/IBSR_13
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_13/csf -tp Registered_images/Validation_Set/registered_images/IBSR_13/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_13/wm -tp Registered_images/Validation_Set/registered_images/IBSR_13/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_13/gm -tp Registered_images/Validation_Set/registered_images/IBSR_13/TransformParameters.2.txt 

elastix -f Validation_Set/IBSR_14/IBSR_14.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Validation_Set/registered_images/IBSR_14
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_14/csf -tp Registered_images/Validation_Set/registered_images/IBSR_14/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_14/wm -tp Registered_images/Validation_Set/registered_images/IBSR_14/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_14/gm -tp Registered_images/Validation_Set/registered_images/IBSR_14/TransformParameters.2.txt 

elastix -f Validation_Set/IBSR_17/IBSR_17.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Validation_Set/registered_images/IBSR_17
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_17/csf -tp Registered_images/Validation_Set/registered_images/IBSR_17/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_17/wm -tp Registered_images/Validation_Set/registered_images/IBSR_17/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Validation_Set/registered_labels/IBSR_17/gm -tp Registered_images/Validation_Set/registered_images/IBSR_17/TransformParameters.2.txt 



------------------------
Test data


elastix -f Test_Set/IBSR_02/IBSR_02.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Test_Set/registered_images/IBSR_02
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_02/csf -tp Registered_images/Test_Set/registered_images/IBSR_02/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_02/wm -tp Registered_images/Test_Set/registered_images/IBSR_02/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_02/gm -tp Registered_images/Test_Set/registered_images/IBSR_02/TransformParameters.2.txt 

elastix -f Test_Set/IBSR_10/IBSR_10.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Test_Set/registered_images/IBSR_10
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_10/csf -tp Registered_images/Test_Set/registered_images/IBSR_10/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_10/wm -tp Registered_images/Test_Set/registered_images/IBSR_10/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_10/gm -tp Registered_images/Test_Set/registered_images/IBSR_10/TransformParameters.2.txt 

elastix -f Test_Set/IBSR_15/IBSR_15.nii.gz -m atlas/tissue_model.nii.gz -p Par0026/Par0026rigid.txt -p Par0026/Par0026affine.txt -p Par0026/Par0026bspline.txt -out Registered_images/Test_Set/registered_images/IBSR_15
transformix -in atlas/atlas_CSF.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_15/csf -tp Registered_images/Test_Set/registered_images/IBSR_15/TransformParameters.2.txt 
transformix -in atlas/atlas_WM.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_15/wm -tp Registered_images/Test_Set/registered_images/IBSR_15/TransformParameters.2.txt 
transformix -in atlas/atlas_GM.nii.gz -out Registered_images/Test_Set/registered_labels/IBSR_15/gm -tp Registered_images/Test_Set/registered_images/IBSR_15/TransformParameters.2.txt 
