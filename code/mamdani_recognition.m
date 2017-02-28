function recog_percentage =  mamdani_recognition(fs_inputs,fs_targets,fs_redux,fuzzy_mamdani)
match=0;
TRAIN_ELEMS = numel(fs_inputs(:,1));
OUTPUT_INTERVAL_LENGTH = 80;

    for i=1:TRAIN_ELEMS
        %fuzzy output
        y = evalfis(fs_inputs(i,fs_redux), fuzzy_mamdani);
        %target
        t = vec2ind(fs_targets(i,:)');
        %Converting fuzzy outputs to position (1,2,3,4) 
        y = fix(1 + (y-1)/OUTPUT_INTERVAL_LENGTH);
        %counting matches
        if y==t
            match=match+1;
        end    
    end
    recog_percentage = (match/TRAIN_ELEMS)*100;
end