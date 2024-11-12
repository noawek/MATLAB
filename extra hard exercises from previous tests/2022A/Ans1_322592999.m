

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% loading the face images %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% loading images and colormaps into structures, by using a loop:

for i1 = 1:7
 [Real_images{1,i1},Real_colors{1,i1}] = imread(['Real' num2str(i1) '.jpg'],'jpg');
 [Play_images{1,i1},Play_colors{1,i1}] = imread(['Play' num2str(i1) '.jpg'],'jpg');

end

% imshow('Play3.jpg')


%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% preperations for the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% setting the number of trials for this experiment:
number_of_trials = 20;

% creating a vector of NaNs that will get values from the loop later:
experiment_vec = NaN(1,number_of_trials);

% calculating 30% from 20 trials (as was instructed):
num_of_match = number_of_trials/100*30;


% creating a vector with 20 random values in the range 1-7 (like the number
% of images we've loaded to matlab), but which has 30% of the time matched pictures.
% this vector will be used later to display the images randomly, according to their
% numbers, but in the right way for the detection in our experiment:
% the loops for finding the right vector:

while sum(experiment_vec) ~= num_of_match
    for i = 1:number_of_trials
        the_right_vector_real(i) = randi(7,1,1);
        the_right_vector_play(i) = randi(7,1,1);
        if the_right_vector_real(i) == the_right_vector_play(i)
            experiment_vec(i) = 1;
        else
            experiment_vec(i) = 0;
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

figure_text_headline = text(0.2,0.8,'This is an experiment about Hamilton (the musical)','FontSize', 20, 'FontWeight', 'bold');
figure_text_instructions = text(0.2,0.5,{'this experoment includes 20 trials. in each trial, 2 pictures will presented to you.' , ...
    'In the right picture, there is a photo of an actor that plays a certain character in the musical.' ...
    'In the left picture there is an historical portrate of the real person that is played in the musical.',...
    'you are asked to detect each time the person in the portrate appears with the actor playing him in the musical,'...
    'according to the following instructions:',...
    '',...
    'If it is the same character - press the key "S",',...
    'otherwise - press the key "L".', ...
    '',...
    'The letters here are written in CAPS (the same way they appear on your keyboard),',...
    'so you`ll be able recognize them more easily.',...
    '',...
    'BUT - please notice that you are required to use English *small* letters only!',...
    '(when conducting the experiment), meaning: "s" / "l".',...
    '',...
    'To start the experiment, press any button.'}, 'FontSize', 16);
axis off;


% wait for button press and then start timing:

waitforbuttonpress;


% deleting the texts that are no longer required:

delete(figure_text_headline);

delete(figure_text_instructions);


% starting the trial:

Hamilton_results = NaN(number_of_trials,4);

for trial = 1:number_of_trials
    tic;
    axis off;
    subplot(1,2,1);
    the_image_Real = the_right_vector_real(trial);
    current_image_Real = imshow(Real_images{1,the_image_Real},Real_colors{1,the_image_Real},'InitialMagnification','fit');
    axis off;
    subplot(1,2,2);
    the_image_Play = the_right_vector_play(trial);
    current_image_Play = imshow(Play_images{1,the_image_Play},Play_colors{1,the_image_Play},'InitialMagnification','fit');
    axis off;
    drawnow;
    pause;
    what_was_pressed = get(tb,'CurrentCharacter');
    Hamilton_results(trial,3) = toc;
    Hamilton_results(trial,2) = what_was_pressed;
    if the_image_Real == the_image_Play
        Hamilton_results(trial,1) = 1;
    else
        Hamilton_results(trial,1) = 0;
    end
    if Hamilton_results(trial,1) == 0 && Hamilton_results(trial,2) == 108 % Correct negative
        Hamilton_results(trial,4) = 1;
    elseif Hamilton_results(trial,1) == 1 && Hamilton_results(trial,2) == 115 % HIT = Correct positive
        Hamilton_results(trial,4) = 1;
    elseif Hamilton_results(trial,1) == 1 && Hamilton_results(trial,2) == 108 % Miss
        Hamilton_results(trial,4) = 0;
    elseif Hamilton_results(trial,1) == 0 && Hamilton_results(trial,2) == 115 % False positive
        Hamilton_results(trial,4) = 0;
    end
 clf(tb);
end

% closing the trial:
close(tb);


%%

%%%%%%%%%%%%%%%%%%%%%%%% which number stands for each kind of response %%%%%%%%%%%%%%%%%%%%%%%%
% 1 = Correct negative (correct rejection)
% 2 = HIT = Correct positive
% 3 = Miss
% 4 = False positive


