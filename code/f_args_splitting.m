function [Xtrain, Ttrain, Xtest, Ttest] = f_args_splitting( XT, test_size)

%splitting TRAIN and TESTING SETS
testrows = fix( (rand(test_size,1))*numel( XT(:,1)) +1 );
num_cols = numel(XT(1,:));
XTtest = zeros(test_size, num_cols);
XTtest = XT(testrows,:);
XT(testrows,:) = [];

%returning training sets for INPUT SET and TESTING SET
Xtrain = XT(:,1:num_cols-4);
Ttrain = XT(:,num_cols-3:num_cols);

%returning testing set for INPUT SET and TESTING SET
Xtest = XTtest(:,1:num_cols-4);
Ttest = XTtest(:,num_cols-3:num_cols);
end
