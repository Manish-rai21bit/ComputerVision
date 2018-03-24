function EpipoleVisualizationRANSAC(im1, im2, F, u, v)
x1 = u;
x2 = v;

% Compute epipole 1
e1 = null(F);
% Compute epipole 2
e2 = null(F');

figure(1);
clf;
subplot(1,2,1)
imshow(im1);
subplot(1,2,2)
imshow(im2);

c = hsv(200);
for i = 1 : size(x1,1)
    l12 = F'*[x2(i,1:2)';1];
    
    d0 = -size(im1,2);
    d1 = size(im1,2);
    y1 = -(l12(1)*d0+l12(3))/l12(2);
    y2 = -(l12(1)*d1+l12(3))/l12(2);
    r = randperm(200);
    subplot(1,2,1)
    hold on
    plot(x1(i,1), x1(i,2), 'o', 'Color', c(r(1),:), 'MarkerFaceColor', c(r(1),:));
    hold on
    plot([d0 d1], [y1 y2], 'Color', c(r(1),:), 'LineWidth', 2);
    
    l12 = F*[x1(i,1:2)';1];
    
    d0 = -size(im1,2);
    d1 = size(im1,2);
    y1 = -(l12(1)*d0+l12(3))/l12(2);
    y2 = -(l12(1)*d1+l12(3))/l12(2);
    subplot(1,2,2)
    hold on
    plot(x2(i,1), x2(i,2), 'o', 'Color', c(r(1),:), 'MarkerFaceColor', c(r(1),:));
    hold on
    plot([d0 d1], [y1 y2], 'Color', c(r(1),:), 'LineWidth', 2);
end