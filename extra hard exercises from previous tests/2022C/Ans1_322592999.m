

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% loading the face images %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% loading images and colormaps into structures, by using a loop:
for i = 1:6
 [images{1,i},colors{1,i}] = imread(['Die' num2str(i) '.jpg'],'jpg');
end
imshow('Die3.jpg');

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% preperations for the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% setting the number of trials for this experiment:
number_of_trials = 20;

% creating a vector of NaNs that will get values from the loop later:
vec_vec = NaN(1,number_of_trials);

% calculating 40% from 20 trials (as was instructed):
num_of_even = number_of_trials/100*40;

% creating two vectors with 20 random values in the range 1-6 (like the number
% of images we've loaded to matlab), but which has 40% of the time an even sum.
% this vector will be used later to display the images randomly, according to their
% numbers, but in the right way for the detection in the experiment:

% the loops for finding the right vector:

while sum(vec_vec) ~= num_of_even
    for i = 1:number_of_trials
        Die_1(i) = randi(6,1,1);
        Die_2(i) = randi(6,1,1);
        temp_val = Die_1(i) + Die_2(i);
        if temp_val == 2 || temp_val == 4 || temp_val == 6 || temp_val == 8 || temp_val == 10 || temp_val == 12
            vec_vec(i) = 1;
        else
            vec_vec(i) = 0;
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
figure_text_headline = text(0.2,0.8,'This is the "dice-sum" experiment','FontSize', 20, 'FontWeight', 'bold');
figure_text_instructions = text(0.2,0.5,{'the experiment has 20 steps, in each step you will be presented with 2 images of dices.' ,...
 'You will have to use 2 different numbers from your keyboard, according to the following instructions:',...
 '',...
 'If you think the sum of the dices is even - press the key "2",',...
 'otherwise - press the key "1".', ...
 '',...
 'please notice that we youll have to be as fast as you can - we are timing you',...
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
    tic;
    axis off;
    the_image_1 = Die_1(trial);
    the_image_2 = Die_2(trial);
    subplot(1,2,1);
    current_image1 = imshow(images{1,the_image_1},colors{1,the_image_1},'InitialMagnification','fit');
    axis off;
    subplot(1,2,2);
    current_image2 = imshow(images{1,the_image_2},colors{1,the_image_2},'InitialMagnification','fit');
    axis off;
    drawnow;
    pause;
    what_was_pressed = get(tb,'CurrentCharacter');
    Responses(trial,3) = toc;
    Responses(trial,2) = what_was_pressed;
    Responses(trial,1) = vec_vec(trial)+1;
    if Responses(trial,1) == 1 && Responses(trial,2) == 49 % Correct rejection - 4
        Responses(trial,4) = 4;
    elseif Responses(trial,1) == 2 && Responses(trial,2) == 50 % HIT = Correct positive - 1
        Responses(trial,4) = 1;
    elseif Responses(trial,1) == 2 && Responses(trial,2) == 49 % Miss - 2
        Responses(trial,4) = 2;
    elseif Responses(trial,1) == 1 && Responses(trial,2) == 50 % False positive - 3
        Responses(trial,4) = 3;
    end
 clf(tb);
end

% closing the trial:
close(tb);

%%

%%%%%%%%%%%%%%%%%%%%%%%% which number stands for each kind of response %%%%%%%%%%%%%%%%%%%%%%%%

% 1 = HIT = Correct positive
% 2 = Miss
% 3 = False positive
% 4 = Correct negative (correct rejection)

%%

save('Responses', 'Responses');
