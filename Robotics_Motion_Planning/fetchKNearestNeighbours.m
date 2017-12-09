% fetch 10 nearest neighbours of the given node
% Input -> a Puma560 6 DOF robot rob
%         sphereCenter1,...
%         sphereCenter2,sphereCenter3,sphereCenter4,sphereCenter5
%       -> sphere centers of obstacles
%       sphereRadius-> radius of obstacles
function firstKNodes = fetchKNearestNeighbours(rob,node,nodes,sphereCenter1,...
    sphereCenter2,sphereCenter3,sphereCenter4,sphereCenter5,sphereRadius)

for i = 1: size(nodes)
    eDist(i,:) = euclideanDist(node,nodes(i,:));
end

[val indx] = sort(eDist);

% fetch first ten nearest nodes
firstKNodes =[];
count =1;

while (size(firstKNodes,1) <= 10)
    if count >= size(eDist,1)
        break;
    end
    if val(count,:) == 0
        count = count +1;
        continue;
    end
    q1 =  nodes(indx(count,:),:);
    collision = edgeCollision(rob,node,q1,sphereCenter1,sphereCenter2,sphereCenter3,...
        sphereCenter4,sphereCenter5,sphereRadius);
    if collision
        count = count +1;
        continue;
    end
    firstKNodes= [firstKNodes; indx(count,:) val(count,:);];
    count = count +1;
end
end