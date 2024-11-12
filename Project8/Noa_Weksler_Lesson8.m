


function [common_num,common_num_index_vec_1,common_num_index_vec_2] = My_Intersect_Noa_Weksler(input_vec_1,input_vec_2)

input_vec_1 = [2,5,6,4,7,8,98,4,5,4,55,45,65,85,74,85,62,22,36,63,65,41,1,3,5,8,9,4,5,5,65,75,8];
input_vec_2 = [1,4,5,7,9,3,6,5,8,52,1,4,80,26,55,36,14,56,87,22,41,1,3,8,7,6,5,95,45,12,25,85,75,1,5,3,5,4];

% length(input_vec_2);
% length(input_vec_1);

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
end






