

load EEG.mat;

var_string1 = 'Left';
var_string2 = 'Right';

elect_num_var = 55;

[EEG_mat1] = Function_Ans_322592999(EEG, elect_num_var, var_string1);

[EEG_mat2] = Function_Ans_322592999(EEG, elect_num_var, var_string2);


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
intervalls_between_each_stimuli_in_ms = round(from_ms_to_s/srate);



%% targil2

% creating a matrix for all 8 electrodes ERP's:
ERP1 = squeeze(mean(EEG_mat1));
ERP2 = squeeze(mean(EEG_mat2));


%% targil3

% the new range, to find the p100s:
beggining_of_range_ms = 80;
end_of_range_ms = 120;
beggining_of_range = trials_in_200_ms+1+round(beggining_of_range_ms/from_ms_to_s*srate);
end_of_range = trials_in_200_ms+1+round(end_of_range_ms/from_ms_to_s*srate);

% the beginning of the range is 80ms from when the stimuli was presented.
% that is why it is nessecery to add the trials until the stimuli + the
% trial where the stimuli was presented (+1), to the value calculated for the
% number of trials passed from when the stimuli was presented, in order to
% find the range in segments (trials) of the ERP.
% finding the p100s values, and their indexes:

p100_left = max(ERP1(beggining_of_range:end_of_range));
p100_x1 = find(ERP1 == p100_left);
p100_latency1 = p100_x1*intervalls_between_each_stimuli_in_ms;
p100_right = max(ERP2(beggining_of_range:end_of_range));
p100_x2 = find(ERP2 == p100_right);
p100_latency2 = p100_x2*intervalls_between_each_stimuli_in_ms;

xtics = -time_needed_before_stimulus_ms:intervalls_between_each_stimuli_in_ms:time_needed_after_stimulus_ms;
figure('Units','normalized','position',[0 0 1 1]);
plot(xtics, ERP1, color = [0, 0, 0.4], LineWidth = 2);
hold on;
plot(xtics, ERP2, color = [0.5, 0, 0], LineWidth = 2);
% i have to adjust the indexes of the p100, to the xtics i created, so that
% the * would be in their right places in the x axis (in addition to the y value):
plot((p100_x1-(trials_in_200_ms+1))*intervalls_between_each_stimuli_in_ms, p100_left, '*',color = 'm', MarkerSize = 14);
plot((p100_x2-(trials_in_200_ms+1))*intervalls_between_each_stimuli_in_ms, p100_right, '*',color = 'g', MarkerSize = 14);
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title({['\fontsize{30} avarage ERPs of both sides, and the p100 of each']});
legend('avg ERP of left electrodes', 'avg ERP of right electrodes', 'p100 left', 'p100 right');


%% targil4


p_100_eeg1 = EEG_mat1(:,p100_x1);

p_100_eeg2 = EEG_mat2(:,p100_x2);


% preforming t-test for paired samples (dependent), because there's a similar number of
% trials in both conditions, and because we want to compare within the same
% electrode in different conditions:
[h1,p1,ci1,stats1] = ttest(p_100_eeg1,p_100_eeg2);
% h1 = hypothesis (1 = accepting H1 , 0 = not rejecting H0)
% p1 = p-value (if less than 0.05, the result of the test is significant)
% ci1 = confidence interval (if 0 is in this interval, we're not rejecting H0)
% stats1 = statistics (t-value, degrees of freedom, etc.)
%%% the result of the test is significant %%%
%%% which make sence, because we expect to see a change in a person's running times %%%
%%% due to using the suplements %%%


figure('Units','normalized','position',[0 0 1 1]);
scatter(ones(length(p_100_eeg1),1),p_100_eeg1, 'magenta');
hold on;
scatter(ones(length(p_100_eeg2),1)*2,p_100_eeg2, 'cyan');
xlim([0 3]);
xticks([1 2]);
xticklabels({'left','right'});
xlabel('stimuli side (left/right)');
ylabel('amplitude in one trial (mV)');
legend('left','right');
title({['p100 in each trial by sides of the appearance of the stimuli. p_v_a_l=' num2str(p1) ' t_v_a_l=' num2str(stats1.tstat)]})












