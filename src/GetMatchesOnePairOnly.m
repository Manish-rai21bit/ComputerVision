function [Mx, My] = GetMatchesOnePairOnly(f1,d1, f2,d2)
    run('/Users/manishrai/Documents/VLFEATROOT/toolbox/vl_setup')
    Mx = []; My = [];
    
%     [f1,d1] = vl_sift(im2single(rgb2gray(I1))) ; 
%     [f2,d2] = vl_sift(im2single(rgb2gray(I2))) ; 
    
    % Matching from I1 to I2
    % knnsearch(X,Y) finds the nearest neighbor in X for each point in Y...
    % IDX is a column vector with my rows. Each row in IDX contains the index..
    % of nearest neighbor in X for the corresponding row in Y.
    [knn_i1Toi2, dist_i1Toi2] = knnsearch(d2', d1','dist','euclidean', 'k', 2);
    f2_perm = f2( : , knn_i1Toi2(1, :)'); %permuting/rearranging/swapping columns
    % fb_perm = fb_perm( : , 1:m);

    [knn_i2Toi1, dist_i2Toi1] = knnsearch(d1', d2','dist','euclidean', 'k', 2);
    f1_perm = f1( : , knn_i2Toi1(1, :)'); %permuting/rearranging/swapping columns
    % fa_perm = fa_perm(:, 1:m);

    % Bidirectional matching
    Knn_dist = [knn_i1Toi2 dist_i1Toi2];
    ratio = Knn_dist(:, 3)./Knn_dist(:, 4);
    Knn_dist =[Knn_dist ratio];
    A= [];
    for i = 1:size(Knn_dist, 1)
        if Knn_dist(i, 5)< 0.7
         A = [A; i Knn_dist(i, :)];
        end
    end

    A1 = A;
    A1 = [A1(:, 1) A1(:, 2)];

% ------------------------------------------------------------------------
    Knn_dist = [knn_i2Toi1 dist_i2Toi1];
    ratio = Knn_dist(:, 3)./Knn_dist(:, 4);
    Knn_dist =[Knn_dist ratio];
    A= [];
    for i = 1:size(Knn_dist, 1)
        if Knn_dist(i, 5)< 0.7
            A = [A; i Knn_dist(i, :)];
        end
    end
    A2 = A;

    A2 = [A2(:, 2) A2(:, 1)];

% -------------------------
    [~,index_A1,index_A2] = intersect(A1,A2,'rows');
    A1_hat = A1(index_A1, :); % matrix with first column from img1 and 2nd column from img2

% now refining the corresponding points with fundamental matrix
    u = [f1(1, A1_hat(:, 1) ); f1(2, A1_hat(:, 1) )]';
    v = [f2(1, A1_hat(:, 2) ); f2(2, A1_hat(:, 2) )]';
    [F, n, inlier] = GetInliersRANSAC(u, v); % Computing the fundamental matrix 

% final set of corresponding points after outlier removing 
    u = u(inlier, :);
    v = v(inlier, :);
    Mx = [u(:, 1) v(:, 1)]; My = [u(:, 2) v(:, 2)];
  
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
