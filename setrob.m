% setrob.m

function setrob( angles, rob )
% DESCRIPTION - Update the position of the rob after calling drawrob()
% 
% This function can be used as is once robFK() and drawrob() have been
% completed.

[~,rob_T] = robFK(angles,rob);
set(rob.handles(1),'Matrix',rob_T{1});
set(rob.handles(2),'Matrix',rob_T{2});
% set(rob.handles(3),'Matrix',rob_T{3});

% visibility = {'off','on'};
% set(rob.handles(7),'Visible',visibility{double(rob.brush==1)+1});
% set(rob.handles(8),'Visible',visibility{double(rob.brush==2)+1});
% set(rob.handles(9),'Visible',visibility{double(rob.brush==3)+1});
% set(rob.handles(10),'Visible',visibility{double(rob.brush==4)+1});
drawnow;

end
