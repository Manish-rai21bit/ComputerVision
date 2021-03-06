function NonlinearCameraPoseRefinement

%     p = [C' R(:, 1)' R(:, 2)' R(:, 3)']'
u = K*R*[eye(3) -C]*[X'; ones(1,nPoints)]; 
u = [u(1,:)./u(3,:); u(2,:)./u(3,:)];
x = [C; q]; 

for j = 1 : 40
    R1 = Quaternion2Rotation(x(4:7)); 
    C1 = x(1:3);
    df_dc = []; 
    df_dR=[];
    for k = 1 : nPoints
        df_dc = [df_dc; JacobianC(K, R1, C1, X(k,:)')];
        df_dR = [df_dR; JacobianR(K, R1, C1, X(k,:)')*JacobianQ(x(4:7))]; 
    end
    u1 = K*R1*[eye(3) -C1]*[X'; ones(1,nPoints)]; 
    u1 = [u1(1,:)./u1(3,:); u1(2,:)./u1(3,:)];
    jacobian = [df_dc df_dR]; delta_b = u(:)-u1(:);
    delta_x = inv(jacobian'*jacobian + lambda*eye(size(jacobian'*jacobian , 1)))*jacobian'*(b - fu);
    x = x + delta_x;
    x(4:7) = x(4:7)/norm(x(4:7));
end
