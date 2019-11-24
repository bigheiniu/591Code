close all;clc;clear;
% give the point density, generate points uniform distribute in
% ([0,6],[0,6])
point_density = 50; % generate ~90000 points
[x,y] = meshgrid(0:1/point_density:6, 0:1/point_density:6);
points = [x(:) y(:)];
% generate robots locations (int type)
robotNumber = 6;
% possible position array[4 4;3 6;5 5;2 4;3 2;6 4]
robot_positions = randi([1,6],robotNumber,2);
robot_weights = 1*[1,1.2,1,0.8,1,1];
% get current time each robot/cell's mass,centroid,cost
euclidean_distance=pdist2(points,robot_positions,'euclidean');
euclidean_distance = euclidean_distance.^2;
[~,normal_nearest_neighbors]=min(euclidean_distance,[],2);
weighted_distance = euclidean_distance-robot_weights;
[~,weight_nearest_neighbors]=min(weighted_distance,[],2);
[mass,centroid,cost] = mass_centroid_cost(points,robot_positions,robot_weights);

%% code below are changed by Lecheng for test
% powerDiagram plot
robot_positions = randi([1,6],robotNumber,2);
robot_weights = 1*[1,1.2,1,0.8,1,1];
health = [0.2;0.5;1;1;1;1];
[PD, PDinf] = powerDiagramWrapper(robot_positions, robot_weights.','r');
% only perform algorithm when the cell number is equal to agent number,
% otherwise exit 

% just one move at this time, can be modified to iteration when test is over 

for i = 1:10
if length(PD{1,1}) == length(robot_positions)
    [attackHealth, index] = Poision(health);
    [robot_positions_new,robot_weights_new] = LocalUpdate(robot_positions, mass, centroid, PD, PDinf, health);
    % adjustment the weight by copy from last iteration
    [adjustWeight, maliciousIndex] = MaliciousDetection(robot_weights, robot_weights_new');
    %robot_positions = robot_positions_new;
    %robot_weights = adjustWeight;
    % poison the health data for the next iteration
    [mass,centroid,cost] = massive_all_1(points,robot_positions, robot_weights);
    disp(robot_weights)
else 'reject, not enough cells'

end
[PD, PDinf] = powerDiagramWrapper(robot_positions, robot_weights.','r');

end
