function dR_dq = JacobianQ(q)
    qw = q(1);
    qx = q(2);
    qy = q(3);
    qz = q(4);
    
    dR_dq = [0 0 -4*qy -4*qz; 
        -2*qz 2*qy 2*qx -2*qw;
             2*qy 2*qz 2*qw 2*qx;
             2*qz 2*qy 2*qx 2*qw;
             0 -4*qx 0 -4*qz;
             -2*qx -2*qw 2*qz 2*qy;
             -2*qy 2*qz -2*qw 2*qx;
             2*qx 2*qw 2*qz 2*qy
             0 -4*qx -4*qy 0];