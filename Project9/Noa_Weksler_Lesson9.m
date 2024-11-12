


% Homework - Lesson 9 



%% (bonus assignment)
%%


% Targil1 


% Load the data:

load 'HWRunnerTable.mat';



%%


% Targil2


% creating a matrix with the running times from mornings 2&3, of group 1:

RUNCOMP = RunnerTable(:,2:3,1);



%%


% Targil3


% creating a seperate vector with morning 2 running times, so it'll be easier to work with them:

morning_2 = RUNCOMP(:,1);


% finding the mean of running times in morning 2:

morning_2_mean = mean(morning_2);


% finding the standart deviation of running times in morning 2:

morning_2_std = std(morning_2);



%%% (1) %%%

group1 = find(morning_2 >= morning_2_mean+1.5*morning_2_std);

%%% (2) %%%

group2 = find(morning_2 <= morning_2_mean-1.5*morning_2_std);



%%


% Targil4


% creating a seperate vector with morning 3 running times, so it'll be easier to work with them:

morning_3 = RUNCOMP(:,2);


% finding the mean of running times in morning 3:

morning_3_mean = mean(morning_3);


% finding the standart deviation of running times in morning 3:

morning_3_std = std(morning_3);



%%% (1) %%%

group3 = find(morning_3 >= morning_3_mean+1.5*morning_3_std);

%%% (2) %%%

group4 = find(morning_3 <= morning_3_mean-1.5*morning_3_std);



%%


% Targil5


% creating a figure: 

figure('Units','normalized','position',[0 0 1 1]);


% group1 = purple

purple = [.5 .5 1];


% group2 = pink

pink = [1 .5 .5];


% group3 = green

green = 'g';


% group4 = blue

blue = 'b';


%%% the content: %%%

subplot(2,2,1);
histogram(morning_2(group1),8,'FaceColor',purple);
hold on;
histogram(morning_3(group3),8,'FaceColor',green);
title({['\fontsize{10} group1 VS group3'];['comparison between groups that are radical in the ' ...
    'same way'];['(1.5 SD above the mean of their day), but from 2 different days']});
legend('group 1','group 3');
xlabel('Running Time (min)');
ylabel('number of subjects');

subplot(2,2,2);
histogram(morning_2(group2),8,'FaceColor',pink);
hold on;
histogram(morning_3(group4),8,'FaceColor',blue);
title({['\fontsize{10} group2 VS group4'];['comparison between groups that are radical in the ' ...
    'same way'];['(1.5 SD under mean of their day), but from 2 different days']});
legend('group 2','group 4');
xlabel('Running Time (min)');
ylabel('number of subjects');

subplot(2,2,3);
histogram(morning_2(group1),8,'FaceColor',purple);
hold on;
histogram(morning_2(group2),8,'FaceColor',pink);
title({['\fontsize{10} group1 VS group2'];['comparison between 2 oppositly-radical groups from the same day']});
legend('group 1','group 2');
xlabel('Running Time (min)');
ylabel('number of subjects');

subplot(2,2,4);
histogram(morning_3(group3),8,'FaceColor',green);
hold on;
histogram(morning_3(group4),8,'FaceColor',blue);
title({['\fontsize{10} group3 VS group4'];['comparison between 2 oppositly-radical groups from the same day']});
legend('group 3','group 4');
xlabel('Running Time (min)');
ylabel('number of subjects');

sgtitle({['\fontsize{18} 4 different comparisons between groups 1-4 running times:']; ...
    ['\fontsize{10} \color[rgb]{' num2str(purple) '} group1 = people that are 1.5 SD above the avarge running time of day 2']; ...
    ['\color[rgb]{' num2str(pink) '} group2 = people that are 1.5 SD under the avarge running time of day 2']; ...
    ['\color{green} group3 = people that are 1.5 SD above the avarge running time of day 3']; ...
    ['\color{blue} group4 = people that are 1.5 SD under the avarge running time of day 3']});



%%


% Targil6


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% t-test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% preforming t-test for paired samples (dependent), because there's a similar number of
% subjects in both conditions, and because we want to compare within
% subject in different days (in the same group, the 100 people are the same):

[h1,p1,ci1,stats1] = ttest(morning_2,morning_3);

