


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% loading the face images %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% loading images and colormaps into structures, by using a loop:

for i = 1:8
 [images_rep{1,i},colors_rep{1,i}] = imread(['reptile' num2str(i) '.jpg'],'jpg');
 [images_bird{1,i},colors_bird{1,i}] = imread(['bird' num2str(i) '.jpg'], 'jpg');
end

% imshow('reptile3.jpg');


%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% preperations for the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% setting the number of trials for this experiment:

number_of_trials = 30;


% creating a vector of NaNs that will get values from the loop later:

its_a_reptile = zeros(1,number_of_trials);


% calculating 20% from 30 trials (as was instructed):

num_of_reptiles = number_of_trials/2;

% 1 = reptile
% 2 = bird

% creating a vector with 30 random values in the range 1-2 (like the number
% of kinds of images we've loaded to matlab), but which has 50% of the time a reptile.
% this vector will be used later to display the images randomly, according to their
% numbers, but in the right way for a "two-back" face-detection experiment:
% the loops for finding the right vector:

while sum(its_a_reptile) ~= num_of_reptiles
    for i = 1:number_of_trials
        the_right_vector(i) = randi(2,1,1);
        if the_right_vector(i) == 1
            its_a_reptile(i) = 1;
        else
            its_a_reptile(i) = 0;
        end
    end
end


% now we have the right vector in our workspace.



%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% creating the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% creating a figure for the trial:

tb = figure('Toolbar','none','Menubar','none','NumberTitle','off',...
 'Units','normalized','position',[0 0 1 1],'Color',[1 1 1]);


% display some text on the figure, that instruct how to start, and do the experiment:

figure_text_headline = text(0.2,0.8,'This is an animal detection experiment','FontSize', 20, 'FontWeight', 'bold');
figure_text_instructions = text(0.2,0.5,{'this experiment has 30 steps, in each step you will be presented with 4 images of animals (birds/reptiles).' ,...
    'three of the picture are of animals from the same group, and one is different',...
    'You will have to use the numbers 1-4 on your keboard, to point where was the odd picture, while:',...
 '',...
 '1 = in the top left picture there is a different kind of animal from all',...
 '2 = in the top right picture',...
 '3 = in the bottom left picture',...
 '4 = in the bottom right picture',...
 '',...
 'To start the experiment, press any button.'}, 'FontSize', 16);
axis off;


% wait for button press and then start timing:

waitforbuttonpress;


% deleting the texts that are no longer required:

delete(figure_text_headline);
delete(figure_text_instructions);


% starting the trial:

Responses = NaN(number_of_trials,4);

for trial = 1:number_of_trials
    place_rand = randperm(4);
    if the_right_vector(trial) == 1
        x1 = images_rep;
        y1 = colors_rep;
        x2 = images_bird;
        y2 = colors_bird;
        Responses(trial,1) = 1;
    elseif the_right_vector(trial) == 2
        x1 = images_bird;
        y1 = colors_bird;
        x2 = images_rep;
        y2 = colors_rep;
        Responses(trial,1) = 2;
    end
    different_pic = randi(8,1,1);
    three_pics = randperm(8,3);
    
    tic;
    axis off;
   
    subplot(2,2,place_rand(1));
    current_image1 = imshow(x1{1,different_pic},y1{1,different_pic},'InitialMagnification','fit');
    axis off;
    title({['Picture ' num2str(place_rand(1))]});
    
    subplot(2,2,place_rand(2));
    current_image2 = imshow(x2{1,three_pics(1)},y2{1,three_pics(1)},'InitialMagnification','fit');
    axis off;
    title({['Picture ' num2str(place_rand(2))]});
    
    subplot(2,2,place_rand(3));
    current_image3 = imshow(x2{1,three_pics(2)},y2{1,three_pics(2)},'InitialMagnification','fit');
    axis off;
    title({['Picture ' num2str(place_rand(3))]});
    
    subplot(2,2,place_rand(4));
    current_image4 = imshow(x2{1,three_pics(3)},y2{1,three_pics(3)},'InitialMagnification','fit');
    axis off;
    title({['Picture ' num2str(place_rand(4))]});

    axis off;
    drawnow;
    pause;
    what_was_pressed = get(tb,'CurrentCharacter');
    Responses(trial,3) = toc;
    if what_was_pressed == 49
        Responses(trial,2) = 1;
    elseif what_was_pressed == 50
        Responses(trial,2) = 2;
    elseif what_was_pressed == 51
        Responses(trial,2) = 3;
    elseif what_was_pressed == 52
        Responses(trial,2) = 4;
    end
    if place_rand(1) == Responses(trial,2)
        Responses(trial,4) = 1;
    else
        Responses(trial,4) = 0;
    end
    clf(tb);
end



% closing the trial:

close(tb);


save('Responses', 'Responses');


