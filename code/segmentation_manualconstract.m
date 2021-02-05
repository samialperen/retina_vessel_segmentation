%MANUAL CONTRAST ADJUSTING!!


%Read an image and make it gray-scale
original=rgb2gray(imread('rop1.tif'));

%Adjust this images contrast by using imtool interactively
adjustedcontrast=imread('rasadjusted.jpg');

%Show original image vs adjusted contrast image
figure('Name','Original Vs Adjusted Contrast Image'), imshowpair(original,adjustedcontrast,'montage');

%Sharpen image by using unsharp masking
unsharpened=imsharpen(adjustedcontrast,'Radius',15,'Amount',2);

%Subtract adjusted contrast ýmage from sharpened ýmage to get only edges
only_edges=adjustedcontrast-unsharpened;
figure, imshow(only_edges), title('The only edges Image');

%Since all images have different size from each other, we need to resize
%all image into one size
resized_only_edges=imresize(only_edges,[600 800]);


%%%%THIS PART IS NOT USED!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Now we want to break our image into small grids and make local
%thresholding but also in same time we want to compare this local
%thresholding values with general thresholding value to eliminate small
%details in grids. We just want dominant details (from perspective of big
%picture)
%general_threshold_level=graythresh(resized_only_edges);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%One can get better results changing grids number in x and y direction!
%Let's say we want to create 10 grids for both x and y directions
grids=10;
sizex=size(resized_only_edges,1); %Horizontal length of image
sizey=size(resized_only_edges,2); %Vertical length of image
gridx=sizex/grids; %Each grids x length
gridy=sizey/grids; %Each grids y length

%Take local threshold level for each grid seperately
for k=1:10
    for m=1:10
        local_threshold_levels(k,m)=graythresh(resized_only_edges(max([1,k-1*gridx]):k*gridx,max([1,m-1*gridy]):m*gridy));
    end
end
%Make threshold using local threshold values obtained from above
for k=1:10
    for m=1:10
        threshold=im2bw(resized_only_edges(max([1,k-1*gridx]):k*gridx,max([1,m-1*gridy]):m*gridy),local_threshold_levels(k,m));
    end
end

%%%%MORPHOLIGICAL OPERATIONS to make threshold image better

%Get rid of isolated pixels
binaryim1=bwareaopen(threshold,25);
binaryim2=bwareaopen(threshold,50);
binaryim3=bwareaopen(threshold,100);
binaryim4=bwareaopen(threshold,200);
figure, imshow(binaryim1), title('P=25');
figure, imshow(binaryim2), title('P=50');
figure, imshow(binaryim3), title('P=100');
figure, imshow(binaryim4), title('P=200');

%ALGORITHM 1 (bwareaopen function is key factor here so important!!)
bw1=bwmorph(threshold,'Clean');
bw2=medfilt2(bw1);
bw3=bwareaopen(bw2,30);
bw4=bwmorph(bw3,'bridge');
bw5=bwmorph(bw4,'fill');
bw6=bwareaopen(bw5,50);
bw7=bwmorph(bw6,'bridge');
final=bwmorph(bw7,'fill');
figure, imshow(final), title('Final1 ALGORITHM 1');

%ALGORITHM 2
%Clear vessel borders
binary1=imclearborder(threshold);
figure, imshow(binary1), title('Border is cleaned!');
%Remove isolated pixels
binary2=bwmorph(binary1,'Clean');
figure, imshow(binary2), title('Isolated pixels are removed!');
%Get the area information of regions
CC=bwconncomp(binary2);
area=regionprops(CC,'Area');
areas=[area.Area]; %Make it matrix
figure, title('Histogram of connected Areas');
area_histogram=histogram(areas,15);
obj_count=0;
for m=2:15
        obj_count=obj_count+area_histogram.Values(m);    
 end
 final2=bwareafilt(binary2,obj_count);
 figure, imshow(final2), title('Final2 ALGORITHM 2');
 


















