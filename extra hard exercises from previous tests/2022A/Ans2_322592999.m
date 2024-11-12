
clear;
clc;

load("Responses001.mat");


%%


% 1 = HIT = Correct positive
% 2 = Miss
% 3 = False positive
% 4 = Correct negative (correct rejection)


%%%%%%%%%%%%%%%%%%%% showing and analyzing the results of the experiment %%%%%%%%%%%%%%%%%%%%%%

% preparing and organizing the data for analysis:

sum_results1 = [sum(Responses001(:,4,1)==1),sum(Responses001(:,4,1)==2),sum(Responses001(:,4,1)==3),sum(Responses001(:,4,1)==4)];
sum_results2 = [sum(Responses001(:,4,2)==1),sum(Responses001(:,4,2)==2),sum(Responses001(:,4,2)==3),sum(Responses001(:,4,2)==4)];




sum_cor_or_not1 = [sum(sum_results1([1 , 4])),sum(sum_results1(2:3))];
sum_cor_or_not2 = [sum(sum_results2([1 , 4])),sum(sum_results2(2:3))];

Accuracy1 = sum_cor_or_not1(1)/size(Responses001,1)*100;
Accuracy2 = sum_cor_or_not2(1)/size(Responses001,1)*100;

meaning_of_each_number = [{'First try'},{'Second try'}];
Accuracy_all = [Accuracy1, Accuracy2];

% responses and accuracy analysis:
figure('Toolbar','none','Menubar','none','NumberTitle','off',...
 'Units','normalized','position',[0.2 0.2 0.6 0.6],'Color',[1 1 1]);

% figure('Units','normalized','position',[0 0 1 1]);
subplot(1,2,1);
times_mean = squeeze(mean(Responses001(:,3,:)))';
times_std = squeeze(std(Responses001(:,3,:)))';
bar(times_mean, 'g');
hold on;
errorbar(times_mean, times_std, 'k', 'LineStyle', 'none');
box off;
xticklabels(meaning_of_each_number);
ylabel('Time (s)');
xlabel('Attempt');
title('Response time','FontSize',14);
subplot(1,2,2);
bar(Accuracy_all, 'c');
box off;
xticklabels(meaning_of_each_number);
ylabel('Accuracy %');
xlabel('Attempt');
title('Accuracy','FontSize',14);
sgtitle('Hamilton','FontSize',20,'Color','black');
hold off;

