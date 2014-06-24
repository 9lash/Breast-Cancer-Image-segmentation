function [N_objects,N_holes,AvgEccent_objs,Euler,Arnf1,eccnmedian,eccnmean,eccnvar, eccnkurtosis]=Segmentation(IM, n)

%im=imread(fname);
im=mat2gray(IM);

imbin=im2bw(im,0.7);
imbin = bwareaopen(imbin, 1000);
SE = strel('square',5);
imbin = imdilate(imbin,SE);
%figure; imshow(imbin); title('imbin');
base = imbin;
imbin = ~imbin;

%%

imbin = bwareaopen(imbin,5000);
%figure;imshow(imbin); title('Get rid of small areas in the mask');

im(~imbin)=0; 
%figure;imshow(im); title('Get the nuclei chains without fragments');

%%
BW = imbin;
% Also try this BW = imbin and form connected comp;
CC = bwconncomp(BW); 
stats = regionprops(CC,'Area','Eccentricity','EulerNumber' );

%Area
Area = [stats.Area];
Ar = 0; 
for i = 1:(CC.NumObjects)
    Ar = Ar+Area(i);
end


[B,L,N,A] = bwboundaries(BW);
[p,n] = size(B);
N_holes = p-N;                  %Feature exporting1
N_objects = N;                  %Feature exporting2
R = N_holes/N_objects;          %Feature not exporting


%Finding avg eccentricity of the objects of the image
Eccentobj = [stats.Eccentricity]; 
Eobj = 0;
for i = 1: (CC.NumObjects)
    Eobj = Eobj + Eccentobj(i);
end
AvgEccent_objs = Eobj/ CC.NumObjects;      %Feature Exporting3

%Finding Average EulerNumber
Eulernumber = [stats.EulerNumber];
Euler = 0; 
for i = 1:(CC.NumObjects)
    Euler = Euler + abs(Eulernumber(i));
end
Euler = Euler/CC.NumObjects;            %Feature Exporting4

%%
%% Finding Nucleus
A = [];
temp = im;
temp = imerode(temp,true(3));

% figure;imshow(temp); 
% title('Dilated temp');

% figure; imshow(im); hold on;
% %title('Segmented Image  - IDC');
% title(' Nucleus Segmented Image - Normal Tissue');


for i = 1: CC.NumObjects
    x = temp(CC.PixelIdxList{i});
    A = [A;x];
end

T = 1.1*graythresh(A);
im2 = im2bw(im,T);
im2 = bwareaopen(im2,100);
CC5 = bwconncomp(im2);
numPixels5 = cellfun(@numel,CC5.PixelIdxList);
stats5 = regionprops(CC5, 'Area','Eccentricity' );

[B2,L2,N2,A2] = bwboundaries(im2);
[p2,n2] = size(B2);

% figure; imshow(im);hold on;
% [r c] = find(im2);
% plot(c,r, '.r');

%%Nucleus display
figure; imshow(im); hold on;
title(' Nucleus Segmented Image');
for kk=1:length(B2),
    boundary2 = B2{kk};
    if(kk > N2)
        plot(boundary2(:,2),boundary2(:,1),'g');
    else
        plot(boundary2(:,2),boundary2(:,1),'r');
    end
end


Arn = [stats5.Area];
eccn = [stats5.Eccentricity]; 
sumArn = sum(Arn);

Arnfeature = sumArn/Ar;
Arnf1 = var(Arnfeature);% Feature of Nucleus Area
eccnmedian = median(eccn); % Feature of Nucleus Median 
eccnmean = mean(eccn); % Feature of Nucleus Mean

eccnvar = var(eccn); %% Feature of Nucleus - Variance of eccentricity
eccnkurtosis = kurtosis(eccn);
eccnskew = skewness(eccn);
Arnvar = var(Arn); %% Feature of Nucleus - Variance of Area


% figure; imshow(im); hold on;
% title('Segmented Image  - IDC');
% %title('Segmented Image - Normal');
% 
% for k=1:length(B),
%     boundary = B{k};
%     if(k > N)
%         plot(boundary(:,2),boundary(:,1),'g');
%     else
%         plot(boundary(:,2),boundary(:,1),'r');
%     end
% end

%% Finding the holes 

%figure, imshow(base);
CC2 = bwconncomp(base);
numPixels = cellfun(@numel,CC2.PixelIdxList);
[biggest, idx] = max(numPixels);
base(CC2.PixelIdxList{idx}) = 0;
%figure, imshow(base);
%title('Holes - IDC')
base2 = base;           % Have a copy

CC3 = bwconncomp(base);
stats3 = regionprops(CC3, 'Area', 'Eccentricity');
eccholes=[stats3.Eccentricity];

Hnm = CC3.NumObjects;        %Feature Exporting5

Ehole = 0;
for i = 1: (CC3.NumObjects)
    Ehole = Ehole + eccholes(i);
end
AvgEcch_nm = Ehole/ CC3.NumObjects;    %Feature exporting6

%%
%Finding Holes when Masking is done
%bwarea to eliminate small holes for calculation of Eccentricity
base2 = bwareaopen(base2,4000);
% figure, imshow(base2);
% title('Bigger Holes - IDC');

CC4 = bwconncomp(base2);
stats4 = regionprops(CC4, 'Area', 'Eccentricity', 'EquivDiameter');
eccholes2=[stats4.Eccentricity];
edia2 =[stats4.EquivDiameter]; 
Hm = CC4.NumObjects;            %Feature Exporting7

Ehole2 = 0;
for i = 1: (CC4.NumObjects)
    Ehole2 = Ehole2 + eccholes2(i);
end
AvgEcch_m = Ehole2/ CC4.NumObjects;      %Feature exporting7

Edia2 = 0;
for i = 1:(CC4.NumObjects)
    Edia2 = Edia2+edia2(i);
end
Avgedia2=Edia2/CC4.NumObjects;          %Feature exporting 8

