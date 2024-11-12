
function [common_num,common_num_index_vec_1,common_num_index_vec_2] = My_Intersect_Noa_Weksler(input_vec_1,input_vec_2)

%%%%% to apply this function, you have to know few things: %%%%%

%%% 1 %%% 
% the function most receive two independent vectors of any 
% length as input (they don't have to be in the same length).

%%% 2 %%% 
% the function creats 3 outputs: 
%1% a vector of numbers in common to both input vectors (with no repeats).
%2% a vector with index values for the common numbers in the first input vector. 
%3% a vector with index values for the common numbers in the second input vector.

%%% 3 %%% 
% if you'll give the function an option for only one output it'll give
% back the first output on the list. if you'll give an option for two- it'll
% give the first two outputs from the list above. if you would like to get
% the three listed outputs, you'll have to ask for three. 

%%% how should you do it? here's an example:
% vec_1 = [2,5,6,4,7,8,98,4,5,4,55,45,65,85,74,85,62,22,36,63,65,41,1,3,5,8,9,4,5,5,65,75,8];
% vec_2 = [1,4,5,7,9,3,6,5,8,52,1,4,80,26,55,36,14,56,87,22,41,1,3,8,7,6,5,95,45,12,25,85,75,1,5,3,5,4];
% [common, index_1, index_2] = My_Intersect_Noa_Weksler(vec_1,vec_2);

%%

% the length of vec 1:
input_vec_1_ed = [input_vec_1, 'e'];
length_vec_1 = 0;
i1 = 1;
while i1 ~= 0
    if input_vec_1_ed(i1) == 'e'
        i1 = 0;
    else
        i1 = i1+1;
        length_vec_1 = length_vec_1+1;
    end
end

% the length of vec 2:
input_vec_2_ed = [input_vec_2, 'e'];
length_vec_2 = 0;
i2 = 1;
while i2 ~= 0
    if input_vec_2_ed(i2) == 'e'
        i2 = 0;
    else
        i2 = i2+1;
        length_vec_2 = length_vec_2+1;
    end
end

% i had to calculate the length of both vectors in order to use it in the loops afterwards.
% in order to calculate the length of both vectors (that was inserted),
% i first added the letter 'e' (that stands for 'end'), to the end of each vector.
% then, i created a while loop that continues running, until it hits the letter 'e', and stops.
% the loop is able to count the number of time it runs. the number of time it ran, stands for 
% the number of values that are in the vector, without counting the letter 'e'.
% the solution (with the letter 'e' in the end) works, because as instructed- 
% the input vectors are composed from numerical values only, so there is no way the loop 
% will "bump" with the letter 'e' before the vector had really come to an end.

%%

% making vec 1 with no repeats: 
vec_1_no_repeats = input_vec_1;
length_vec_1_no_repeats = length_vec_1;
for k1 = length_vec_1:-1:1
    temp_val_1 = input_vec_1(k1);
    count1 = 0;
    for k2 = 1:length_vec_1_no_repeats
        if vec_1_no_repeats(k2) == temp_val_1
            count1 = count1+1;
        end
    end
    if count1 ~= 1
        vec_1_no_repeats(k1) = [];
        length_vec_1_no_repeats = length_vec_1_no_repeats-1;
    end
end

% making vec 2 with no repeats: 
vec_2_no_repeats = input_vec_2;
length_vec_2_no_repeats = length_vec_2;
for k3 = length_vec_2:-1:1
    temp_val_2 = input_vec_2(k3);
    count2 = 0;
    for k4 = 1:length_vec_2_no_repeats
        if vec_2_no_repeats(k4) == temp_val_2
            count2 = count2+1;
        end
    end
    if count2 ~= 1
        vec_2_no_repeats(k3) = [];
        length_vec_2_no_repeats = length_vec_2_no_repeats-1;
    end
end

% we were asked for no repeats in the common numbers vector we creat. 
% (although it is possibble that a number will repeat several times in a vector).
% so, i had a dilema: wheather to compare values, and then cut the repeats,
% or to cut repeats from each vector, and then to compare the no repeats vectors.
% i decided to go with the second option, so i had to find a way 
% for each number to appear only once in each vector.
% i designed a loop inside a loop, that in a way- compares the vector to itself.
% if a value appeared more than once, one appearence was deleted, until all
% the values appeared only once. this loop also creates a variable for the
% length of the new "no repeats vector".

%%

% creating common numbers vec:
common_num = vec_1_no_repeats;
length_common_num_vec = length_vec_1_no_repeats;
for i = length_vec_1_no_repeats:-1:1
    temp_val = vec_1_no_repeats(i);
    count = 0;
    for j = 1:length_vec_2_no_repeats
        if vec_2_no_repeats(j) == temp_val
            count = count+1;
        end
    end
    if count ~= 1
        common_num(i) = [];
        length_common_num_vec = length_common_num_vec-1;
    end
end

% i created a vector contains the common numbers for both vectors, that will 
% be shown as an output, by using a similar method to the one i used to create the 
% "no repeat vectors", but in the current case, i compared the first vector 
% (without repeats), to the second vector (without repeats), and not a vector to itself. 

%%

% creating index vector of common numbers for vec 1:
common_num_index_vec_1 = [];
for j1 = 1:length_common_num_vec
    for j2 = 1:length_vec_1
        if common_num(j1) == input_vec_1(j2)
            common_num_index_vec_1 = [common_num_index_vec_1,j2];
        end
    end
end

% creating index vector of common numbers for vec 2:
common_num_index_vec_2 = [];
for j3 = 1:length_common_num_vec
    for j4 = 1:length_vec_2
        if common_num(j3) == input_vec_2(j4)
            common_num_index_vec_2 = [common_num_index_vec_2,j4];
        end
    end
end

% i created a vector of the indexes of each common value for each vector,
% both of them will be given as outputs of this function.
% i did it by creating a loop inside a loop, that finds each time a number
% from the common vector, appears in the input vector. each time it happens,
% the index is added to a vector that contains all the indexes. the loop
% has the index because the index of a number in the original input vector,
% is equale to the number of times the inner loop ran until it "bumped" with
% the specific value (j2/j4).

end