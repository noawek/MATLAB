
% Homework - Lesson 2

%%

% Targil1
mat1= rand(10,10);
% building a 2 dimensional matrix (that gets randomal values between 0-1),
% with 10 values in the 1st and 2nd dimensions. 

% Targil2
extracted_value_mat1= mat1(3,9);
% Extracting the value in the 3rd row, and 9th column of mat1.

% Targil3
vec1= mean(mat1);
% Using the mean function to create a vector, 
% which contains the means across all rows of mat1.
% as long as we're using the function to find the mean of the first dimension,
% it is not obligating to write what dimension do we want to calculate for. 
% so, it's the same as writing: "mean(mat1,1)".

% Targil4
mat1_squared= mat1.^2;
% Creating a new matrix, which contains the squared values of mat1.
% we have to use the dot (.) to tell the computer to multiply 
% two values in the same absolute spot.

% Targil5
SQRT_mat1_squared= sqrt(mat1_squared);
% Using the sqrt function to compute the square root of mat1_squared.
% we're getting a matrix identical to mat1 as answer.

% Targil6
save homework2;
% Using the save command to save all of the matrices created in a file 
% If filename has no extension (that is, no period followed by text), 
% and the value of format is not specified, then MATLAB appends .mat
% that way, the file is saved by the name asked: homework2.mat 

%%

% Targil8
load("homework2.mat");
% loading the saved file from the current folder

% Targil9
mat2= rand(10,10);
% creating a second matrix 10X10

% Targil10
mat1_vec= mat1(:);
mat2_vec= mat2(:);
% reshaping both matrices to vectors, so it can be used in the scatter plot.
figure;
scatter([1:100],mat1_vec,20,'r','filled');
hold on;
scatter([1:100],mat2_vec,30,'b','filled','hexagram');
title(['mat1 VS mat2']);
xlabel('absolute index of values');
ylabel('the values');
legend('mat1 values','mat2 values');
hold off;
% creating the scatter plot as asked, 
% and using them to compare mat1 and mat2.
% i compared the matrices's values according to their absolute locations. 

