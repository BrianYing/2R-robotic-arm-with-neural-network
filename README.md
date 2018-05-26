*********************** Project Summary ************************ 

This project is an application of machine learning on 2R robotic arm.
It is modeled and simulated in Matlab to perform a task of drawing.

The general idea is to use a two layer perception neural network to solve for 
the inverse kinematics problem for the joint angles, and then applied PD control
for the robotic arm to draw the patterns we want. The workspace of the robotic
arm can be found on 'workspace.png', and the training scores of the neural network
can be found on 'training scores.png'. And the final result of drawing can be 
seen on 'flower.png'.

*********************** Construction of Neural Network **********************

The structure of the neural network:
        n+1 ----> n/2+1 ----> n/2+1 ---- n
    where n is the number of sets of training data and add one training bias
    n/2 is the number of neuron. In this project we use fewer neuron due to 
    the computational ability of our laptop
Learning rule:
	backpropagation learning rule
Transfer function:
	tanh
Other parameters can be seem in the function neuralNetwork.m

************************** Files and Instructions ***************************

The files include:
    functions:
	createflower.m
	datagenerator.m
 	dhtf.m
	drawrob.m
	mapping.m
	neuralNetwork.m
	recalled.m
	remapping.m
	robDraw3D.m
	robFK.m
	robIK.m
	robInit.m
	setrob.m
	train.m
    datafiles:
	a1.mat
	data.mat
-> datagenerator.m, train.m, neuralNetwork.m, mapping.m, remapping.m, and recalled.m
   are used for constructing and using neural network
-> robInit.m is for initialization of robot
-> dhtf.m, robFK.m, robIK.m are used as kinematics
-> createflower.m is used for generating trajectory
-> drawrob.m, robDraw3D.m, setrob.m are used for drawing
   robDraw3D.m also contrains PD control and dynamics parts

=========== Instruction ============

The weight and data has already be generated and saved as .mat file. If you do not 
wish to do the training yourself, just go directly to step 2.

1. Run train.m file, which calls datagenerator to generate training dataset and train
   to get the two weights, stored on a1.mat. (by changing the step size in datagenerator.m,
   you can change the precision of the training dataset. However, keep in mind that the
   smaller the step is, the longer the training will take, and you also need to change other
   parameters in the neural network)
2. Run robDraw3D.m file, which calls createflower.m to generate a trajectory of a flower
   and it will draw a flower on the workspace. (createflower.m can be changed to any function
   that create other trajectories)

************* Supplemental Materials ****************

This part of codes can be find in the folder 'supplemental function'. The codes inside are
used for computing the derications of equations for kinematics. The function dynamicrob.m
calls dynamics_lagrangian.m to compute the equations of robot dynamics using lagrangian
method.
	
