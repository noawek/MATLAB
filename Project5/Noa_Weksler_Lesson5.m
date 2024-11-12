

% Homework - Lesson 5


%%


% Targil1

% loading the dataset example:
load cities.mat; 
% creating a figure of all cities data:
figure(1);
plot(ratings);
title 'Cities Data';
xlim([0 size(names,1)]);
xlabel('Cities');
ylabel('Ratings');
legend(categories);


%%


% Targil2

% creating a vector that recieves true/false values as ones/zeros.
% this vector will detrmine which indexes are relevent to be presented,  
% and by that- will help us to present all the categories, while omitting 
% "arts", in the figure.
for i = 1:size(categories,1)
    if strfind(categories(i,:),'arts')
        no_arts_vec(i) = false;
    else
        no_arts_vec(i) = true;
    end 
end 
% creating a figure includding all cities categories, 
% but omitting "arts" category.
figure(2);
plot(ratings(:,no_arts_vec));
title 'Cities Data';
xlim([0 size(names,1)]);
xlabel('Cities');
ylabel('Ratings');
legend(categories(no_arts_vec,:));


%%%% an answer:
% We deleted specifically the "arts" category, because it has much higher ratings,
% and by adding "arts" data to the plot, it makes the scale of the plot 
% more than 2 times bigger than when we build a plot without this data.
% omitting the "arts" category from our plot, gives us a bigger resolution of the plot.


%%


% Targil3

% creating a vector that recieves true/false values as ones/zeros. 
% this vector will detrmine which indexes are relevent to be presented,  
% and by that- will help us to present ratings only for the "education" category afterwards.
for i = 1:size(categories,1)
    if strfind(categories(i,:),'education')
        education_vec(i) = true;
    else
        education_vec(i) = false;
    end 
end
% finding the index of the maximum value in education:
[best_education,category_ed] = find(ratings == max(ratings(:,education_vec)));
% creating a figure in a good size:
figure('Units','normalized','Position',[0.2,0.2,0.6,0.6]);
% using the index of the city to create a bar plot with all of it's ratings:
bar(ratings(best_education,:));
title (names(best_education,:));
ylabel('Ratings');
xticklabels(categories);
xlabel('categories');


%%


% Targil4

% creating a vector that recieves true/false values as ones/zeros. 
% this vector will detrmine which indexes are relevent to be presented,  
% and by that- will help us to present ratings only for the "economics" category afterwards.
for i = 1:size(categories,1)
    if strfind(categories(i,:),'economics')
        economics_vec(i) = true;
    else
        economics_vec(i) = false;
    end 
end
% finding the index of the maximum value in economics:
[best_economics,category_ec] = find(ratings == max(ratings(:,economics_vec)));
% creating a vector that recieves true/false values as ones/zeros. 
% this vector will detrmine which indexes are relevent to be presented,  
% and by that- will help us to present ratings only for the "health" category afterwards.
for i = 1:size(categories,1)
    if strfind(categories(i,:),'health')
        health_vec(i) = true;
    else
        health_vec(i) = false;
    end 
