# rop_disease_classification

This repository contains files belong to the project **"Diagnasis of Retinopathy of Prematurity (ROP) Disease Using Deep Learning''**

## Retinal Vessel Segmentation
Two different approach was followed in order to segment retinal vessels. 

### Segmenting Retinal Vessels Using Traditional Image Processing Techniques 
MATLAB image processing toolbox is used to segment vessels using traditional computer vision approaches (edge detection, local threshold, morphological operations etc). Related scripts are [segmentation and auto contrast](https://github.com/samialperen/rop_disease_classification/blob/master/code/segmentation_autocontrast.m) and [segmentation without auto contrast](https://github.com/samialperen/rop_disease_classification/blob/master/code/segmentation_manualconstract.m). 

The approach followed for this purpose:

* Original Image
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/original_img.jpg" width="60%" height="60%">
* Adjust Contrast
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/contrast.jpg" width="60%" height="60%">
* Filter Edges
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/edges.jpg" width="60%" height="60%">
* Apply Local Threshold
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/local_threshold.jpg" width="60%" height="60%">
* Bridge the gaps with morphological operations
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/fill_gaps.jpg" width="60%" height="60%">
* Select the longest and thickest vessels to obtain final segmented vessels
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/biggest_vessels.jpg" width="60%" height="60%">
