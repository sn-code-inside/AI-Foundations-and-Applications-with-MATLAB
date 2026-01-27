
% Perform segmentation for two images with FCM algorithm
% Name: Car_Image_FCM_Func.m
% Input: Two car images
% Output: FCM clustering result

Img1 = ['C:\Artificial Intelligence Book\Students\Datasets\Car Type Dataset\' ...
                'car_train_data\sedan\PHOTO_7.jpg'];
Img2 = ['C:\Artificial Intelligence Book\Students\Datasets\Car Type Dataset\' ...
                'car_train_data\sedan\PHOTO_9.jpg'];

I1 = im2double(imread(Img1));                               % Load car 1 image
I1 = rgb2gray(I1);                                                      % convert to gray scale
I1 = imadjust(I1);

I2 = im2double(imread(Img2));                               % Load car 2 image
I2 = rgb2gray(I2);                                                      % convert to gray scale
I2 = imadjust(I1);

subplot(121);
imshow(I1, []);
  
data = [I1(:) I2(:)];                                                      % make data array = (400 * 500)) 200000 by 1 array
[center, U, obj_fcn, info] = fcm(data, 5);                   % Fuzzy C-means classification with 5 classes
 
Noptim = info.OptimalNumClusters;
% Find the pixels for each class, which have the max MD values
maxU = max(U);
index = cell(Noptim, 1);
for k = 1:Noptim
    index{k} = find(U(k, :) == maxU);
end

% Assigning pixel to each class by giving them a specific value
N = 1.2;
fcmImage(1:length(data))=0;       
for i = 1:Noptim
    fcmImage(index{i}) = N - 0.2*i;
end

% Reshapeing the array to a imag
imagNew = reshape(fcmImage, 400, 500);
subplot(122);
imshow(imagNew, []); 