% h1 = hypothesis (1 = accepting H1 , 0 = not rejecting H0)
% p1 = p-value (if less than 0.05, the result of the test is significant)
% ci1 = confidence interval (if 0 is in this interval, we're not rejecting H0)
% stats1 = statistics (t-value, degrees of freedom, etc.)


%%% the result of the test is significant %%%
%%% which make sence, because we expect to see a change in a person's running times %%%
%%% due to using the suplements %%%



%%


% Targil7


% duplicating the vector with morning 2 running times, so it'll be easier to work with it:

morning_2_new = morning_2;

% removing running times of groups 1-4 i created, from morning 2:

morning_2_new([group1', group2', group3', group4']) = [];


% duplicating the vector with morning 3 running times, so it'll be easier to work with it:

morning_3_new = morning_3;


% removing running times of groups 1-4 i created, from morning 3:

morning_3_new([group1', group2', group3', group4']) = []; 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% t-test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% preforming t-test for paired samples (dependent), because there's a similar number of
% subjects in both conditions, and because we want to compare within
% subject in different days. it is important to note that even after removing
% particullar subjects as asked, the people that were left in a group, are the same:

[h2,p2,ci2,stats2] = ttest(morning_2_new,morning_3_new);

% h2 = hypothesis (1 = accepting H1 , 0 = not rejecting H0)
% p2 = p-value (if less than 0.05, the result of the test is significant)
% ci2 = confidence interval (if 0 is in this interval, we're not rejecting H0)
% stats2 = statistics (t-value, degrees of freedom, etc.)


%%% the result of the test is significant %%% 
%%% altough the removel of radical subjects %%%
%%% we still see a significant change in a person's running times %%%
%%% which means that the differencess and the significant result we've seen in exercise 6 %%%
%%% are caused by using the suplements, and not due to variances between runners %%% 
%%% or radical changes within specific runnurs %%%



%%


% Targil8


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% creating a matrix with the running times from morning 2 of group 1, and morning 3, of group 3:

RUNCOMP_8 = [RunnerTable(:,2,1), RunnerTable(:,3,3)];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (3) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% i decided to calculate ir all over again 
% (although i have the data from the original exercise 2), 
% just for the aesthetics:


% creating a seperate vector with morning 2 running times, so it'll be easier to work with them:

morning_2_8 = RUNCOMP_8(:,1);


% finding the mean of running times in morning 2:

morning_2_mean_8 = mean(morning_2_8);


% finding the standart deviation of running times in morning 2:

morning_2_std_8 = std(morning_2_8);



%%% (1) %%%

group1_8 = find(morning_2_8 >= morning_2_mean_8+1.5*morning_2_std_8);

%%% (2) %%%

group2_8 = find(morning_2_8 <= morning_2_mean_8-1.5*morning_2_std_8);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (4) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% creating a seperate vector with morning 3 running times, so it'll be easier to work with them:

morning_3_8 = RUNCOMP_8(:,2);


% finding the mean of running times in morning 3:

morning_3_mean_8 = mean(morning_3_8);


% finding the standart deviation of running times in morning 3:

morning_3_std_8 = std(morning_3_8);



%%% (1) %%%

group3_8 = find(morning_3_8 >= morning_3_mean_8+1.5*morning_3_std_8);

%%% (2) %%%

group4_8 = find(morning_3_8 <= morning_3_mean_8-1.5*morning_3_std_8);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (5) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% creating a figure: 

figure('Units','normalized','position',[0 0 1 1]);


%%% using the existing colors: %%%

% group1_8 = purple

% group2_8 = pink

% group3_8 = green

% group4_8 = blue


%%% the content: %%%

subplot(2,2,1);
histogram(morning_2_8(group1_8),8,'FaceColor',purple);
hold on;
histogram(morning_3_8(group3_8),8,'FaceColor',green);
title({['\fontsize{10} group1 VS group3'];['comparison between groups that are radical in the ' ...
    'same way'];['(1.5 SD above the mean of their day), but from 2 different experimental groups, in 2 different days']});
legend('group 1','group 3');
xlabel('Running Time (min)');
ylabel('number of subjects');

subplot(2,2,2);
histogram(morning_2_8(group2_8),8,'FaceColor',pink);
hold on;
histogram(morning_3_8(group4_8),8,'FaceColor',blue);
title({['\fontsize{10} group2 VS group4'];['comparison between groups that are radical in the ' ...
    'same way'];['(1.5 SD under mean of their day), but from 2 different experimental groups, in 2 different days']});
legend('group 2','group 4');
xlabel('Running Time (min)');
ylabel('number of subjects');

subplot(2,2,3);
histogram(morning_2_8(group1_8),8,'FaceColor',purple);
hold on;
histogram(morning_2_8(group2_8),8,'FaceColor',pink);
title({['\fontsize{10} group1 VS group2'];['comparison between 2 oppositly-radical groups from the same day(2) and the same experimental group(1)']});
legend('group 1','group 2');
xlabel('Running Time (min)');
ylabel('number of subjects');

subplot(2,2,4);
histogram(morning_3_8(group3_8),8,'FaceColor',green);
hold on;
histogram(morning_3_8(group4_8),8,'FaceColor',blue);
title({['\fontsize{10} group3 VS group4'];['comparison between 2 oppositly-radical groups from the same day(3) and the same experimental group(3)']});
legend('group 3','group 4');
xlabel('Running Time (min)');
ylabel('number of subjects');

sgtitle({['\fontsize{18} 4 different comparisons between groups 1-4 running times:']; ...
    ['\fontsize{14} in this exercise (8), it is no longer the same experimental group in different days, but different experimental groups in different days']
    ['\fontsize{10} \color[rgb]{' num2str(purple) '} group1 = people from experimental group 1, that are 1.5 SD above the avarge running time of day 2']; ...
    ['\color[rgb]{' num2str(pink) '} group2 = people from experimental group 1, that are 1.5 SD under the avarge running time of day 2']; ...
    ['\color{green} group3 = people from experimental group 3, that are 1.5 SD above the avarge running time of day 3']; ...
    ['\color{blue} group4 = people from experimental group 3, that are 1.5 SD under the avarge running time of day 3']});




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (6) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% t-test %%%

% preforming t-test for un-paired samples (independent), although the number of
% subjects in both conditions is similar, because we want to compare
% between subjucts from two different experimental groups (1&3), which means that 
% they are not the same people, and that is why their results are independent:

[h1_8,p1_8,ci1_8,stats1_8] = ttest2(morning_2_8,morning_3_8);

% h1_8 = hypothesis (1 = accepting H1 , 0 = not rejecting H0)
% p1_8 = p-value (if less than 0.05, the result of the test is significant)
% ci1_8 = confidence interval (if 0 is in this interval, we're not rejecting H0)
% stats1_8 = statistics (t-value, degrees of freedom, etc.)


%%% the result of the test is significant %%%
%%% which make sence, for 2 reasons: %%%
%%% 1) due to the fact we compared between different experimental groups, %%%
     % that used different suplements (as long as the suplements really had different effects) %%%
%%% 2) but if the suplement didn't really have an effect, another possible explenation %%%
     % is that because as someone parctices, we expect to see a change in his running times %%%
     % althogh we're comparing people from 2 different experimental groups, %%%
     % we check their result after an uneven amount of days %%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% (7) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% duplicating the vector with morning 2 running times, so it'll be easier to work with it:

morning_2_new_8 = morning_2_8;


% removing running times of groups 1-4 i created, from morning 2:

morning_2_new_8([group1_8', group2_8', group3_8', group4_8']) = [];


% duplicating the vector with morning 3 running times, so it'll be easier to work with it:

morning_3_new_8 = morning_3_8;


% removing running times of groups 1-4 i created, from morning 3:

morning_3_new_8([group1_8', group2_8', group3_8', group4_8']) = []; 



%%% t-test %%%

% preforming t-test for un-paired samples (independent), although the number of subjects 
% in both conditions is similar (because we removed the same number of subjects from each 
% experimental group), because we want to compare between subjucts from two different experimental 
% groups (1&3), which means that they are not the same people, and that is why their results are independent:

[h2_8,p2_8,ci2_8,stats2_8] = ttest2(morning_2_new_8,morning_3_new_8);

% h2_8 = hypothesis (1 = accepting H1 , 0 = not rejecting H0)
% p2_8 = p-value (if less than 0.05, the result of the test is significant)
% ci2_8 = confidence interval (if 0 is in this interval, we're not rejecting H0)
% stats2_8 = statistics (t-value, degrees of freedom, etc.)


%%% the result of the test is significant %%% 
%%% altough the removel of radical subjects %%%
%%% we still see a significant change in the avarage running times %%%
%%% between experimental groups, and in different days %%%
%%% which means that the differencess and the significant result we've seen in exercise 8_6 %%%
%%% are caused by using the suplements/the day gap between the measurements, %%% 
%%% and not due to variances between runners or radical changes within specific runnurs %%%



%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% an answer for exercise 8: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% we do see some changes in results. 
% although result are significant each time, the question is why.
% we can see in the graphs that as expected- the bottom graphs trend wasn't
% really changed (because we compare 2 oppositly-radical groups from the
% same experimental group. but, we can see that the low running times in
% the original graph of group3 VS group4 are way lower than in the
% comparison showen in exercise 8.
% another thing we can see is that the original graphs: group1 VS group3 & 
% group2 VS group4, is that we see an improvent in the running times in day 3
% while in the same graphs in exercise 8, it is not just that there's no
% improvement, but there's also deterioration, so maybe the suplement of
% experimental group 3 wasn't good for running skills (although they had
% the advantage of one day ahead wuth their trainings, they still weren't better).
% with that said- it seems like the suplement given to experimental group
% 1, had a good influance on running skills, while the suplement that was given 
% to experimental group 3, didn't have a good influance on running skills.





