%{

Max Z = 15x1+10x2

4x1 + 6x2 <= 360
3x1 < 180
5x2 < 200
x1, x2 >= 0

%}

clc;
clear;

A = [4 6; 3 0; 0 5; 1 0; 0 1];
B = [360; 180; 200; 0; 0];
C = [15 10];

x1 = 0:0.1:max(B);
hold on;
for i = 1:5
    
    x2 = (B(i) - x1 * A(i,1)) / A(i,2);
    x2 = max(0, x2);
    plot(x1, x2);
    
end
hold off;

xlabel('x1');
ylabel('x2');
title('Plot of linear equations');
legend('Eq 1', 'Eq 2', 'Eq 3', 'Eq 4', 'Eq 5', 'Location', 'Best');
grid on;

sol = [];
for i = 1:5
    A1 = A(i,:);
    B1 = B(i);

    for j = i+1:5

        A2 = A(j,:);
        B2 = B(j);

        A3 = [A1;A2];
        B3 = [B1;B2];

        x = inv(A3)*B3;

        sol = [sol,x];
    end
end

sol;
sol1 = sol';
sol1;

x1 = sol1(:, 1);
x2 = sol1(:, 2);
h1 = find(5*x2-200>0);
sol1(h1, :) = [];

x1 = sol1(:, 1);
x2 = sol1(:, 2);
h2 = find(4*x1 + 6*x2 - 360>0);
sol1(h2, :) = [];

x1 = sol1(:, 1);
x2 = sol1(:, 2);
h3 = find(3*x1-180>0);
sol1(h3, :) = [];


x1 = sol1(:, 1);
x2 = sol1(:, 2);
h4 = find(x1<=0);
sol1(h4, :) = [];


x1 = sol1(:, 1);
x2 = sol1(:, 2);
h5 = find(x2<=0);
sol1(h5, :) = [];

k = sol1;
ans = []
for i = 1:size(k,1)
    x=sum(k(i,:)*C');
    ans=[ans,x];
end

max(ans)