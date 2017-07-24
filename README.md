# pelvicSeg

Used to store my projects

1. readMRCTimgFile.m read the mhd files in a patch style.

2. mha_read_header.m and mha_read_volume.m is the basic codes for reading mhd format files.

3. extractPatch4SegMedImg.py: extract patches.

4. extractMsPatch4SegMedImg.py: extract patches at multi-scale. Note, we didnot resize the 1st dimension, but the 2nd and 3rd dimension.

5. dicom2Nii.py: convert dicom format data into nifti data.

6. pelvic_train_test_23d_resnet_fcn.prototxt: a basic FCN+residual unit prototxt.
