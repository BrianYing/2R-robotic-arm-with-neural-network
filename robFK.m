% robFK.m

function [T,rob_T] = robFK(joint_angles, rob)
%{
Input: a 2-element vector of joint angles joint_angles;
       the structure output by the function fanucInit.m
Output: full forward kinematics transform matrix T;
        cell array of tranforms fanuc_T
%}
T01 = dhtf(rob.parameters.alpha_0, rob.parameters.a_0, rob.parameters.d_1, joint_angles(1));
T12 = dhtf(rob.parameters.alpha_1, rob.parameters.a_1, rob.parameters.d_2, joint_angles(2));
T23 = dhtf(rob.parameters.alpha_2, rob.parameters.a_2, rob.parameters.d_3, 0);

rob_T = {T01 T12 T23};
T = T01 * T12 * T23;

end


