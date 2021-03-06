function H = homography(p1, p2)
% Assume we have two images called '1' and '2'
% p1 is an n x 2 matrix containing n feature points, where each row
% holds the coordinates of a feature point in image '1'
% p2 is an n x 2 matrix where each row holds the coordinates of a
% corresponding point in image '2'
% H is the homography matrix, such that
% p1_homogeneous = H * [p2 ones(size(p2, 1), 1)]'
% p1_homogeneous contains the transformed homogeneous coordinates of
% p2 from image �2� to image �1�. 

n = size(p1, 1);
if n < 4
 error('Not enough points');
end

A = zeros(n*2,8);
b = zeros(n*2,1);
for i=1:n
 A(2*(i-1)+1,1:3) = [p1(i,:),1];
 A(2*(i-1)+1,7:8) = [-p1(i,1)*p2(i,1),-p1(i,2)*p2(i,1)];
 A(2*(i-1)+2,4:6) = [p1(i,:),1];
 A(2*(i-1)+2,7:8) = [-p1(i,1)*p2(i,2),-p1(i,2)*p2(i,2)];
 b(2*(i-1)+1:2*(i-1)+2) = p2(i,:);
end

x = (A\b)';
H = [x(1:3); x(4:6); [x(7:8),1]];

