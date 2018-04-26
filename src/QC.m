%% 
u = [Mx1(:, 1) My1(:, 1)];
v = [Mx1(:, 2) My1(:, 2)];

%% 4.2 Visualize 3D camera pose and 3D points
C0 = [0; 0; 0];
R0 = eye(3);
figure(1)
plot3(X2(:,1), X2(:,2), X2(:,3), 'b.');
hold on
DisplayCamera(C0, R0, 1);
hold on
DisplayCamera(C2, R2, 1);
%axis ([0, 100, 0, 100, 0, 100])

%% 4.a
figure(2) ; clf ;
imagesc(cat(2, I3, I4)) ;
% faHat = fa(:, 1:m);
xa = (Mx1(:, 3)'*f + K(1,3)) ;
xb = (Mx1(:, 4)'*f+ K(1,3)) + size(I4,2) ;
ya = (My1(:, 3)'*f + K(2,3));
yb = (My1(:, 4)'*f +K(2,3));

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'r') ;



%% Reprojection
% K = [700 0 960;
%      0 700 540;
%      0 0 1];
u_new = K*[eye(3) [0; 0; 0]]*X';
u_new = [u_new(1, :)./u_new(3, :); u_new(2, :)./u_new(3, :); u_new(3, :)./u_new(3, :)];

v_new = K*[R (-R*C)]*X';
v_new = [v_new(1, :)./v_new(3, :); v_new(2, :)./v_new(3, :); v_new(3, :)./v_new(3, :)];

Mx2 = Mx1(:, [3, 4]); My2 = My1(:, [3, 4]);
figure(1)
imshow(I3)
hold on
plot(u_new(1,:), u_new(2, :), 'b*', (Mx2(:, 1)'*f + K(1,3)), (My2(:, 1)'*f + K(2,3)), 'r*')
% hold on
% plot(u(:, 1), u(:, 2), 'r*')
legend('Reprojection','Actual');

figure(2)
imshow(I4)
hold on
plot(v_new(1,:), v_new(2, :), 'b*', (Mx2(:, 2)'*f + K(1,3)), (My2(:, 2)'*f + K(2,3)), 'r*')
% hold on
% plot(v(:, 1), v(:, 2), 'r*')
legend('Reprojection','Actual');
%% Q5. Refinement
R1 = eye(3);
C1 = [0; 0; 0];
R2 = R; C2 = C;
u = [Mx1(:, 1) My1(:, 1)];
v = [Mx1(:, 2) My1(:, 2)];

u1 = u';
u2 = v';

X = NonlinearTriangulation(X, u1, R1, C1, u2, R2, C2);

%% Q6. Camera Refinement
new_image = 2;
exclude = inv(K)*[0; 0; 1];

Mx1 = Mx(Mx(:, 4) ~= exclude(1), :);
My1 = My(My(:, 4) ~= exclude(2), :);

indices = find((Mx1(:, new_image) ~= exclude(1)) == 1); %getting index of relevent points

Mx2 = [Mx1(indices, new_image) indices];
My2 = [My1(indices, new_image) indices];

% indices2 = find((Mx2(:, 1) ~= exclude(1)) == 1);
% Mx2 = Mx2(indices2, :);
% My2 = My2(indices2, :);

X2 = X(Mx2(:, 2), :);

u2 = [Mx2(:, 1) My2(:, 1)];
[R2, C2] =  PnPRANSAC(u2, X2)

% Reprojection
u_new = K*[eye(3) [0; 0; 0]]*X2';
u_new = [u_new(1, :)./u_new(3, :); u_new(2, :)./u_new(3, :); u_new(3, :)./u_new(3, :)];

v_new = K*[R2 (-R2*C2)]*X2';
v_new = [v_new(1, :)./v_new(3, :); v_new(2, :)./v_new(3, :); v_new(3, :)./v_new(3, :)];

figure(1)
imshow(I2)
hold on
plot(v_new(1,:), v_new(2, :), 'b*', (Mx2(:, 1)'*f + K(1,3)), (My2(:, 1)'*f + K(2,3)), 'r*')
% hold on
% plot(u(:, 1), u(:, 2), 'r*')
legend('Reprojection','Actual');



%% 7.
q = Rotation2Quaternion(R)

%% 8. Bundle Adjustment
% I'll work with Image4, the X coordinates are already computed
q = Rotation2Quaternion(R)
P = [C' q']';

Mxtest = Mx1(:, 4);
Mytest = My1(:, 4);

[P, X] = BundleAdjustment(P, X, R, Mxtext, Mytest)
q = P(4:7);
Rtest = Quaternion2Rotation(q);
Ctest = P(1:3);


v_new = K*[Rtest (-Rtest*Ctest)]*X';
v_new = [v_new(1, :)./v_new(3, :); v_new(2, :)./v_new(3, :); v_new(3, :)./v_new(3, :)];

figure(1)
imshow(I4)
hold on
plot(v_new(1,:), v_new(2, :), 'b*', (Mxtest(:, 1)'.*f + K(1,3)), (Mytest(:, 1)'.*f + K(2,3)), 'r*')
% hold on
% plot(u(:, 1), u(:, 2), 'r*')
legend('Reprojection','Actual');
