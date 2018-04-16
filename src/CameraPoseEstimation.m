function [R, C, X] = CameraPoseEstimation(u, v)
    % 1. Fundamental matrix via RANSAC on correspondences, Mx(:,i1), My(:,i2) 
    % 2. Essential matrix from the fundamental matrix
    % 3. Four configurations of camera poses given the essential matrix
    % 4. Disambiguation via chierality (using 3D point linear triangulation):
    %X = LinearTriangulation(u, Pi, v, Pj)
    K = [1023/4 0 408;
    0 1023/4 302;
    0 0 1];

    [F, n, inlier] = GetInliersRANSAC(u, v); %1.
    E = ComputeEssentialMatrix(F, K) % 2. Essential matrix from fundamental matrix
    [R1 C1 R2 C2 R3 C3 R4 C4] = CameraPose(F, K); % 3.
    % 4. Disambiguate via chierality
    C = [];
    R = [];
    X = [];
    n = 0;
    for i = 1 : 4
        Chat = eval(['C' num2str(i)]);
        Rhat = eval(['R' num2str(i)]);
        P1 = K*[eye(3) [0; 0; 0]];
        P2 = K*[Rhat -Rhat*Chat];
        X1 = LinearTriangulation(P1,u,P2,v);
        [n1, idx] = CheckCheirality(X1(:, 1:3), [0; 0; 0], eye(3), Chat, Rhat);
        
        if n1> n
            n = n1;
            X = X1;
            C = Chat;
            R = Rhat;
        end
    end