
% You must run startup_rvc FIRST before running this function.
% DO NOT MODIFY THIS FILE!
% input: questionNum -> Integer between 1 and 3 that denotes question
%                       number to run.
function [elapsedTime,message] = prmPathPlan 
warning off;

% set up robot and initial joint configuration
rob = createRobot();

% start and goal configuration
 qStart = [0.78 0.78 -0.78 -0.78 0 0.78];
 xGoal = [-0.75 0.0 -0.5];
% obstacle positions in cspace
sphereCenter = [0.0;-0.4;-0.4];
sphereCenter2 = [1.0;-1;0];
sphereCenter3 = [-1;0.0;0];
sphereCenter4 = [-0.25;0.25;0.25];
sphereCenter5 = [0.5;0.5;1];

% obstacle radius
sphereRadius = 0.125;

% plot robot and sphere
rob.plot(qStart);
hold on;
drawSphere(sphereCenter,sphereRadius);
hold on;
drawSphere(sphereCenter2,sphereRadius);
hold on;
drawSphere(sphereCenter3,sphereRadius);
hold on;
drawSphere(sphereCenter4,sphereRadius);
hold on;
drawSphere(sphereCenter5,sphereRadius);
hold on;

T0 = transl(xGoal);
%goal position orientation
qGoal = rob.ikine(T0);
collision1= robotCollision(rob,qStart,sphereCenter,sphereCenter2,sphereCenter3,sphereCenter4,sphereCenter5,sphereRadius);
collision2= robotCollision(rob,qGoal,sphereCenter,sphereCenter2,sphereCenter3,sphereCenter4,sphereCenter5,sphereRadius);
    
if (collision1 || collision2)
    elapsedTime = [0 0 0;];
    message ="start or goal configuration is in collision";
else
    failureCount=0;
    [elapsedTime,qMilestones] = roadMap(rob,sphereCenter,sphereCenter2,sphereCenter3,sphereCenter4,sphereCenter5,sphereRadius,qStart,xGoal,failureCount);
    % interpolate and plot direct traj from start to goal
    if sum(qMilestones==qStart)==6
       elapsedTime = [0 0 0;];
       message = "collision free path cannot be found for given start and goal configurations";
    else
        message = "";
        qTraj = interpMilestones(qMilestones);
        rob.plot(qTraj);
    end
end  
end

function traj = interpMilestones(qMilestones)

d = 0.05;
traj = [];
for i=2:size(qMilestones,1)
    delta = qMilestones(i,:) - qMilestones(i-1,:);
    m = max(floor(norm(delta) / d),1);
    vec = linspace(0,1,m);
    leg = repmat(delta',1,m) .* repmat(vec,size(delta,2),1) + repmat(qMilestones(i-1,:)',1,m);
    traj = [traj;leg'];
    
end
end

function rob = createRobot()

% load the standard Puma
mdl_puma560;
rob = SerialLink(p560, 'name', 'P560');

end

function drawSphere(position,diameter)

[X,Y,Z] = sphere;
X=X*diameter;
Y=Y*diameter;
Z=Z*diameter;
X=X+position(1);
Y=Y+position(2);
Z=Z+position(3);
%surf(X,Y,Z);
spherei = surf(X,Y,Z);
alpha(spherei,0.5);

end


