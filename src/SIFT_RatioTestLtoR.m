function SIFT_RatioTestLtoR(Ia, Ib, fa, fb, da, db)

    n = min(size(fa,2), size(fb, 2));
    fa = fa(:, 1:n);
    fb = fb(:, 1:n);
    da = da(:, 1:n);
    db = db(:, 1:n);

    [knn_a, dist_a] = knnsearch(db', da','dist','euclidean', 'k', 2);
    Knn_dist = [knn_a dist_a];
    ratio = Knn_dist(:, 3)./Knn_dist(:, 4);
    Knn_dist =[Knn_dist ratio];
    A= [];
    for i = 1:size(Knn_dist, 1)
        if Knn_dist(i, 5)< 0.7
            A = [A; i Knn_dist(i, :)];
        end
    end

    knn_a = A(:, 2);
    fb_perm = fb( : , knn_a');

    figure(421) ; clf ;
    imagesc(cat(2, Ia, Ib)) ;

    faHat = fa(:, A(:, 1));
    xa = faHat(1, :) ;
    xb = fb_perm(1, :) + size(Ia,2) ;
    ya = faHat(2, :) ;
    yb = fb_perm(2, :) ;

    hold on ;
    h = line([xa ; xb], [ya ; yb]) ;
    set(h,'linewidth', 1, 'color', 'r') ;