end
% finding the index of the maximum value in health:
[best_health,category_he] = find(ratings == max(ratings(:,health_vec)));
% creating a figure in a good size:
figure('Units','normalized','Position',[0.2,0.2,0.6,0.6]);
% using the indexes of the cities to create a bar plot with all of their ratings:
bar([ratings(best_education,:) ; ratings(best_economics,:) ; ratings(best_health,:)]');
% i created a matrix inside the "bar" function, and then flipping it.
title 'Leading cities';
ylabel('Ratings');
xticklabels(categories);
xlabel('categories');
legend(names([best_education best_economics best_health],:));


%%


% Targil5

% creating 2 vectors in the same length: 
% one gets values of standart deviation of the ratings in each category (by thier order), 
% and the second gets the means of each category as values.
[std_ratings,means_ratings] = std(ratings);
% displaying a bigger figure, so that all the data will appear proparlly:
figure('Units','normalized','Position',[0.2,0.2,0.6,0.6]);
hold on;
% creating an error bar acorrding to this data:
errorbar(2:size(categories,1)+1, means_ratings, std_ratings, LineStyle="none", Marker="+");
xlim([1 size(categories,1)+2]);
% adding a scatter plot, that will show the ratings of the 
% 3 cities from before in each category:
scatter(2:size(categories,1)+1 , [ratings(best_education,:) ; ratings(best_economics,:) ; ratings(best_health,:)]','*');
ylabel('Ratings');
xticks(2:size(categories,1)+1);
xticklabels(categories);
xlabel('categories');
legend ('mean', names(best_education,:), names(best_economics,:), names(best_health,:));
title 'error bar of ratings in the categories + the ratings of the chosen 3 cities in each category';
hold off;


%%


% Targil6

%%%%%% with 100
% creating a vector with 100 random numbers as instructed:
rand_vector = 2*randn(1,100)+10;
% creating a figure that compares histograms with different numbers of bins:
figure('Units','normalized','Position',[0.2,0.2,0.6,0.6]);
hold on;
% creating a histogram of the results (with the defult number of bins):
subplot(2,2,1);
histogram(rand_vector);
title 'a histogram with the difult number of bins';
xlabel('values');
ylabel('how many values are in this range');
yl10= ylim;
xl10= xlim;
% creating a histogram with more bins:
subplot(2,2,2);
histogram(rand_vector,30);
title 'a histogram with larger number of bins';
xlabel('values');
ylabel('how many values are in this range');
yl20= ylim;
xl20= xlim;
% it is also possible to use the function: morebins(h), but in this case 
% it won't be that effective, because it increases the number of bins in 
% histogram h by 10%, which means that in this case only ~1 bin will be 
% added to the defult number of bins, and the number of bins
% wouldn't be that much bigger than before.
%%%% but, it is also possible to calculate the ultimate number of bins 
% for building a histogram on a specific dataset
% there are few different formulas for this calculation, i chose this optain:
% calculating the ultimate number of bins for the histogram:
k= round(abs(sqrt(size(rand_vector,2))));
% creating a histogram of the results with the ultimate number of bins:
subplot(2,2,3:4);
histogram(rand_vector,k);
title 'the histogram with the best number of bins';
xlabel('values');
ylabel('how many values are in this range');
yl30= ylim;
xl30= xlim;
% Finding the max limits to set them for all histograms:
y1max = max([yl10(2), yl20(2), yl30(2)]);
x1max = max([xl10(2), xl20(2), xl30(2)]);
% Set all to be the same:
subplot(2,2,1);
ylim([0, y1max]);
xlim([0, x1max]);
subplot(2,2,2);
ylim([0, y1max]);
xlim([0, x1max]);
subplot(2,2,3:4);
ylim([0, y1max]);
xlim([0, x1max]);
sgtitle({['a comparison between different histograms of the distribution of ' num2str(size(rand_vector,2)) ' values'];['derived from a normal distribution with avarage=10 & sd=2']});
hold off;


%%%%%% with 10,000
% creating a vector with 10000 random numbers as instructed:
rand_vector2 = 2*randn(1,10000)+10;
% creating a figure that compares histograms with different numbers of bins:
figure('Units','normalized','Position',[0.2,0.2,0.6,0.6]);
hold on;
% creating a histogram of the results (with the defult number of bins):
subplot(2,2,1);
histogram(rand_vector2);
title 'a histogram with the difult number of bins';
xlabel('values');
ylabel('how many values are in this range');
yl1= ylim;
xl1= xlim;
% creating a histogram with more bins:
subplot(2,2,2);
h=histogram(rand_vector2);
title 'a histogram with larger number of bins (using the morebins function)';
xlabel('values');
ylabel('how many values are in this range');
morebins(h);
yl2= ylim;
xl2= xlim;
% now we can use this function because it is much more usefull on this scale 
% of numbers (it increases the number of bins in histogram h by 10%, 
% and the defult bin number that we are starting with in this case is much 
% bigger than when we built a histogram of a vector with 100 values only)
% with 10,000 values, the defult bin number to start with is bigger, 
% so when we will use the function: "morebins", it would really add an amount 
% of bins that will make the number of bins bigger enough for comparison.
% but, of course we can use the second method aswell:
subplot(2,2,3);
histogram(rand_vector2, 120);
title 'a histogram with larger number of bins (manualy)';
xlabel('values');
ylabel('how many values are in this range');
yl3= ylim;
xl3= xlim;
%%%% here as well, we can calculate the ultimate number of bins 
% for building a histogram on a specific dataset:
% calculating the ultimate number of bins for the histogram:
k2= round(abs(sqrt(size(rand_vector2,2))));
% creating a histogram of the results with the ultimate number of bins:
subplot(2,2,4);
histogram(rand_vector2, k2);
title 'the histogram with the best number of bins';
xlabel('values');
ylabel('how many values are in this range');
yl4= ylim;
xl4= xlim;
% Finding the max limits to set them for all histograms:
ymax = max([yl1(2), yl2(2), yl3(2), yl4(2)]);
xmax = max([xl1(2), xl2(2), xl3(2), xl4(2)]);
% Set all to be the same:
subplot(2,2,1);
ylim([0, ymax]);
xlim([0, xmax]);
subplot(2,2,2);
ylim([0, ymax]);
xlim([0, xmax]);
subplot(2,2,3);
ylim([0, ymax]);
xlim([0, xmax]);
subplot(2,2,4);
ylim([0, ymax]);
xlim([0, xmax]);
sgtitle({['a comparison between different histograms of the distribution of ' num2str(size(rand_vector2,2)) ' values'];['derived from a normal distribution with avarage=10 & sd=2']});
hold off;


%%%%%% an answer:
% in my opinion, it is best to use a formula to calculate the ultimate number
% of bins for a specific dataset. this way, we can creat a histogram adjusted 
% to our dataset (with the ultimate number of bins according to our data), 
% so the histogram would really demonstrate the general shape of the distribution 
% of vector's values, and that will allow us to conclude from it.



