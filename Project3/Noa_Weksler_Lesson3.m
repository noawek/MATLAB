
% Homework - Lesson 3

%%

% Targil1
load cities.mat; 
% loading the cities data we used in class.


% Targil2
mean_ratings = mean(ratings,2);
% creating a vector of the means of each city.
[val,ind] = maxk(mean_ratings,2,1);
% finding the two best mean scores with the maxk function (their values and their indexes).
second_best_mean_score= names(ind(2,1),:);
% finding the second value in the index which reflects the second best score
% and by the value there (which reflects the index of the second best score) 
% finding the city name (Chicago, IL)


% Targil3
[B,I]= maxk(ratings,2,1);
two_best_values= B';
two_best_index= I';
second_best_rated= names(two_best_index(:,2),:);
% Finding the 9 cities with the second best score in each categorie 
% by choosing the two best, and then choosing from them the second best (like in targil2).
figure();
for i = 1:size(categories,1)
    text(0.1,(1-i/10),[categories(i,:) ': ' names(two_best_index(i,2),:)],'FontSize',16, 'Color','r');
end
axis off;
% Showing the results in a figure by creating a loop that finds the values indexes, 
% and by that finds the name of the second best city in each catogory in the original table,
% and then creats a nice figure from it (that displays the findings).


% Targil4 
% making a crime vector from the raiting matrix, made histogram of crime rate
crime_scores= ratings(:,4);
% making a crime vector from the raiting matrix
k= round(abs(sqrt(size(crime_scores,1))));
% calculating the ultimate number of bins for the histogram
figure();
hold on;
hist= histogram(crime_scores, NumBins=k);
xlabel('crime scores');
ylabel('number of cities who gave a score in this range');
title('the distribution of crime scores for all US cities');
hold off;
% Creating a figure with the histogram (the distribution) of crime scores for all US cities


% Targil5
percentile_5th= prctile(crime_scores,5);
% computing the 5th precentile of this crime scores distribution.
rated_worse_than_the_5th_percentile=(crime_scores<percentile_5th);
% finding the cities that received scores that are worse than this 5th percentile
% by using logic condition.
number_of_cities_that_are_worse_than_this_5th_percentile=sum(rated_worse_than_the_5th_percentile);
% finding how many cities received scores that are worse than this 5th percentile 
% by computing the number of cities which appear in the vector 
% created in the last step: "rated_worse_than_the_5th_percentile".


