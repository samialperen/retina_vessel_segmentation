# rop_disease_classification

This repository contains files belong to the project **"Diagnasis of Retinopathy of Prematurity (ROP) Disease Using Deep Learning''**

## Retinal Vessel Segmentation
Two different approach was followed in order to segment retinal vessels. 

### 1-) Segmenting Retinal Vessels Using Traditional Image Processing Techniques 
MATLAB image processing toolbox is used to segment vessels using traditional computer vision approaches (edge detection, local threshold, morphological operations etc). Related scripts are [segmentation and auto contrast](https://github.com/samialperen/rop_disease_classification/blob/master/code/segmentation_autocontrast.m) and [segmentation without auto contrast](https://github.com/samialperen/rop_disease_classification/blob/master/code/segmentation_manualconstract.m). 

The approach followed for this purpose:

* Original Image
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/original_img.jpg" width="50%" height="50%">
* Adjust Contrast
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/contrast.jpg" width="50%" height="50%">
* Filter Edges
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/edges.jpg" width="50%" height="50%">
* Apply Local Threshold
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/local_threshold.jpg" width="50%" height="50%">
* Bridge the gaps with morphological operations
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/fill_gaps.jpg" width="50%" height="50%">
* Select the longest and thickest vessels to obtain final segmented vessels
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/biggest_vessels.jpg" width="50%" height="50%">

### 2-) Segmenting Using Convolutional Neural Network U-Net with Transfer Learning
* A CNN architecture aimed for segmentation named **U-Net** (as shown below) was used 
<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/CNN/unet.png" width="50%" height="50%">

* Train it with [Imagenet](https://www.pyimagesearch.com/2017/03/20/imagenet-vggnet-resnet-inception-xception-keras)

* Use trained U-Net network to train our network for [DRIVE DATASET: Digital Retinal Images for Vessel Extraction](https://drive.grand-challenge.org) -->transfer learning


* Here are example input-output pairs where left image is the original image and right image is the output of U-Net
<p float="left">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/CNN/input1.jpg" width="40%" height="40%">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/CNN/output1.png" width="40%" height="40%">
</p>

<p float="left">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/CNN/input2.jpg" width="40%" height="40%">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/CNN/output2.jpg" width="40%" height="40%">
</p>

