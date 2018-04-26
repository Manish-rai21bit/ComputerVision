function [Mx, My] = GetMatches_vOld(I1, I2, I3, I4, I5, I6)
    run('/Users/manishrai/Documents/VLFEATROOT/toolbox/vl_setup')
    Mx = []; My = [];
    
    [f1,d1] = vl_sift(im2single(rgb2gray(I1))) ; 
    [f2,d2] = vl_sift(im2single(rgb2gray(I2))) ; 
    [f3,d3] = vl_sift(im2single(rgb2gray(I3))) ; 
    [f4,d4] = vl_sift(im2single(rgb2gray(I4))) ; 
    [f5,d5] = vl_sift(im2single(rgb2gray(I5))) ; 
    [f6,d6] = vl_sift(im2single(rgb2gray(I6))) ; 

    
    [u1, v1] = GetMatchingPairs(d3, f3, d1, f1);
    [u2, v2] = GetMatchingPairs(d3, f3, d2, f2);
    [u4, v4] = GetMatchingPairs(d3, f3, d4, f4);
    [u5, v5] = GetMatchingPairs(d3, f3, d5, f5);
    [u6, v6] = GetMatchingPairs(d3, f3, d6, f6);

    
%     % Matching from I1 to I2
%     % knnsearch(X,Y) finds the nearest neighbor in X for each point in Y...
%     % IDX is a column vector with my rows. Each row in IDX contains the index..
%     % of nearest neighbor in X for the corresponding row in Y.
%     [knn_i1Toi2, dist_i1Toi2] = knnsearch(d2', d1','dist','euclidean', 'k', 2);
%     f2_perm = f2( : , knn_i1Toi2(1, :)'); %permuting/rearranging/swapping columns
%     % fb_perm = fb_perm( : , 1:m);
% 
%     [knn_i2Toi1, dist_i2Toi1] = knnsearch(d1', d2','dist','euclidean', 'k', 2);
%     f1_perm = f1( : , knn_i2Toi1(1, :)'); %permuting/rearranging/swapping columns
%     % fa_perm = fa_perm(:, 1:m);
% 
%     % Bidirectional matching
%     Knn_dist = [knn_i1Toi2 dist_i1Toi2];
%     ratio = Knn_dist(:, 3)./Knn_dist(:, 4);
%     Knn_dist =[Knn_dist ratio];
%     A= [];
%     for i = 1:size(Knn_dist, 1)
%         if Knn_dist(i, 5)< 0.7
%          A = [A; i Knn_dist(i, :)];
%         end
%     end
% 
%     A1 = A;
%     A1 = [A1(:, 1) A1(:, 2)];
% 
% % ------------------------------------------------------------------------
%     Knn_dist = [knn_i2Toi1 dist_i2Toi1];
%     ratio = Knn_dist(:, 3)./Knn_dist(:, 4);
%     Knn_dist =[Knn_dist ratio];
%     A= [];
%     for i = 1:size(Knn_dist, 1)
%         if Knn_dist(i, 5)< 0.7
%             A = [A; i Knn_dist(i, :)];
%         end
%     end
%     A2 = A;
% 
%     A2 = [A2(:, 2) A2(:, 1)];
% 
% % -------------------------
%     [~,index_A1,index_A2] = intersect(A1,A2,'rows');
%     A1_hat = A1(index_A1, :); % matrix with first column from img1 and 2nd column from img2
% 
% % now refining the corresponding points with fundamental matrix
%     u = [f1(1, A1_hat(:, 1) ); f1(2, A1_hat(:, 1) )]';
%     v = [f2(1, A1_hat(:, 2) ); f2(2, A1_hat(:, 2) )]';
%     [F, n, inlier] = GetInliersRANSAC(u, v); % Computing the fundamental matrix 
% 
% % final set of corresponding points after outlier removing 
%     u = u(inlier, :);
%     v = v(inlier, :);
%     Mx = [u(:, 1) v(:, 1)]; My = [u(:, 2) v(:, 2)];
  

    u = [u1; u2; u4; u5; u6];
    u = unique(u, 'rows');
    
    Mx = [u(:, 1)];
    My = [u(:, 2)];
    
    mx1 = []; my1 = [];
    mx2 = []; my2 = [];
    mx4 = []; my4 = [];
    mx5 = []; my5 = [];
    mx6 = []; my6 = [];
    
    for i = 1: size(u, 1)
        % ref and i1
        if ismember(u(i, :), u1, 'rows') == 1
            [~, index1, index2] = intersect(u(i, :), u1, 'rows');
            mx1 = [mx1; v1(index2, 1)];
            my1 = [my1; v1(index2, 1)];
        else 
            mx1 = [mx1; 0];
            my1 = [my1; 0];
        end
        % ref and i2
        if ismember(u(i, :), u2, 'rows') == 1
            [~, index1, index2] = intersect(u(i, :), u2, 'rows');
            mx2 = [mx2; v2(index2, 1)];
            my2 = [my2; v2(index2, 1)];
        else 
            mx2 = [mx2; 0];
            my2 = [my2; 0];
        end
        % ref and i4
        if ismember(u(i, :), u4, 'rows') == 1
            [~, index1, index2] = intersect(u(i, :), u4, 'rows');
            mx4 = [mx4; v4(index2, 1)];
            my4 = [my4; v4(index2, 1)];
        else 
            mx4 = [mx4; 0];
            my4 = [my4; 0];
        end
        % ref and i5
        if ismember(u(i, :), u5, 'rows') == 1
            [~, index1, index2] = intersect(u(i, :), u5, 'rows');
            mx5 = [mx5; v5(index2, 1)];
            my5 = [my5; v5(index2, 1)];
        else 
            mx5 = [mx5; 0];
            my5 = [my5; 0];
        end
        % ref and i6
        if ismember(u(i, :), u6, 'rows') == 1
            [~, index1, index2] = intersect(u(i, :), u6, 'rows');
            mx6 = [mx6; v6(index2, 1)];
            my6 = [my6; v6(index2, 1)];
        else 
            mx6 = [mx6; 0];
            my6 = [my6; 0];
        end
    end 
    Mx = [mx1, mx2, u(:, 1), mx4, mx5, mx6];
    My = [my1, my2, u(:, 1), my4, my5, my6];
%% plot these points
%     figure(1) ; clf ;
%     imagesc(cat(2, I1, I2)) ;
% % faHat = fa(:, 1:m);
%     xa = (Mx(:, 1)'*f + 408) ;
%     xb = (Mx(:, 2)'*f+ 408) + size(I1,2) ;
%     ya = (My(:, 1)'*f + 306);
%     yb = (My(:, 2)'*f +306);
% 
%     hold on ;
%     h = line([xa ; xb], [ya ; yb]) ;
%     set(h,'linewidth', 1, 'color', 'r') ;
