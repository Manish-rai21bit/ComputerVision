function [R, C] = PnP_NonLinear(R, C, u, X) 
K = eye(3);
nIters = 100;
q = Rotation2Quaternion(R);
p = [C' q']';
lambda = 0.7;

b = u';
b = b(:);

df_dC = JacobianC(R, C, X);
df_dR = JacobianR(R, C, X);
dR_dq = JacobianQ(q);

for i = 1: nIters
    
    JacobianP = [df_dC df_dR*dR_dq];

    x = K*R*(X(:, 1:3)' - C); % Compute f(p)
    x = [x(1, :)./x(3, :);  x(2, :)./x(3, :)];
    x = x(:);
        
    del_p = [inv(JacobianP'*JacobianP + lambda*eye(7))*JacobianP'*(b - x)];
    p = p + del_p;
    % Normalise p
    p(4:7) = p(4:7)./norm(p(4:7));
end

C = p(1:3);
q = p(4:7);
R = Quaternion2Rotation(q);
