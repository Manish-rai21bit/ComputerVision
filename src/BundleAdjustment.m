function [P, X] = BundleAdjustment(P, X, R, Mx, My)

% phat = [p1' p2']'; 
% Xhat = X';
% Xhat = Xhat(:);
% 
% 
% df_dC = JacobianC(R, C, X);
% df_dR = JacobianR(R, C, X);
% dR_dq = JacobianQ(q);
% JacobianP = [df_dC df_dR*dR_dq];
% df_dX = JacobianX(K, R, C, X)
rescale = 0.5;
f_unscaled = 1023;
f = f_unscaled*rescale;
K = [f 0 512*0.5*rescale;
     0 f 384*0.5*rescale;
     0 0 1];
exclude = inv(K)*[0; 0; 1];
lambda = 10;
C = P(1:3);
q = P(4:7);
K = eye(3);
nIters = 2;
for iter = 1:nIters
    Jp = []; Jx = [];b = []; f = []; Dinv = []; 
    Jphat = []; Jxhat = [];
    for i = 1:size(X, 1) % number of points
        Jp = []; Jx = [];
        
        d = zeros(3, 3);
        
        df_dC = JacobianC(R, C, X(i, :));
        df_dR = JacobianR(R, C, X(i, :));
        dR_dq = JacobianQ(q);
        JacobianP = [df_dC df_dR*dR_dq];
        df_dX = JacobianX(K, R, C, X(i, :));
        
        for j = 1: size(Mx, 2) % number of images

           if find(Mx(i, j) ~= exclude(1)) % if ith point is visible from camera j
              uij = [Mx(i, j); My(i, j)]; % change 2 to j
              xij = K*[R (-R*C)]*X(i, :)';
              xij = [xij(1)/xij(3); xij(2)/xij(3)];
              J1 = zeros(2, 7*j); J2 = zeros(2, 3*i);
              
              J1(:, 7*(j - 1) + 1 : 7*j) = JacobianP;
              J2(:, 3*(i - 1) + 1: 3*i) = df_dX;
              
              Jp = [Jp zeros(2*(size(Jp, 1) >= size(J1, 1)), abs((size(Jp, 2) - size(J1, 2)))*(size(Jp, 1) >= size(J1, 1))); J1];
              Jx = [Jx zeros(2*(size(Jp, 1) >= size(J1, 1)), abs((size(Jp, 2) - size(J1, 2))*(size(Jp, 1) >= size(J1, 1)))); J2];
              
              d = d + df_dX'*df_dX;
              b = [b' uij']';
              f = [f' xij']';
           end
        end
        Jphat = [Jphat ;Jp];
        Jxhat = [Jxhat zeros(size(Jxhat, 1), abs(size(Jx, 2) - size(Jxhat, 2))*(size(Jx, 2) >= size(Jxhat, 2))); Jx];
        

        d = d + lambda*eye(3);
        Dinv = blkdiag(Dinv, inv(d));        
    end
    Jp = Jphat;
    Jx = Jxhat;
    ep = Jp'*(b - f);
    ex = Jx'*(b - f);
    A = Jp'*Jp + lambda*eye(size(Jp, 2));
    B = Jp'*Jx;
%     Dinv = inv(D);
    del_p = inv(A - B*Dinv*B')*(ep - B*Dinv*ex);
    % normalise quartonians
    P(4:7) = P(4:7)/norm(P(4:7));
    del_X = Dinv*(ex - B'*del_p);
end
