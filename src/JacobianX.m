function df_dX = JacobianX(K, R, C, X)
%     u_new = K*R*(X(:, 1:3)' - C)
%     u_new = bsxfun(@rdivide,u_new,u_new(3,:))
K = eye(3);
x = K*R*(X(:, 1:3)' - C);
u = x(1, :); 
v = x(2, :); 
w = x(3, :);

del=K*R; 
du_dx = del(1,:); 
dv_dx = del(2,:);
dw_dx = del(3,:);
df_dX = [(w'*du_dx-u'*dw_dx)./w'.^2; (w'*dv_dx-v'*dw_dx)./w'.^2];
