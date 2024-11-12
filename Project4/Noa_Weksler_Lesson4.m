

% Homework - Lesson 4


%%


% Targil1

load carsmall.mat; 
% loading the dataset example.
for i = 1:size(Model,1)
% using the size of "Model", because it most mention a value (which is
% actually a name), and has no NAs, otherwise- there is nothing to elaborate about. 
% so the size of it reflects the size of all other fields.
    Carsmall(i).Acceleration = Acceleration(i);
    Carsmall(i).Cylinders = Cylinders(i);
    Carsmall(i).Displacement = Displacement(i);
    Carsmall(i).Horsepower = Horsepower(i);
    Carsmall(i).MPG = MPG(i);
    Carsmall(i).Mfg = Mfg(i,:);
    Carsmall(i).Model = Model(i,:);
    Carsmall(i).Model_Year = Model_Year(i);
    Carsmall(i).Origin = Origin(i,:);
    Carsmall(i).Weight = Weight(i);
end
% Arranging the data set in a structure with 10 fields, by using a "for" loop 



%%


% Targil2

horsepower_bigger_than_200_model_names = best_horsepower(Carsmall);
% applying the function named best_horsepower, that i created in a different script
% the function receives the previous structure that was created, 
% and finds all the models with horse power bigger than 200 and return their names.



%%


% Targil3

figure();
for i = 1:size(horsepower_bigger_than_200_model_names,1)
    text(0.1,(1-i/10),horsepower_bigger_than_200_model_names(i,:),'FontSize',16, 'Color','r');
end
axis off;
% after calling the function, i displayed the results on a figure 
% using the text command, inside an "if" loop.



