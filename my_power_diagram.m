clear;close all;clc;
% sample input for 2D Voronoi diagram
RobotNumber = 6;
H = zeros(RobotNumber, 1);
H = [0.1;0.3;0.5;0.7;0.9;1]/2;

E = randi([1,5],RobotNumber,2);
wts = zeros(RobotNumber,1);
% wts(1) = wts(1) + 0.5;
% wts=2*[1, 1.5, 1, 1, 0.5, 1]';
wts=[1;1;1;1;1;1];
% plot with red line -- starting state
[PD, PDinf] = powerDiagramWrapper(E, wts,'r');
sum = 0;
% compute weight after converge(need to change)

% for i=1:RobotNumber
%     sum = sum + wts(i);
% end
% final_w = sum/RobotNumber;
% 
% for i=1:RobotNumber
%     wts(i) = final_w;
% end

% including health
sum_1 = 0;
for i=1:RobotNumber
    sum_1 = sum_1 + (wts(i)-H(i));
end
for i=1:RobotNumber
    wts(i) = H(i) + sum_1/RobotNumber;
end
% plot with blue line -- sudo converge state

[PD, PDinf] = powerDiagramWrapper(E, wts,'b');