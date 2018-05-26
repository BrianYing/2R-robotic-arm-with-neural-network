% Creating training data and perform training
% train.m

rob = robInit;
data = datagenerator(rob);

data = [data(:,1:2) data(:,4:5)]; % create x-y-theta1 dataset
% data2 = [data(:,1:2) data(:,5)]; % create x-y-theta2 dataset
save('data.mat')
% save('data2.mat')

maxx = max(data(:,1));
minx = min(data(:,1));
maxy = max(data(:,2));
miny = min(data(:,2));
maxt1 = max(data(:,3));
maxt2 = max(data(:,4));
mint1 = min(data(:,3));
mint2 = min(data(:,4));

%======== training for Model 1 for t1=========%
dmapped1 = mapping(data,maxx,minx,maxy,miny,maxt1,mint1,maxt2,mint2);
input1 = dmapped1(:,1:2);
output1 = dmapped1(:,3:4);
[train_score1,weights_1,weights_2]=neuralNetwork(input1, output1,...
                                                  100, 0.0001, 0.05,... 
                                                  5000, size(dmapped1,1), 0.0000001);
save('a1.mat','weights_1','weights_2')


% %======== training for Model 2 for t2=========%
% dmapped2 = mapping(data2,maxx,minx,maxy,miny,maxt2,mint2);
% input2 = dmapped2(:,1:2);
% output2 = dmapped2(:,3);
% [train_score2,weights_1,weights_2]=neuralNetwork(input2, output2,... 
%                                                   20, 0.001, 0.05,...
%                                                   50000, size(dmapped2,1), 0.0000001);
% save('a2.mat','weights_1','weights_2')

