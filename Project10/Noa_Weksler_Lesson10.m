


% Homework - Lesson 10



%%


% Targil1 


%%% (A) %%%

% Load the EEG data:
load 'EEG_Data.mat';

% inserting electrodes as instructed (4 from each side of the occipital lobe): 
electrodes_left = [25,22,21,26];
electrodes_right = [62,63,58,59];

% a vector including them all:
all_electrodes = [electrodes_left,electrodes_right]; 

% creating the terms for ERP:
time_needed_before_stimulus_ms = 200;
time_needed_after_stimulus_ms = 600;
from_ms_to_s = 1000;
% the "srate" is measured as trials per second, but the times are given in
% milliseconds. thus, we want to have the time in seconds, so it can be used
% later to find the number of trials in a time frame. so, in order to devided 
% it by "srate" i had to turn the units to seconds (by deviding it in 1000).
time_needed_before_stimulus_s = time_needed_before_stimulus_ms/from_ms_to_s;
time_needed_after_stimulus_s = time_needed_after_stimulus_ms/from_ms_to_s;
trials_in_600_ms = round(time_needed_after_stimulus_s*EEG.srate);
trials_in_200_ms = round(time_needed_before_stimulus_s*EEG.srate);
intervalls_between_each_stimuli_in_ms = round(from_ms_to_s/EEG.srate);

% Extract the timing (EEG.event.latency) of events where stimulus was in the left visual field:
number_of_events = length(EEG.event);
left_events = [];
left_count = 0;
for i = 1:number_of_events
    if EEG.event(i).type == 2   % Stimulus was in left visual field
        left_count = left_count+1;
        left_events(left_count) = round(EEG.event(i).latency);
    end
end

% Cut the stimuli into segments according to stimulus presentation:
left_stimulus = [];
for i = 1:length(left_events)
    timestamp = left_events(i);
    for j = 1:length(all_electrodes)
    left_stimulus(i,:,j) = EEG.data(all_electrodes(j),timestamp-trials_in_200_ms:timestamp+trials_in_600_ms);   % Extract segments 200ms before and 600ms after stimulus onset
    end
end

% creating a matrix for all 8 electrodes ERP's:
ERP = squeeze(mean(left_stimulus));


%%% (B) %%%

% Normalizing the responses by using the avarage of the pre-stimulus interval 
% (the avarage of the responses from the first 200ms in the ERP i created 
% [before the stimulus appeared]) as baseline (different baseline for each electrode):
norm_ERP = [];
for i = 1:length(all_electrodes)
    prestim = squeeze(mean(ERP(1:trials_in_200_ms,i),1));
    norm_ERP(:,i) = ERP(:,i)-prestim;
end

% seperating the data according to the side it came from:
ERP_left_electrodes = norm_ERP(:,1:length(electrodes_left));
ERP_right_electrodes = norm_ERP(:,1+length(electrodes_left):length(electrodes_left)+length(electrodes_right)); 
% the +1 is there, so an electrode won't be included twice.
xtics = -time_needed_before_stimulus_ms:intervalls_between_each_stimuli_in_ms:time_needed_after_stimulus_ms;
% set numbers on x axis to fit the time in msec. the intervalls were calculated in advance.

