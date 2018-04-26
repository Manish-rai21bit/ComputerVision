function [u, v] = GetMatchingPairs(d1, f1, d2, f2)

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
