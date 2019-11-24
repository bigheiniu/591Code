function [mass,centroids,cost] = massive_all_1(points,robot_positions,robot_weights)

% calculate the normal Euclidean distance
euclidean_distance=pdist2(points,robot_positions,'euclidean');
% in the paper, it use absolute value, so square it for easy in next steps
euclidean_distance = euclidean_distance.^2;
[~,normal_nearest_neighbors]=min(euclidean_distance,[],2);
% according to paper formula(1)
weighted_distance = euclidean_distance.^2-robot_weights;
[~,weight_nearest_neighbors]=min(weighted_distance,[],2);
% test to find how many points updated its centorid robot after using
% weighted distance
points_changed_number = sum(length(normal_nearest_neighbors)-sum(weight_nearest_neighbors==normal_nearest_neighbors));
% disp(changed);
robot_number = length(robot_positions);

mass = zeros(robot_number,1);
centroids = zeros(robot_number,2);
cost = zeros(robot_number,1);
% assume phi has 2 Gaussian function, so pdf will provide phi(q) in
% formula before (5)
%% the 2 Gaussian distributions were fixed here

for i = 1:robot_number
    current_points = points(weight_nearest_neighbors==i,:);
    current_points_weight_dis = weighted_distance(weight_nearest_neighbors==i,i);
    current_number = length(current_points(:,1));
    current_mass = 0;
    
%     phi_x = normpdf(current_points(:,1),mu1,sigma1);
%     phi_y = normpdf(current_points(:,2),mu2,sigma2);
    phi_x = ones(current_number,1);
    phi_y = ones(current_number,1);
    current_mass = current_mass + sum(phi_x);
    current_mass = current_mass + sum(phi_y);
    
%     centroid_x = sum(normpdf(current_points(:,1),mu1,sigma1).*current_points(:,1))/current_mass;
%     centroid_y = sum(normpdf(current_points(:,2),mu2,sigma2).*current_points(:,2))/current_mass;
    centroid_x = sum(ones(current_number,1).*current_points(:,1))/current_mass;
    centroid_y = sum(ones(current_number,1).*current_points(:,2))/current_mass;
   
    weight_loss = sum(0.5*(current_points_weight_dis.*(phi_x+phi_y)));
    
    mass(i,1) = current_mass;
    centroids(i,1)=centroid_x;
    centroids(i,2)=centroid_y;
    cost(i,1) = weight_loss;
end


end

