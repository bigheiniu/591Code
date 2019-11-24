function[] 

N = length(c) ;     % total number of v/c
IDc = cell(N,1) ;   % Initialize to store neighbors of every c
nn = 2 ;            % number of neighbors wanted  
for i1 = 1:N        % loop for each c
    Ni = length(c{i1}) ;   % number of points in every c
    IDci = cell(Ni,1) ;    % initialization to store each c
    for j1 = 1:Ni          % loop for every point in c
        [IDX,D] = knnsearch(Pos,v(c{i1}(j1),:),'k',nn) ;
        IDci{j1} = IDX ;   % store the neighbors
    end
    IDc{i1} = IDci ;
end