% Dijkstra's shortest path algorithm
% Input-> adjacency matrix A of size 400X400
%         start and goal indexes s and d respectively
function [e,L] = dijkstra(A,s,d)

if s==d
    e=0;
    L=[s];
else
    
    A = setupgraph(A,inf,1);
    
    if d==1
        d=s;
    end
    A=exchangenode(A,1,s);
    
    lengthA=size(A,1);
    W=zeros(lengthA);
    
    for i=2 : lengthA
        W(1,i)=i;
        W(2,i)=A(1,i);
    end
    
    for i=1 : lengthA
        D(i,1)=A(1,i);
        D(i,2)=i;
    end
    
    D2=D(2:length(D),:);
    L=2;
    while L<=(size(W,1)-1)
        L=L+1;
        D2=sortrows(D2,1);
        k=D2(1,2);
        W(L,1)=k;
        D2(1,:)=[];
        for i=1 : size(D2,1)
            if D(D2(i,2),1)>(D(k,1)+A(k,D2(i,2)))
                D(D2(i,2),1) = D(k,1)+A(k,D2(i,2));
                D2(i,1) = D(D2(i,2),1);
            end
        end
        
        for i=2 : length(A)
            W(L,i)=D(i,1);
        end
    end
    if d==s
        L=(1);
    else
        L=(d);
    end
    e=W(size(W,1),d);
    L = listOfIndexes(L,W,s,d);
end
end

function G = exchangenode(G,a,b)

%Exchange element at column a with element at column b;
temp=G(:,a);
G(:,a)=G(:,b);
G(:,b)=temp;

%Exchange element at row a with element at row b;
temp=G(a,:);
G(a,:)=G(b,:);
G(b,:)=temp;
end
% find list of indexes of nodes leading to the goal
function L = listOfIndexes(L,W,s,d)

index=size(W,1);
while index>0
    if W(2,d)==W(size(W,1),d)
        L=[L s];
        index=0;
    else
        index2=size(W,1);
        while index2>0
            if W(index2,d)<W(index2-1,d)
                L=[L W(index2,1)];
                L=listOfIndexes(L,W,s,W(index2,1));
                index2=0;
            else
                index2=index2-1;
            end
            index=0;
        end
    end
end
end

% replace zero weights with Inf
function G = setupgraph(G,b,s)

if s==1
    for i=1 : size(G,1)
        for j=1 :size(G,1)
            if G(i,j)==0
                G(i,j)=b;
            end
        end
    end
end
if s==2
    for i=1 : size(G,1)
        for j=1 : size(G,1)
            if G(i,j)==b
                G(i,j)=0;
            end
        end
    end
end
end
