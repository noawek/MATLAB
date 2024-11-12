

load("Responses.mat");

RT_rep = [];
RT_bird = [];

for i = 1:size(Responses,1)
    if Responses(i,1) == 1
        RT_rep = [RT_rep, Responses(i,3)];
    elseif Responses(i,1) == 2
        RT_bird = [RT_bird, Responses(i,3)];
    end
end

means_all = [mean(RT_rep), mean(RT_bird)];
sds_all = [std(RT_rep), std(RT_bird)];
% sds_all = [std(RT_rep)/sqrt(size(RT_rep,2)), std(RT_bird)/sqrt(size(RT_bird,2))];

acc_rep = [];
acc_bird = [];

for i = 1:size(Responses,1)
    if Responses(i,1) == 1
        acc_rep = [acc_rep, Responses(i,4)];
    elseif Responses(i,1) == 2
        acc_bird = [acc_bird, Responses(i,4)];
    end
end

accuracies = [sum(acc_rep)/size(acc_rep,2)*100, sum(acc_bird)/size(acc_bird,2)*100];


figure('Units','normalized','position',[0.2 0.2 0.6 0.6]);
subplot(1,2,1);
scatter(ones(size(RT_rep,2),1),RT_rep,'b');
hold on;
scatter(ones(size(RT_bird,2),1)*2,RT_bird,'r');
xlim([0 3]);
xticks([1,2]);
xticklabels({'Reptiles', 'Birds'});
errorbar(means_all, sds_all, 'k', 'LineStyle','none');
ylabel('seconds');
title('Reaction Time');
subplot(1,2,2);
bar(accuracies, 'g');
xticklabels({'Reptiles', 'Birds'});;
ylabel('Percent of correct answers (%)');
title('Accuracy');
















