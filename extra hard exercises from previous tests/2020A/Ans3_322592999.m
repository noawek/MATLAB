


load("EEG_data.mat");

load("Stim.mat");

load("Electrodes.mat");



%% targil1


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
intervalls_between_each_stimuli_in_ms = round(from_ms_to_s/srate);


% Cut the stimuli into segments according to stimulus presentation:

EEG_stimulus = [];
for i = 1:length(Stim)
    for j = 1:length(Electrodes)
        EEG_stimulus(i,:,j) = EEG_data(j,Stim(i)-trials_in_200_ms:Stim(i)+trials_in_500_ms); % Extract segments 200ms before and 500ms after stimulus onset
    end
end

norm_EEG = [];
for i = 1:length(Electrodes)
    prestim = squeeze(mean(mean(EEG_stimulus(:,1:trials_in_200_ms,i),2)));
    norm_EEG(:,:,i) = EEG_stimulus(:,:,i)-prestim;
end


%% targil2

% new_elec = cell2(Electrodes);
% ind_elec = [contains(Electrodes, 'F4'), find(Electrodes == 'C4'), find(Electrodes == 'P4'), find(Electrodes == 'O2')];

F4 = 40;
C4 = 50;
P4 = 58;
O2 = 64;

ind_elect = [F4, C4, P4, O2];


% creating a matrix for all 8 electrodes ERP's:

ERP = squeeze(mean(norm_EEG(:,:,ind_elect)));



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

p100_elect = [];
p100_x1 = [];
latency_p100 = [];

for i = 1:length(ind_elect)
    p100_elect(i) = max(ERP(beggining_of_range:end_of_range,i));
    p100_x1(i) = find(ERP(:,i) == p100_elect(i));
    latency_p100(i) = (p100_x1(i)-(trials_in_200_ms+1))*intervalls_between_each_stimuli_in_ms;
end





%% targil3


xtics = [-200:intervalls_between_each_stimuli_in_ms:500];
figure('Units','normalized','position',[0.2 0.2 0.6 0.6]);


subplot(2,2,1);
plot(xtics, ERP(:,1), color = [0, 0, 0.4], LineWidth = 2);
hold on;
plot(latency_p100(1),p100_elect(1), '*',color = 'g', MarkerSize = 14);
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('electrode F4');

subplot(2,2,2);
plot(xtics, ERP(:,2), color = [0, 0, 0.4], LineWidth = 2);
hold on;
plot(latency_p100(2),p100_elect(2), '*',color = 'g', MarkerSize = 14);
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('electrode C4');

subplot(2,2,3);
plot(xtics, ERP(:,3), color = [0, 0, 0.4], LineWidth = 2);
hold on;
plot(latency_p100(3),p100_elect(3), '*',color = 'g', MarkerSize = 14);
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('electrode P4');

subplot(2,2,4);
plot(xtics, ERP(:,4), color = [0, 0, 0.4], LineWidth = 2);
hold on;
plot(latency_p100(4),p100_elect(4), '*',color = 'g', MarkerSize = 14);
ylabel('Amplitude (uV)');
xlabel('Time (ms)');
title('electrode O2');

sgtitle('ERPs of the 4 electrodes, with the p100 marked:')


%% targil4


F4_amplitude = norm_EEG(:,p100_x1(1),F4);

O2_amplitude = norm_EEG(:,p100_x1(4),O2);



%% targil5


%%% t-test %%%
% preforming t-test for un-paired samples (independent), although the number of
% samples in both conditions is similar, because we want to compare
% between two different electrodes, and that is why their results are independent:
[h1,p1,ci1,stats1] = ttest2(F4_amplitude,O2_amplitude);
% h1_8 = hypothesis (1 = accepting H1 , 0 = not rejecting H0)
% p1_8 = p-value (if less than 0.05, the result of the test is significant)
% ci1_8 = confidence interval (if 0 is in this interval, we're not rejecting H0)
% stats1_8 = statistics (t-value, degrees of freedom, etc.)


figure('Units','normalized','position',[0.2 0.2 0.6 0.6]);
histogram(F4_amplitude, 'FaceColor', 'c');
hold on;
histogram(O2_amplitude,'FaceColor', 'm');
legend('electrode F4' ,'electrode O2');
title({['comparing p100s of elctrodes F4 & O2 in all trials. in ttest, the p_v_a_l = ' num2str(p1)]});
xlabel('the value');
ylabel('how many like this value');


















