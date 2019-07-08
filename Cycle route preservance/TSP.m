close all


epochs = 20; %Number of epochs
eta = 0.2; %Step size
neighborhood = 2;
city = load('cities.dat');
weights = rand(10,2);
%weights = city;

ranges = [9 10 1:10 1 2];

%Outer loop
for outer = 1:epochs
    
    %Inner loop
    for cit = 1:size(city,1)
        c = city(cit,:); %Extract animal property
        
        cmat = repmat(c,size(weights,1),1); %Matrix with identical rows
        diff = cmat - weights;
        dist = sum(diff.^2,2); %Summing the rows of the differences 
        [mindist, mindistind] = min(dist); %Value and index of min dist

        range = ranges((mindistind+2-neighborhood):(mindistind+2+neighborhood));
           
        weights(range,:) = weights(range,:) + eta*(cmat(range,:)-weights(range,:));
        
%         if outer < epochs/2
%             neighborhood = 2;
%         elseif (outer < 3/4*epochs)&&(outer >=epochs/2)
%             neighborhood = 1;
%         else 
%             neighborhood = 0;
%         end

        if outer < 10
            neighborhood = 2;
        elseif (outer < 15)&&(outer >= 10)
            neighborhood = 1;
        else 
            neighborhood = 0;
        end
    end
end

pos = zeros(10,1);

for cit = 1:size(city,1)
    c = city(cit,:); %Extract animal property

    cmat = repmat(c,size(weights,1),1); %Matrix with identical rows
    diff = cmat - weights;
    dist = sum(diff.^2,2); %Summing the rows of the differences 
    [mindist, mindistind] = min(dist); %Value and index of min dist
    
    %pos(cit,1) = mindistind;
end

% [~,order] = sort(pos);
% w = weights([order,order]);
w = weights;

tour = [w;w(1,:)];
figure
plot(city(:,1),city(:,2),'r+')
figure
plot(tour(:,1),tour(:,2),'b-*',city(:,1),city(:,2),'r+')

