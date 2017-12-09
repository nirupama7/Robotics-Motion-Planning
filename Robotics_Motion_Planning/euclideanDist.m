function eDist = euclideanDist(q1,q2)
% calculating euclidean distance between the two vectors in C-space
q = q1-q2;
eDist = sum(q.^2,2);

end