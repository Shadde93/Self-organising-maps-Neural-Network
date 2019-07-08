close all

votes = load('votes.dat');
votes = reshape(votes,31,349)';
district = load('mpdistrict.dat');
party = load('mpparty.dat');
gen = load('mpsex.dat');

eta = 0.2;
epochs = 20;
n = 6; % neighborhood

w = rand(100,31);
w_rows = size(w,1);

N = size(votes,1);

for i = 1:epochs
    for j = 1:N
        v = votes(j,:);
        vmat = repmat(v,w_rows,1);
        diff_sq = (vmat - w).^2; % square distance of the components
        sq_dist = sum(diff_sq,2); % sum rows of diff_sq, total square distance
        [mindist,index] = min(sq_dist);
        
        manhattan;
        
        w(range,:) = w(range,:) + eta*(vmat(range,:) - w(range,:));
        
        if (i <=1)
            n = 6;    
        elseif (i < 4) 
            n = 4;
        elseif (i < 7)
            n = 2;
        elseif (i<10)
            n = 1;
        else
            n = 0;
        end
            
        
    end
    
end


pos = zeros(349,1);

for vo = 1:size(votes,1)
    v = votes(vo,:); %Extract animal property

    vmat = repmat(v,size(w,1),1); %Matrix with identical rows
    diff = vmat - w;
    dist = sum(diff.^2,2); %Summing the rows of the differences 
    [mindist, mindistind] = min(dist); %Value and index of min dist
    
    pos(vo,1) = mindistind;
end

colormap([0 0 0; 0 0 1; 0 1 1; 1 0 1; 1 0 0; 0 1 0; 1 1 1; 1 1 0])

a = ones(1,100)*350;
a(pos) = 1:349;

district;
p = [mppartyy;0];
image(p(reshape(a,10,10))+1);
