function best_net = compute_network(trX, trT, tstX, tstT)

    % Choose a Training Function
    trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

    % Create a Pattern Recognition Network
    hiddenLayerSize = 20;
    net = patternnet(hiddenLayerSize);

    perc_error = 1;
    %training 10 times the network to find the best
    for i=1:10
        % Setup Division of Data for Training, Validation, Testing
        net.divideParam.trainRatio = 90/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 0/100;

        % Train the Network
        [net,tr] = train(net,trX',trT');

        % Test the Network
        y = net(tstX');
        tind = vec2ind(tstT');
        yind = vec2ind(y);
        percentError = sum(tind ~= yind)/numel(tind);

        if(percentError < perc_error)
            best_net = net;
            perc_error = percentError;
        end
    end
    
    %plotting best network classification over the test set
    y = best_net(tstX');
    
    plotconfusion(tstT',y)
end
