function PnPRANSAC(X, u)

f = 2682/4;
K = [f 0 816;
    0 f 612;
    0 0 1];

nInliers = 0;
threshold = 100;
n = 0;
M = 100;
for i = 1:M
    n1 = 0;
    y = randsample(size(u, 1), 6);
    ur = u(y, :);
    Xr = X(y, :);
    [Rr, Cr] = LinearPnP(ur, Xr);
    tr = -Rr*Cr;
    % Compute the number of inliers
    Pr = K*[Rr tr];
    uhat = Pr*[X ones(size(X, 1), 1)]';
    uhat = bsxfun(@rdivide,uhat,uhat(3,:));
    uhat = uhat';
    uhat = [uhat(:, 1) uhat(:, 2)];
    for j = 1: size(u, 1)
        norm2 = sqrt((u(j, 1)-uhat(j, 1))^2 + (u(j, 2)-uhat(j, 2))^2 );
        if norm2 < threshold
            n1 = n1+1;
        end
    end
    
    if n > n1
        n = n1;
        R = Rr;
        t = tr;
    end
end