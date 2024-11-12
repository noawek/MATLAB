

load("fMRI_data.mat");

%% targil 1

selected_time = 22;
TR = 2;
the_right_dgima = floor(selected_time/TR);

the_brain = fmri(:,:,the_right_dgima);

figure();
imagesc(the_brain);
colormap gray;

the_brain_copy = the_brain;

figure();
for i = 1:size(voxel_map,1)
    for j = 1:size(voxel_map,2)
        if voxel_map(i,j) == 1
            voxel_map1(i,j,1) = 0;
            voxel_map1(i,j,2) = 1;
            voxel_map1(i,j,3) = 0;
        else
            newval = the_brain_copy(i,j)/max(the_brain_copy(:));
            voxel_map1(i,j,1) = newval;
            voxel_map1(i,j,2) = newval;
            voxel_map1(i,j,3) = newval;
        end
    end
end
imagesc(voxel_map1);


%% targil 2

% copy the voxel map
left_voxel_map = voxel_map;
right_voxel_map = voxel_map;

% put only the voxels that relevant for each side 
left_voxel_map(:,24:46) = 0;
right_voxel_map(:,1:23) = 0;

for i2 = 1:size(voxel_map,1)
    for j2 = 1:size(voxel_map,2)
        if left_voxel_map(i2,j2) == 1
            left_voxel_map1(i2,j2) = the_brain_copy(i2,j2);
        else
            left_voxel_map1(i2,j2) = left_voxel_map(i2,j2);
        end
    end
end

for i3 = 1:size(voxel_map,1)
    for j3 = 1:size(voxel_map,2)
        if right_voxel_map(i3,j3) == 1
            right_voxel_map1(i3,j3) = the_brain_copy(i3,j3);
        else
            right_voxel_map1(i3,j3) = right_voxel_map(i3,j3);
        end
    end
end

% display the voxels of each side in a figure
figure();
subplot(1,2,1);
imagesc(left_voxel_map1);
colormap gray;
title('left voxels');
subplot(1,2,2);
imagesc(right_voxel_map1);
colormap gray;
title('right voxels');

%% targil 3

vec_right_voxels = zeros(size(fmri,3),1);
for k = 1:size(fmri,3)
    count = 0;
for i4 = 1:size(voxel_map,1)
    for j4 = 1:size(voxel_map,2)
        if right_voxel_map(i4,j4) == 1
            temp_ans = fmri(i4,j4,k);
            vec_right_voxels(k,1) = vec_right_voxels(k,1) + temp_ans;
            count = count + 1;
        end
    end
end
vec_right_voxels(k,1) = vec_right_voxels(k,1)/count;
end


vec_left_voxels = zeros(size(fmri,3),1);
for k1 = 1:size(fmri,3)
    count1 = 0;
for i5 = 1:size(voxel_map,1)
    for j5 = 1:size(voxel_map,2)
        if left_voxel_map(i5,j5) == 1
            temp_ans1 = fmri(i5,j5,k1);
            vec_left_voxels(k1,1) = vec_left_voxels(k1,1) + temp_ans1;
            count1 = count1 + 1;
        end
    end
end
vec_left_voxels(k1,1) = vec_left_voxels(k1,1)/count1;
end



norm_right_voxels = mean_right_voxels/mean(mean_right_voxels);



%% i give up!!
%%

% extracting the right voxels
for i=1:size(voxel_map, 1)
    for j=1:size(voxel_map, 2)
        if voxel_map_right(i,j)==1
            mean_right_voxels=squeeze(mean(fmri(i,j,:),1));
        end
    end
end

%extracting the left voxels
for i=1:size(voxel_map, 1)
    for j=1:size(voxel_map, 2)
        if voxel_map_left(i,j)==1
            mean_left_voxels=squeeze(mean(fmri(i,j,:),1));
        end
    end
end

%normelizing
norm_right_voxels = 100*(mean_right_voxels/mean(mean_right_voxels)-1);
norm_left_voxels = 100*(mean_left_voxels/mean(mean_left_voxels)-1);

%display the voxels
figure(4);
title('Voxels right Vs. Voxels left');
plot(norm_right_voxels,'r');
hold on
plot(norm_left_voxels,'g');
legend({'right voxels','left voxels'});
xlabel('Time (TR)');
ylabel('percent signal change (%)');





