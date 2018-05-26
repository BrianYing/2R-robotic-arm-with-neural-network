% datagenerator.m
% generate all the positions with their angles for training
% data is n-by-5 matrix with each column as x, y, z, t1, t2

function data = datagenerator(rob)

limit1 = rob.joint_limits{1};
limit2 = rob.joint_limits{2};


%%%%%%%%%% generating data for training %%%%%%%%%%%%%%%%%%%%%
theta = [];
step = .05;
n = 1;
for t1 = limit1(1):step:limit1(2)
    for t2 = limit2(1):step:limit2(2)
        theta(n,:) = [t1 t2];
        n = n+1;
    end
end

xmin = rob.workspace(1);
xmax = rob.workspace(2);
ymin = rob.workspace(3);
ymax = rob.workspace(4);
zmin = rob.workspace(5);
zmax = rob.workspace(6);

data = [];
for i = 1:size(theta,1)
    angles = theta(i,:);
    [T1,~] = robFK(angles,rob);
    P1 = T1(1:3,4);
    if P1(1,1)>=xmin && P1(1,1)<=xmax && P1(2,1)>=ymin && ...
        P1(2,1)<=ymax && P1(3,1)>=zmin && P1(3,1)<=zmax
        data = [data;P1' angles];
    end
end
figure,
plot3(data(:,1),data(:,2),data(:,3),'.','Color','b')
end

