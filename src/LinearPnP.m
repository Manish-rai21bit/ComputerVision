function [R, C] = LinearPnP(u, X)
A = [];
K = eye(3);

for i = 1:size(X, 1)
    A = [A;
        X(i, :) zeros(1, 4) -u(i, 1)*X(i, 1) -u(i, 1)*X(i, 2 ) -u(i, 1)*X(i, 3) -u(i, 1);
        zeros(1, 4) X(i, :) -u(i, 2)*X(i, 1) -u(i, 2)*X(i, 2 ) -u(i, 2)*X(i, 3) -u(i, 2)];
    
end
p = SolveHomogeneousEq(A);
p = reshape(p, [4, 3]);
p = p';
R = inv(K)*[p(:, 1) p(:, 2) p(:, 3)];
[U D V] = svd(R);

R = U*V';
t = inv(K)*p(:, 4)/D(1, 1);

if(det(R)<0)
    t = -t;
    R = -R;
end

C = -R'*t;