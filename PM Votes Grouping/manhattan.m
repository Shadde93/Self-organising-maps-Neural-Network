% vec = [-1 1 3 0 5 -1 10];
% vec1 = vec(vec > 0);
%n = 4;
[x,y] = meshgrid([1:10],[1:10]);
xpos = reshape(x,1,100);
ypos = reshape(y,1,100);
range = [];
%index = 90;

for ii = -n:n+1
    dummy = index+sign(ii)*10*(n-abs(ii)+1);
    %dummy2 = index+10*(n-i+1);
    if (dummy < 1 || dummy > 100 || ii == 0)
        continue
    end
%     if dummy2 > 100
%         continue
%     end
    x1 = xpos(dummy);
    for jj = -(abs(ii)-1):(abs(ii)-1)
        if (dummy+jj < 1 || dummy+jj > 100)
            continue
        end
        if xpos(dummy+jj) == x1
            range(end+1) = dummy + jj;
        end
%         if (xpos(dummy2+j) == x2 && i~=n+1)
%             range(end+1) = dummy2 + j;
%         end
    end
end

range = sort(range);