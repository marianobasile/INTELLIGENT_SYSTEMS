function  [FS_X, FS_T] = features_min_mean_max( DATA, timesplit, accuracy)
%DATA is a cell array containing the inputs and targets for each volunteeer
%accuracy is the number of times to split single volunteer features to
%timesplit is the number of times to split the recognizing interval
%compute min, mean and max indeces

    n_volunteers = 10;
    n_positions = 4;
    n_sensors = 3;

    %The features selection will be a matrix FS:
    %   columns: S1_Int1_min | S1_Int1_mean | S1_Int1_max | S1_Int2_min | ... |S3_Intacc_mean | S3_Intacc_max 
    %   rows: P1
    %         P2
    %         P3
    %         P4
    
    FS_X = zeros(40*timesplit,accuracy*3*3);
    FS_T = zeros(40*timesplit,4);
    
    for l=0:timesplit-1
        %for each volunteer
        for i=0:n_volunteers-1     
            %for each position
            for j=0:n_positions-1
                %target matrix: 
                        %(P1 = 1 0 0 0, P2= 0 1 0 0, P3= 0 0 1 0, P4=0 0 0 1)
                        FS_T(40*l+i*4+j+1,j+1) = 1;

                %input matrix:
                %for each sensor
                for k=0:n_sensors-1
                    %starting from the sampling intervals # l
                    start = fix( numel(DATA{i+1,4*j+k+1})/timesplit)*l +1;
                    pass = fix( numel(DATA{i+1,4*j+k+1})/timesplit /accuracy);
                %according to accuracy (accuracy = # intervals)
                    for h=0:accuracy-1
                        %Sk_Inth_min
                        FS_X(40*l+i*4+j+1, accuracy*3*k+3*h+1) = min(DATA{i+1,4*j+k+1}(start:start+pass-1));
                        %Sk_Inth_mean
                        FS_X(40*l+i*4+j+1, accuracy*3*k+3*h+2) = mean(DATA{i+1,4*j+k+1}(start:start+pass-1));
                        %Sk_Inth_max
                        FS_X(40*l+i*4+j+1, accuracy*3*k+3*h+3) = max(DATA{i+1,4*j+k+1}(start:start+pass-1));
                        start = start+pass;
                    end
                end
            end
        end
    end
end
        
