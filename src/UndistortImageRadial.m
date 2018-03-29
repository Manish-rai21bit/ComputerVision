function UndistortImageRadial(k1 = 0, k2 =0, k3 = 0)
% Lens distortion is a function of distance from the principal point. This
% is called the RADIAL DISTORTION MODEL
% u_dist = L(p)*u_undist; p = ||u_undist||
% L(p) = 1 + k1*p^2 + k2*p^4 + ...
k = -0.3;
[X, Y] = meshgrid(1:(size(im,2)), 1:(size(im,1))); 
h = size(X, 1); 
w = size(X,2);
X = X(:);
Y = Y(:);
pt = [X'; Y'];
% bsxfun - Apply element-wise operation to two arrays with implicit expansion enabled
pt = bsxfun(@minus, pt, [px;py]);
pt = bsxfun(@rdivide, pt, [f;f]);
r_u = sqrt(sum(pt.^2, 1));
pt = bsxfun(@times, pt, 1 + k * r_u.^2); 
pt = bsxfun(@times, pt, [f;f]);
pt = bsxfun(@plus, pt, [px;py]);

imUndistortion(:,:,1) = reshape(interp2(im(:,:,1), pt(1,:), pt(2,:)), [h, w]); 
imUndistortion(:,:,2) = reshape(interp2(im(:,:,2), pt(1,:), pt(2,:)), [h, w]); 
imUndistortion(:,:,3) = reshape(interp2(im(:,:,3), pt(1,:), pt(2,:)), [h, w]);
% Undistorted image = imUndistortion
imshow(imUndistortion)
