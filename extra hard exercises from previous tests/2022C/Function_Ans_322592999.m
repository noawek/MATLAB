

function [EEG_mat] = Function_Ans_322592999(EEG, elect_num_var, var_string)

% var_string = 'Left';
% elect_num_var = 55;

% creating the terms for ERP:
time_needed_before_stimulus_ms = 200;
time_needed_after_stimulus_ms = 500;
from_ms_to_s = 1000;
srate = 250;

% the "srate" is measured as trials per second, but the times are given in
% milliseconds. thus, we want to have the time in seconds, so it can be used
% later to find the number of trials in a time frame. so, in order to devided
% it by "srate" i had to turn the units to seconds (by deviding it in 1000).
time_needed_before_stimulus_s = time_needed_before_stimulus_ms/from_ms_to_s;
time_needed_after_stimulus_s = time_needed_after_stimulus_ms/from_ms_to_s;
trials_in_500_ms = round(time_needed_after_stimulus_s*srate);
trials_in_200_ms = round(time_needed_before_stimulus_s*srate);
% intervalls_between_each_stimuli_in_ms = round(from_ms_to_s/srate);


% checking if the stimulus was in the left/right visual field:

side_choose = [];
if strcmp(var_string,'Right')
    side_choose = 2;
elseif strcmp(var_string,'Left')
    side_choose = 1;
end

number_of_events = length(EEG.stimuli);

left_events = [];
left_count = 0;
if side_choose == 1
for i = 1:number_of_events
    if EEG.stimuli(i) == side_choose  % Stimulus was in left visual field
        left_count = left_count+1;
        left_events(left_count,1) = EEG.data(elect_num_var,i);
        left_events(left_count,2) = i;
    end
end
end

right_events = [];
right_count = 0;
if side_choose == 2
for i = 1:number_of_events
    if EEG.stimuli(i) == side_choose  % Stimulus was in right visual field
        right_count = right_count+1;
        right_events(right_count,1) = EEG.data(elect_num_var,i);
        right_events(right_count,2) = i;
    end
end
end


events1 = [];
if right_count ~= 0 
    events1 = right_events;
elseif left_count ~= 0
    events1 = left_events;
end


% Cut the stimuli into segments according to stimulus presentation:

EEG_mat = [];
for i = 1:length(events1)
    the_trial = events1(i,2);
    EEG_mat(i,:) = EEG.data(elect_num_var,the_trial-trials_in_200_ms:the_trial+trials_in_500_ms); % Extract segments 200ms before and 500ms after stimulus onset
end



end