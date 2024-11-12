

% Homework - Lesson 7


%% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% loading the face images %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% loading images and colormaps into structures, by using a loop:
for i = 1:length(dir('*.bmp'))
    [images{1,i},colors{1,i}] = imread(['face' num2str(i) '.bmp'],'bmp');
end


imshow('face3.bmp')
%% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% preperations for the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% setting the number of trials for this experiment:
number_of_trials = 30;

% creating a vector of NaNs that will get values from the loop later:
twoback = NaN(1,number_of_trials);

% calculating 20% from 30 trials (as was instructed):
num_of_two_back = number_of_trials/100*20;

% creating a vector with 30 random values in the range 1-8 (like the number 
% of images we've loaded to matlab), but which has 20% of the time a "two back" repeat.
% this vector will be used later to display the images randomly, according to their 
% numbers, but in the right way for a "two-back" face-detection experiment:

% the loops for finding the right vector: 
while sum(twoback) ~= num_of_two_back
for i = 1:number_of_trials
    the_right_vector(i) = randi(8,1,1);
    if i == 1  
        twoback(i) = 0;
    elseif i == 2
        twoback(i) = 0;
    elseif the_right_vector(i) == the_right_vector(i-2)
        twoback(i) = 1;
    else
        twoback(i) = 0;
    end 
end
end % now we have the right vector in our workspace.



%% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% creating the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% creating a figure for the trial:
tb = figure('Toolbar','none','Menubar','none','NumberTitle','off',...
    'Units','normalized','position',[0 0 1 1],'Color',[1 1 1]);

% display some text on the figure, that instruct how to start, and do the experiment:
figure_text_headline = text(0.2,0.8,'This is a "two-back" face-detection experiment', 'FontSize', 20, 'FontWeight', 'bold');
figure_text_instructions = text(0.2,0.5,{'In this experiment, you will be presented with 30 images of faces.' ,...
    'You will have to use 2 different keys from your keyboard, according to the following instructions:',...
    '',...
    'If the face is similar to the face which was presented 2 trials back - press the key "S",',...
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
two_back_results = NaN(number_of_trials,3);
for trial = 1:number_of_trials
    tic;
    axis off;
    the_image = the_right_vector(trial);
    current_image = imshow(images{1,the_image},colors{1,the_image},'InitialMagnification','fit');
    axis off;
    drawnow;
    pause;
    what_was_pressed = get(tb,'CurrentCharacter');
    two_back_results(trial,1) = toc;
    two_back_results(trial,2) = what_was_pressed;
    if trial == 1 && two_back_results(trial,2) == 108       % Correct negative
        two_back_results(trial,3) = 1;
    elseif trial == 2 && two_back_results(trial,2) == 108      % Correct negative
        two_back_results(trial,3) = 1;
    elseif trial == 1 && two_back_results(trial,2) == 115       % False positive
        two_back_results(trial,3) = 4;
    elseif trial == 2 && two_back_results(trial,2) == 115       % False positive
        two_back_results(trial,3) = 4;
    elseif the_right_vector(trial) ~= the_right_vector(trial-2) && two_back_results(trial,2) == 108      % Correct negative
        two_back_results(trial,3) = 1;
    elseif the_right_vector(trial) == the_right_vector(trial-2) && two_back_results(trial,2) == 115       % HIT = Correct positive
        two_back_results(trial,3) = 2;
    elseif the_right_vector(trial) == the_right_vector(trial-2) && two_back_results(trial,2) == 108      % Miss
        two_back_results(trial,3) = 3;
    elseif the_right_vector(trial) ~= the_right_vector(trial-2) && two_back_results(trial,2) == 115      % False positive
        two_back_results(trial,3) = 4; 
    end
    clf(tb);
end

% closing the trial:
close(tb);



%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%% which number stands for each kind of response %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 1 = Correct negative (correct rejection)
% 2 = HIT = Correct positive
% 3 = Miss
% 4 = False positive
   


%% 


%%%%%%%%%%%%%%%%%%%%%%%%% showing and analyzing the results of the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% preparing and organizing the data for analysis:
sum_results = [sum(two_back_results(:,3)==1),sum(two_back_results(:,3)==2),sum(two_back_results(:,3)==3),sum(two_back_results(:,3)==4)];
meaning_of_each_number = [{'correct rejection'}, {'HIT'}, {'Miss'}, {'False positive'}];
sun_cor_or_not = [sum(sum_results(1:2)),sum(sum_results(3:4))];
meaning_of_each_number2 = [{'correct answers'},{'wrong answers'}];

% responses and accuracy analysis:
figure('Units','normalized','position',[0 0 1 1]);
subplot(1,3,1);
bar(sum_results);
xticklabels(meaning_of_each_number);
ylabel('how many times a response type happened');
xlabel('response type');
title('Number of reponses from each type');
subplot(1,3,2);
bar(sun_cor_or_not);
xticklabels(meaning_of_each_number2);
ylabel('how many times the subject had correct/wrong answers');
xlabel('correct/wrong answers');
title('Number of times the subject was correct VS wrong');
subplot(1,3,3);
pie(sun_cor_or_not);
legend(meaning_of_each_number2,'location','northeastoutside');
title('Percentage of accuracy');
sgtitle('Responses and Accuracy Analysis','FontSize',20,'Color','red');
hold off;

% reaction time analysis:
figure('Units','normalized','position',[0 0 1 1]);
subplot(1,3,1);
histogram(two_back_results(:,1),0:0.3:(max(two_back_results(:,1)+1)));
% if we want to see the results really clear, it would be better to use
% more bins, because time gaps between each and every trial are small. 
% in other cases, it might be better to use: 
% k= round(abs(sqrt(size(two_back_results,1))));
ylabel('how many trial took this time (+-)');
xlabel('time (seconds)');
title('Reaction Time Distribution');
subplot(1,3,2);
HITS = two_back_results(:,3)==2;
cor_rej = two_back_results(:,3)==1;
bar([mean(two_back_results(HITS,1)),mean(two_back_results(cor_rej,1))]);
xticklabels(meaning_of_each_number(1:2));
xlabel('type of correct response');
ylabel('time mean for a certian type (seconds)');
title('Mean of Reaction Time (when the subject answered correctly)');
subplot(1,3,3);
bar(two_back_results(:,1));
ylabel('how much time until the subject pressend on the specific trial (seconds)');
xlabel('trial number');
title('"Improvment" graph (time for each trial, by their order)');
sgtitle('Reaction Time Analysis','FontSize',20,'Color','red');
hold off;


