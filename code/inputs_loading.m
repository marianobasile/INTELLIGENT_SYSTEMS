function V = inputs_loading()
    %importing data
    
    V = cell(10,16);
    %V is a cell array where:
    %10 volunteers
    %16 features: 1-4: dorsiflexion sensor 1,2,3, TIME
    %             5-8: stairs sensor 1,2,3, TIME
    %             9-12: supine sensor 1,2,3, TIME
    %             13-16: walkin sensor 1,2,3, TIME

    for i=1:10
        %creating paths strings
        f = strcat('Measurements_10_volunteers/Volunteer_', num2str(i));
        f = strcat(f,'/V');
        f = strcat(f, num2str(i));
        s = strcat('S',num2str(i));

        f1 = strcat(f, ' dorsiflexion.xlsx');
        s1 = strcat(s, ' Dorsiflessione');
        [V{i,1},V{i,2},V{i,3},V{i,4}] = importfile(f1, s1, 1, 2200);

        f1 = strcat(f, ' stairs.xlsx');
        s1 = strcat(s, ' Scale');
        [V{i,5},V{i,6},V{i,7},V{i,8}] = importfile(f1, s1, 1, 2200);

        f1 = strcat(f, ' supine.xlsx');
        s1 = strcat(s, ' Sdraiato');
        [V{i,9},V{i,10},V{i,11},V{i,12}] = importfile(f1, s1, 1, 2200);

        f1 = strcat(f, ' walking.xlsx');
        s1 = strcat(s, ' Camminata');
        [V{i,13},V{i,14},V{i,15},V{i,16}] = importfile(f1, s1, 1, 2200);
    end
end