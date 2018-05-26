% robIK.m

function [is_solution,joint_angles] = robIK(pos,rob,data)
%{
Input: pos, desired position;
       rob, structure output by robInit;
Output: boolean variable is_solution;
        2-element vector joint_angles that is the inverse kinematics
        solution.
%}

%%%%% check workspace %%%%%
xmin = rob.workspace(1);
xmax = rob.workspace(2);
ymin = rob.workspace(3);
ymax = rob.workspace(4);
if pos(1)>=xmin && pos(1)<xmax && pos(2)>=ymin && pos(2)<=ymax
    is_solution = 'True';

%%%%% loading model for angle 1 and angle 2
a1 = load('a1.mat');
% data = load('data.mat');

maxx = max(data(:,1));
minx = min(data(:,1));
maxy = max(data(:,2));
miny = min(data(:,2));
maxt1 = max(data(:,3));
mint1 = min(data(:,3));
maxt2 = max(data(:,4));
mint2 = min(data(:,4));

%%%%%%%% map x,y %%%%%%%%
inputmap = [2*(pos(1)-minx)/(maxx-minx)-1, 2*(pos(2)-miny)/(maxy-miny)-1];

% train_bias = ones(size(data,1), 1);
input = [1 inputmap];
% display(inputt)

t = recalled(input, a1.weights_1, a1.weights_2);
% t2 = recalled(inputmap, a2.weights_1, a2.weights_2);


%%%%%%%% remap t1,t2 %%%%%%%%
t1 = remapping(t(1),maxt1,mint1);
t2 = remapping(t(2),maxt2,mint2);

% t1 = rad2deg(t1);
% t2 = rad2deg(t2);
joint_angles = [t1 t2];

else
    is_solution = 'False';
    joint_angles = [0 0];
    return
end