%DATA IMPORTING (returning a cell arrays with data for each volunteer)
if(not(exist('DATA','var')))
    DATA = inputs_loading();
end

%DATA MANIPULATION
%
%representing the positions according to min, mean and max values related
%to the sensors in different time intervals (accuracy = # of intervals)
% timeplit = A means splitting the singles sampling in A intervals
%this implies reducing the recognizing times!
% accuracy = B means splitting in B intervals 
if(not(exist('fs_inputs','var')&&exist('fs_targets','var')))
    [fs_inputs, fs_targets] = features_min_mean_max(DATA, 6,6);
end

%DATA SPLITTING (arguments: DATA VALUES and TEST SET SIZE)
%
    %trainingX & trainingT = INPUTS and TARGET for the TRAINING SET (to reduce)
    %testingX & testingT = INPUTS and TARGET for the TESTING SET
%test size ~15%
    test_size = fix(numel(fs_inputs(:,1))*0.15);
    [fs_trainX, fs_trainT, fs_testX, fs_testT] = f_args_splitting( [fs_inputs, fs_targets], test_size); 

%FEATURES SELECTION
%
%fs contains indeces of the selected features
if(not(exist('fs','var')&&exist('history','var')))
    opts = statset('display','iter'); 
    fun = @(trainingX,trainingT,testingX,testingT)compute_errors(trainingX',trainingT',testingX',testingT');
    
    [fs, history] = sequentialfs(fun, fs_trainX, fs_trainT,'options', opts );
end


%NEURAL NETWORK
%
%computing the NEURAL NETWORK for CLASSIFICATION
    %training set according fs
    final_trainX = fs_trainX(:,fs);
    final_trainT = fs_trainT;
    %testing set according fs
    final_testX = fs_testX(:,fs);
    final_testT = fs_testT;
    

    % Choose a Training Function
    if(not(exist('net','var')))
        net = compute_network(final_trainX, final_trainT, final_testX, final_testT);
    end

%TESTING NN RECOGNITION
%
%trying the network classification accuracy on different test sets
y = net(final_testX');
plotconfusion(final_testT',y);

%#########################################################################
                              %FUZZY SYSTEM                  

%Feature reduction (from 7 to 4) and Model Fitting

                    %return values: 
%               feature definition range 
%               ( 4x2 matrix 
%                 ROW: feature 
%                 COLUMN: min max )

%               ling_val: min and max for each position for each feature
%               (2x1 cell array.Each cell is a 4x4 matrix
%                 ROW: feature 
%                 COLUMN: position (min, max)  )  
%               )                          

[ranges, ling_val] = features_analysis(fs_inputs, fs_targets, history, 4);


%Compute Fuzzy (Mamdani type) recognition percentage.
%(fuzzy_mamdani stores the fuzzy system)

mamdani_recognition_perc = mamdani_recognition(fs_inputs,fs_targets,fs_redux,fuzzy_mamdani);


%#########################################################################
                                %ANFIS SYSTEM                             

%Training set
sugeno_trainX = fs_trainX(:,fs_redux);
sugeno_trainT = vec2ind(fs_trainT(:,:)');
sugeno_train = [sugeno_trainX sugeno_trainT'];
                                
%SUGENO FIS:
%
%Generating the Sugeno FIS with Grid Partitioning
fuzzy_sugeno = genfis1(sugeno_train, 6, 'gaussmf', 'constant');

%training Sugeno fis (without the checking set)
fuzzy_sugeno = anfis(sugeno_train, fuzzy_sugeno);

%testing Sugeno recognition over all the data
sugeno_recognition_perc = sugeno_recognition(fs_inputs,fs_targets,fs_redux,fuzzy_sugeno);


%Sugeno: Percetage Recognition on training and testing set

sugeno_test_recognition = sugeno_recognition(fs_testX, fs_testT, fs_redux, fuzzy_sugeno)
sugeno_train_recognition = sugeno_recognition(fs_trainX, fs_trainT, fs_redux, fuzzy_sugeno)
