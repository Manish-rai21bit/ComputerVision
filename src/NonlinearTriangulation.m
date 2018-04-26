function X = NonlinearTriangulation(X, u1, R1, C1, u2, R2, C2)
K = eye(3);
nIters = 100;
lambda = 100;
%     b = [u1(:)' u2(:)']';
X1 = X(:, 1:3)'; error = [];
for j = 1:size(X, 1)
    for i = 1 : nIters
        fu = []; b = [];
        JX = [JacobianX(K, R1, C1, X1(:, j)'); JacobianX(K, R2, C2, X1(:, j)')];
        u1hat = K*R1*(X1(:, j) - C1);
        u1hat = bsxfun(@rdivide,u1hat,u1hat(3,:));
        u1hat = u1hat(1:2, :);
        
        
        u2hat = K*R2*(X1(:, j) - C2);
        u2hat = bsxfun(@rdivide,u2hat,u2hat(3,:));
        u2hat = u2hat(1:2, :);
        
        fu = [fu; [u1hat(:)' u2hat(:)']'];
        b = [b; [u1(:, j)' u2(:, j)']'];
    end
    del_X = inv(JX'*JX + lambda*eye(size(JX'*JX , 1)))*JX'*(b - fu);
    
    X1(:, j) = X1(:, j) + del_X;
%     error = [error; norm(b-fu)];
end
X =[X1' ones(size(X1,2), 1)];