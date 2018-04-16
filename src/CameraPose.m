function  [R1 C1 R2 C2 R3 C3 R4 C4] = CameraPose(F, K)
    % Essential Matrix Computation
    E = ComputeEssentialMatrix(F, K);
    
    [U D V] = svd(E);
    W1 = [0 -1 0; 1 0 0; 0 0 1];
    W2 = [0 1 0; -1 0 0; 0 0 1];
    
    t1 = U(:, 3);
    R1 = U*W1*V';
    if(det(R1)<0)
      t1 = -t1;
      R1 = -R1; 
    end
    C1 = -R1'*t1;
    
    t2 = -U(:, 3);
    R2 = U*W1*V';
    if(det(R1)<0)
      t2 = -t2;
      R2 = -R2; 
    end
    C2 = -R2'*t2

    
    t3 = U(:, 3);
    R3 = U*W2*V';
    if(det(R3)<0)
      t3 = -t3;
      R3 = -R3; 
    end
    C3 = -R3'*t3

    
    t4 = -U(:, 3);
    R4 = U*W2*V';
    if(det(R4)<0)
      t4 = -t4;
      R4 = -R4; 
    end
    C4 = -R4'*t4

    
    
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