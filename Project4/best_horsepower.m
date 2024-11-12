
function horsepower_bigger_than_200_model_names = best_horsepower(input_carsmall)

for i = 1:size(input_carsmall,2)
    if (input_carsmall(i).('Horsepower'))>200
        bigger_than_200(i) = true;
    else
        bigger_than_200(i) = false;
    end 
end
% creating a vector that recieves true/false values as ones/zeros. 
% this vector will detrmine which indexes are relevent to be presented 
% and by that- will help us to present only car models that have horsepower bigger than 200.
temp = cell2mat({input_carsmall(:).Model}');
% transffering the data from a strust to cell array, and to a matrix, 
% so it will be easier to use, and extract the data.
horsepower_bigger_than_200_model_names = temp(bigger_than_200,:);
end

% creating a function named best_horsepower:
% the function is suppose to receive a structure that was created, 
% and to find all the car models in the structer with 
% horse power bigger than 200 and return their names.
