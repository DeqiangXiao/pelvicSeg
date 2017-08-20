# pelvicSeg

Used to store my projects

1. readMRCTimgFile.m read the mhd files in a patch style.

2. mha_read_header.m and mha_read_volume.m is the basic codes for reading mhd format files.

3. extractPatch4SegMedImg.py: extract patches.

4. extractMsPatch4SegMedImg.py: extract patches at multi-scale. Note, we didnot resize the 1st dimension, but the 2nd and 3rd dimension.

5. dicom2Nii.py: convert dicom format data into nifti data.

6. pelvic_train_test_23d_resnet_fcn.prototxt: a basic FCN+residual unit prototxt.

7. genLossSeries.m and drawDiagram.m are the codes I wrote to generate loss from the caffe output logs, and then draw the loss curves.

8. extractSsPatch4SegMedImg.py: extract single scale patches, same as extractPatch4SegMedImg.py

9. extractPatch4SegRegMedImg.py: based on 8, we also extract regression patches for organs
