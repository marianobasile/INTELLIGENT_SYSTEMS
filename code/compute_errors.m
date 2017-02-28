function error = compute_errors(trainingX,trainingT,testingX,testingT)
% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;

% Train the Network
[net,tr] = train(net,trainingX,trainingT);

% Test the Network
y = net(testingX);
tind = vec2ind(testingT);
yind = vec2ind(y);
error = sum(tind ~= yind);
end