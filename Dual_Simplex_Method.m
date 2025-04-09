```clc;
clear;

% Cost function (Objective Coefficients)
cost = [-5 -6 0 0 0];

% Constraint coefficients
a = [-1 -1 1 0; -4 -1 0 1];
b = [-2; -4];

% Construct the initial simplex tableau
A = [a b];
bv = [3 4]; % Basic variables

% Compute zj - cj
zjcj = cost(bv) * A - cost;
simplex_table = [A; zjcj];

% Display initial tableau
disp('Initial Simplex Tableau:');
disp(simplex_table);

RUN = true;

while RUN
    sol = A(:, end);
    
    % Check infeasibility condition (any solution < 0)
    if any(sol < 0)
        fprintf('\nCurrent BFS is not feasible\n');
        
        % Find the most negative value in solution column (Leaving Variable)
        [leaving_val, pvt_row] = min(sol);
        fprintf('Leaving row: %d\n', pvt_row);
        
        % Compute ratios for selecting entering column
        ratio = inf(1, size(A, 2) - 1); % Initialize with infinity
        for i = 1:size(A, 2) - 1
            if A(pvt_row, i) < 0
                ratio(i) = abs(zjcj(i) / A(pvt_row, i));
            end
        end
        
        % Select the smallest ratio (Entering Variable)
        [entering_value, pvt_col] = min(ratio);
        fprintf('Entering column: %d\n', pvt_col);
        
        % Update basis
        bv(pvt_row) = pvt_col;
        
        % Perform pivoting
        pvt_key = A(pvt_row, pvt_col);
        A(pvt_row, :) = A(pvt_row, :) / pvt_key;
        
        % Row operations to make pivot column zero except pivot row
        for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end
        
        % Update zj - cj row
        zjcj = cost(bv) * A - cost;
        
        % Display updated tableau
        disp('Updated Simplex Tableau:');
        disp([A; zjcj]);
        
    else
        RUN = false;
        fprintf('\nThe solution is now feasible.\n');
        Obj_value = zjcj(end);
        fprintf('The final optimal value is: %f\n', Obj_value);
    end
end
```