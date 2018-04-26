function X = NonlinearTriangulation_old(X, u1, R1, C1, u2, R2, C2)
    K = eye(3);
    nIters = 100;
    lambda = 4;
    b = [u1(:)' u2(:)']';
    X1 = X(:, 1:3)';
    for i = 1 : nIters
        JX = [JacobianX(K, R1, C1, X1'); JacobianX(K, R2, C2, X1')]; 
        u1hat = K*R1*(X1 - C1);
        u1hat = bsxfun(@rdivide,u1hat,u1hat(3,:));
        u1hat = u1hat(1:2, :);
        
        
        u2hat = K*R2*(X1 - C2);
        u2hat = bsxfun(@rdivide,u2hat,u2hat(3,:));
        u2hat = u2hat(1:2, :);
        
        fu = [u1hat(:)' u2hat(:)']';
        
        del_X = inv(JX'*JX + lambda*eye(size(JX'*JX , 1)))*JX'*(b - fu);
        
        X1 = X1 + del_X; 
    end
    X =[X1' ones(size(X1,2), 1)];