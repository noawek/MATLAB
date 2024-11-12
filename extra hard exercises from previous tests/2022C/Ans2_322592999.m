
load("Responses003.mat");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% t-test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% preforming t-test for paired samples (dependent), because there's a similar number of
% subjects in both conditions, and because we want to compare within
% subject in different days (in the same group, the 100 people are the same):

[h1,p1,ci1,stats1] = ttest(Responses003(:,3,1),Responses003(:,3,4));

% h1 = hypothesis (1 = accepting H1 , 0 = not rejecting H0)
% p1 = p-value (if less than 0.05, the result of the test is significant)
% ci1 = confidence interval (if 0 is in this interval, we're not rejecting H0)
% stats1 = statistics (t-value, degrees of freedom, etc.)

%%% the result of the test is significant %%%
%%% which make sence, because we expect to see a change in a person's running times %%%
%%% due to using the suplements %%%

time_means = [mean(Responses003(:,3,1)), mean(Responses003(:,3,4))];
time_success = [sum(Responses003(:,4,1)==1) + sum(Responses003(:,4,1)==4),sum(Responses003(:,4,2)==1) + sum(Responses003(:,4,2)==4),...
    sum(Responses003(:,4,3)==1) + sum(Responses003(:,4,3)==4),sum(Responses003(:,4,4)==1) + sum(Responses003(:,4,4)==4)];
precent_success = time_success/size(Responses003,1)*100;

figure('Toolbar','none','Menubar','none','NumberTitle','off',...
 'Units','normalized','position',[0.2 0.2 0.6 0.6],'Color',[1 1 1]);
subplot(1,2,1);
bar(time_means, 'FaceColor', 'y', 'EdgeColor', 'g', 'LineWidth', 1.5);
xticklabels({'First', 'Last'});
xlabel('Attempt');
ylabel('Mean Time (s)');
title({['Response Time; p_v_a_l =', num2str(p1)]});
subplot(1,2,2);
plot(precent_success, 'Marker', '*', 'Color', 'r', 'LineStyle', '--')
xticks(1:1:4);
xticklabels({'1', '2', '3', '4'});
xlabel('Attempt');
ylabel('Success %');
title('Task Improvement');
sgtitle('Dice Roll Sum Task');

