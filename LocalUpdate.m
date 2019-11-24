% return position and weight of all agents in two arrays
function[Position2, Weight2] = LocalUpdate(Position, Mass, Centroid, PD, PDinf, health)
n = length(Position);
Position2 = zeros(n,2);
Weight2 = zeros(n,1);
kp = 0.01;
kw = 10;
Weight2 = NeighborWeight(PD, PDinf, health);
for i=1:n
    Position2(i,:) = kp*(Centroid(i) - Position(i,:));
    Weight2(i) = -kw/(2*Mass(i))* Weight2(i);   
end    

end
% return the sum of all fi result about all agent points
function[Weight2] = NeighborWeight(PD, PDinf, health)
n = length(PD{1,1});
Weight2 = zeros(n,1);
% c is all shared line betweena all cell
c = length(PD{2,1});
for i=1:c
    % if both two points of line are out of boundray, then omit the line
    if ~inpolygon(PD{2,1}{i,1}(1,1),PD{2,1}{i,1}(1,2),[1 1 6 6 1],[1 6 6 1 1]) && ~inpolygon(PD{2,1}{i,1}(1,1),PD{2,1}{i,1}(1,2),[1 1 6 6 1],[1 6 6 1 1])
       continue; 
    end
%     % if both point are out off boundray
%     if checkOff(PD{2,1}{i,1}(1,:),PD{2,1}{i,1}(2,:))
%         continue;
%     end
    
    for j=1:n
        % check if cell_j contains line_i, if so then check the other side
        % of the line
       if ismember(PD{2,1}{i,1},PD{1,1}{j,1})
           for k=1:n
               % omit same cell 
               if j==k
                   continue;
               end
               % if cell_k and cell_j shared a line_i, update part of their new weight 
               if ismember(PD{2,1}{i,1},PD{1,1}{k,1})
                   mid = midpoint(PD{2,1}{i,1}(1,:),PD{2,1}{i,1}(2,:));
                   Weight2(j) = Weight2(j) + Fi(j,mid,health(j)) - Fi(k,mid,health(k));
                   Weight2(k) = Weight2(k) + Fi(k,mid,health(k)) - Fi(j,mid,health(j));
               end
           end
       end
    end    
end

end

% return fi
function[fi] = Fi(q, p, h)
alph = 1;
fi = alph*(norm(q-p)^2 - h);
end

% return mid point of two point, check boundry as well
function[mid] = midpoint(q, p)
xlimit = [1 6];
ylimit = [1 6];
xx = xlimit([1 1 2 2 1]);
yy = ylimit([1 2 2 1 1]);
% because PD contains points off boundray, we need to check and modify them
q = EdgePoint(q,p,xx,yy);
p = EdgePoint(p,q,xx,yy);
mid = (p+q)/2;

end

% return point. if out of boundry, return a point on the edge of boundry
function[edge] = EdgePoint(point,helper,xx,yy)
edge = zeros(2,1);

% if the point is in the boundray, then just return itself
if inpolygon(point(1),point(2),xx,yy)
    edge = point;
% if the point is off the boundray, then find the intersection of the line
% and the boundray
% boundray.
else
    [edge(1),edge(2)] = polyxpoly([point(1),helper(1)],[point(2),helper(2)],xx,yy);
end
end

% function[res] = checkOff(p,q) 
% xlimit = [1 6];
% ylimit = [1 6];
% xx = xlimit([1 1 2 2 1]);
% yy = ylimit([1 2 2 1 1]);
% res = true(1);
% intersection = polyxpoly([p(1),q(1)],[p(2),q(2)],xx,yy);
% if isempty(intersection)
%     res = false(1);
% end
% end