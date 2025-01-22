%{

x1 + x2 <= 450
2x1 + x2 <= 600

x1 + x2 + s1 = 450
2x1 + x2 + s2 = 600

Max Z = 3x1 + 4x2
%}
clc
clear

A = [1 1 1 0; 2 1 0 1];
B = [450; 600];
C = [3 4 0 0];

n = size(A, 2); % No of columns / variables
m = size(A, 1);
ncm = nchoosek(n, m);
pairs = nchoosek(1:n, m);

sol = [];
for i = 1: ncm
    y=zeros(n,1);
    x = inv(A(:, pairs(i, :)))*B; % x = A(:, pairs(i, :)) \ b

    if (x>=0 & x~=inf)
        y(pairs(i,:)) = x;
        sol = [sol, y];
    end
end

Z = @(X) C*X;
cost = Z(sol)
[Zmax, Zindex] = max(cost)
ans = sol(:, Zindex);