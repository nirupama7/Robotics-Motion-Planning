% 
% Evaluate whether the configuration <q> is in collision with a spherical
% obstacle centered at <sphereCenter> with radius <r>.
% 
% input: q -> 1x4 vector of joint angles
%        sphereCenter1, sphereCenter2, sphereCenter3,sphereCenter4,sphereCenter5
%        -> 3x1 vector that denotes sphere center
%        r -> radius of sphere 
% output: collision -> binary number that denotes whether this
%                      configuration is in collision or not.
function collision = robotCollision(rob,q,sphereCenter1, sphereCenter2, sphereCenter3,sphereCenter4,sphereCenter5,r)

    % get points on elbow and at EE
    x1 = [0;0;0];
    T2 = rob.A(1,q) * rob.A(2,q) * rob.A(3,q);
    x2 = T2(1:3,4);
    T3 = rob.A(1,q) * rob.A(2,q) * rob.A(3,q) * rob.A(4,q);
    x3 = T3(1:3,4);
    
    % rob.plot(q);
    
    vec = 0:0.1:1;
    m = size(vec,2);
    
    x12 = repmat(x2-x1,1,m) .* repmat(vec,3,1) + repmat(x1,1,m);
    x23 = repmat(x3-x2,1,m) .* repmat(vec,3,1) + repmat(x2,1,m);
    x = [x12 x23];

    
    euclideanDist1 = sum(sum((x - repmat(sphereCenter1,1,size(x,2))).^2,1) < r^2);
    euclideanDist2 = sum(sum((x - repmat(sphereCenter2,1,size(x,2))).^2,1) < r^2);
    euclideanDist3 = sum(sum((x - repmat(sphereCenter3,1,size(x,2))).^2,1) < r^2);
    euclideanDist4 = sum(sum((x - repmat(sphereCenter4,1,size(x,2))).^2,1) < r^2);
    euclideanDist5 = sum(sum((x - repmat(sphereCenter5,1,size(x,2))).^2,1) < r^2);
    
    if euclideanDist1 > 0|| euclideanDist2 > 0 || euclideanDist3 >0||euclideanDist4 >0||euclideanDist5 >0
        collision = 1;
    else
        collision = 0;
    end

end
