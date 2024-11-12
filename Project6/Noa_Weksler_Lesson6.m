


% Homework - Lesson 6



%%


% Targil1

% loading the image file:
puppiesImage = imread('puppies.jpg');


%%


% Targil2

% displaying the image, using the "imshow" function:
figure(1);
hold on;
imshow(puppiesImage); 
title('puppies image');
hold off;


%%


% Targil3

% creating 2 new variables, each containing the data for displaying only a dog's head,
% by cutting it from the original puppies image (by mentioning specific coordianates):
left_dogs_head = puppiesImage(38:220,190:412,:);
right_dogs_head = puppiesImage(65:241,410:584,:);
% displaying only their heads:
figure(2);
hold on;
subplot(1,2,1);
imshow(left_dogs_head); % using the "imshow" function, because it's not distorting the image proportion
title('left dogs head');
subplot(1,2,2);
imshow(right_dogs_head); % using the "imshow" function, because it's not distorting the image proportion
title('right dogs head');
sgtitle('dogs heads only');
hold off;


%%


% Targil4

% saving both of the images on the current folder, 
% using the '.jpg' ending, so that the saved result would jpg image file:
imwrite(left_dogs_head, 'left_dogs_head.jpg');
imwrite(right_dogs_head, 'right_dogs_head.jpg');


%%


% Targil5

% flipping both heads images, and saving them in 2 new variables:
flipped_left_dog = fliplr(left_dogs_head);
flipped_right_dog = fliplr(right_dogs_head);


%%


% Targil6

% inserting the data of puppiesImage to a new variable, so it will be 
% possible to edit it, without harming the original image:
new_puppies = puppiesImage;
% inserting the flipped heads data to the original place where the data about 
% dogs heads were, and by that planting flipped heads insted of the original one's:
new_puppies(38:220,190:412,:) = flipped_left_dog;
new_puppies(65:241,410:584,:) = flipped_right_dog;
% displaying the new image:
figure(3);
hold on;
imshow(new_puppies);
title('puppies with flipped heads');
hold off;
% saving the new image as a jpg file, on the current folder:
imwrite(new_puppies,'puppies with flipped heads.jpg');


%%


% Targil7

% creating a three dimentional matrix, containing only zeros for now, and
% that is built in the right size to accept the data for the matrix we want later:
lower_resolution_puppies5 = zeros(size(puppiesImage,1)/5,size(puppiesImage,2)/5,size(puppiesImage,3));
% lowering the original image resolution, by creating a loop, inside a loop, 
% inside a loop, that calculates the avarage of the RGB data of each 5x5
% pixels. that yields a three dimentional matrix smaller 5 times than the
% original one in x and y dimensions, but staying the same in the z axis:
for i=1:size(lower_resolution_puppies5,1)
    for j=1:size(lower_resolution_puppies5,2)
        for j2=1:size(lower_resolution_puppies5,3)
            lower_resolution_puppies5(i,j,j2)=mean(mean(mean(puppiesImage(i*5-4:i*5,j*5-4:j*5,j2))));
        end
    end
end
% converting the "double" format, to a format that will enable us to display the image: 
lower_resolution_by_5_dogs_image = uint8(lower_resolution_puppies5);
% creating a figure which shows the original image besides the lower resolution image:
figure(4);
hold on;
subplot(1,2,1);
imshow(puppiesImage);
title('the original puppies image');
subplot(1,2,2);
imshow(lower_resolution_by_5_dogs_image);
title({'the puppies image';'with a lower';'resolution (by 5)'});
sgtitle('comparing the original resolution with a lower one (by 5)');
hold off;


%%


% Targil8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% the first part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%% (which id similar to Targil7, only we had to lower the resolution by 25) %%%%%%%%%%%
% creating a three dimentional matrix, containing only zeros for now, and
% that is built in the right size to accept the data for the matrix we want later:
lower_resolution_puppies25 = zeros(size(puppiesImage,1)/25,size(puppiesImage,2)/25,size(puppiesImage,3));
% lowering the original image resolution, by creating a loop, inside a loop, 
% inside a loop, that calculates the avarage of the RGB data of each 25x25
% pixels. that yields a three dimentional matrix smaller 25 times than the
% original one in x and y dimensions, but staying the same in the z axis:
for i1=1:size(lower_resolution_puppies25,1)
    for i2=1:size(lower_resolution_puppies25,2)
        for i3=1:size(lower_resolution_puppies25,3)
            lower_resolution_puppies25(i1,i2,i3)=mean(mean(mean(puppiesImage(i1*25-24:i1*25,i2*25-24:i2*25,i3))));
        end
    end
end
% converting the "double" format, to a format that will enable us to display the image: 
lower_resolution_by_25_dogs_image = uint8(lower_resolution_puppies25);
% creating a figure which shows the original image besides the lower resolution image:
figure(5);
hold on;
subplot(1,2,1);
imshow(puppiesImage);
title('the original puppies image');
subplot(1,2,2);
imshow(lower_resolution_by_25_dogs_image);
title({'the puppies image';'with a lower';'resolution (by 25)'});
sgtitle('comparing the original resolution with a lower one (by 25)');
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% the second part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% changing the color map to gray (black and whith) tones:
gray_lower_resolution25 = rgb2gray(lower_resolution_by_25_dogs_image);
% the change yeilds a two dimentional matrix, because it is "flatnning" the 
% z axis and remains one value which sets the gray tone of a pixel.
% now we will turn every value above 200 to 255 (the maximum RGB value possible= white),
% every value underneath 50 to 0 (the minimum RGB value possible= black),
% and every other value to 155 (a gray tone). 
% we will do it using an if loop, and logical conditioning. 
% that way we will see only 3 colors when the new image will be displayed: 
for i1=1:size(lower_resolution_by_25_dogs_image,1)
    for i2=1:size(lower_resolution_by_25_dogs_image,2)
        if gray_lower_resolution25(i1,i2)>200
            gray_lower_resolution25(i1,i2)=255;
        elseif gray_lower_resolution25(i1,i2)<50
            gray_lower_resolution25(i1,i2)=0;
        else
            gray_lower_resolution25(i1,i2)=155;
        end
    end
end   
% displaying the new image as instructed, with the colorful title:
figure(6);
imagesc(gray_lower_resolution25);
colormap gray;
hold on;
title('\color{red}The \color{magenta}Image');
hold off;



