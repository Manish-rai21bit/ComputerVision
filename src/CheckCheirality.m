function idx = CheckCheirality(Y, C1, R1, C2, R2)
idx = [];
n = 0;

for i = 1: size(Y, 1)
    n1 = 0;
    n2 = 0;
    
    if R1(3, :)*(Y(i, :)' - C1) > 0
        n1 = 1;
    end
    
    if R2(1, :)*(Y(i, :)' - C2) > 0
        n2 = 1;
    end
    
    if n1 + n2 == 2
        n = n + 1;
        idx = [idx; i];
    end
end