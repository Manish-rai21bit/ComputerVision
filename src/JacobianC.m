function df_dC = JacobianC(R, C, X)
K = eye(3);
x = K*R*(X(:, 1:3)' - C); % one X at a time
u = x(1, :); 
v = x(2, :); 
w = x(3, :);

del= -K*R; 
du_dx = del(1,:); 
dv_dx = del(2,:);
dw_dx = del(3,:);
df_dC = [(w'*du_dx-u'*dw_dx)./w'.^2; (w'*dv_dx-v'*dw_dx)./w'.^2]; % The dimension of the final matrix should be 2nx3. 
% where n is the number of the 3D points.