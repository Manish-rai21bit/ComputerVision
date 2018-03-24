function SIFT_RatioTestRtoL(Ia, Ib, fa, fb, da, db)

    [knn, dist] = knnsearch(da', db','dist','euclidean', 'k', 2);
    Knn_dist = [knn dist];
    ratio = Knn_dist(:, 3)./Knn_dist(:, 4);
    Knn_dist =[Knn_dist ratio];
    A= [];
    for i = 1:size(Knn_dist, 1)
        if Knn_dist(i, 5)< 0.7
            A = [A; i Knn_dist(i, :)];
        end
    end

    knn = A(:, 2);
    fa_perm = fa( : , knn');

    figure(422) ; clf ;
    imagesc(cat(2, Ia, Ib)) ;

    fbHat = fb(:, A(:, 1));
    xb = fbHat(1, :) ;
    xa = fa_perm(1, :) + size(Ia,2) ;
    yb = fbHat(2, :) ;
    ya = fa_perm(2, :) ;

    hold on ;
    h = line([xa ; xb], [ya ; yb]) ;
    set(h,'linewidth', 1, 'color', 'b') ;
