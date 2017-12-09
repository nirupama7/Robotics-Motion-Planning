% find adjacency matrix using edgesWithWeights matrix
function shortestPath = getShortestPath(edgesWithWeights,nodes,qGoal,qStart,...
    rob,sphereCenter1,sphereCenter2,sphereCenter3,...
    sphereCenter4,sphereCenter5,sphereRadius,xGoal,failureCount)
% calculating shortest path
n=size(nodes,1);
A=zeros(n,n);

% creating adjacency matrix with weights for edges
for i=1:1:n
    for j=1:1:n
        for k=1:1:size(edgesWithWeights,1)
            if sum(i== edgesWithWeights(k,1))== 1
                if sum(j==edgesWithWeights(k,2))==1
                    A(i,j)=edgesWithWeights(k,3);
                end
            end
        end
    end
end

startIndex=1;
goalIndex=1;

for i=1:n
    if sum(nodes(i,:)==qStart)==6
        startIndex=i;
    end
end

for i=1:n
    if sum(nodes(i,:)==qGoal)==6
        goalIndex=i;
    end
end


[e,L]=dijkstra(A,startIndex,goalIndex);

% if cost==Inf no path is found
if(e==Inf)
    failureCount = failureCount+1;
    if(failureCount>5)
        shortestPath=[qStart;];
        
    else
        roadMap(rob,sphereCenter1,sphereCenter2,sphereCenter3,...
            sphereCenter4,sphereCenter5,sphereRadius,qStart,xGoal,failureCount);
    end
end

shortestPath=[];
for i= 1:1:size(L,2)
    for j=1:1:n
        if(L(1,i)==j)
            shortestPath = [nodes(j,:);shortestPath;];
        end
    end
end
end