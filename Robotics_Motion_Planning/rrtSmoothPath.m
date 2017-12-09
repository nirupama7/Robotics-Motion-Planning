% Smooth path given in qMilestones
% input: qMilestones -> nx4 vector of n milestones. 
%        sphereCenter1, sphereCenter2, sphereCenter3,sphereCenter4,sphereCenter5
%        -> 3x1 position of center of spherical obstacle
%        sphereRadius -> radius of obstacle
% output -> qMilestones -> 4xm vector of milestones. A straight-line interpolated
%                    path through these milestones should result in a
%                    collision-free path. You should output a number of
%                    milestones m<=n.
function qMilestonesSmoothed = rrtSmoothPath(rob,qMilestones,sphereCenter,sphereCenter2,sphereCenter3,sphereCenter4,sphereCenter5,sphereRadius)
   % adding goal orientation to the qMilestonesSmoothed
   qMilestonesSmoothed(1, : ) = qMilestones(end, : );
   endIndex = size(qMilestones,1);
   for i = 2 : size(qMilestones,1)
        indexCollisionList =[];
        if (endIndex == 1)
            break;
        end
        % back traversing to get smooth mile stones
        for j =1:endIndex-1
            isColliding = edgeCollision(rob,qMilestones(j, : ),...
                qMilestones(endIndex, : ),sphereCenter,sphereCenter2,...
                sphereCenter3,sphereCenter4,sphereCenter5,sphereRadius);
            if(not(isColliding))
                indexCollisionList =[indexCollisionList;1];
            else
                indexCollisionList = [indexCollisionList;0];
            end 
        end
        % fetching the first collision free node
        mileStoneIndex = find(indexCollisionList,1);
        smoothNodeIndex = mileStoneIndex(1);
        qMilestonesSmoothed(i, : ) = qMilestones(smoothNodeIndex, : );
        endIndex = smoothNodeIndex;
   end    
    % reversing milestones order to get path from strat to goal
    qMilestonesSmoothed = qMilestonesSmoothed(end:-1:1,:);
end
