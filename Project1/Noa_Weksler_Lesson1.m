
% Homework - Lesson 1

%%

% Targil 1

B= reshape(1:24, [8,3]); 
% reshaping a vector with the values 1:24, to a matrix of 8X3

% (a)
V_a= [B(:,2);B(:,3)];
% creating a sixteen-element column vector 
% that contains the elements of the 2nd and 3rd columns of B
% by adding the entire 3rd column to the 2nd one, vertically (;)

% (b)
V_b= [B(2:5,3);B(8,:)'];
% Creating a seven-element column vector
% that contains elements 2 through 5 of the 3rd column of B 
% and the elements of the last row of B,
% by turning the chosen last row of B to a column (using ')
% and adding it vertically (;) to a chosen part (rows 2-5) of the 3rd column of B 

V_c= [B(2,:)';B(4,:)';B(6,:)'];
% Creating a nine-element column vector 
% that contains the elements of the 2nd, 4th, and 6th rows of B,
% by turning the chosen rows of B to columns (using ')
% and adding them vertically (;) to one another

%%

% Targil 2

M_a= [zeros(2),ones(2,1)];
% adding horizontally (by using ,) a "2X1 ones matrix" 
% to a "2X2 zeros matrix", 
% to create the asked full matrix

M_b= [ones(1,3);eye(3,3)];
% adding vertically (by using ;) a "3X3 eye matrix" 
% (which gives identity matrix with ones on the main diagonal and zeros elsewhere)
% to a "1X3 ones matrix", 
% to create the asked full matrix

M_c= [zeros(5,1),[[zeros(2,1),ones(2)];fliplr(eye(3))]];
% i'll explane this code from the inner brackets to out:
% first, adding horizontally (,) a "2X2 ones matrix" to a "2X1 zeros matrix"
% we will call the matrix we get from it "MAT1" for the explanation.
% then, flipping a "3X3 eye matrix" (by using "fliplr"), 
% so the diagonal would be in the wanted direction,
% and then adding it vertically (;) to "MAT1"
% we will call the matrix we get from it "MAT2" for the explanation.
% and, to create the asked full matrix: 
% adding "MAT2" horizontally (,) to a "5X1 zeros matrix". 


