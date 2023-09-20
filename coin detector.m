image=imread('a01_ENV8QR.jpg');

% Linear Streaching the input image
img = stretch_lin(image);

img=rgb2gray(img);

% converting it to binary image
binaryimage=imbinarize(img,0.3591248698999999);
figure;
subplot(1,2,1);
imshow(image)
title('Orginal Input Image')
subplot(1,2,2);
imshow(binaryimage)
title('Thresholded Binary Image')


filter=fspecial('gaussian',[148 148], 8);
binaryimage=imfilter(binaryimage, filter);



%remove the white noise pixels and clearly delinates the boundry of the
%objects inside the image
binaryimage=bwareaopen(binaryimage,17195);

se=strel('disk',8);
binaryimage=imerode(binaryimage,se);



%get the position of the pixel inside and at the boundary of the objects
[B,L] = bwboundaries(binaryimage,'noholes');






stats = regionprops(L,'Area','BoundingBox');


figure;
imshow(label2rgb(L,@jet,[.5 .5 .5]))
colorbar
title('Result of Convolution')


% Positioning the bondries of the objects to be used for cropping from the
% orginal image
statssize=size(stats);
for i=1:statssize(1)
    if stats(i).Area<12500
        stats(i).BoundingBox=[0, 0 ,0 ,0];
    else
        stats(i).BoundingBox=[stats(i).BoundingBox(1)-10, stats(i).BoundingBox(2)-20, stats(i).BoundingBox(3)+50, stats(i).BoundingBox(4)+50];
    end
end




a=0;
meann=zeros(1,15);
hsvimage=rgb2hsv(image);
hsvimage=hsvimage(:,:,2);
figure;
count=0;

%To display all the detected Objects in the image

 for i=1:statssize(1)
     sz=size(B{i,1});
     if sz(1)>1
         count=count+1;
        subplot(4,4,count); 
     
        saturation=imcrop(hsvimage,stats(i).BoundingBox);
     
     
         dim=size(saturation);   
         a=0;
         for x=1:dim(1)
             for y=1:dim(2)
                 a=a+saturation(x,y);
             end
         end
         meann(i)=a/(dim(1)*dim(2));
         circle_measure=find_round_objects(B{i},stats(i).Area);
         if (meann(i)<0.4 && circle_measure>0.5)
             q=imcrop(image,stats(i).BoundingBox);
             imshow(q);
             title('coin')
         else
             q=imcrop(image,stats(i).BoundingBox);
             imshow(q);
             title('NOT coin')
         end
    end

 end
 
 
 % To display only Coins in the image and their values
 count=0;
 n=0;
 figure;
totalFt=0;
totaleuro=0;
for i=1:statssize(1)
     sz=size(B{i,1});
     if sz(1)>1
         count=count+1;
         
     
        saturation=imcrop(hsvimage,stats(i).BoundingBox);
     
     
         dim=size(saturation);   
         a=0;
         for x=1:dim(1)
             for y=1:dim(2)
                 a=a+saturation(x,y);
             end
         end
         meann(i)=a/(dim(1)*dim(2));
         circle_measure=find_round_objects(B{i},stats(i).Area);
 
        
         
         if (meann(i)<0.4 && circle_measure>0.5)
             n=n+1;
             q=imcrop(image,stats(i).BoundingBox);
             
             if meann(i)<0.2450
                 subplot(4,4,n);
                 hold on;
                 imshow(q)
                 title('50Ft')
                 totalFt=totalFt+50;
             elseif (meann(i)<0.2590 || meann(i)>0.2700 && meann(i)<0.2800)
                 subplot(4,4,n)
                 hold on;
                 imshow(q)
                 title('100Ft')
                 totalFt=totalFt+100;
             elseif meann(i)<0.2690
                 subplot(4,4,n)
                 hold on;
                 imshow(q)
                 title('200Ft')
                 totalFt=totalFt+200;
             elseif (meann(i)<0.2890 || (meann(i)>0.2980 && meann(i)<0.3000))
                 subplot(4,4,n)
                 hold on;
                 imshow(q)
                 title('5Ft')
                 totalFt=totalFt+5;
             elseif meann(i)<0.3100
                 subplot(4,4,n)
                 hold on;
                 imshow(q)
                 title('20Ft')
                 totalFt=totalFt+20;
             elseif meann(i)<0.3550
                 subplot(4,4,n)
                 hold on;
                 imshow(q)
                 title('2 cents')
                 totaleuro=totaleuro+0.02;
             elseif meann(i)<0.3590
                 subplot(4,4,n)
                 hold on;
                 imshow(q)
                 title('5 cents')
                 totaleuro=totaleuro+0.05;
             end
         end
         
     end
end
 
 
 fprintf('Total of %d HUF and %0.2f EURO \n',totalFt,totaleuro)

