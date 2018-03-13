function get_keypoint_func(Image)
image(Image) ;
axis equal ; axis off ; axis tight ;
Image = single(rgb2gray(Image)) ;
% Computes the keypoints & descriptors of a greyscale image I
% A frame is a disk of center f(1:2), scale f(3) and orientation f(4)
[f,d] = vl_sift(Image) ; 
% Visualize a random selection of 50 features
perm = randperm(size(f,2)) ;
sel = perm(1:500) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
end