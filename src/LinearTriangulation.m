function [X] = LinearTriangulation(P1,u,P2,v)
X = [];
for i = 1 : size(u,1)
    % Construct A matrix
    A = [Vec2Skew([u(i, 1); u(i, 2); 1]) * P1; Vec2Skew([v(i, 1); v(i, 2); 1]) * P2];
    % Solve linear least squares to get 3D point
    % X(:,i) = point_3d;
    [U1, S, V1] = svd(A);
    b = V1(1:4, 4);
    X = [X; [b(1)/b(4) b(2)/b(4) b(3)/b(4) b(4)/b(4)]];
end