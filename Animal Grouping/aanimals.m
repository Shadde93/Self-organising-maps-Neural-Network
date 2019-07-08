props = load('animals.dat');
props = reshape(props,84,32)';
N = size(props,1);
w = rand(100,84);
w_rows = size(w,1);

eta = 0.2;
epochs = 20;
n = 50; % neighborhood

dummy_index = 0;

for i = 1:epochs
    for j = 1:N
        p = props(j,:);
        pmat = repmat(p,w_rows,1);
        diff_sq = (pmat - w).^2; % square distance of the components
        sq_dist = sum(diff_sq,2); % sum rows of diff_sq, total square distance
        [mindist,index] = min(sq_dist);
        
        lower = max(1,index-fix(n/2));
        upper = min(index+fix(n/2),w_rows);
        range = lower:upper;
        
        w(range,:) = w(range,:) + eta*(pmat(range,:) - w(range,:));
        
        dummy_index = dummy_index + 1;
        
        if mod(dummy_index,20) == 0
            n = max(1,n-5);
        end


    end
    
end

%pos = zeros(w_rows,1);
pos = zeros(N,1);

for k = 1:N
    %for m = 1:N
        p = props(k,:);
        pmat = repmat(p,w_rows,1);
        diff_sq = (pmat - w).^2; % square distance of the components
        sq_dist = sum(diff_sq,2); % sum rows of diff_sq, total square distance
        [mindist,index] = min(sq_dist);
    %end
    
    pos(k,1) = index;
end

[~,order] = sort(pos);
fileID = fopen('animalnames.txt');
names = textscan(fileID, '%s');
fclose(fileID);
names = names{1};
names = names(order)'