function [r, l_vals]=features_analysis(input, target, history, n_features)
%Selecting only n_features to give as input to the fuzzy system 
%Find the indexes of the first n_features selected by seqfs() 
fs_redux = find(history.In(n_features,:)' == 1);

%Group (all) feature values according to the target position = {1,2,3,..}
pY = cell(4,1);
pX = cell(4,1);

for k=1:4
    %Values for each position for all the features
    pY{k,1} = input(find( vec2ind(target') == k),:);
    %Number of values for each position for each feature 
    pX{k,1} = 1:numel(pY{k,1}(:,1));
end

   [features_intervals, x_values]  = compute_mf_intervals(input);
   
for i=1:n_features
   %Plot values distribution (histogram) for each feature
   subplot(2,n_features,i), hist(input(:,fs_redux(i))' )
   title(strcat('feature #', num2str(i)))
   
   start=0;
   for j=1:4    
        app = pX{j,1} + start;
        subplot(2,n_features,4+i),
        %Plot values distribution for each position for each feature
        plot( app , pY{j,1}(:,fs_redux(i))' )
        hold on
        start = start + numel(pX{j,1});  
   end
   
    title(strcat('feature #', num2str(i)));
    legend('pos1','pos2','pos3','pos4')
    
    for j=1:4    
        %Plot membership functions intervals
        plot(x_values,features_intervals{i,1},'k--')
    end
end
    
%Computing ranges of definition for each feature
r = zeros(n_features, 2);
for i=1:n_features
   r(i,1) = min(input(:, fs_redux(i)));
   r(i,2) = max(input(:, fs_redux(i)));
end

%Computing min,max for each position for each feature
l_vals = cell(2,1);

for i=1:n_features
   for j=1:4
      l_vals{1,1}(i,j) = min( pY{j,1}(:,fs_redux(i)) );
      l_vals{2,1}(i,j) = max( pY{j,1}(:,fs_redux(i)) );
   end
end

