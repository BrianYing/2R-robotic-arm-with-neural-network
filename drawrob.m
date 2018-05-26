% drawrob.m

function [handles] = drawrob(joint_angles, rob)
%{
Plot a graphical representation of the robot with 
attached coordinate frames.

Input: joint_angles, a 2-element vector of joint angles to specify 
       the pose in which we wish to draw the robot; 
       rob, a structure generated by robInit()
Output: handles is a vector of graphics handles corresponding to the
        moving frames attached to the robot
%}

[~,rob_T] = robFK(joint_angles,rob);

% Shorten variable names
l_1 = rob.parameters.l_1;
l_2 = rob.parameters.l_2;


% Plot scaling properties
origin_size = 20;
marker_size = 10;
vector_size = 0.05*max(abs(diff(reshape(rob.workspace,2,3))));

% Create figure window
figure('Color','w');

% Create axes object
ax = axes('XLim',rob.workspace(1:2),'YLim',rob.workspace(3:4),...
   'ZLim',rob.workspace(5:6));
vw = [31.3,22.8];
set(gca,'View',vw);
grid on;
axis equal;
xlabel('X (mm)','FontSize',16);
ylabel('Y (mm)','FontSize',16);
zlabel('Z (mm)','FontSize',16);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Draw Robot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create link 0 and frame 0
h = drawRobotFrame([0,0,0]);
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
circ = linspace(0,2*pi,50);
L_0 = line(1*cos(circ),1*sin(circ),...
    'Color','k','LineWidth',1.5);
set(L_0,'Parent',hg);
T_0 = hgtransform('Parent',ax,'Matrix',makehgtform('translate',[0,0,0]));
set(hg,'Parent',T_0);

% Create link 1 and frame 1
h = drawRobotFrame(rob.colors{1});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_1 = line([0,0,l_1],[0,0,0],[0,0,0],...
    'Color',rob.colors{1},'LineWidth',1.5);
set(L_1,'Parent',hg);
T_1 = hgtransform('Parent',T_0,'Matrix',rob_T{1});
set(hg,'Parent',T_1);

% Create link 2 and frame 2
h = drawRobotFrame(rob.colors{2});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_2 = line([0,0,0],[0,0,0],[0,0,0],...
    'Color',rob.colors{2},'LineWidth',1.5);
set(L_2,'Parent',hg);
T_2 = hgtransform('Parent',T_1,'Matrix',rob_T{2});
set(hg,'Parent',T_2);

% Create link 3 and frame 3
h = drawRobotFrame(rob.colors{3});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_3 = line([0,0,-l_2],[0,0,0],[0,0,0],...
    'Color',rob.colors{3},'LineWidth',1.5);
set(L_3,'Parent',hg);
T_3 = hgtransform('Parent',T_2,'Matrix',rob_T{3});
set(hg,'Parent',T_3);



% Render graphics
set(gcf,'Renderer','openGL');
drawnow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Return hgtransform handles
handles = [T_1,T_2];

    function h = drawRobotFrame( color )
         
        % Plot reference frame
        X_b = [vector_size,0,0,1]';
        Y_b = [0,vector_size,0,1]';
        Z_b = [0,0,vector_size,1]';
        h(1) = line(0,0,0,'Marker','.','MarkerSize',origin_size,'Color',color);
        h(2) = line([0,X_b(1)],[0,X_b(2)],[0,X_b(3)],'LineWidth',1.5,'Color',color);
        h(3) = line([0,Y_b(1)],[0,Y_b(2)],[0,Y_b(3)],'LineWidth',1.5,'Color',color);
        h(4) = line([0,Z_b(1)],[0,Z_b(2)],[0,Z_b(3)],'LineWidth',1.5,'Color',color);
        h(5) = line(X_b(1),X_b(2),X_b(3),'LineWidth',1.5,'Marker','x','MarkerSize',marker_size,'Color',color);
        h(6) = line(Y_b(1),Y_b(2),Y_b(3),'LineWidth',1.5,'Marker','o','MarkerSize',marker_size,'Color',color);
        h(7) = line(Z_b(1),Z_b(2),Z_b(3),'LineWidth',1.5,'Marker','d','MarkerSize',marker_size,'Color',color);
    end


end