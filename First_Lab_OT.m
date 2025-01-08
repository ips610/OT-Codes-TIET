clc;
clear;

A = [1 2; 1 1; 1 -2; 1 0; 0 1];
B = [10; 6; 1; 0; 0];

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