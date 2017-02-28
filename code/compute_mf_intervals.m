function [features_intervals, x_values]  = compute_mf_intervals(input)
num_elem = numel(input(:,1));
x_values = 1:num_elem;
features_intervals = cell(4,1);
feature = zeros(17,num_elem);
   for i=1:4
       for j=1:4
           if i==1
                if j==1
                   feature(1,:) = 5000;
                elseif j==2
                   feature(2,:) = 7050;
                elseif j==3
                   feature(3,:) = 15000;
                elseif j==4
                   feature(4,:) = 23000;
                end
            features_intervals{1,1} = feature(1:4,:);
            elseif i==2
                if j==1
                   feature(5,:) = 3100;
                elseif j==2
                   feature(6,:) = 7009;
                elseif j==3
                   feature(7,:) = 11370;
                elseif j==4
                   feature(8,:) = 16040;
                end
            features_intervals{2,1} = feature(5:8,:);
            elseif i==3
                if j==1
                   feature(9,:) = 5000;
                elseif j==2
                   feature(10,:) = 8666;
                elseif j==3
                   feature(11,:) = 33800;
                elseif j==4
                   feature(12,:) = 69500;
                end
            features_intervals{3,1} = feature(9:12,:);
           else
                if j==1
                   feature(13,:) = 3000;
                elseif j==2
                   feature(14,:) = 3620;
                elseif j==3
                   feature(15,:) = 5140;
                elseif j==4
                   feature(16,:) = 12600;
                end
          feature(17,:) = 16900;     
          features_intervals{4,1} = feature(13:17,:);
           end
       end
   end
end