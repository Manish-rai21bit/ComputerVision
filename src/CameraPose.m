function  [R1 C1 R2 C2 R3 C3 R4 C4] = CameraPose(F, K)
% [R1 C1 R2 C2 R3 C3 R4 C4] =
    E = ComputeEssentialMatrix(F, K);
    [u d v] = svd(E);
    d(1,1) = 1;
    d(2,2) = 1;
    d(3,3) = 0;
    E = u*d*v';
    [U D V] = svd(E);
    W1 = [0 -1 0; 1 0 0; 0 0 1];
    W2 = [0 1 0; -1 0 0; 0 0 1];
    
    C1 = U(:,3);
    R1 = U*W1*V';
    if(det(R1)<0)
        C1 = -C1;
        R1 = -R1;
    end

    C2 = U(:,3);
    R2 = U*W2*V';
    if(det(R2)<0)
        C2 = -C2;
        R2 = -R2;
    end

    C3 = -U(:,3);
    R3 = U*W1*V';
    if(det(R3)<0)
        C3 = -C3;
        R3 = -R3;
    end

    C4 = -U(:,3);
    R4 = U*W2*V';
    if(det(R4)<0)
        C4 = -C4;
        R4 = -R4;
    end    
    
    figure(1)
    DisplayCamera([0; 0; 0], eye(3), 1);
    hold on
    DisplayCamera(C1, R1, 1);
%     axis([-2, 2, -2, 2, -2, 2]);
    
    
    figure(2)
    DisplayCamera([0; 0; 0], eye(3), 1);
    hold on
    DisplayCamera(C2, R2, 1);
%     axis([-2, 2, -2, 2, -2, 2]);
    
    
    figure(3)
    DisplayCamera([0; 0; 0], eye(3), 1);
    hold on
    DisplayCamera(C3, R3, 1);
%     axis([-2, 2, -2, 2, -2, 2]);
    
    
    figure(4)
    DisplayCamera([0; 0; 0], eye(3), 1);
    hold on
    DisplayCamera(C4, R4, 1);
%     axis([-2, 2, -2, 2, -2, 2]);