# rop_disease_classification

This repository contains files belong to the project **"Diagnasis of Retinopathy of Prematurity (ROP) Disease Using Deep Learning''**

## Retinal Vessel Segmentation
Two different approach was followed in order to segment retinal vessels. 

### 1-) Segmenting Retinal Vessels Using Traditional Image Processing Techniques 
MATLAB image processing toolbox is used to segment vessels using traditional computer vision approaches (edge detection, local threshold, morphological operations etc). Related scripts are [segmentation and auto contrast](https://github.com/samialperen/rop_disease_classification/blob/master/code/segmentation_autocontrast.m) and [segmentation without auto contrast](https://github.com/samialperen/rop_disease_classification/blob/master/code/segmentation_manualconstract.m). 

The approach followed for this purpose:

* Read original image and adjust contrast 
<p float="left">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/original_img.jpg" width="45%" height="45%" alt="Original Image">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/contrast.jpg" width="45%" height="45%"> 
</p>
* Filter edges and apply local threshold 
<p float="left">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/edges.jpg" width="45%" height="45%">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/local_threshold.jpg" width="40%" height="40%"> 
</p>
* Bridge the gaps with morphological operations and finally select the longest/thickest vessels to obtain final image
<p float="left">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/fill_gaps.jpg" width="45%" height="45%">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/computer_vision/biggest_vessels.jpg" width="45%" height="45%"> 
</p>



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
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/CNN/output2.jpg" width="38%" height="38%">
</p>

## Diagnosis of Retinopath of Prematurity (ROP) Using Segmented Vessels

### Marking App to Collect Training Data from ROP Specialists
In order to classify retinal images into three categories depending on the level of ROP (plus, preplus and normal/healthy), the [marking app]() was developed. It is a GUI to allow medical doctors to manually label retina images as plus, preplus or normal/healthy. This approach allows us to collect enough training data for classification. 

<img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/marking_app/gui.jpg" width="50%" height="50%">

### Classification of ROP Disease
* Previously trained U-Net (with Imagenet) network was trained with segmented version of data that we collected. 
* 81% accuracy obtained with confusions mostly between Plus/Preplus and Preplus/Normal categories.

* Correctly predicted examples: (Normal, Preplus and Plus Starting from Left to Right)
<p float="left">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/diagnosis/correct_normal.jpg" width="30%" height="30%">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/diagnosis/correct_preplus.jpg" width="30%" height="30%">
  <img src="https://github.com/samialperen/rop_disease_classification/blob/master/media/diagnosis/correct_plus.jpg" width="30%" height="30%">
</p>



