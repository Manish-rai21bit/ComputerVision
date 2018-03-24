function  [R1 C1 R2 C2 R3 C3 R4 C4] = CameraPose(F, K)
% [R1 C1 R2 C2 R3 C3 R4 C4] =
    E = ComputeEssentialMatrix(F, K);
    t1 = null(E');
    t2 = -null(E');
%     t1 = [t1(1)/t1(3); t1(2)/t1(3); t1(3)/t1(3)];
    [U D V] = svd(E);
    Ra = U*[0 -1 0; 1 0 0; 0 0 1]*V';
    Rb = U*[0 1 0; -1 0 0; 0 0 1]*V';
    
%     if det(Ra) < 0
%         t1 = -t1; 
%         Ra = -Ra;
%     end
%     
%     if det(Rb) < 0
%         t2 = -t2; 
%         Rb = -Rb;
%     end
    C1 = -Ra'*t1;
    R1 = Ra;
    C2 = -Ra'*t2;
    R2 = Ra;
    C3 = -Rb'*t1;
    R3 = Rb;
    C4 = -Rb'*t2;
    R4 = Rb;
    
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