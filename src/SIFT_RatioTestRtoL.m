function SIFT_RatioTestRtoL(Ia, Ib, fa, fb, da, db)

    n = min(size(fa,2), size(fb, 2));
    fa = fa(:, 1:n);
    fb = fb(:, 1:n);
    da = da(:, 1:n);
    db = db(:, 1:n);

    [knn_b, dist_b] = knnsearch(da', db','dist','euclidean', 'k', 2);
    Knn_dist = [knn_b dist_b];
    ratio = Knn_dist(:, 3)./Knn_dist(:, 4);
    Knn_dist =[Knn_dist ratio];
    A= [];
    for i = 1:size(Knn_dist, 1)
        if Knn_dist(i, 5)< 0.7
            A = [A; i Knn_dist(i, :)];
        end
    end

    knn_b = A(:, 2);
    fa_perm = fa( : , knn_b');

    figure(421) ; clf ;
    imagesc(cat(2, Ia, Ib)) ;

    fbHat = fb(:, A(:, 1));
    xb = fbHat(1, :) ;
    xa = fa_perm(1, :) + size(Ia,2) ;
    yb = fbHat(2, :) ;
    ya = fa_perm(2, :) ;

    hold on ;
    h = line([xa ; xb], [ya ; yb]) ;
    set(h,'linewidth', 1, 'color', 'b') ;