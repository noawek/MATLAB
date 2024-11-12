

load("Responses.mat");

correct_answer = [];
wrong_answer = [];
for i = 1:size(Responses,1)
    if Responses(i,4) == 1
        correct_answer = [correct_answer , Responses(i,1)];
    elseif Responses(i,4) == 0
        wrong_answer = [wrong_answer , Responses(i,1)];
    end
end

mean_right = mean(correct_answer);
mean_wrong = mean(wrong_answer);
sd_right = std(correct_answer);
sd_wrong = std(wrong_answer);
mean_s = [mean_wrong, mean_right];
sd_s = [sd_wrong, sd_right];

figure('Units','normalized','Position',[0.2,0.2,0.2,0.5]);
scatter(ones(size(wrong_answer,2),1),wrong_answer, 'r');
hold on;
scatter(ones(size(correct_answer,2),1)*2,correct_answer, 'g');
hold on;
scatter([1,2],mean_s, 'k', 'filled');
errorbar(mean_s,sd_s, 'k', 'LineStyle', 'none');
xlim([0 3]);
xticks([1,2]);
xticklabels({'Wrong Answers','Right Answers'})
ylabel('time (s)');
xlabel('wrong/right answer');
title({['Reaction time. Total mean =' num2str(mean(mean_s)) 's']})



