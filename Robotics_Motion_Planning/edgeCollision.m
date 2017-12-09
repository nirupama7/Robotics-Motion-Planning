%
% This function takes two joint configurations and the parameters of the
% obstacle as input and calculates whether a collision free path exists
% between them.
%
% input: q1, q2 -> start and end configuration, respectively. Both are 1x4
%                  vectors.
%        sphereCenter1,sphereCenter2,SphereCenter3,sphereCenter4,sphereCenter5
%        -> 3x1 positions of centers of spheres
%        r -> radius of sphere
%        rob -> SerialLink class that implements the robot
% output: collision -> binary number that denotes whether this
%                      configuration is in collision or not.

function collision = edgeCollision(rob,q1,q2,sphereCenter1,sphereCenter2,SphereCenter3,sphereCenter4,sphereCenter5,r)

stepSize = 100;
cols = size(q1,2);
q = zeros(cols,stepSize);
for i = 1: cols
    q(i,:) = linspace(q1(i),q2(i),stepSize);
end
q = q';
rows = size(q,1);
for i = 1:rows
    collision = robotCollision(rob,q(i,:),sphereCenter1,sphereCenter2,...
        SphereCenter3,sphereCenter4,sphereCenter5,r);
    if collision == 1
        break;
    end
end
end

