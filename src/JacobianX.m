function df_dX = JacobianX(K, R, C, X)
%     u_new = K*R*(X(:, 1:3)' - C)
%     u_new = bsxfun(@rdivide,u_new,u_new(3,:))

x = K*R*(X(:, 1:3)' - C);
u = x(1, :); 
v = x(2, :); 
w = x(3, :);

del=K*R; 
du_dc = del(1,:); 
dv_dc = del(2,:);
dw_dc = del(3,:);
df_dX = [(w'*du_dc-u'*dw_dc)./w'.^2; (w'*dv_dc-v'*dw_dc)./w'.^2];
