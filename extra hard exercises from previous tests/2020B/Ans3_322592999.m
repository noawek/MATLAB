

load("EEGdata.mat");
load("RT.mat");


% creating the terms for ERP:

time_needed_before_stimulus_ms = 200;
time_needed_after_stimulus_ms = 500;
srate = 500;
s_to_ms = 1000;

% the "srate" is measured as trials per second, but the times are given in
% milliseconds. thus, we want to have the time in seconds, so it can be used
% later to find the number of trials in a time frame. so, in order to devided
% it by "srate" i had to turn the units to seconds (by deviding it in 1000).

time_needed_before_stimulus_s = time_needed_before_stimulus_ms/s_to_ms;
time_needed_after_stimulus_s = time_needed_after_stimulus_ms/s_to_ms;
trials_in_500_ms = round(time_needed_after_stimulus_s*srate);
trials_in_200_ms = round(time_needed_before_stimulus_s*srate);
intervalls_between_each_stimuli_in_ms = round(s_to_ms/srate);


%% targil1

ERP_all = squeeze(mean(EEGdata,3));


%% targil2

ERP_mean = mean(ERP_all);

xtics = [-200:intervalls_between_each_stimuli_in_ms:498];
figure('Units','normalized','Position',[0,0,1,1]);
plot(xtics, ERP_all');
hold on;
plot(xtics, ERP_mean, 'Color', 'k', 'LineWidth',2);
ylabel('amplitude (uV)');
xlabel('Time (ms)');
title('ERP of all subjects + the avarage ERP');

%% targil3



% the new range, to find the n170s:

beggining_of_range_ms = 110;
end_of_range_ms = 210;

beggining_of_range = trials_in_200_ms+1+round(beggining_of_range_ms/s_to_ms*srate);
end_of_range = trials_in_200_ms+1+round(end_of_range_ms/s_to_ms*srate);


% the beginning of the range is 110ms from when the stimuli was presented.
% that is why it is nessecery to add the trials until the stimuli + the
% trial where the stimuli was presented (+1), to the value calculated for the
% number of trials passed from when the stimuli was presented, in order to
% find the range in segments (trials) of the ERP.
% finding the p100s values, and their indexes:


for i = 1:size(ERP_all,1)
    [n170_all(i),latency(i)] = min(ERP_all((i),beggining_of_range:end_of_range));
    latency1 = (latency*2)+110;
end


%% targil4


n170_mean = mean(n170_all);
n170_sd = std(n170_all);
n170_shgia = n170_sd/sqrt(size(ERP_all,1));
latency_mean = mean(latency1);
latency_sd = std(latency1);
latency_shgia = latency_sd/sqrt(size(ERP_all,1));

figure('Units','normalized','Position',[0,0,1,1]);
subplot(1,2,1);
bar(n170_mean);
hold on;
errorbar(n170_mean,n170_shgia, 'k', 'LineStyle', 'none');
ylabel('amplitude (uV)');
xticklabels('N170');
title('the avarage N170 of all subjects + the standart error');
subplot(1,2,2);
bar(latency_mean)
hold on;
errorbar(latency_mean,latency_shgia, 'k', 'LineStyle', 'none');
xticklabels('N170');
ylabel('Time (ms)');
title('the avarage latency of N170 of all subjects + the standart error');


%% targil5

r = corrcoef(latency1,RT', 'Rows','all');
figure('Units','normalized','Position',[0,0,1,1]);
scatter(latency1,RT);
xlabel('latency of N170 (ms)');
ylabel('Avarage Response Time of a subject (ms)');
title({['the connection between latency of N170 and the avarage response time of a subject. the correlation coefficient =' num2str(r(1,2))]});






