% showing the normalized ERP's of the electrodes from each side visually:
figure('Units','normalized','position',[0 0 1 1]);
subplot(1,2,1);
plot(xtics,ERP_left_electrodes');
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('Left stimulus (left electrodes)');
for i = 1:length(electrodes_left)
    legend_left(i) = {['electrode number ' num2str(electrodes_left(i))]};
end
legend(legend_left);
subplot(1,2,2);
plot(xtics,ERP_right_electrodes');
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('Left stimulus (right electrodes)');
for i = 1:length(electrodes_right)
    legend_right(i) = {['electrode number ' num2str(electrodes_right(i))]};
end
legend(legend_right);
linkaxes([subplot(1, 2, 1), subplot(1, 2, 2)], 'y');
% i linked the y axes so we can compare better between the two sides.
sgtitle({'ERPs of 8 electrodes from the occipital lobe'; '(4 from the left side, and 4 from the right side),'; 'in response to a stimulus presented in the left visual field'});



%%


% Targil2

% calculating the avarage ERP for each 4 electrodes (right and left seperatly):
avg_ERP_left = squeeze(mean(ERP_left_electrodes,2));
avg_ERP_right = squeeze(mean(ERP_right_electrodes,2));

% showing the normalized ERP's of the electrodes from each side + the avarage one, visually:
figure('Units','normalized','position',[0 0 1 1]);
% already created xtics to set numbers on x axis to fit the time in msec.
subplot(1,2,1);
% creating shades of blue (i used the function "uisetcolor()" to find shades): 
blue_colors_map = [0.3412 0.3412 0.9804
    0.3020 0.7451 0.9333
    0 0 1
    0.3294 0.6431 1];
for i = 1:size(ERP_left_electrodes,2)
    plot(xtics, ERP_left_electrodes(:,i)', color = [blue_colors_map(i,:)]);
    hold on;
end
%%% there's a way to do it complitly random, and not manual, and
%%% compatibale for even more electrodes if nessecery. but, i asked Shahar
%%% in class and she said that we need to create a color map of our own (by
%%% actually writing it down manually), and espacially because the loop i 
%%% suggust here in the comment below, gives shades of blue for instance, 
%%% but it can also look purplish/pinkish... the loop:
% for i = 1:size(ERP_left_electrodes,2)
%    plot(xtics,ERP_left_electrodes(:,i)',color = [rand(1),rand(1),1]);
%    hold on;
% end
plot(xtics, avg_ERP_left, color = [0, 0, 0.4], LineWidth = 2); % using dark blue
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('Left stimulus (left electrodes)');
for i = 1:length(electrodes_left)
    legend_left1(i) = {['electrode number ' num2str(electrodes_left(i))]};
end
legend_left1(i+1) = {'avg ERP of left electrodes'};
legend(legend_left1);
subplot(1,2,2);
% creating shades of red (i used the function "uisetcolor()" to find shades): 
red_colors_map = [0.9686 0.3725 0.2824
    0.9294 0.5216 0.5216
    1 0 0
    0.7882 0.3216 0.1490];
for i = 1:size(ERP_right_electrodes,2)
    plot(xtics, ERP_right_electrodes(:,i)', color = [red_colors_map(i,:)]);
    hold on;
end
%%% there's a way to do it complitly random, and not manual, and
%%% compatibale for even more electrodes if nessecery. but, i asked Shahar
%%% in class and she said that we need to create a color map of our own (by
%%% actually writing it down manually), and espacially because the loop i 
%%% suggust here in the comment below, gives shades of red for instance, 
%%% but it can also look yellowish/pinkish... the loop:
% for i = 1:size(ERP_right_electrodes,2)
%     plot(xtics, ERP_right_electrodes(:,i)', color = [1,rand(1),rand(1)]);
%     hold on;
% end
plot(xtics, avg_ERP_right, color = [0.5, 0, 0], LineWidth = 2); % using dark red
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('Left stimulus (right electrodes)');
for i = 1:length(electrodes_right)
    legend_right1(i) = {['electrode number ' num2str(electrodes_right(i))]};
end
legend_right1(i+1) = {'avg ERP of right electrodes'};
legend(legend_right1);
linkaxes([subplot(1, 2, 1), subplot(1, 2, 2)], 'y');
% i linked the y axes so we can compare better between the two sides.
sgtitle({'ERPs of 8 electrodes from the occipital lobe'; '(4 from the left side in blue shades, and 4 from the right side in red shades),'; 'in response to a stimulus presented in the left visual field'; 'the avarage ERP is mentioned for each side as well (the thick lines)'});



%%


% Targil3

% the new range, to find the p100s:
beggining_of_range_ms = 90;
end_of_range_ms = 120;
beggining_of_range = trials_in_200_ms+1+round(beggining_of_range_ms/from_ms_to_s*EEG.srate);
end_of_range = trials_in_200_ms+1+round(end_of_range_ms/from_ms_to_s*EEG.srate);
% the beginning of the range is 90ms from when the stimuli was presented.
% that is why it is nessecery to add the trials until the stimuli + the
% trial where the stimuli was presented (+1), to the value calculated for the
% number of trials passed from when the stimuli was presented, in order to
% find the range in segments (trials) of the ERP.

% finding the p100s values, and their indexes:
p100_left = max(avg_ERP_left(beggining_of_range:end_of_range));
p100_x1 = find(avg_ERP_left == p100_left);
p100_right = max(avg_ERP_right(beggining_of_range:end_of_range));
p100_x2 = find(avg_ERP_right == p100_right);

% already created xtics to set numbers on x axis to fit the time in msec.
figure('Units','normalized','position',[0 0 1 1]);
plot(xtics, avg_ERP_left, color = [0, 0, 0.4], LineWidth = 2);
hold on;
plot(xtics, avg_ERP_right, color = [0.5, 0, 0], LineWidth = 2);
% i have to adjust the indexes of the p100, to the xtics i created, so that 
% the * would be in their right places in the x axis (in addition to the y value):
plot((p100_x1-(trials_in_200_ms+1))*intervalls_between_each_stimuli_in_ms, p100_left, '*', color = 'm', MarkerSize = 14);
plot((p100_x2-(trials_in_200_ms+1))*intervalls_between_each_stimuli_in_ms, p100_right, '*', color = 'g', MarkerSize = 14);
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title({['\fontsize{30} avarage ERPs of both sides, and the p100 of each']; ['\fontsize{20} the ratio between the rights p100 and the lefts p100 is: ' num2str(p100_right/p100_left)]; ['\fontsize{12} the ratio is negetive because the p100 of the left electrodes is negetive while for the right is positive']; ['(just as expected, because the stimuli appeared in the left visual field)']; ...
    ['']; ['\fontsize{10} anyways, the absulote ratio is: ' num2str(abs(p100_right/p100_left)) ',']; ['the opposite ratio (p100 left/p100 right), is: ' num2str(p100_left/p100_right) ',']; ['and the absolute opposite ratio is: ' num2str(abs(p100_left/p100_right))]});
% i hope it's ok i elaborated that much.. i didn't really understand what
% did you mean by "ratio", so i gave all options.
legend('avg ERP of left electrodes', 'avg ERP of right electrodes', 'p100 left', 'p100 right');


  
%%


% Targil4

% Since in this work we referred to the stimulus presented in the 
% left visual field, the expectation was that the right electrodes would 
% show a stronger response (than the left), due to brain crossover. 
% You can see this very clearly in the graphs produced in questions 2 and 3:

%%%% • In graph 2, all the ERPs of all the electrodes appear separately from each other,
% when the right ones appear together in the same subplot, as do the left ones. 
% Already here, we see a trend that reflects a sharper increase in brain activity after 
% the presentation of the stimulus on the right side of the brain (around p100).

%%%% • In addition, graphs 2 and 3 show the average ERPs for each 4 electrodes of a certain side. 
% This averaging allows us to look at the brain activity in the right/left occipital lobe 
% (separately), and compare the general activity on both sides as a response to the stimulus 
% presented in the left visual field. Here too, we see that there is a higher electrical (brain) 
% activity on the right side of the brain (as expected) at the time after the presentation of 
% the stimulus on the left. Furthermore, at the time when a reaction begins on the right side, 
% we also see a decrease in the electrical activity of the left side.

%%%% • Furthermore, graph 3 also shows the p100 values for each side of the occipital lobe, 
% which are actually the maximum values found in the range in which a brain response 
% (change in electrical activity) usually occurs, as a response to a certain stimulus. 
% Even in these values, you can clearly see a difference in the different p100 values 
% that each side has. The maximum value for the right side is relatively high and positive 
% (8.7135), while the maximum value for the left side in this range is even negative (-3.0934), 
% which really demonstrates how much higher the activity of the right side is (as expected).


