function [Mx, My] = GetMatches(I1, I2, I3, I4, I5, I6)
run('/Users/manishrai/Documents/VLFEATROOT/toolbox/vl_setup')

[f1,d1] = vl_sift(im2single(rgb2gray(I1))) ;
[f2,d2] = vl_sift(im2single(rgb2gray(I2))) ;
[f3,d3] = vl_sift(im2single(rgb2gray(I3))) ;
[f4,d4] = vl_sift(im2single(rgb2gray(I4))) ;
[f5,d5] = vl_sift(im2single(rgb2gray(I5))) ;
[f6,d6] = vl_sift(im2single(rgb2gray(I6))) ;

Mx = []; My = [];

[Mx1, My1] = GetMatchesOnePairOnly(f3,d3, f1,d1);

for i = 1:size(Mx1, 1)
    if size(find(Mx == Mx1(i, 1)), 1) == 0
        Mx = [Mx; Mx1(i, 1)];
    end
end

[Mx2, My2] = GetMatchesOnePairOnly(f3,d3, f2,d2);

for i = 1:size(Mx2, 1)
    if size(find(Mx == Mx2(i, 1)), 1) == 0
        Mx = [Mx; Mx2(i, 1)];
    end
end

[Mx4, My4] = GetMatchesOnePairOnly(f3,d3, f4,d4);

for i = 1:size(Mx4, 1)
    if size(find(Mx == Mx4(i, 1)), 1) == 0
        Mx = [Mx; Mx4(i, 1)];
    end
end

[Mx5, My5] = GetMatchesOnePairOnly(f3,d3, f5,d5);

for i = 1:size(Mx5, 1)
    if size(find(Mx == Mx5(i, 1)), 1) == 0
        Mx = [Mx; Mx5(i, 1)];
    end
end

[Mx6, My6] = GetMatchesOnePairOnly(f3,d3, f6,d6);

for i = 1:size(Mx6, 1)
    if size(find(Mx == Mx6(i, 1)), 1) == 0
        Mx = [Mx; Mx6(i, 1)];
    end
end

Mx = [Mx zeros(size(Mx, 1), 1) zeros(size(Mx, 1),1) zeros(size(Mx, 1), 1) zeros(size(Mx, 1), 1) zeros(size(Mx, 1), 1)];


% filling other columns of Mx
%Mx1
for i = 1:size(Mx1, 1)
    if size(find(Mx(:, 1) ==  Mx1(i, 1)), 1) ~= 0
        Index = find(Mx(:, 1) ==  Mx1(i, 1));
        Mx(Index, 2) = Mx1(i, 2);
    end
end
%Mx2
for i = 1:size(Mx2, 1)
    if size(find(Mx(:, 1) ==  Mx2(i, 1)), 1) ~= 0
        Index = find(Mx(:, 1) ==  Mx2(i, 1));
        Mx(Index, 3) = Mx2(i, 2);
    end
end

% Mx4
for i = 1:size(Mx4, 1)
    if size(find(Mx(:, 1) ==  Mx4(i, 1)), 1) ~= 0
        Index = find(Mx(:, 1) ==  Mx4(i, 1));
        Mx(Index, 4) = Mx4(i, 2);
    end
end

% Mx5
for i = 1:size(Mx5, 1)
    if size(find(Mx(:, 1) ==  Mx5(i, 1)), 1) ~= 0
        Index = find(Mx(:, 1) ==  Mx5(i, 1));
        Mx(Index, 5) = Mx5(i, 2);
    end
end

% Mx6
for i = 1:size(Mx6, 1)
    if size(find(Mx(:, 1) ==  Mx6(i, 1)), 1) ~= 0
        Index = find(Mx(:, 1) ==  Mx6(i, 1));
        Mx(Index, 6) = Mx6(i, 2);
    end
end

Mx = Mx(:, [2,3,1,4,5,6]);


%% My


for i = 1:size(My1, 1)
    if size(find(My == My1(i, 1)), 1) == 0
        My = [My; My1(i, 1)];
    end
end



for i = 1:size(My2, 1)
    if size(find(My == My2(i, 1)), 1) == 0
        My = [My; My2(i, 1)];
    end
end

for i = 1:size(My4, 1)
    if size(find(My == My4(i, 1)), 1) == 0
        My = [My; My4(i, 1)];
    end
end


for i = 1:size(My5, 1)
    if size(find(My == My5(i, 1)), 1) == 0
        My = [My; My5(i, 1)];
    end
end


for i = 1:size(My6, 1)
    if size(find(My == My6(i, 1)), 1) == 0
        My = [My; My6(i, 1)];
    end
end


My = [My zeros(size(My, 1), 1) zeros(size(My, 1),1) zeros(size(My, 1), 1) zeros(size(My, 1), 1) zeros(size(My, 1), 1)];
% filling other columns of My
%My1
for i = 1:size(My1, 1)
    if size(find(My(:, 1) ==  My1(i, 1)), 1) ~= 0
        Index = find(My(:, 1) ==  My1(i, 1));
        My(Index, 2) = My1(i, 2);
    end
end
%My2
for i = 1:size(My2, 1)
    if size(find(My(:, 1) ==  My2(i, 1)), 1) ~= 0
        Index = find(My(:, 1) ==  My2(i, 1));
        My(Index, 3) = My2(i, 2);
    end
end

% My4
for i = 1:size(My4, 1)
    if size(find(My(:, 1) ==  My4(i, 1)), 1) ~= 0
        Index = find(My(:, 1) ==  My4(i, 1));
        My(Index, 4) = My4(i, 2);
    end
end

% My5
for i = 1:size(My5, 1)
    if size(find(My(:, 1) ==  My5(i, 1)), 1) ~= 0
        Index = find(My(:, 1) ==  My5(i, 1));
        My(Index, 5) = My5(i, 2);
    end
end

% My6
for i = 1:size(My6, 1)
    if size(find(My(:, 1) ==  My6(i, 1)), 1) ~= 0
        Index = find(My(:, 1) ==  My6(i, 1));
        My(Index, 6) = My6(i, 2);
    end
end

My = My(:, [2,3,1,4,5,6]);
