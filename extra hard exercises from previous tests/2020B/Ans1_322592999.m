


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% preperations for the experiment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% setting the number of trials for this experiment:

number_of_trials = 40;



% creating a vector of NaNs that will get values from the loop later:

exogen_inco = zeros(1,number_of_trials); % (1)
endogen_inco = zeros(1,number_of_trials); % (2)
exogen_con = zeros(1,number_of_trials); % (3)
endogen_con = zeros(1,number_of_trials); % (4)



% calculating 10 from 40 trials (as was instructed):

kinds_of_conditions = 4;

num_exogen_inco = number_of_trials/4; % (1)
num_endogen_inco = number_of_trials/4; % (2)
num_exogen_con = number_of_trials/4; % (3)
num_endogen_con = number_of_trials/4; % (4)



% creating a vector with 40 random values in the range 1-8 (like the number
% of images we've loaded to matlab), but which has 20% of the time a "two back" repeat.
% this vector will be used later to display the images randomly, according to their
% numbers, but in the right way for a "two-back" face-detection experiment:
% the loops for finding the right vector:

while sum(exogen_inco) ~= num_exogen_inco && sum(exogen_con) ~= num_exogen_con && sum(endogen_inco) ~= num_endogen_inco && sum(endogen_con) ~= num_endogen_con 
for i = 1:number_of_trials
    the_right_vector(i) = randi(4,1,1);
    if the_right_vector(i) == 1
        exogen_inco(i) = 1;
    elseif the_right_vector(i) == 2
        endogen_inco(i) = 1;
    elseif the_right_vector(i) == 3
        exogen_con(i) = 1;
    elseif the_right_vector(i) == 4
        endogen_con(i) = 1;
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
figure_text_headline = text(0.05,0.7,'This is an experiment','FontSize', 25, 'FontWeight', 'bold');
figure_text_instructions = text(0.05,0.5,{'In this experiment, you are asked to type the key "K" when the stimuli appears on the right side,'...
    'and "S" when it appears on the left side' ,...
 ''...
 'To start the experiment, press any button.'}, 'FontSize', 20);
axis off;


% wait for button press and then start timing:
waitforbuttonpress;


% deleting the texts that are no longer required:
delete(figure_text_headline);
delete(figure_text_instructions);


% starting the trial:
Responses = NaN(number_of_trials,4);
for i = 1:number_of_trials
    side_choose = randi(2,1,1);
    x2 = 0.05;
    y1 = 0.5;
    y2 = 0.05;
    yy2 = 0.5;
    if side_choose == 1
        x1 = 0.2;
        xx1 = 0.55;
        xx2 = 0.45;
        s1 = 0.8;
    elseif side_choose == 2
        x1 = 0.8;
        xx1 = 0.45;
        xx2 = 0.55;
        s1 = 0.2;
    end
    if the_right_vector(i) == 1
        Responses(i,2) = 1;
        Responses(i,3) = 1;
        plot1 = annotation('textbox', [x1 y1 x2 y2], 'string', '\ast', 'Color', 'r', 'EdgeColor', 'none');
    elseif the_right_vector(i) == 2
        Responses(i,2) = 0;
        Responses(i,3) = 1;
        plot1 = annotation('textarrow', [xx1 xx2], [y1 yy2], 'Color', 'k');
    elseif the_right_vector(i) == 3
        Responses(i,2) = 1;
        Responses(i,3) = 0;
        plot1 = annotation('textbox', [s1 y1 x2 y2], 'string', '\ast', 'Color', 'r', 'EdgeColor', 'none');
    elseif the_right_vector(i) == 4
        Responses(i,2) = 0;
        Responses(i,3) = 0;
        plot1 = annotation('textarrow', [xx2 xx1], [y1 yy2], 'Color', 'k');
    end
    T = timer('TimerFcn',@(~,~)delete(plot1),'StartDelay',0.5);
    start(T);
    wait(T);
    delete(T);
    tic;
    plot2 = annotation('textbox', [s1 y1 x2 y2], 'string', 'X', 'Color', 'k', 'EdgeColor', 'none');
    axis off;
    drawnow;
    pause;
    what_was_pressed = get(tb,'CurrentCharacter');
    Responses(i,1) = toc;
    Responses(i,4) = what_was_pressed;
    if side_choose == 1 && Responses(i,4) == 107
        Responses(i,4) = 1;
    elseif side_choose == 2 && Responses(i,4) == 115
        Responses(i,4) = 1;
    else
        Responses(i,4) = 0;
    end
    clf(tb);
end

% closing the trial:
close(tb);




