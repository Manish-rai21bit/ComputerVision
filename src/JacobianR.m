function df_dR = JacobianR(R, C, X)
K = eye(3);

df_dR = [];
for i = 1:size(X, 1)
    x = K*R*(X(i, 1:3)' - C);
    u = x(1, :);
    v = x(2, :);
    w = x(3, :);

    del = [K(1,1)*(X(i, 1:3)' - C)' zeros(1, 3) K(1, 3)*(X(i, 1:3)' - C)';
        zeros(1, 3) K(2, 2)*(X(i, 1:3)' - C)' K(2, 3)*(X(i, 1:3)' - C)';
        zeros(1, 3) zeros(1, 3) (X(i, 1:3)' - C)']; % pass one X at a time
    du_dx = del(1,:);
    dv_dx = del(2,:);
    dw_dx = del(3,:);
    df_dR = [df_dR; (w'*du_dx-u'*dw_dx)./w'.^2; (w'*dv_dx-v'*dw_dx)./w'.^2];
    
end