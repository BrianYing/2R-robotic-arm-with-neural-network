% remapping function
% map from [-1,1] back to data set range
% only for theta
% remapping.m

function data = remapping(d,maxt,mint)
%{
Input: d - mapped dataset 
       maxt - maximum value on t dataset
Output: data - original dataset
%}
data = [];
for k = 1:size(d,1)
    data(k,1) = (d(k,1)+1)/2*(maxt-mint);
end

end