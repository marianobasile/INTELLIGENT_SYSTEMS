function recog_percentage =  sugeno_recognition(fs_inputs,fs_targets,fs_redux,fuzzy_sugeno)
match=0;
TRAIN_ELEMS = numel(fs_inputs(:,1));

    for i=1:TRAIN_ELEMS
        %fuzzy output
        y = evalfis(fs_inputs(i,fs_redux), fuzzy_sugeno);
        %target
        t = vec2ind(fs_targets(i,:)');
        %Rounding fuzzy outputs to position (1,2,3,4) 
        y = round(y);
        %counting matches
        if y==t
            match=match+1;
        end    
    end
    recog_percentage = (match/TRAIN_ELEMS)*100;
end