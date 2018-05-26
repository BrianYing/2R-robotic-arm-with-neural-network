% mapping function
% map from data set range to [-1,1]
% mapping.m

function dmap = mapping(data,maxx,minx,maxy,miny,maxt1,mint1,maxt2,mint2)
%{
Input: data - original dataset n-by-3
       maxx - maximum value on x dataset
       minx - minimum value on x dataset
       maxy - maximum value on y dataset
       miny - minimum value on y dataset
       maxt1 - maximum value on t1 dataset
       mint1 - minimum value on t1 dataset
       maxt2 - maximum value on t2 dataset
       mint2 - minimum value on t2 dataset
Output: dmap - mapped dataset
%}
dmap = [];
%%%%%%%% for x %%%%%%%%
for i = 1:size(data,1)
    dmap(i,1) = 2*(data(i,1)-minx)/(maxx-minx)-1;    
end
%%%%%%%% for y %%%%%%%%
for j = 1:size(data,1)
    dmap(j,2) = 2*(data(j,2)-miny)/(maxy-miny)-1;
end
%%%%%%%% for t %%%%%%%%
for k = 1:size(data,1)
    dmap(k,3) = 2*(data(k,3)-mint1)/(maxt1-mint1)-1;
end

for k = 1:size(data,1)
    dmap(k,4) = 2*(data(k,4)-mint2)/(maxt2-mint2)-1;
end


end