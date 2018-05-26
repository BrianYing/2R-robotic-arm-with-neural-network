% robInit.m

%    DESCRIPTION - Initialize a structure kuka_struct to contain important
%    robot information that will be passed into various simulation
%    functions.
%
%    Contians:
%
%    All dimensions of the nested structure, rob_struct.parameters.
%
%    Joint limits from
%
%    Limits of the workspace.

function [ rob_struct ] = robInit()
% FANUC dimensions in millimeters
l_1 = 10; % [mm]
l_2 = 5; % [mm]


% Fill in FANUC D-H parameters and other necessary parameters 
rob_struct.parameters.l_1 = l_1;
rob_struct.parameters.l_2 = l_2;

rob_struct.parameters.alpha_0 = 0; 
rob_struct.parameters.a_0 = 0;
rob_struct.parameters.d_1 = 0;

rob_struct.parameters.alpha_1 = 0; 
rob_struct.parameters.a_1 = l_1;
rob_struct.parameters.d_2 = 0;

rob_struct.parameters.alpha_2 = 0; 
rob_struct.parameters.a_2 = l_2;
rob_struct.parameters.d_3 = 0;


% FANUC joint limits (deg)
deg2rad = pi/180;
rob_struct.joint_limits{1} = [0,90]*deg2rad;
rob_struct.joint_limits{2} = [0,180]*deg2rad;

% Set bounds on the cartesian workspace of the FANUC for plotting in the
% form:  [ xmin, xmax, ymin, ymax, zmin, zmax]
rob_struct.workspace = [-5, 10, 5, 15, 0, 1];


% Set colors to be drawn for each link and associated frame, including the
% tool
rob_struct.colors{1} = [1,0,0];
rob_struct.colors{2} = [0,1,0];
rob_struct.colors{3} = [0,0,1];

end