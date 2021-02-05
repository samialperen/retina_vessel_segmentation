%GREEN CHANNEL OF RETINA IMAGE WAS USED INSTEAD OF ALTERING CONTRAST
%MANUALLY SINCE GREEN CHANNEL CONTAINS MORE INFORMATION RELATED TO VESSELS


%Read an image and make it gray-scale
original=imread('rop1.tif');
figure, imshow(original), title('Original Image');
%Adjust this images contrast by using imtool interactively
greenchannel=original(:,:,2);
%Show original image vs adjusted contrast image
figure, imshow(greenchannel), title('Green Channel');
%Sharpen image by using unsharp masking
unsharpened=imsharpen(greenchannel,'Radius',15,'Amount',2);
%Subtract adjusted contrast ýmage from sharpened ýmage to get only edges
only_edges=greenchannel-unsharpened;
%Show the image sharpened by unsharp masking VS only edges images
figure, imshow(only_edges), title('Only Edges Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%I tried to use gradient to highlight dominant edges but since gradient is
%too sensitive to noises the result were not good enough
%Try median filter to remove noise from only_edges image
%medfilteredim=medfilt2(only_edges,[10 10]);
%Show the noise removed image
%figure,imshow(medfilteredim), title('The median filtered image');
%This time use average filter to remove noise
%averagefilter=fspecial('average',5);
%noiseremoved2=imfilter(only_edges,averagefilter);
%Show the noise removed by averaging filter image
%figure('Name','Noise Removed by Averaging Filter'), imshow(noiseremoved2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Resize image to use algorithm for another images since each image has
%different sizes (IN FUTURE BETTER APPROXIMATIONS SHOULD BE USED !)
resized_only_edges=imresize(only_edges,[600,800]);
%MAKE LOCAL THRESHOLDING
%Break image into 10x10 grids
grids_number=10; %In our case the grid number in x and y direction is equal so we have only one variable
sizex=size(resized_only_edges,1); %Horizontal length of image
sizey=size(resized_only_edges,2); %Vertical length of image
gridx=sizex/grids_number; %Each grids x length
gridy=sizey/grids_number; %Each grids y length

%Take local threshold level for each grid seperately
for k=1:grids_number
    for m=1:grids_number
        local_threshold_levels(k,m)=graythresh(resized_only_edges(max([1,k-1*gridx]):k*gridx,max([1,m-1*gridy]):m*gridy));
    end
end
%Since we are not looking for all image just once we need to eliminate
%small details in grids to contribute local thresholding
max_local_threshold_level=max(max(local_threshold_levels));
for k=1:grids_number
    for m=1:grids_number
        if local_threshold_levels(k,m) < 0.75*max_local_threshold_level
            local_threshold_levels2(k,m)=0.5*local_threshold_levels(k,m); %Reduce its effect
        else
            local_threshold_levels2(k,m)=local_threshold_levels(k,m); %Do not do anything
        end 
        old_threshold=im2bw(resized_only_edges(max([1,k-1*gridx]):k*gridx,max([1,m-1*gridy]):m*gridy),local_threshold_levels(k,m));
        new_threshold=im2bw(resized_only_edges(max([1,k-1*gridx]):k*gridx,max([1,m-1*gridy]):m*gridy),local_threshold_levels2(k,m));
    end
end

figure, imshow(old_threshold), title('Local threshold');
figure, imshow(new_threshold), title('Local threshold with reduced effect');

%%%DRAW GRID LINES
% hold on
% for k=1:grids_number
%     for m=1:grids_number
%         line([m m],[k-1*gridx k*gridx]);
%         %line([max([1,m-1*gridx]) max([1,m-1*gridx])],[max([1,k-1*gridy]) k*gridy])
%         %line([max([1,k-1*gridx]) k*gridx],[max([1,m-1*gridy]) max([1,m-1*gridy])])
%     end
% end

%%%MORPHOLOGICAL OPERATIONS
binary1=bwmorph(new_threshold,'Clean');
binary2=imclearborder(binary1);
binary3=bwmorph(binary2,'bridge');
binary4=bwmorph(binary3,'fill');
binary5=bwmorph(binary4,'Majority');
figure, imshow(binary1), title('Isolated Pixels are removed');
figure, imshow(binary2), title('Border is cleaned');
figure, imshow(binary3), title('The bridges are completed');
figure, imshow(binary4), title('The empty spaces are filled');
figure, imshow(binary5), title('Just majority is taken');


%%%IMAGE ANALYSIS JUST TAKE REGIONS THAT CONTAIN BIGGER OBJECTS
%Write histogram of areas
CC=bwconncomp(binary5);
areas=regionprops(CC,'Area');
number_of_bins=20;
area_hist=histogram([areas.Area],number_of_bins);
%The shown big histogram bin means small objects so we eliminate it by
%counting objects after from it. So we started to count from 2 not 1. So we
%did not take histogram bin1 
obj_count=0;
for m=2:number_of_bins
        obj_count=obj_count+area_hist.Values(m);    
end

big_objects=bwareafilt(binary5,obj_count);
figure , imshow(big_objects), title('biggest objects');
%One can see that if we increase number of bins in histogram, we can take
%more vessels(much smaller ones also). On the other hand, it also means
%that taking unconnected and small vessels that is not desired. So one
%should choose properly number of bins in histogram!






% %Erode the noise removed image
% se=strel('disk',2,0);
% erodedimage=imerode(noiseremoved2,se);
% %Show the eroded image
% %figure('Name','Eroded Image'), imshow(erodedimage);
% %Use median filter to remove noise from eroded image
% clearerodedimage=medfilt2(erodedimage);
% %Show the noise removed eroded image
% %figure('Name','Noise Removed Eroded Image'), imshow(clearerodedimage);
% %Again use averaging filter to remove noise
% averagefilter2=fspecial('average',15);
% clearerodedimage2=imfilter(clearerodedimage,averagefilter2);
% %Show the noise removed eroded image
% %figure('Name','Noise Removed Eroded Image 2'), imshow(clearerodedimage2);
